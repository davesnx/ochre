open Common

type token = { ending : int; scopes : string list }

let ending token = token.ending
let scopes token = token.scopes

type line_id = unit ref

module Scope_set = Set.Make (String)

let add_scope_prefixes set = function
  | None ->
      set
  | Some names ->
      List.fold_left
        (fun set name ->
          let rec go set i =
            match String.index_from_opt name i '.' with
            | Some dot ->
                go (Scope_set.add (String.sub name 0 dot) set) (dot + 1)
            | None ->
                Scope_set.add name set
          in
          if name = "" then
            set
          else
            go set 0
        )
        set
        (String.split_on_char ' ' names)

let scope_set_of_scopes scopes =
  List.fold_left
    (fun set scope -> add_scope_prefixes set (Some scope))
    Scope_set.empty scopes

type stack_elem = {
  stack_delim : delim;
  stack_enter : (line_id * int) option;
  stack_resume_anchor : (line_id * int) option;
  stack_has_while : bool;
  stack_begin_eol : bool;
  stack_end_re : regex;
  stack_grammar : grammar;
  stack_repos : (string, repo_item) Hashtbl.t list;
  stack_name : string option;
  stack_content_name : string option;
  stack_scopes : string list;
  stack_scope_set : Scope_set.t;
  stack_prev_scopes : string list;
  stack_retokenizing : (int * int * rule list) list;
}

type stack = { first_line : bool; frames : stack_elem list }

let empty = { first_line = true; frames = [] }

let add_scope scopes = function
  | None ->
      scopes
  | Some x ->
      List.fold_left
        (fun acc scope ->
          if scope = "" then
            acc
          else
            scope :: acc
        )
        scopes
        (String.split_on_char ' ' x)

let add_scopes scopes names = List.fold_left add_scope scopes names
let has_progress start ending = ending > start

type matched_region = { region : Oniguruma.Region.t; regex : regex; end_ : int }

type match_result =
  | No_match
  | Empty_match of matched_region
  | Nonempty_match of matched_region

(* Oniguruma cannot interrupt a match in progress, so one call can run past
   the deadline. *)
type clock = { mutable calls : int; mutable expired : bool; deadline : float }

let clock_check_interval = 16

let match_regex clock regex line pos options =
  clock.calls <- clock.calls + 1;
  if
    (not clock.expired)
    && clock.calls mod clock_check_interval = 0
    && Unix.gettimeofday () > clock.deadline
  then
    clock.expired <- true;
  if clock.expired then
    None
  else
    try Oniguruma.match_ regex line pos options with Oniguruma.Error _ -> None

(* As vscode-textmate, [\A] only matches on the first line and [\G] only at the
   anchor. *)
let anchor_options ~first_line ~anchor ~pos =
  let options =
    if anchor <> Some pos then
      Oniguruma.Options.not_begin_position
    else
      Oniguruma.Options.none
  in
  if first_line then
    options
  else
    Oniguruma.Options.(options <+> not_begin_string)

(* On malformed UTF-8 Oniguruma can report a match that ends past the end of
   the subject. *)
let capture_span ~len region idx =
  if idx < 0 || idx >= Oniguruma.Region.length region then
    None
  else
    let beg = Oniguruma.Region.capture_beg region idx in
    let end_ = Oniguruma.Region.capture_end region idx in
    if beg < 0 || end_ < beg || end_ > len then
      None
    else
      Some (beg, end_)

let classify_match ~pos ~len regex region =
  match capture_span ~len region 0 with
  | Some (start, end_) when start = pos ->
      let matched = { region; regex; end_ } in
      if has_progress start end_ then
        Nonempty_match matched
      else
        Empty_match matched
  | Some _ | None ->
      No_match

let match_pattern ~first_line clock regex line pos anchor =
  match
    match_regex clock regex line pos (anchor_options ~first_line ~anchor ~pos)
  with
  | None ->
      No_match
  | Some region ->
      classify_match ~pos ~len:(String.length line) regex region

let entered_at line_id se pos =
  match se.stack_enter with
  | Some (id, at) ->
      id == line_id && at = pos
  | None ->
      false

let resume_anchor line_id se =
  match se.stack_resume_anchor with
  | Some (id, anchor) when id == line_id ->
      Some anchor
  | Some _ | None ->
      None

let rec has_same_delim_at_pos line_id stack delim pos =
  match stack with
  | se :: rest when entered_at line_id se pos ->
      se.stack_delim == delim || has_same_delim_at_pos line_id rest delim pos
  | _ ->
      false

let next_pats grammar = function
  | [] ->
      grammar.patterns
  | s :: _ ->
      s.stack_delim.delim_patterns

let is_special = function
  | '|'
  | '.'
  | '*'
  | '+'
  | '?'
  | '^'
  | '$'
  | '-'
  | ':'
  | '~'
  | '#'
  | '&'
  | '('
  | ')'
  | '['
  | ']'
  | '{'
  | '}'
  | '<'
  | '>'
  | '\\'
  | '\'' ->
      true
  | _ ->
      false

let insert_capture buf text =
  String.iter
    (fun ch ->
      if is_special ch then Buffer.add_char buf '\\';
      Buffer.add_char buf ch
    )
    text

let subst_backrefs delim line region =
  let { delim_end = regex_str; delim_begin = begin_re; _ } = delim in
  let buf = Buffer.create (String.length regex_str) in
  let num_beg_captures = Oniguruma.num_captures begin_re in
  let regex_len = String.length regex_str in
  let len = String.length line in
  let valid = ref true in
  let rec loop i escaped =
    if i < regex_len then
      match (regex_str.[i], escaped) with
      | '\\', true ->
          Buffer.add_string buf "\\\\";
          loop (i + 1) false
      | '\\', false ->
          loop (i + 1) true
      | char, true ->
          if char >= '0' && char <= '9' then (
            let idx = Char.code char - Char.code '0' in
            if idx <= num_beg_captures then
              match capture_span ~len region idx with
              | Some (beg, end_) ->
                  let text = String.sub line beg (end_ - beg) in
                  if String.is_valid_utf_8 text then
                    insert_capture buf text
                  else
                    valid := false
              | None ->
                  ()
          ) else (
            Buffer.add_char buf '\\';
            Buffer.add_char buf char
          );
          loop (i + 1) false
      | char, false ->
          Buffer.add_char buf char;
          loop (i + 1) false
  in
  loop 0 false;
  if !valid then
    Some (Buffer.contents buf)
  else
    None

let rec find_nested scope = function
  | [] ->
      None
  | repo :: repos -> (
      match Hashtbl.find_opt repo scope with
      | Some x ->
          Some x
      | None ->
          find_nested scope repos
    )

type candidate_kind = Candidate_match of match_ | Candidate_delim of delim

type candidate = {
  candidate_kind : candidate_kind;
  candidate_repos : (string, repo_item) Hashtbl.t list;
  candidate_grammar : grammar;
}

type candidate_groups = {
  left : candidate list;
  base : candidate list;
  right : candidate list;
}

type line_state = {
  mutable entries :
    (stack_elem option * rule list * grammar * candidate_groups) list;
  clock : clock;
  line_id : line_id;
  first_line : bool;
  eol : int;
}

let max_cached_frames = 16

let last_ending = function [] -> 0 | tok :: _ -> tok.ending

(* As vscode-textmate's [LineTokens.produce]: a token that does not end past
   the previous one is dropped. *)
let produce toks scopes ending =
  if ending <= last_ending toks then
    toks
  else
    { scopes; ending } :: toks

let retokenize_ref =
  ref
    (fun
      ~t:_
      ~state:_
      ~base:_
      ~grammar:_
      ~repos:_
      ~scopes:_
      ~patterns:_
      ~active:_
      ~pos:_
      ~end_pos:_
      ~toks
      ~line:_
    -> (toks : token list)
  )

let is_digit c = c >= '0' && c <= '9'

let strip_leading_dots text =
  let len = String.length text in
  let rec first_other i =
    if i < len && text.[i] = '.' then
      first_other (i + 1)
    else
      i
  in
  let start = first_other 0 in
  if start = 0 then
    text
  else
    String.sub text start (len - start)

(* As vscode-textmate's [replaceCaptures]. *)
let expand_capture_refs ~line region name =
  if not (String.contains name '$') then
    name
  else
    let len = String.length line in
    let n = String.length name in
    let buf = Buffer.create n in
    let group_text idx command =
      match capture_span ~len region idx with
      | Some (beg, end_) -> (
          let text = strip_leading_dots (String.sub line beg (end_ - beg)) in
          match command with
          | `Downcase ->
              String.lowercase_ascii text
          | `Upcase ->
              String.uppercase_ascii text
          | `Keep ->
              text
        )
      | None ->
          ""
    in
    let digits_end i =
      let j = ref i in
      while !j < n && is_digit name.[!j] do
        incr j
      done;
      !j
    in
    let index_of first last =
      if last - first > 9 then
        None
      else
        let idx = int_of_string (String.sub name first (last - first)) in
        if idx < Oniguruma.Region.length region then
          Some idx
        else
          None
    in
    let command_at i =
      let has prefix =
        let width = String.length prefix in
        i + width <= n && String.sub name i width = prefix
      in
      if has ":/downcase}" then
        Some (`Downcase, String.length ":/downcase}")
      else if has ":/upcase}" then
        Some (`Upcase, String.length ":/upcase}")
      else
        None
    in
    let rec go i =
      if i < n then
        if name.[i] <> '$' then (
          Buffer.add_char buf name.[i];
          go (i + 1)
        ) else
          let first = i + 1 in
          let last = digits_end first in
          if last > first then (
            ( match index_of first last with
            | Some idx ->
                Buffer.add_string buf (group_text idx `Keep)
            | None ->
                Buffer.add_string buf (String.sub name i (last - i))
            );
            go last
          ) else if first < n && name.[first] = '{' then (
            let first = first + 1 in
            let last = digits_end first in
            match (last > first, command_at last, index_of first last) with
            | true, Some (command, width), Some idx ->
                Buffer.add_string buf (group_text idx command);
                go (last + width)
            | _ ->
                Buffer.add_char buf '$';
                go (i + 1)
          ) else (
            Buffer.add_char buf '$';
            go (i + 1)
          )
    in
    go 0;
    Buffer.contents buf

(* As vscode-textmate's [handleCaptures]. *)
let handle_captures ~t ~state ~base_grammar ~grammar ~repos ~line ~active scopes
    default region captures toks =
  let len = String.length line in
  match capture_span ~len region 0 with
  | None ->
      toks
  | Some _ when Hashtbl.length captures = 0 ->
      toks
  | Some (_, mat_end) ->
      let region_len = Oniguruma.Region.length region in
      let base = add_scope scopes default in
      let rec close_until pos stack toks =
        match stack with
        | (ending, frame_scopes) :: rest when ending <= pos ->
            close_until pos rest (produce toks frame_scopes ending)
        | _ ->
            (stack, toks)
      in
      let rec close_all stack toks =
        match stack with
        | [] ->
            toks
        | (ending, frame_scopes) :: rest ->
            close_all rest (produce toks frame_scopes ending)
      in
      let rec go idx stack toks =
        if idx >= region_len then
          close_all stack toks
        else
          match Hashtbl.find_opt captures (Capture_idx idx) with
          | None ->
              go (idx + 1) stack toks
          | Some { capture_name = None; capture_patterns = [] } ->
              go (idx + 1) stack toks
          | Some capture -> (
              match capture_span ~len region idx with
              | None ->
                  go (idx + 1) stack toks
              | Some (beg, end_) ->
                  if beg = end_ then
                    go (idx + 1) stack toks
                  else if beg > mat_end then
                    close_all stack toks
                  else
                    let stack, toks = close_until beg stack toks in
                    let toks =
                      match stack with
                      | (_, frame_scopes) :: _ ->
                          produce toks frame_scopes beg
                      | [] ->
                          produce toks base beg
                    in
                    let name =
                      Option.map
                        (expand_capture_refs ~line region)
                        capture.capture_name
                    in
                    if
                      capture.capture_patterns <> []
                      && not
                           (List.exists
                              (fun (beg', end', patterns) ->
                                beg' = beg && end' = end_
                                && patterns == capture.capture_patterns
                              )
                              active
                           )
                    then
                      let toks =
                        !retokenize_ref ~t ~state ~base:base_grammar ~grammar
                          ~repos
                          ~scopes:(add_scopes scopes [ default; name ])
                          ~patterns:capture.capture_patterns ~active ~pos:beg
                          ~end_pos:end_ ~toks ~line
                      in
                      go (idx + 1) stack toks
                    else
                      let frame_scopes =
                        match stack with
                        | (_, frame_scopes) :: _ ->
                            frame_scopes
                        | [] ->
                            base
                      in
                      go (idx + 1)
                        ((end_, add_scope frame_scopes name) :: stack)
                        toks
            )
      in
      go 0 [] toks

let emit_scope_token scopes name ending toks =
  produce toks (add_scope scopes name) ending

let candidate_first = function
  | { candidate_kind = Candidate_match m; _ } ->
      m.pattern_first
  | { candidate_kind = Candidate_delim d; _ } ->
      d.delim_begin_first

let candidate_regex = function
  | { candidate_kind = Candidate_match m; _ } ->
      m.pattern
  | { candidate_kind = Candidate_delim d; _ } ->
      d.delim_begin

type expansion = Expanding_patterns of grammar | Expanding_item of repo_item

let same_expansion a b =
  match (a, b) with
  | Expanding_patterns g1, Expanding_patterns g2 ->
      g1 == g2
  | Expanding_item i1, Expanding_item i2 ->
      i1 == i2
  | Expanding_patterns _, Expanding_item _
  | Expanding_item _, Expanding_patterns _ ->
      false

let with_inner inner repos =
  if Hashtbl.length inner = 0 then
    repos
  else
    inner :: List.filter (fun repo -> repo != inner) repos

let already_expanded seen expansion =
  List.exists (same_expansion expansion) !seen
  || begin
    seen := expansion :: !seen;
    false
  end

let rec collect_candidates ~t ~base_grammar ?(seen = ref []) repos cur_grammar =
  function
  | [] ->
      []
  | Match m :: pats ->
      {
        candidate_kind = Candidate_match m;
        candidate_repos = repos;
        candidate_grammar = cur_grammar;
      }
      :: collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
  | Delim d :: pats ->
      {
        candidate_kind = Candidate_delim d;
        candidate_repos = repos;
        candidate_grammar = cur_grammar;
      }
      :: collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
  | Scope_patterns child_patterns :: pats ->
      let inner =
        collect_candidates ~t ~base_grammar ~seen repos cur_grammar
          child_patterns
      in
      inner @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
  | Include_scope name :: pats -> (
      match find_by_scope_name t name with
      | None ->
          collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
      | Some g ->
          let included = collect_grammar_patterns ~t ~base_grammar ~seen g in
          included
          @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
    )
  | Include_scope_rule { scope; rule } :: pats -> (
      match find_by_scope_name t scope with
      | None ->
          collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
      | Some g ->
          let included =
            collect_candidates ~t ~base_grammar ~seen [ g.repository ] g
              [ Include_local rule ]
          in
          included
          @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
    )
  | Include_base :: pats ->
      let included =
        collect_grammar_patterns ~t ~base_grammar ~seen base_grammar
      in
      included
      @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
  | Include_self :: pats ->
      let included =
        collect_grammar_patterns ~t ~base_grammar ~seen cur_grammar
      in
      included
      @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
  | Include_local key :: pats -> (
      match find_nested key repos with
      | None ->
          collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
      | Some item -> (
          let expansion = Expanding_item item in
          if already_expanded seen expansion then
            collect_candidates ~t ~base_grammar ~seen repos cur_grammar pats
          else
            match item.repo_item_kind with
            | Repo_rule rule ->
                let included =
                  collect_candidates ~t ~base_grammar ~seen repos cur_grammar
                    [ rule ]
                in
                included
                @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar
                    pats
            | Repo_patterns pats' ->
                let included =
                  collect_candidates ~t ~base_grammar ~seen
                    (with_inner item.repo_inner repos)
                    cur_grammar pats'
                in
                included
                @ collect_candidates ~t ~base_grammar ~seen repos cur_grammar
                    pats
        )
    )

and collect_grammar_patterns ~t ~base_grammar ~seen g =
  let expansion = Expanding_patterns g in
  if already_expanded seen expansion then
    []
  else
    collect_candidates ~t ~base_grammar ~seen [ g.repository ] g g.patterns

let scope_matches_selector_part scope part =
  scope = part
  || String.length part < String.length scope
     && String.starts_with ~prefix:part scope
     && scope.[String.length part] = '.'

let injection_selector_matches ~scope_set scopes (sel : injection_selector) =
  List.for_all (fun seg -> Scope_set.mem seg scope_set) sel.selector_segments
  &&
  match sel.selector_segments with
  | [ _ ] ->
      true
  | _ ->
      let rev_scopes = List.rev scopes in
      let rec go segments scope_list =
        match segments with
        | [] ->
            true
        | seg :: rest_segs -> (
            match scope_list with
            | [] ->
                false
            | scope :: rest_scopes ->
                if scope_matches_selector_part scope seg then
                  go rest_segs rest_scopes
                else
                  go segments rest_scopes
          )
      in
      go sel.selector_segments rev_scopes

let collect_injection_candidates ~t ~base_grammar ~scope_set scopes =
  let left = ref [] in
  let right = ref [] in
  let check_injections injections grammar =
    List.iter
      (fun (sel, patterns) ->
        if injection_selector_matches ~scope_set scopes sel then begin
          let cs =
            collect_candidates ~t ~base_grammar [ grammar.repository ] grammar
              patterns
          in
          if sel.selector_left then
            left := List.rev_append cs !left
          else
            right := List.rev_append cs !right
        end
      )
      injections
  in
  check_injections base_grammar.injections base_grammar;
  Hashtbl.iter
    (fun _name (g : grammar) ->
      if g.scope_name <> base_grammar.scope_name then
        match g.parsed_injection_selector with
        | None ->
            ()
        | Some sel ->
            if injection_selector_matches ~scope_set scopes sel then begin
              let cs =
                collect_candidates ~t ~base_grammar [ g.repository ] g
                  g.patterns
              in
              if sel.selector_left then
                left := List.rev_append cs !left
              else
                right := List.rev_append cs !right
            end
    )
    t.by_scope_name;
  (List.rev !left, List.rev !right)

(* Each candidate is checked with an anchored, single-position
   [Oniguruma.match_] rather than a ranged [Oniguruma.RegSet.search]: a
   result is only ever accepted below when it starts exactly at [pos]
   (anything else would be discarded anyway), and Oniguruma's regset
   search, when ruling out a candidate that doesn't match anywhere in the
   searched range, costs time proportional to that range (confirmed by
   direct benchmarking against the oniguruma binding -- this is not
   specific to anchored patterns, it's true of any candidate with no match
   left in the buffer). Narrowing the range instead of dropping RegSet
   doesn't work either: it also caps how far a *matching* candidate's own
   content may extend, silently truncating ordinary multi-character
   matches. [Oniguruma.match_] has neither problem: it only ever looks at
   [pos] itself, so its cost never depends on line length.

   What it does cost is one native call per candidate tried, and most
   candidates don't match at most positions. [First_byte.may_match_at]
   rules out a candidate without that call whenever the character at
   [pos] can't possibly start a match for it, which is decidable from the
   pattern's source text for the common cases (a literal character, a
   character class, a word-boundary-led version of either) -- when it
   isn't, the candidate is simply tried, which is always correct, just not
   free. *)
let search_candidates_at_pos ~first_line ~clock ~line ~pos ~anchor candidates =
  let options = anchor_options ~first_line ~anchor ~pos in
  let ch =
    if pos < String.length line then
      Some line.[pos]
    else
      None
  in
  let rec go = function
    | [] ->
        None
    | candidate :: rest -> (
        if not (First_byte.may_match_at (candidate_first candidate) ch) then
          go rest
        else
          let regex = candidate_regex candidate in
          match match_regex clock regex line pos options with
          | None ->
              go rest
          | Some region -> (
              match
                classify_match ~pos ~len:(String.length line) regex region
              with
              | No_match ->
                  go rest
              | Empty_match matched | Nonempty_match matched ->
                  Some (candidate, matched)
            )
      )
  in
  go candidates

let frame_scopes grammar = function
  | [] ->
      [ grammar.scope_name ]
  | se :: _ ->
      se.stack_scopes

let frame_scope_set grammar = function
  | [] ->
      scope_set_of_scopes [ grammar.scope_name ]
  | se :: _ ->
      se.stack_scope_set

let frame_repos grammar = function
  | [] ->
      [ grammar.repository ]
  | se :: _ ->
      se.stack_repos

let frame_has_while = function [] -> false | se :: _ -> se.stack_has_while
let frame_retokenizing = function [] -> [] | se :: _ -> se.stack_retokenizing

let unmatchable_re = compile_regex "\\A(?!x)x"

let end_regex delim line region =
  match delim.delim_end_regex with
  | Some regex ->
      regex
  | None -> (
      match subst_backrefs delim line region with
      | None ->
          unmatchable_re
      | Some source -> (
          match
            compile_regex
              ~error_context:("End pattern for " ^ delim.delim_end)
              source
          with
          | regex ->
              regex
          | exception Error _ ->
              unmatchable_re
        )
    )

let next_pos line pos =
  if pos >= String.length line then
    pos + 1
  else
    pos + Uchar.utf_decode_length (String.get_utf_8_uchar line pos)

let end_of_line_scopes grammar stack =
  match stack with
  | [] ->
      frame_scopes grammar stack
  | se :: _ ->
      se.stack_scopes

let safe_pop = function [] -> [] | _ :: rest -> rest

let rec match_line ~t ~state ~grammar ~stack ~anchor ~line_pos ~pos ~toks ~line
    rem_pats =
  let len = String.length line in
  let first_line = state.first_line in
  let scopes = frame_scopes grammar stack in
  let stop toks stack =
    (produce toks (end_of_line_scopes grammar stack) len, stack)
  in
  let candidate_groups repos cur_grammar pats =
    let frame = match stack with [] -> None | se :: _ -> Some se in
    let same_frame (frame', pats', grammar', _) =
      ( match (frame, frame') with
        | None, None ->
            true
        | Some se, Some se' ->
            se == se'
        | None, Some _ | Some _, None ->
            false
        )
      && pats == pats' && grammar == grammar'
    in
    match List.find_opt same_frame state.entries with
    | Some (_, _, _, groups) ->
        groups
    | None ->
        let base =
          collect_candidates ~t ~base_grammar:grammar repos cur_grammar pats
        in
        let left, right =
          collect_injection_candidates ~t ~base_grammar:grammar
            ~scope_set:(frame_scope_set grammar stack)
            scopes
        in
        let groups = { left; base; right } in
        let kept =
          List.filteri (fun i _ -> i < max_cached_frames - 1) state.entries
        in
        state.entries <- (frame, pats, grammar, groups) :: kept;
        groups
  in
  let try_candidates candidates ~k =
    match
      search_candidates_at_pos ~first_line ~clock:state.clock ~line ~pos ~anchor
        candidates
    with
    | None ->
        k ()
    | Some (candidate, ({ region; end_; _ } : matched_region)) -> (
        let advanced = end_ > line_pos in
        let repos = candidate.candidate_repos in
        let grammar' = candidate.candidate_grammar in
        match candidate.candidate_kind with
        | Candidate_match m ->
            let toks = produce toks scopes pos in
            let name = Option.map (expand_capture_refs ~line region) m.name in
            let toks =
              handle_captures ~t ~state ~base_grammar:grammar ~grammar:grammar'
                ~repos ~line ~active:(frame_retokenizing stack) scopes name
                region m.captures toks
            in
            let toks = emit_scope_token scopes name end_ toks in
            if advanced then
              match_line ~t ~state ~grammar ~stack ~anchor ~line_pos:end_
                ~pos:end_ ~toks ~line (next_pats grammar stack)
            else
              stop toks (safe_pop stack)
        | Candidate_delim d ->
            let toks = produce toks scopes pos in
            if
              (not advanced)
              && has_same_delim_at_pos state.line_id stack d line_pos
            then
              stop toks stack
            else
              let expand = Option.map (expand_capture_refs ~line region) in
              let name = expand d.delim_name in
              let content_name = expand d.delim_content_name in
              let toks =
                handle_captures ~t ~state ~base_grammar:grammar
                  ~grammar:grammar' ~repos ~line
                  ~active:(frame_retokenizing stack) scopes name region
                  d.delim_begin_captures toks
              in
              let toks = emit_scope_token scopes name end_ toks in
              let child_scopes = add_scopes scopes [ name; content_name ] in
              let stack_end_re = end_regex d line region in
              let se =
                {
                  stack_delim = d;
                  stack_enter = Some (state.line_id, line_pos);
                  stack_resume_anchor =
                    Option.map (fun anchor -> (state.line_id, anchor)) anchor;
                  stack_has_while =
                    d.delim_kind = While || frame_has_while stack;
                  stack_begin_eol = end_ = state.eol;
                  stack_end_re;
                  stack_name = name;
                  stack_content_name = content_name;
                  stack_repos = repos;
                  stack_grammar = grammar';
                  stack_scopes = child_scopes;
                  stack_scope_set =
                    List.fold_left add_scope_prefixes
                      (frame_scope_set grammar stack)
                      [ name; content_name ];
                  stack_prev_scopes = scopes;
                  stack_retokenizing = frame_retokenizing stack;
                }
              in
              match_line ~t ~state ~grammar ~stack:(se :: stack)
                ~anchor:(Some end_) ~line_pos:end_ ~pos:end_ ~toks ~line
                d.delim_patterns
      )
  in
  let try_pats repos cur_grammar pats ~steps =
    let groups = lazy (candidate_groups repos cur_grammar pats) in
    let left k = try_candidates (Lazy.force groups).left ~k in
    let base k = try_candidates (Lazy.force groups).base ~k in
    let right k = try_candidates (Lazy.force groups).right ~k in
    let continue () =
      match_line ~t ~state ~grammar ~stack ~anchor ~line_pos
        ~pos:(next_pos line pos) ~toks ~line
        ( match stack with
        | [] ->
            rem_pats
        | se :: _ ->
            se.stack_delim.delim_patterns
        )
    in
    List.fold_right
      (fun step next () -> step next)
      (steps ~left ~base ~right) continue ()
  in
  let try_delim_end se stack_tail ~k =
    let delim = se.stack_delim in
    let end_match =
      match_pattern ~first_line state.clock se.stack_end_re line pos anchor
    in
    match (delim.delim_kind, end_match) with
    | End, No_match ->
        k ()
    | End, (Empty_match matched | Nonempty_match matched) ->
        let toks =
          produce toks
            (add_scopes se.stack_prev_scopes
               [ se.stack_name; se.stack_content_name ]
            )
            pos
        in
        let toks =
          handle_captures ~t ~state ~base_grammar:grammar
            ~grammar:se.stack_grammar ~repos:se.stack_repos ~line
            ~active:se.stack_retokenizing se.stack_prev_scopes se.stack_name
            matched.region delim.delim_end_captures toks
        in
        let toks =
          emit_scope_token se.stack_prev_scopes se.stack_name matched.end_ toks
        in
        if matched.end_ > line_pos || not (entered_at state.line_id se line_pos)
        then
          match_line ~t ~state ~grammar ~stack:stack_tail
            ~anchor:(resume_anchor state.line_id se)
            ~line_pos:matched.end_ ~pos:matched.end_ ~toks ~line
            (next_pats grammar stack_tail)
        else
          ( produce toks (add_scope se.stack_prev_scopes se.stack_name) len,
            se :: stack_tail
          )
    | While, _ ->
        k ()
  in
  if pos > len || state.clock.expired then
    (produce toks (end_of_line_scopes grammar stack) len, stack)
  else
    match stack with
    | [] ->
        try_pats (frame_repos grammar stack) grammar rem_pats
          ~steps:(fun ~left ~base ~right -> [ left; base; right ]
        )
    | se :: stack' -> (
        let repos = frame_repos grammar stack in
        match se.stack_delim.delim_kind with
        | While ->
            try_pats repos se.stack_grammar rem_pats
              ~steps:(fun ~left ~base ~right -> [ left; base; right ]
            )
        | End ->
            try_pats repos se.stack_grammar rem_pats
              ~steps:(fun ~left ~base ~right ->
                let end_ k = try_delim_end se stack' ~k in
                if se.stack_delim.delim_apply_end_pattern_last then
                  [ left; base; end_; right ]
                else
                  [ left; end_; base; right ]
            )
      )

let empty_captures = Hashtbl.create 0

let retokenize_line ~t ~state ~base ~grammar ~repos ~scopes ~patterns ~active
    ~pos ~end_pos ~toks ~line =
  let se =
    {
      stack_delim =
        {
          delim_begin_source = "";
          delim_begin = unmatchable_re;
          delim_begin_first = None;
          delim_end = "\\A(?!x)x";
          delim_end_regex = Some unmatchable_re;
          delim_patterns = patterns;
          delim_name = None;
          delim_content_name = None;
          delim_begin_captures = empty_captures;
          delim_end_captures = empty_captures;
          delim_apply_end_pattern_last = false;
          delim_kind = End;
        };
      stack_enter = None;
      stack_resume_anchor = None;
      stack_has_while = false;
      stack_begin_eol = false;
      stack_name = None;
      stack_content_name = None;
      stack_end_re = unmatchable_re;
      stack_grammar = grammar;
      stack_repos = repos;
      stack_scopes = scopes;
      stack_scope_set = scope_set_of_scopes scopes;
      stack_prev_scopes = scopes;
      stack_retokenizing = (pos, end_pos, patterns) :: active;
    }
  in
  let sub_line = String.sub line 0 end_pos in
  let toks, _ =
    match_line ~t ~state ~grammar:base ~stack:[ se ] ~anchor:None ~line_pos:pos
      ~pos ~toks ~line:sub_line patterns
  in
  toks

let () = retokenize_ref := retokenize_line

let default_max_line_length = 10_000
let default_time_limit = 0.25

let tokenize_prefix ~time_limit ~eol t grammar { first_line; frames } line =
  let state =
    {
      entries = [];
      line_id = ref ();
      clock =
        {
          calls = 0;
          expired = false;
          deadline = Unix.gettimeofday () +. time_limit;
        };
      first_line;
      eol;
    }
  in
  let rec try_while_rules pos anchor toks rem_stack = function
    | [] ->
        (toks, pos, anchor, rem_stack)
    | se :: stack -> (
        match se.stack_delim.delim_kind with
        | End ->
            try_while_rules pos anchor toks (se :: rem_stack) stack
        | While ->
            let rec loop pos' =
              if state.clock.expired then
                (toks, pos, anchor, List.rev_append (se :: stack) rem_stack)
              else if pos' = String.length line then
                (toks, pos, anchor, rem_stack)
              else
                match
                  match_pattern ~first_line state.clock se.stack_end_re line
                    pos' anchor
                with
                | No_match ->
                    loop (next_pos line pos')
                | Empty_match matched | Nonempty_match matched ->
                    let toks =
                      let toks =
                        if pos' > pos then
                          produce toks se.stack_scopes pos'
                        else
                          toks
                      in
                      let toks =
                        handle_captures ~t ~state ~base_grammar:grammar
                          ~grammar:se.stack_grammar ~repos:se.stack_repos ~line
                          ~active:se.stack_retokenizing se.stack_scopes None
                          matched.region se.stack_delim.delim_end_captures toks
                      in
                      emit_scope_token se.stack_scopes None matched.end_ toks
                    in
                    try_while_rules matched.end_ (Some matched.end_) toks
                      (se :: rem_stack) stack
            in
            loop pos
      )
  in
  let anchor =
    match frames with se :: _ when se.stack_begin_eol -> Some 0 | _ -> None
  in
  let toks, pos, anchor, frames =
    if frame_has_while frames then
      try_while_rules 0 anchor [] [] (List.rev frames)
    else
      ([], 0, anchor, frames)
  in
  let toks, frames =
    match_line ~t ~state ~grammar ~stack:frames ~anchor ~line_pos:pos ~pos ~toks
      ~line (next_pats grammar frames)
  in
  (toks, { first_line = false; frames })

let rec utf8_boundary line cut =
  if cut > 0 && Char.code line.[cut] land 0xC0 = 0x80 then
    utf8_boundary line (cut - 1)
  else
    cut

let tokenize_exn ?(max_line_length = default_max_line_length)
    ?(time_limit = default_time_limit) t grammar stack line =
  let len = String.length line in
  let max_line_length = max 1 max_line_length in
  if len <= max_line_length then
    let toks, stack =
      tokenize_prefix ~time_limit ~eol:len t grammar stack line
    in
    (List.rev toks, stack)
  else
    let cut =
      match utf8_boundary line max_line_length with
      | 0 ->
          max_line_length
      | cut ->
          cut
    in
    let toks, stack =
      tokenize_prefix ~time_limit ~eol:len t grammar stack
        (String.sub line 0 cut)
    in
    let scopes = end_of_line_scopes grammar stack.frames in
    let toks =
      match toks with
      | last :: before when last.scopes = scopes ->
          { last with ending = len } :: before
      | _ ->
          { scopes; ending = len } :: toks
    in
    (List.rev toks, stack)
