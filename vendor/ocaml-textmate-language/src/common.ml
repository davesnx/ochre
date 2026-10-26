type capture_key = Capture_idx of int | Capture_name of string

module IntMap = Map.Make (Int)

type capture = { capture_name : string option; capture_patterns : rule list }
and regex = Oniguruma.Encoding.utf8 Oniguruma.t

and match_ = {
  name : string option;
  pattern_source : string;
  pattern : regex;
  pattern_first : (char -> bool) option;
  captures : (capture_key, capture) Hashtbl.t;
}

and delim_kind = End | While

and delim = {
  delim_begin_source : string;
  delim_begin : regex;
  delim_begin_first : (char -> bool) option;
  delim_end : string; (* Either an end or a while pattern *)
  delim_end_regex : regex option;
  delim_patterns : rule list;
  delim_name : string option;
  delim_content_name : string option;
  delim_begin_captures : (capture_key, capture) Hashtbl.t;
  delim_end_captures : (capture_key, capture) Hashtbl.t;
  delim_apply_end_pattern_last : bool;
  delim_kind : delim_kind;
}

and rule =
  | Match of match_
  | Delim of delim
  | Scope_patterns of rule list
  | Include_local of string
  | Include_scope of string
  | Include_scope_rule of { scope : string; rule : string }
  | Include_self
  | Include_base

type repo_item_kind = Repo_rule of rule | Repo_patterns of rule list

type repo_item = {
  repo_item_kind : repo_item_kind;
  repo_inner : (string, repo_item) Hashtbl.t;
}

type injection_selector = {
  selector_segments : string list;
  selector_left : bool;
}

type grammar = {
  name : string option;
  scope_name : string;
  injection_selector : string option;
  parsed_injection_selector : injection_selector option;
  filetypes : string list;
  patterns : rule list;
  repository : (string, repo_item) Hashtbl.t;
  injections : (injection_selector * rule list) list;
}

type t = {
  by_name : (string, grammar) Hashtbl.t;
  by_scope_name : (string, grammar) Hashtbl.t;
  by_filetype : (string, grammar) Hashtbl.t;
}

type union =
  [ `Bool of bool
  | `Data of string
  | `Date of float * float option
  | `Float of float
  | `Int of int
  | `String of string
  | `Array of union list
  | `Dict of (string * union) list
  | `Null
  | `A of union list
  | `O of (string * union) list
  | `Assoc of (string * union) list
  | `List of union list ]

type plist =
  [ `Bool of bool
  | `Data of string
  | `Date of float * float option
  | `Float of float
  | `Int of int
  | `String of string
  | `Array of plist list
  | `Dict of (string * plist) list ]

type ezjsonm =
  [ `Null
  | `Bool of bool
  | `Float of float
  | `String of string
  | `A of ezjsonm list
  | `O of (string * ezjsonm) list ]

type yojson =
  [ `Null
  | `Bool of bool
  | `Int of int
  | `Float of float
  | `String of string
  | `Assoc of (string * yojson) list
  | `List of yojson list ]

exception Error of string

(* As vscode-textmate's RegExpSource: [\z] becomes a pattern that only matches
   at the end of a line that does not end with a newline. *)
let rewrite_end_of_text re =
  if not (String.contains re 'z') then
    re
  else
    let len = String.length re in
    let buf = Buffer.create len in
    let rec go i =
      if i < len then
        if re.[i] = '\\' && i + 1 < len then (
          if re.[i + 1] = 'z' then
            Buffer.add_string buf "$(?!\\n)(?<!\\n)"
          else (
            Buffer.add_char buf '\\';
            Buffer.add_char buf re.[i + 1]
          );
          go (i + 2)
        ) else (
          Buffer.add_char buf re.[i];
          go (i + 1)
        )
    in
    go 0;
    Buffer.contents buf

let compile_regex ?error_context re =
  (* TextMate/Oniguruma grammars routinely mix numbered groups with named
     groups in the same pattern (e.g. Swift's regex-literal-callout rule
     uses \g<20> alongside (?<name>...)). Oniguruma's default syntax turns
     off numbered-group capture once a named group is present in the same
     pattern ("numbered backref/call is not allowed. (use name)"), unlike
     vscode-oniguruma, which always compiles with ONIG_OPTION_CAPTURE_GROUP
     so unnamed groups keep their numbers regardless. Match that. *)
  match
    Oniguruma.create (rewrite_end_of_text re) Oniguruma.Options.capture_group
      Oniguruma.Encoding.utf8 Oniguruma.Syntax.default
  with
  | Ok re ->
      re
  | Error msg ->
      let prefix =
        match error_context with
        | None ->
            re
        | Some context ->
            context ^ ": " ^ re
      in
      raise (Error (prefix ^ ": " ^ msg))

let has_backrefs pattern =
  let len = String.length pattern in
  let rec go i =
    i + 1 < len
    &&
    if pattern.[i] <> '\\' then
      go (i + 1)
    else if pattern.[i + 1] >= '0' && pattern.[i + 1] <= '9' then
      true
    else
      go (i + 2)
  in
  go 0

let create () =
  {
    by_name = Hashtbl.create 23;
    by_scope_name = Hashtbl.create 23;
    by_filetype = Hashtbl.create 23;
  }

let add_grammar t grammar =
  ( match grammar.name with
  | Some name ->
      Hashtbl.replace t.by_name (String.lowercase_ascii name) grammar
  | None ->
      ()
  );
  Hashtbl.replace t.by_scope_name grammar.scope_name grammar;
  List.iter
    (fun filetype -> Hashtbl.replace t.by_filetype filetype grammar)
    grammar.filetypes

let find_by_name t name =
  Hashtbl.find_opt t.by_name (String.lowercase_ascii name)

let find_by_scope_name t = Hashtbl.find_opt t.by_scope_name
let find_by_filetype t = Hashtbl.find_opt t.by_filetype
let error msg = raise (Error msg)
