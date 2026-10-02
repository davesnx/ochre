open Common

let find_exn key obj =
  match List.assoc_opt key obj with
  | Some v ->
      v
  | None ->
      error (key ^ " not found.")

let get_dict = function
  | `Assoc d | `Dict d | `O d ->
      d
  | _ ->
      error "Type error: Expected dict."

let get_string = function
  | `String s ->
      s
  | _ ->
      error "Type error: Expected string."

let get_list f = function
  | `A l | `Array l | `List l ->
      List.map f l
  | _ ->
      error "Type error: Expected list."

(* "name"/"contentName" are read straight off the raw rule object in
   vscode-textmate with no type check (e.g. `desc.contentName` is passed
   as-is to the rule constructor). A non-string value there, such as
   Wikitext's `"contentName": null` on one `hl-rust` pattern, is simply
   falsy wherever vscode-textmate later gates on it, i.e. it behaves as if
   the field were absent. Mirror that instead of failing the whole
   grammar. *)
let get_name_opt obj key =
  match List.assoc_opt key obj with
  | Some (`String s) ->
      Some s
  | Some _ | None ->
      None

(* Helper function for handling both dict-based capture specifications of
   the form { "0": {"name": ..., "patterns": ...}, ... } and list-based
   capture specifications of the form [{"name": ..., "patterns": ...}, ...] *)
let rec get_captures_helper :
    'a.
    (int -> 'a -> capture_key) ->
    (int -> 'a -> union) ->
    'a list ->
    (capture_key, capture) Hashtbl.t =
 fun idx_fun capture_fun captures ->
  let tbl = Hashtbl.create 21 in
  let rec loop i = function
    | [] ->
        ()
    | capture :: captures ->
        let k = idx_fun i capture in
        (* Some bundled grammars have a non-dict value under a capture index
           (a bare scope-name string, or a one-element array instead of
           {"name": ...}), e.g. Racket's and Stata's `{"0": "scope.name"}`
           and Wikitext's `{"4": null}`. vscode-textmate's _compileCaptures
           reads `.name`/`.patterns` straight off whatever value is there;
           on a string, array, or null those are just `undefined`, so the
           capture silently gets no name and no patterns rather than
           failing. Match that instead of erroring on the whole grammar. *)
        let v =
          match capture_fun i capture with
          | `Assoc d | `Dict d | `O d ->
              d
          | _ ->
              []
        in
        let capture_name =
          match List.assoc_opt "name" v with
          | None ->
              None
          | Some name ->
              Some (get_string name)
        in
        let capture_patterns =
          match List.assoc_opt "patterns" v with
          | None ->
              []
          | Some v ->
              get_pattern_list v
        in
        Hashtbl.replace tbl k { capture_name; capture_patterns };
        loop (i + 1) captures
  in
  loop 0 captures;
  tbl

and get_pattern_list l = get_list (fun x -> patterns_of_plist (get_dict x)) l

and get_patterns obj =
  (* vscode-textmate's IncludeOnlyRule treats a missing "patterns" key as an
     empty pattern list rather than an error (RuleFactory.getCompiledRuleId:
     `let patterns = desc.patterns` is left `undefined` and
     `_compilePatterns` returns `[]` for that). Some bundled grammars (e.g.
     D's "module" repo entry, Move's "=== DEPRECATED_BELOW ===" entry) rely
     on this: a repository item with neither match/begin nor patterns. *)
  match List.assoc_opt "patterns" obj with
  | None ->
      []
  | Some v ->
      get_pattern_list v

and get_captures_from_dict dict =
  get_captures_helper
    (fun _ (k, _) ->
      match int_of_string_opt k with
      | Some int ->
          Capture_idx int
      | None ->
          Capture_name k
    )
    (fun _ (_, v) -> v)
    dict

and get_captures_from_list list =
  get_captures_helper (fun i _ -> Capture_idx i) (fun _ v -> v) list

and get_captures = function
  | `Assoc d | `Dict d | `O d ->
      get_captures_from_dict d
  | `A l | `Array l | `List l ->
      get_captures_from_list l
  | _ ->
      error "Type error: Expected dict or list."

and patterns_of_plist obj =
  match List.assoc_opt "include" obj with
  | Some s -> (
      match get_string s with
      | "$base" ->
          Include_base
      | "$self" ->
          Include_self
      | s ->
          let len = String.length s in
          if len > 0 && s.[0] = '#' then
            Include_local (String.sub s 1 (len - 1))
          else
            Include_scope s
    )
  | None -> (
      match (List.assoc_opt "match" obj, List.assoc_opt "begin" obj) with
      | Some s, _ ->
          (* vscode-textmate's RuleFactory.getCompiledRuleId checks
             `desc.match` before `desc.begin`/`desc.while`: when a rule has
             both "match" and "begin" (a grammar bug, e.g. CodeQL's
             "select-as-clause" repo entry has "match" where it meant
             "name"), "match" wins outright and begin/end/patterns are
             ignored, rather than the grammar failing to load. *)
          let pattern_source = get_string s in
          Match
            {
              pattern_source;
              pattern = compile_regex pattern_source;
              name = get_name_opt obj "name";
              captures =
                ( match List.assoc_opt "captures" obj with
                | None ->
                    Hashtbl.create 0
                | Some value ->
                    get_captures value
                );
            }
      | None, Some b ->
          let delim_begin_source = get_string b in
          let e, key, delim_kind =
            match (List.assoc_opt "end" obj, List.assoc_opt "while" obj) with
            | _, Some e ->
                (* `while` also takes priority over `end` in vscode-textmate
                   (the `desc.while` check runs before the BeginEndRule
                   fallback), so a rule with both uses `while`. *)
                (e, "whileCaptures", While)
            | Some e, None ->
                (e, "endCaptures", End)
            | None, None ->
                (* A begin rule with neither end nor while (a grammar bug,
                   e.g. Blade's "isset|unset|..." construct rule and XML's
                   bad-comment/CDATA rule meant "match", not "begin".
                   vscode-textmate's BeginEndRule defaults a missing `end`
                   to the sentinel source "￿" (`new RegExpSource(end ?
                   end : "￿", -1)`): a pattern that (in practice) can
                   never match, so the block just runs to the end of the
                   document instead of failing to load. Reuse this
                   codebase's own "impossible pattern" idiom, already used
                   for the same purpose in tokenizer.ml's
                   [retokenize_line]. *)
                (`String "\\A(?!x)x", "endCaptures", End)
          in
          let delim_begin_captures, delim_end_captures =
            match List.assoc_opt "captures" obj with
            | Some value ->
                let captures = get_captures value in
                (captures, captures)
            | None ->
                ( ( match List.assoc_opt "beginCaptures" obj with
                  | Some value ->
                      get_captures value
                  | None ->
                      Hashtbl.create 0
                  ),
                  match List.assoc_opt key obj with
                  | Some value ->
                      get_captures value
                  | None ->
                      Hashtbl.create 0
                )
          in
          Delim
            {
              delim_begin_source;
              delim_begin = compile_regex delim_begin_source;
              delim_end = get_string e;
              delim_patterns =
                ( match List.assoc_opt "patterns" obj with
                | None ->
                    []
                | Some v ->
                    get_pattern_list v
                );
              delim_name = get_name_opt obj "name";
              delim_content_name = get_name_opt obj "contentName";
              delim_begin_captures;
              delim_end_captures;
              delim_apply_end_pattern_last =
                ( match List.assoc_opt "applyEndPatternLast" obj with
                | Some (`Int 1) ->
                    true
                | _ ->
                    false
                );
              delim_kind;
            }
      | None, None ->
          (* Pattern with neither match nor begin acts as a scope wrapper *)
          let scope_name = get_name_opt obj "name" in
          let child_patterns =
            match List.assoc_opt "patterns" obj with
            | None ->
                []
            | Some v ->
                get_pattern_list v
          in
          Scope_patterns { scope_name; child_patterns }
    )

let parse_injection_selector raw =
  let s = String.trim raw in
  if String.length s >= 2 && s.[0] = 'L' && s.[1] = ':' then
    let rest = String.trim (String.sub s 2 (String.length s - 2)) in
    {
      selector_left = true;
      selector_segments =
        String.split_on_char ' ' rest
        |> List.map String.trim
        |> List.filter (fun x -> x <> "");
    }
  else
    let rest =
      if String.length s >= 2 && s.[0] = 'R' && s.[1] = ':' then
        String.trim (String.sub s 2 (String.length s - 2))
      else
        s
    in
    {
      selector_left = false;
      selector_segments =
        String.split_on_char ' ' rest
        |> List.map String.trim
        |> List.filter (fun x -> x <> "");
    }

let get_injections obj =
  match List.assoc_opt "injections" obj with
  | None ->
      []
  | Some inj_obj ->
      let entries = get_dict inj_obj in
      List.filter_map
        (fun (selector_str, value) ->
          let selector = parse_injection_selector selector_str in
          if selector.selector_segments = [] then
            None
          else
            let patterns =
              let d = get_dict value in
              match List.assoc_opt "patterns" d with
              | None -> (
                  match
                    (List.assoc_opt "match" d, List.assoc_opt "begin" d)
                  with
                  | None, None ->
                      []
                  | _, _ ->
                      [ patterns_of_plist d ]
                )
              | Some v ->
                  get_pattern_list v
            in
            Some (selector, patterns)
        )
        entries

let of_doc_exn (plist : union) =
  let rec get_repo_item obj =
    {
      repo_item_kind =
        ( match (List.assoc_opt "match" obj, List.assoc_opt "begin" obj) with
        | None, None ->
            Repo_patterns (get_patterns obj)
        | _, _ ->
            Repo_rule (patterns_of_plist obj)
        );
      repo_inner =
        ( match List.assoc_opt "repository" obj with
        | None ->
            Hashtbl.create 0
        | Some obj ->
            get_repo obj
        );
    }
  and get_repo obj =
    let hashtbl = Hashtbl.create 31 in
    List.iter
      (fun (k, v) ->
        let item =
          (* A repository entry is normally a single rule dict. Racket's
             "lambda-onearg" entry (a grammar bug, probably meant to be
             wrapped in {"patterns": [...]}) is instead a bare array of
             rule dicts. vscode-textmate uses repository values straight
             as a RuleFactory `desc`; an array has no match/begin/patterns/
             include property, so it compiles to an IncludeOnlyRule with
             zero patterns rather than failing to load - i.e. `#lambda-
             onearg` just includes nothing. Match that. *)
          match v with
          | `Assoc d | `Dict d | `O d ->
              get_repo_item d
          | _ ->
              {
                repo_item_kind = Repo_patterns [];
                repo_inner = Hashtbl.create 0;
              }
        in
        Hashtbl.add hashtbl k item
      )
      (get_dict obj);
    hashtbl
  in
  let obj = get_dict plist in
  {
    name = Option.map get_string (List.assoc_opt "name" obj);
    scope_name = get_string (find_exn "scopeName" obj);
    injection_selector =
      Option.map get_string (List.assoc_opt "injectionSelector" obj);
    filetypes =
      ( match List.assoc_opt "fileTypes" obj with
      | None ->
          []
      | Some filetypes ->
          get_list get_string filetypes
      );
    patterns = get_patterns obj;
    repository =
      ( match List.assoc_opt "repository" obj with
      | None ->
          Hashtbl.create 0
      | Some obj ->
          get_repo obj
      );
    injections = get_injections obj;
  }

let of_plist_exn = (of_doc_exn :> plist -> grammar)
let of_ezjsonm_exn = (of_doc_exn :> ezjsonm -> grammar)
let of_yojson_exn = (of_doc_exn :> yojson -> grammar)
