open Common

type token = { ending : int; scopes : string list }

let ending token = token.ending
let scopes token = token.scopes

type stack_elem = {
  stack_delim : delim;
  stack_enter_pos : int option;
  stack_resume_anchor : int option;
  stack_end_re : regex;
  stack_grammar : grammar;
  stack_repos : (string, repo_item) Hashtbl.t list;
  stack_scopes : string list;
  stack_prev_scopes : string list;
}

type stack = stack_elem list

let empty = []

let add_scope scopes = function
  | None -> scopes
  | Some x ->
    List.fold_left
      (fun acc scope -> if scope = "" then acc else scope :: acc)
      scopes
      (String.split_on_char ' ' x)

let add_scopes scopes names = List.fold_left add_scope scopes names
let has_progress start ending = ending > start

type matched_region = {
  region : Oniguruma.Region.t;
  regex : regex;
  end_ : int;
}

type match_result =
  | No_match
  | Empty_match of matched_region
  | Nonempty_match of matched_region

let anchor_options ~anchor ~pos =
  if anchor <> Some pos then Oniguruma.Options.not_begin_position
  else Oniguruma.Options.none

let match_pattern regex line pos anchor =
  match Oniguruma.match_ regex line pos (anchor_options ~anchor ~pos) with
  | exception Oniguruma.Error _ -> No_match
  | None -> No_match
  | Some region ->
    let start = Oniguruma.Region.capture_beg region 0 in
    let end_ = Oniguruma.Region.capture_end region 0 in
    if start <> pos then No_match
    else
      let matched = { region; regex; end_ } in
      if has_progress start end_ then Nonempty_match matched
      else Empty_match matched

let has_same_delim_at_pos stack delim pos =
  List.exists
    (fun se -> se.stack_enter_pos = Some pos && se.stack_delim == delim)
    stack

let next_pats grammar = function
  | [] -> grammar.patterns
  | s :: _ -> s.stack_delim.delim_patterns

let is_special = function
  | '|' | '.' | '*' | '+' | '?' | '^' | '$' | '-' | ':' | '~' | '#' | '&' | '('
  | ')' | '[' | ']' | '{' | '}' | '<' | '>' | '\\' | '\'' ->
    true
  | _ -> false

let insert_capture buf line beg end_ =
  for i = beg to end_ - 1 do
    let ch = line.[i] in
    if is_special ch then Buffer.add_char buf '\\';
    Buffer.add_char buf ch
  done

let subst_backrefs delim line region =
  let { delim_end = regex_str; delim_begin = begin_re; _ } = delim in
  let buf = Buffer.create (String.length regex_str) in
  let num_beg_captures = Oniguruma.num_captures begin_re in
  let regex_len = String.length regex_str in
  let rec loop i escaped =
    if i < regex_len then
      match (regex_str.[i], escaped) with
      | '\\', true ->
        Buffer.add_string buf "\\\\";
        loop (i + 1) false
      | '\\', false -> loop (i + 1) true
      | char, true ->
        if char >= '0' && char <= '9' then (
          let idx = Char.code char - Char.code '0' in
          if idx < num_beg_captures then
            let beg = Oniguruma.Region.capture_beg region idx in
            let end_ = Oniguruma.Region.capture_end region idx in
            if beg <> -1 then insert_capture buf line beg end_)
        else (
          Buffer.add_char buf '\\';
          Buffer.add_char buf char);
        loop (i + 1) false
      | char, false ->
        Buffer.add_char buf char;
        loop (i + 1) false
  in
  loop 0 false;
  Buffer.contents buf

let rec find_nested scope = function
  | [] -> None
  | repo :: repos -> (
    match Hashtbl.find_opt repo scope with
    | Some x -> Some x
    | None -> find_nested scope repos)

let remove_empties =
  let rec go acc = function
    | [] -> acc
    | tok :: toks ->
      let prev =
        match toks with
        | [] -> 0
        | tok :: _ -> tok.ending
      in
      if tok.ending = prev then go acc toks else go (tok :: acc) toks
  in
  go []

let retokenize_ref =
  ref
    (fun
      ~t:_ ~grammar:_ ~scopes:_ ~patterns:_ ~pos:_ ~end_pos:_ ~toks ~line:_ ->
      (toks : token list))

let handle_captures ~t ~grammar ~line scopes default mat_start mat_end region
    captures tokens =
  let region_len = Oniguruma.Region.length region in
  let captures =
    Hashtbl.fold
      (fun k capture acc ->
        match k with
        (* Capture_name keys come from non-numeric keys in the grammar JSON
           captures dict (e.g. {"name": ...} at the captures level rather than
           {"0": ...}). These are not regex named groups — they are malformed
           or exotic grammar entries. vscode-textmate also ignores them. *)
        | Capture_name _ -> acc
        | Capture_idx idx ->
          if idx < 0 || idx >= region_len then acc
          else
            let beg = Oniguruma.Region.capture_beg region idx in
            let end_ = Oniguruma.Region.capture_end region idx in
            if beg = -1 || beg = end_ then acc
            else if
              capture.capture_name = None && capture.capture_patterns = []
            then acc
            else (idx, capture, beg, end_) :: acc)
      captures []
  in
  let captures =
    List.stable_sort
      (fun (idx1, _, start1, end1) (idx2, _, start2, end2) ->
        let c = compare start1 start2 in
        if c <> 0 then c
        else
          let c = compare end2 end1 in
          if c <> 0 then c else compare idx1 idx2)
      captures
  in
  let _, _, stack, tokens =
    List.fold_left
      (fun (prev_idx, start, stack, tokens) (_, capture, cap_start, cap_end) ->
        let rec pop prev_idx start tokens = function
          | [] ->
            let ending = max prev_idx start in
            ( ending,
              { scopes = add_scope scopes default; ending } :: tokens,
              [] )
          | (ending, scopes) :: stack' as stack ->
            if start >= ending then
              pop (max prev_idx ending) start
                ({ scopes; ending } :: tokens)
                stack'
            else
              let ending = max prev_idx start in
              (ending, { scopes; ending } :: tokens, stack)
        in
        let cap_start = max cap_start start in
        let cap_end = min cap_end mat_end in
        if capture.capture_patterns <> [] then
          let cap_scopes =
            add_scopes scopes [ default; capture.capture_name ]
          in
          let tokens =
            if prev_idx < cap_start then
              { scopes = add_scope scopes default; ending = cap_start }
              :: tokens
            else tokens
          in
          let tokens =
            !retokenize_ref ~t ~grammar ~scopes:cap_scopes
              ~patterns:capture.capture_patterns ~pos:cap_start
              ~end_pos:cap_end ~toks:tokens ~line
          in
          (cap_end, cap_end, stack, tokens)
        else
          let prev_idx, tokens, stack = pop prev_idx cap_start tokens stack in
          let base_scopes =
            match stack with
            | (_, top_scopes) :: _ -> top_scopes
            | [] -> add_scope scopes default
          in
          ( prev_idx,
            cap_start,
            (cap_end, add_scope base_scopes capture.capture_name) :: stack,
            tokens ))
      (mat_start, mat_start, [], tokens)
      captures
  in
  let rec pop tokens = function
    | [] -> tokens
    | (ending, scopes) :: stack -> pop ({ scopes; ending } :: tokens) stack
  in
  pop tokens stack

let emit_scope_token scopes name ending toks =
  { scopes = add_scope scopes name; ending } :: toks

type candidate_kind = Candidate_match of match_ | Candidate_delim of delim

type candidate = {
  candidate_kind : candidate_kind;
  candidate_repos : (string, repo_item) Hashtbl.t list;
  candidate_grammar : grammar;
  candidate_scope : string option;
}

let candidate_regex_source = function
  | { candidate_kind = Candidate_match m; _ } -> m.pattern_source
  | { candidate_kind = Candidate_delim d; _ } -> d.delim_begin_source

let candidate_regex = function
  | { candidate_kind = Candidate_match m; _ } -> m.pattern
  | { candidate_kind = Candidate_delim d; _ } -> d.delim_begin

let rec collect_candidates ~t ~base_grammar ?(scope = None) repos cur_grammar =
  function
  | [] -> []
  | Match m :: pats ->
    {
      candidate_kind = Candidate_match m;
      candidate_repos = repos;
      candidate_grammar = cur_grammar;
      candidate_scope = scope;
    }
    :: collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Delim d :: pats ->
    {
      candidate_kind = Candidate_delim d;
      candidate_repos = repos;
      candidate_grammar = cur_grammar;
      candidate_scope = scope;
    }
    :: collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Scope_patterns { scope_name; child_patterns } :: pats ->
    let inner_scope =
      match scope_name with
      | Some _ -> scope_name
      | None -> scope
    in
    collect_candidates ~t ~base_grammar ~scope:inner_scope repos cur_grammar
      child_patterns
    @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Include_scope name :: pats -> (
    match find_by_scope_name t name with
    | None -> collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
    | Some g ->
      collect_candidates ~t ~base_grammar ~scope [ g.repository ] g g.patterns
      @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats)
  | Include_base :: pats ->
    collect_candidates ~t ~base_grammar ~scope
      [ base_grammar.repository ]
      base_grammar base_grammar.patterns
    @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Include_self :: pats ->
    collect_candidates ~t ~base_grammar ~scope [ cur_grammar.repository ]
      cur_grammar cur_grammar.patterns
    @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Include_local key :: pats -> (
    match find_nested key repos with
    | None -> collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
    | Some item -> (
      match item.repo_item_kind with
      | Repo_rule rule ->
        collect_candidates ~t ~base_grammar ~scope (item.repo_inner :: repos)
          cur_grammar (rule :: pats)
      | Repo_patterns pats' ->
        collect_candidates ~t ~base_grammar ~scope (item.repo_inner :: repos)
          cur_grammar pats'
        @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats))

let scope_matches_selector_part scope part =
  scope = part
  || String.length part < String.length scope
     && String.starts_with ~prefix:part scope
     && scope.[String.length part] = '.'

let injection_selector_matches scopes (sel : injection_selector) =
  let rev_scopes = List.rev scopes in
  let rec go segments scope_list =
    match segments with
    | [] -> true
    | seg :: rest_segs -> (
      match scope_list with
      | [] -> false
      | scope :: rest_scopes ->
        if scope_matches_selector_part scope seg then go rest_segs rest_scopes
        else go segments rest_scopes)
  in
  go sel.selector_segments rev_scopes

let collect_injection_candidates ~t ~base_grammar scopes =
  let left = ref [] in
  let right = ref [] in
  let check_injections injections grammar =
    List.iter
      (fun (sel, patterns) ->
        if injection_selector_matches scopes sel then begin
          let cs =
            collect_candidates ~t ~base_grammar [ grammar.repository ] grammar
              patterns
          in
          if sel.selector_left then left := List.rev_append cs !left
          else right := List.rev_append cs !right
        end)
      injections
  in
  check_injections base_grammar.injections base_grammar;
  Hashtbl.iter
    (fun _name (g : grammar) ->
      if g.scope_name <> base_grammar.scope_name then
        match g.injection_selector with
        | None -> ()
        | Some sel_str ->
          let sel = Reader.parse_injection_selector sel_str in
          if injection_selector_matches scopes sel then begin
            let cs =
              collect_candidates ~t ~base_grammar [ g.repository ] g g.patterns
            in
            if sel.selector_left then left := List.rev_append cs !left
            else right := List.rev_append cs !right
          end)
    t.by_scope_name;
  (List.rev !left, List.rev !right)

let drop n list =
  let rec loop n = function
    | _ :: rest when n > 0 -> loop (n - 1) rest
    | l -> l
  in
  loop n list

module RegSet_cache : sig
  val find_or_create : string list -> Oniguruma.RegSet.t
end = struct
  let max_size = 256

  let tbl : (string list, Oniguruma.RegSet.t) Hashtbl.t =
    Hashtbl.create max_size

  let find_or_create sources =
    match Hashtbl.find_opt tbl sources with
    | Some regset -> regset
    | None ->
      if Hashtbl.length tbl >= max_size then Hashtbl.clear tbl;
      let regexes =
        sources
        |> List.map (fun src ->
            compile_regex ~error_context:("RegSet scanner pattern: " ^ src) src)
        |> Array.of_list
      in
      let regset = Oniguruma.RegSet.create regexes in
      Hashtbl.replace tbl sources regset;
      regset
end

let search_candidates_at_pos ~line ~pos ~anchor candidates =
  match candidates with
  | [] -> None
  | _ -> (
    let sources = List.map candidate_regex_source candidates in
    let regset = RegSet_cache.find_or_create sources in
    match
      Oniguruma.RegSet.search regset line pos (String.length line)
        (anchor_options ~anchor ~pos)
    with
    | exception Oniguruma.Error _ -> None
    | None -> None
    | Some (idx, region) -> (
      if Oniguruma.Region.capture_beg region 0 <> pos then None
      else
        match drop idx candidates with
        | [] -> None
        | candidate :: _ ->
          let end_ = Oniguruma.Region.capture_end region 0 in
          let matched = { region; regex = candidate_regex candidate; end_ } in
          if has_progress pos end_ then
            Some (idx, candidate, Nonempty_match matched)
          else Some (idx, candidate, Empty_match matched)))

let frame_scopes grammar = function
  | [] -> [ grammar.scope_name ]
  | se :: _ -> se.stack_scopes

let frame_repos grammar = function
  | [] -> [ grammar.repository ]
  | se :: _ -> se.stack_repos

let frame_grammar grammar = function
  | [] -> grammar
  | se :: _ -> se.stack_grammar

let rec match_line ~t ~grammar ~stack ~anchor ~pos ~toks ~line rem_pats =
  let len = String.length line in
  let scopes = frame_scopes grammar stack in
  let try_pats repos cur_grammar ~k pats =
    let base_candidates =
      collect_candidates ~t ~base_grammar:grammar repos cur_grammar pats
    in
    let inj_left, inj_right =
      collect_injection_candidates ~t ~base_grammar:grammar scopes
    in
    let candidates = inj_left @ base_candidates @ inj_right in
    let rec try_candidates candidates =
      match search_candidates_at_pos ~line ~pos ~anchor candidates with
      | None -> k ()
      | Some (idx, candidate, result) -> (
        let remaining = drop (idx + 1) candidates in
        match (candidate.candidate_kind, result) with
        | _, No_match | Candidate_match _, Empty_match _ ->
          try_candidates remaining
        | Candidate_match m, Nonempty_match matched ->
          let scopes = add_scope scopes candidate.candidate_scope in
          let toks = { scopes; ending = pos } :: toks in
          let toks =
            handle_captures ~t ~grammar:candidate.candidate_grammar ~line
              scopes m.name pos matched.end_ matched.region m.captures toks
          in
          let toks = emit_scope_token scopes m.name matched.end_ toks in
          match_line ~t ~grammar ~stack ~anchor ~pos:matched.end_ ~toks ~line
            (next_pats grammar stack)
        | Candidate_delim d, Empty_match _
          when has_same_delim_at_pos stack d pos ->
          match_line ~t ~grammar ~stack ~anchor ~pos:(pos + 1) ~toks ~line
            (next_pats grammar stack)
        | ( Candidate_delim d,
            ( Empty_match ({ region; end_; _ } as matched)
            | Nonempty_match ({ region; end_; _ } as matched) ) ) ->
          let scopes = add_scope scopes candidate.candidate_scope in
          let toks = { scopes; ending = pos } :: toks in
          let toks =
            handle_captures ~t ~grammar:candidate.candidate_grammar ~line
              scopes d.delim_name pos matched.end_ matched.region
              d.delim_begin_captures toks
          in
          let toks = emit_scope_token scopes d.delim_name matched.end_ toks in
          let child_scopes =
            add_scopes scopes [ d.delim_name; d.delim_content_name ]
          in
          let stack_end_re =
            compile_regex
              ~error_context:("End pattern for " ^ d.delim_end)
              (subst_backrefs d line region)
          in
          let se =
            {
              stack_delim = d;
              stack_enter_pos = Some pos;
              stack_resume_anchor = anchor;
              stack_end_re;
              stack_repos = candidate.candidate_repos;
              stack_grammar = candidate.candidate_grammar;
              stack_scopes = child_scopes;
              stack_prev_scopes = scopes;
            }
          in
          match_line ~t ~grammar ~stack:(se :: stack) ~anchor:(Some end_)
            ~pos:end_ ~toks ~line d.delim_patterns)
    in
    try_candidates candidates
  in
  let try_delim_end se stack_tail ~k =
    let delim = se.stack_delim in
    let end_match = match_pattern se.stack_end_re line pos anchor in
    let emit_end_captures matched toks =
      let toks =
        {
          scopes =
            add_scopes se.stack_prev_scopes
              [ delim.delim_name; delim.delim_content_name ];
          ending = pos;
        }
        :: toks
      in
      handle_captures ~t ~grammar:se.stack_grammar ~line se.stack_prev_scopes
        delim.delim_name pos matched.end_ matched.region
        delim.delim_end_captures toks
    in
    match (delim.delim_kind, end_match) with
    | End, No_match -> k ()
    | End, Empty_match matched when se.stack_enter_pos = Some pos ->
      let toks = emit_end_captures matched toks in
      match_line ~t ~grammar ~stack:stack_tail ~anchor:se.stack_resume_anchor
        ~pos:(pos + 1) ~toks ~line
        (next_pats grammar stack_tail)
    | End, (Empty_match matched | Nonempty_match matched) ->
      let toks = emit_end_captures matched toks in
      let toks = emit_scope_token scopes delim.delim_name matched.end_ toks in
      match_line ~t ~grammar ~stack:stack_tail ~anchor:se.stack_resume_anchor
        ~pos:matched.end_ ~toks ~line
        (next_pats grammar stack_tail)
    | While, _ -> error "Unreachable"
  in
  if pos > len then
    let end_scopes =
      match stack with
      | [] -> scopes
      | se :: _ -> add_scope scopes se.stack_delim.delim_name
    in
    (remove_empties ({ scopes = end_scopes; ending = len } :: toks), stack)
  else
    let continue () =
      match_line ~t
        ~grammar:(frame_grammar grammar stack)
        ~stack ~anchor ~pos:(pos + 1) ~toks ~line
        (match stack with
        | [] -> rem_pats
        | se :: _ -> se.stack_delim.delim_patterns)
    in
    match stack with
    | [] -> try_pats (frame_repos grammar stack) grammar rem_pats ~k:continue
    | se :: stack' -> (
      match se.stack_delim.delim_kind with
      | While ->
        try_pats
          (frame_repos grammar stack)
          se.stack_grammar rem_pats ~k:continue
      | End ->
        if se.stack_delim.delim_apply_end_pattern_last then
          try_pats (frame_repos grammar stack) se.stack_grammar rem_pats
            ~k:(fun () -> try_delim_end se stack' ~k:continue)
        else
          try_delim_end se stack' ~k:(fun () ->
              try_pats
                (frame_repos grammar stack)
                se.stack_grammar rem_pats ~k:continue))

let unmatchable_re = compile_regex "\\A(?!x)x"
let empty_captures = Hashtbl.create 0

let retokenize_line ~t ~grammar ~scopes ~patterns ~pos ~end_pos ~toks ~line =
  let se =
    {
      stack_delim =
        {
          delim_begin_source = "";
          delim_begin = unmatchable_re;
          delim_end = "\\A(?!x)x";
          delim_patterns = patterns;
          delim_name = None;
          delim_content_name = None;
          delim_begin_captures = empty_captures;
          delim_end_captures = empty_captures;
          delim_apply_end_pattern_last = false;
          delim_kind = End;
        };
      stack_enter_pos = None;
      stack_resume_anchor = None;
      stack_end_re = unmatchable_re;
      stack_grammar = grammar;
      stack_repos = [ grammar.repository ];
      stack_scopes = scopes;
      stack_prev_scopes = scopes;
    }
  in
  let sub_line = String.sub line 0 end_pos in
  let sub_toks, _ =
    match_line ~t ~grammar ~stack:[ se ] ~anchor:(Some pos) ~pos ~toks:[]
      ~line:sub_line patterns
  in
  let rec take_until_pos = function
    | [] -> []
    | tok :: rest ->
      if tok.ending <= pos then [] else tok :: take_until_pos rest
  in
  remove_empties (take_until_pos sub_toks) @ toks

let () = retokenize_ref := retokenize_line

let tokenize_exn t grammar stack line =
  let rec try_while_rules pos anchor toks rem_stack = function
    | [] -> (toks, pos, anchor, rem_stack)
    | se :: stack -> (
      match se.stack_delim.delim_kind with
      | End -> try_while_rules pos anchor toks (se :: rem_stack) stack
      | While ->
        let rec loop pos' =
          if pos' = String.length line then (toks, pos, anchor, rem_stack)
          else
            match match_pattern se.stack_end_re line pos' anchor with
            | No_match | Empty_match _ -> loop (pos' + 1)
            | Nonempty_match matched ->
              let toks =
                let toks =
                  if pos' > pos then
                    { scopes = se.stack_scopes; ending = pos' } :: toks
                  else toks
                in
                let toks =
                  handle_captures ~t ~grammar:se.stack_grammar ~line
                    se.stack_prev_scopes se.stack_delim.delim_name pos'
                    matched.end_ matched.region
                    se.stack_delim.delim_end_captures toks
                in
                emit_scope_token se.stack_prev_scopes se.stack_delim.delim_name
                  matched.end_ toks
              in
              try_while_rules matched.end_ (Some matched.end_) toks
                (se :: rem_stack) stack
        in
        loop pos)
  in
  let toks, pos, anchor, stack =
    try_while_rules 0 None [] [] (List.rev stack)
  in
  let toks, stack =
    match_line ~t ~grammar ~stack ~anchor ~pos ~toks ~line
      (next_pats grammar stack)
  in
  let stack =
    List.map
      (fun se ->
        { se with stack_enter_pos = None; stack_resume_anchor = None })
      stack
  in
  (toks, stack)
