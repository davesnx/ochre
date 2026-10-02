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

let anchor_options ~anchor ~pos =
  if anchor <> Some pos then
    Oniguruma.Options.not_begin_position
  else
    Oniguruma.Options.none

let match_pattern regex line pos anchor =
  match Oniguruma.match_ regex line pos (anchor_options ~anchor ~pos) with
  | exception Oniguruma.Error _ ->
      No_match
  | None ->
      No_match
  | Some region ->
      let start = Oniguruma.Region.capture_beg region 0 in
      let end_ = Oniguruma.Region.capture_end region 0 in
      if start <> pos then
        No_match
      else
        let matched = { region; regex; end_ } in
        if has_progress start end_ then
          Nonempty_match matched
        else
          Empty_match matched

let has_same_delim_at_pos stack delim pos =
  List.exists
    (fun se -> se.stack_enter_pos = Some pos && se.stack_delim == delim)
    stack

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
      | '\\', false ->
          loop (i + 1) true
      | char, true ->
          if char >= '0' && char <= '9' then (
            let idx = Char.code char - Char.code '0' in
            if idx < num_beg_captures then
              let beg = Oniguruma.Region.capture_beg region idx in
              let end_ = Oniguruma.Region.capture_end region idx in
              if beg <> -1 then insert_capture buf line beg end_
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
  Buffer.contents buf

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

let remove_empties =
  let rec go acc = function
    | [] ->
        acc
    | tok :: toks ->
        let prev = match toks with [] -> 0 | tok :: _ -> tok.ending in
        if tok.ending = prev then
          go acc toks
        else
          go (tok :: acc) toks
  in
  go []

let retokenize_ref =
  ref
    (fun
      ~t:_ ~grammar:_ ~scopes:_ ~patterns:_ ~pos:_ ~end_pos:_ ~toks ~line:_ ->
      (toks : token list)
  )

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
        | Capture_name _ ->
            acc
        | Capture_idx idx ->
            if idx < 0 || idx >= region_len then
              acc
            else
              let beg = Oniguruma.Region.capture_beg region idx in
              let end_ = Oniguruma.Region.capture_end region idx in
              if beg = -1 || beg = end_ then
                acc
              else if
                capture.capture_name = None && capture.capture_patterns = []
              then
                acc
              else
                (idx, capture, beg, end_) :: acc
      )
      captures []
  in
  let captures =
    List.stable_sort
      (fun (idx1, _, start1, end1) (idx2, _, start2, end2) ->
        let c = compare start1 start2 in
        if c <> 0 then
          c
        else
          let c = compare end2 end1 in
          if c <> 0 then
            c
          else
            compare idx1 idx2
      )
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
                []
              )
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
          (* A sibling capture earlier in this match may still have an open
             stack frame (pushed by the [else] branch below) if it has not
             been closed yet. Flush it here so frames are always closed in
             position order; otherwise a frame closed later by the trailing
             pop at the end of this fold could emit a token whose [ending] is
             smaller than ones already emitted for this capture, breaking the
             monotonic-ending invariant [extract_tokens] relies on. Keep using
             the ambient [scopes]/[default] (not the popped frame) for this
             capture's own scope, matching how a capture with nested patterns
             has always been scoped here. *)
          let prev_idx, tokens, stack = pop prev_idx cap_start tokens stack in
          let cap_scopes =
            add_scopes scopes [ default; capture.capture_name ]
          in
          let tokens =
            if prev_idx < cap_start then
              { scopes = add_scope scopes default; ending = cap_start }
              :: tokens
            else
              tokens
          in
          let tokens =
            !retokenize_ref ~t ~grammar ~scopes:cap_scopes
              ~patterns:capture.capture_patterns ~pos:cap_start ~end_pos:cap_end
              ~toks:tokens ~line
          in
          (cap_end, cap_end, stack, tokens)
        else
          let prev_idx, tokens, stack = pop prev_idx cap_start tokens stack in
          let base_scopes =
            match stack with
            | (_, top_scopes) :: _ ->
                top_scopes
            | [] ->
                add_scope scopes default
          in
          ( prev_idx,
            cap_start,
            (cap_end, add_scope base_scopes capture.capture_name) :: stack,
            tokens
          )
      )
      (mat_start, mat_start, [], tokens)
      captures
  in
  let rec pop tokens = function
    | [] ->
        tokens
    | (ending, scopes) :: stack ->
        pop ({ scopes; ending } :: tokens) stack
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
  | { candidate_kind = Candidate_match m; _ } ->
      m.pattern_source
  | { candidate_kind = Candidate_delim d; _ } ->
      d.delim_begin_source

let candidate_regex = function
  | { candidate_kind = Candidate_match m; _ } ->
      m.pattern
  | { candidate_kind = Candidate_delim d; _ } ->
      d.delim_begin

let rec collect_candidates ~t ~base_grammar ?(scope = None) repos cur_grammar =
  function
  | [] ->
      []
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
        match scope_name with Some _ -> scope_name | None -> scope
      in
      collect_candidates ~t ~base_grammar ~scope:inner_scope repos cur_grammar
        child_patterns
      @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
  | Include_scope name :: pats -> (
      match find_by_scope_name t name with
      | None ->
          collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
      | Some g ->
          collect_candidates ~t ~base_grammar ~scope [ g.repository ] g
            g.patterns
          @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
    )
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
      | None ->
          collect_candidates ~t ~base_grammar ~scope repos cur_grammar pats
      | Some item -> (
          match item.repo_item_kind with
          | Repo_rule rule ->
              collect_candidates ~t ~base_grammar ~scope
                (item.repo_inner :: repos) cur_grammar (rule :: pats)
          | Repo_patterns pats' ->
              collect_candidates ~t ~base_grammar ~scope
                (item.repo_inner :: repos) cur_grammar pats'
              @ collect_candidates ~t ~base_grammar ~scope repos cur_grammar
                  pats
        )
    )

let scope_matches_selector_part scope part =
  scope = part
  || String.length part < String.length scope
     && String.starts_with ~prefix:part scope
     && scope.[String.length part] = '.'

let injection_selector_matches scopes (sel : injection_selector) =
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
        match g.injection_selector with
        | None ->
            ()
        | Some sel_str ->
            let sel = Reader.parse_injection_selector sel_str in
            if injection_selector_matches scopes sel then begin
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

let drop n list =
  let rec loop n = function
    | _ :: rest when n > 0 ->
        loop (n - 1) rest
    | l ->
        l
  in
  loop n list

(* Decides, from a pattern's source text alone, whether the character at a
   position could possibly be where that pattern starts matching. Used
   below to skip trying a candidate via Oniguruma entirely when the answer
   is confidently "no". This only ever needs to be conservative in one
   direction: every case it doesn't recognize (and anything it's unsure
   about) falls back to "maybe", which just forgoes the optimization; it
   must never answer "no" for a pattern that could actually match. *)
module First_byte = struct
  let is_digit c = c >= '0' && c <= '9'
  let is_alpha c = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
  let is_alnum c = is_alpha c || is_digit c
  let is_space c =
    c = ' ' || c = '\t' || c = '\n' || c = '\r' || c = '\011' || c = '\012'
  let is_word c = is_alpha c || is_digit c || c = '_'
  let is_ascii c = Char.code c < 128

  (* Oniguruma's POSIX classes and shorthand character classes are not
     ASCII-only under UTF-8 encoding with the default options used here:
     confirmed empirically that [[:alpha:]], [[:alnum:]], [[:lower:]],
     [[:print:]], [[:graph:]], [[:word:]], and [\w] all match "e" with an
     acute accent (a 2-byte UTF-8 character), i.e. they're Unicode-category
     based, not a fixed ASCII byte range. Rather than try to reproduce
     Unicode category membership (and risk getting it subtly wrong), every
     positive class predicate here also answers "maybe" (true) for any
     non-ASCII byte -- safe in the only direction that matters: it can
     only make this module skip the optimization more often, never skip a
     candidate that could actually match. This also covers the (empirically
     ASCII-only, e.g. [:digit:], [:space:]) classes; the cost of being
     unnecessarily cautious there is negligible. Negated forms ([\D], [\S],
     etc.) are intentionally left alone: negating the ASCII-only version
     is already safe (non-ASCII bytes fail the positive ASCII check, so the
     negation is true for them, i.e. still permissive), whereas negating
     this conservative version would do the opposite -- turn "maybe" into a
     false "never". *)
  let unicode_safe pred c = pred c || not (is_ascii c)

  let posix_class_pred name =
    let wrap pred = Some (unicode_safe pred) in
    match name with
    | "alpha" ->
        wrap is_alpha
    | "digit" ->
        wrap is_digit
    | "alnum" ->
        wrap (fun c -> is_alpha c || is_digit c)
    | "space" ->
        wrap is_space
    | "upper" ->
        wrap (fun c -> c >= 'A' && c <= 'Z')
    | "lower" ->
        wrap (fun c -> c >= 'a' && c <= 'z')
    | "xdigit" ->
        wrap (fun c ->
            is_digit c || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')
        )
    | "blank" ->
        wrap (fun c -> c = ' ' || c = '\t')
    | "cntrl" ->
        wrap (fun c -> Char.code c < 32 || Char.code c = 127)
    | "print" ->
        wrap (fun c -> Char.code c >= 32 && Char.code c < 127)
    | "graph" ->
        wrap (fun c -> Char.code c > 32 && Char.code c < 127)
    | "punct" ->
        wrap (fun c ->
            Char.code c > 32
            && Char.code c < 127
            && not (is_alpha c || is_digit c)
        )
    | "word" ->
        wrap is_word
    | _ ->
        None

  let shorthand_class = function
    | 'd' ->
        Some (unicode_safe is_digit)
    | 'D' ->
        Some (fun c -> not (is_digit c))
    | 'w' ->
        Some (unicode_safe is_word)
    | 'W' ->
        Some (fun c -> not (is_word c))
    | 's' ->
        Some (unicode_safe is_space)
    | 'S' ->
        Some (fun c -> not (is_space c))
    | 'h' ->
        Some
          (unicode_safe (fun c ->
               is_digit c || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')
           )
          )
    | 'H' ->
        Some
          (fun c ->
            not (is_digit c || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'))
          )
    | _ ->
        None

  (* Parses a bracket expression "[...]" starting at index [i] (pointing at
     '['). Returns (predicate, index just past the closing ']'), or None if
     anything inside isn't recognized (an embedded "[:name:]" this doesn't
     know, an unrecognized escape, no closing ']' at all, a non-ASCII byte
     anywhere -- byte-range arithmetic across a multi-byte UTF-8 character is
     not meaningful, see the note below -- or a negated class that used a
     POSIX/shorthand member, see [unicode_safe]'s comment on why negating
     that conservative form would be unsafe). *)
  let parse_class source i =
    let len = String.length source in
    let j = ref (i + 1) in
    let negate = !j < len && source.[!j] = '^' in
    if negate then incr j;
    let preds = ref [] in
    let ok = ref true in
    let used_class_member = ref false in
    let finished = ref false in
    (* A ']' right after the opening '[' (or '[^') is a literal member, not
       the terminator -- a POSIX bracket-expression convention this needs
       to respect, since grammars do rely on it (e.g. awk's index operator
       pattern is literally "[]\[]", a class matching ']' or '['). Only
       track this for one iteration: after the first character is
       consumed, a ']' always closes the class. *)
    let is_first = ref true in
    while (not !finished) && !ok do
      if !j >= len then (
        ok := false;
        finished := true
      ) else if source.[!j] = ']' && not !is_first then
        finished := true
      else (
        is_first := false;
        if source.[!j] = '[' && !j + 1 < len && source.[!j + 1] = ':' then
          match String.index_from_opt source (!j + 2) ':' with
          | Some close when close + 1 < len && source.[close + 1] = ']' -> (
              let name = String.sub source (!j + 2) (close - (!j + 2)) in
              match posix_class_pred name with
              | Some p ->
                  preds := p :: !preds;
                  used_class_member := true;
                  j := close + 2
              | None ->
                  ok := false
            )
          | _ ->
              ok := false
        else if source.[!j] = '\\' && !j + 1 < len then
          match shorthand_class source.[!j + 1] with
          | Some p ->
              preds := p :: !preds;
              used_class_member := true;
              j := !j + 2
          | None ->
              let c = source.[!j + 1] in
              (* An escaped letter/digit this doesn't recognize could be a
                 backreference, a hex/octal/unicode escape, or another
                 shorthand class -- never assume it's literal. An escaped
                 punctuation character, however, is always just that
                 literal character in every regex dialect this needs to
                 worry about (as long as it's plain ASCII: a backslash
                 immediately followed by a raw UTF-8 continuation/lead
                 byte isn't a construct worth reasoning about here
                 either). *)
              if is_alnum c || not (is_ascii c) then
                ok := false
              else if
                (* This escaped literal could still be the *start* of a
                   range (e.g. "\[-\]", or the space-to-"\[" range in
                   purescript's "characters" pattern, "[ -\[\]-~]"): bail
                   rather than silently treating it as a standalone
                   literal and under-approximating the range, or
                   mis-parsing the upper bound below. *)
                !j + 2 < len
                && source.[!j + 2] = '-'
                && !j + 3 < len
                && source.[!j + 3] <> ']'
              then
                ok := false
              else (
                preds := (fun x -> x = c) :: !preds;
                j := !j + 2
              )
        else
          let c = source.[!j] in
          (* A literal non-ASCII byte here is one byte of a multi-byte
             UTF-8 character. Oniguruma compares ranges like "a-z" at the
             codepoint level (confirmed empirically: a Greek-letter range
             matches correctly), but this parser only ever reasons
             byte-by-byte, so a range such as "[\xCE\xB1-\xCF\x89]" (a
             Greek-letter range) would otherwise get a bogus byte-value
             range built from an unrelated pairing of a continuation byte
             with a hyphen. Bailing on any non-ASCII byte here avoids that
             entirely. *)
          if not (is_ascii c) then
            ok := false
          else if
            !j + 2 < len && source.[!j + 1] = '-' && source.[!j + 2] <> ']'
          then
            (* The upper bound of a range can itself be escaped (e.g. the
               "-\[" / "-\]" halves of the purescript example above): if
               so, bail instead of misreading the backslash itself as the
               bound, which would also desync where the class is parsed
               to continue from. *)
            if source.[!j + 2] = '\\' then
              ok := false
            else
              let hi = source.[!j + 2] in
              if is_ascii hi then (
                preds := (fun x -> x >= c && x <= hi) :: !preds;
                j := !j + 3
              ) else
                ok := false
          else (
            preds := (fun x -> x = c) :: !preds;
            incr j
          )
      )
    done;
    if (not !ok) || !j >= len || source.[!j] <> ']' then
      None
    else if negate && !used_class_member then
      None
    else
      let preds = !preds in
      let pred c = List.exists (fun p -> p c) preds in
      let pred =
        if negate then
          fun c ->
        not (pred c)
        else
          pred
      in
      Some (pred, !j + 1)

  (* Finds the index just past the ')' matching the '(' at index [i],
     treating [...] bracket expressions and backslash escapes along the way
     so a ')' inside either doesn't end the group early. None if there's no
     matching close paren. [class_first] tracks, while inside a bracket
     expression, whether the next character is the one right after '[' or
     '[^' -- there, like in [parse_class], a ']' is a literal member, not
     the closing bracket (grammars rely on this, e.g. a lookbehind can be
     written "(?<=[]\w])", whose bracket content is "]\w": ']' or a word
     character). *)
  let skip_group source i =
    let len = String.length source in
    let rec go i depth in_class class_first =
      if i >= len then
        None
      else
        match source.[i] with
        | '\\' when i + 1 < len ->
            go (i + 2) depth in_class false
        | '[' when not in_class ->
            go (i + 1) depth true true
        | '^' when in_class && class_first ->
            (* The negation marker right after '[' doesn't itself count as
               the class's first content character. *)
            go (i + 1) depth in_class true
        | ']' when in_class && not class_first ->
            go (i + 1) depth false false
        | '(' when not in_class ->
            go (i + 1) (depth + 1) in_class false
        | ')' when not in_class ->
            if depth = 1 then
              Some (i + 1)
            else
              go (i + 1) (depth - 1) in_class false
        | _ ->
            go (i + 1) depth in_class false
    in
    go (i + 1) 1 false false

  (* Splits a group's inner content on top-level '|' (not inside a nested
     group or bracket expression, not escaped). [class_first] has the same
     meaning as in [skip_group]: a ']' right after '[' or '[^' is a literal
     member, not the closing bracket. *)
  let split_top_level content =
    let len = String.length content in
    let parts = ref [] in
    let start = ref 0 in
    let depth = ref 0 in
    let in_class = ref false in
    let class_first = ref false in
    let i = ref 0 in
    while !i < len do
      ( match content.[!i] with
      | '\\' when !i + 1 < len ->
          incr i;
          class_first := false
      | '[' when not !in_class ->
          in_class := true;
          class_first := true
      | '^' when !in_class && !class_first ->
          ()
      | ']' when !in_class && not !class_first ->
          in_class := false
      | '(' when not !in_class ->
          incr depth
      | ')' when not !in_class ->
          decr depth
      | '|' when (not !in_class) && !depth = 0 ->
          parts := String.sub content !start (!i - !start) :: !parts;
          start := !i + 1
      | _ ->
          if !in_class then class_first := false
      );
      incr i
    done;
    parts := String.sub content !start (len - !start) :: !parts;
    List.rev !parts

  (* Skips leading zero-width constructs that never consume a byte: [^],
     [\A], [\G], [\b], [\B], and lookaround groups ([(?=...)], [(?!...)],
     [(?<=...)], [(?<!...)]). Note: [\`] is not among these -- Oniguruma has
     no such anchor, so that's just an (unnecessarily) escaped literal
     backtick character, handled below as a normal atom. *)
  let rec skip_zero_width source i =
    let len = String.length source in
    if i >= len then
      Some i
    else
      match source.[i] with
      | '^' ->
          skip_zero_width source (i + 1)
      | '\\'
        when i + 1 < len
             &&
             match source.[i + 1] with
             | 'A' | 'G' | 'b' | 'B' ->
                 true
             | _ ->
                 false ->
          skip_zero_width source (i + 2)
      | '('
        when i + 2 < len
             && source.[i + 1] = '?'
             && (source.[i + 2] = '=' || source.[i + 2] = '!') -> (
          match skip_group source i with
          | Some after ->
              skip_zero_width source after
          | None ->
              None
        )
      | '('
        when i + 3 < len
             && source.[i + 1] = '?'
             && source.[i + 2] = '<'
             && (source.[i + 3] = '=' || source.[i + 3] = '!') -> (
          match skip_group source i with
          | Some after ->
              skip_zero_width source after
          | None ->
              None
        )
      | '(' -> (
          (* Not a lookaround itself (those are the two cases above), but
             could still be zero-width overall: a plain or non-capturing
             group whose every top-level alternative is itself zero-width
             (grammars commonly combine several lookarounds this way, e.g.
             [(?:(?<=\.\.\.)|(?<!\.))]). If so, the whole group can be
             skipped the same as a single assertion. *)
          match zero_width_group_end source i with
          | Some after ->
              skip_zero_width source after
          | None ->
              Some i
        )
      | _ ->
          Some i

  (* True if every character of [source] is consumed by zero-width
     constructs, i.e. the pattern matches without advancing at all. *)
  and is_pure_zero_width source =
    match skip_zero_width source 0 with
    | Some i ->
        i = String.length source
    | None ->
        false

  (* [i] points at '('. If this is a plain capturing group or a
     non-capturing [(?:...)] group (not a lookaround, named group, or
     other [(?...)] construct this doesn't recognize) whose content, split
     on top-level '|', is made entirely of zero-width alternatives, returns
     the index just past its closing ')'. Otherwise None. *)
  and zero_width_group_end source i =
    let len = String.length source in
    match skip_group source i with
    | None ->
        None
    | Some after_close -> (
        let content_start =
          if i + 1 < len && source.[i + 1] = '?' then
            if i + 2 < len && source.[i + 2] = ':' then
              Some (i + 3)
            else
              None
          else
            Some (i + 1)
        in
        match content_start with
        | None ->
            None
        | Some content_start ->
            let content =
              String.sub source content_start (after_close - 1 - content_start)
            in
            let branches = split_top_level content in
            if branches <> [] && List.for_all is_pure_zero_width branches then
              Some after_close
            else
              None
      )

  (* Is the atom ending just before [after] followed by a quantifier that
     could make zero occurrences of it valid ([?], [*], or a [{0,...}] /
     [{,n}] repetition)? If so, the character at [pos] isn't guaranteed to
     belong to this atom -- whatever follows it in the pattern could be the
     real start instead. *)
  let followed_by_possibly_zero source after =
    let len = String.length source in
    if after >= len then
      false
    else
      match source.[after] with
      | '?' | '*' ->
          true
      | '{' -> (
          match String.index_from_opt source after '}' with
          | None ->
              true
          | Some close ->
              let body = String.sub source (after + 1) (close - after - 1) in
              not (String.length body > 0 && body.[0] >= '1' && body.[0] <= '9')
        )
      | _ ->
          false

  (* Past an atom (and any quantifier on it), skip a following lazy ([?])
     or possessive ([+]) modifier on that quantifier too, so recursion
     continues from the right place. *)
  let skip_quantifier source after =
    let len = String.length source in
    if after >= len then
      after
    else
      let after_q =
        match source.[after] with
        | '?' | '*' | '+' ->
            Some (after + 1)
        | '{' -> (
            match String.index_from_opt source after '}' with
            | Some close ->
                Some (close + 1)
            | None ->
                None
          )
        | _ ->
            None
      in
      match after_q with
      | None ->
          after
      | Some after_q ->
          if after_q < len && (source.[after_q] = '?' || source.[after_q] = '+')
          then
            after_q + 1
          else
            after_q

  let max_depth = 8

  (* The character set a pattern could possibly start matching with,
     starting from index [i] in [source]. Handles a run of zero-width
     assertions, then one atom (a literal, an escape, a bracket
     expression, or a parenthesized group -- recursing into each of the
     group's top-level alternatives and unioning their own leading sets).
     If that atom can match zero times (an optional quantifier), the
     result is unioned with whatever leads the rest of the pattern, since
     either could end up being the real first byte. Anything this doesn't
     recognize, including running past [max_depth] levels of nested
     groups, answers [None] (unknown; always try the candidate for real). *)
  let rec leading_predicate_from depth source i =
    if depth > max_depth then
      None
    else
      match skip_zero_width source i with
      | None ->
          None
      | Some i -> (
          let len = String.length source in
          if i >= len then
            None
          else
            let atom =
              if source.[i] = '[' then
                parse_class source i
              else if source.[i] = '(' then
                parse_group depth source i
              else if source.[i] = '\\' && i + 1 < len then
                match shorthand_class source.[i + 1] with
                | Some p ->
                    Some (p, i + 2)
                | None ->
                    (* As in [parse_class]: an escaped letter/digit this
                       doesn't recognize could be a backreference or a
                       hex/octal/unicode escape, so it's never assumed to
                       be literal; an escaped punctuation character always
                       is (and, as in [parse_class], only when it's plain
                       ASCII). *)
                    let c = source.[i + 1] in
                    if is_alnum c || not (is_ascii c) then
                      None
                    else
                      Some ((fun x -> x = c), i + 2)
              else
                match source.[i] with
                | '.' | ')' | '|' | '+' | '*' | '?' | '$' | '{' ->
                    None
                | c when not (is_ascii c) ->
                    (* One byte of a literal multi-byte UTF-8 character.
                       Unlike a byte *range* spanning such a character (see
                       [parse_class]), treating just this one byte as the
                       required literal is safe on its own -- it's a
                       necessary condition for the full character to match,
                       so excluding candidates whose first byte differs is
                       still exact -- but bail anyway, conservatively, to
                       keep the reasoning about non-ASCII content in one
                       place. *)
                    None
                | c ->
                    Some ((fun x -> x = c), i + 1)
            in
            match atom with
            | None ->
                None
            | Some (pred, after) ->
                if followed_by_possibly_zero source after then
                  match
                    leading_predicate_from depth source
                      (skip_quantifier source after)
                  with
                  | Some rest ->
                      Some (fun c -> pred c || rest c)
                  | None ->
                      None
                else
                  Some pred
        )

  (* [i] points at '('. Lookarounds are consumed by [skip_zero_width]
     before this is ever reached, so this only ever sees a real (capturing,
     non-capturing, or named) group: find its matching close paren, split
     its content on top-level '|', and union each branch's own leading set
     (bailing if any branch isn't understood). *)
  and parse_group depth source i =
    let len = String.length source in
    match skip_group source i with
    | None ->
        None
    | Some after_close -> (
        let content_start =
          if i + 2 < len && source.[i + 1] = '?' then
            match source.[i + 2] with
            | ':' ->
                Some (i + 3)
            | '<' | '\'' -> (
                let close_char =
                  if source.[i + 2] = '<' then
                    '>'
                  else
                    '\''
                in
                match String.index_from_opt source (i + 3) close_char with
                | Some c ->
                    Some (c + 1)
                | None ->
                    None
              )
            | '=' | '!' ->
                (* A lookahead reached here means it wasn't the very first
                   thing in the pattern (skip_zero_width only strips a
                   *leading* run of them); treat the rest as unknown rather
                   than trying to union with a zero-width assertion. *)
                None
            | _ ->
                None (* e.g. (?#...) comments, (?i) option groups, etc. *)
          else
            Some (i + 1)
        in
        match content_start with
        | None ->
            None
        | Some content_start ->
            let content_end = after_close - 1 in
            if content_end < content_start then
              None
            else
              let content =
                String.sub source content_start (content_end - content_start)
              in
              let branches = split_top_level content in
              (* A branch can be entirely optional on its own (e.g. a
                 quantified atom with nothing after it within the branch),
                 in which case what matters is what comes after the whole
                 group, not an artificial end of string. Appending that
                 continuation to each branch before recursing makes that
                 visible; it's a no-op for branches that resolve to a
                 mandatory atom without needing it. *)
              let continuation =
                String.sub source after_close (len - after_close)
              in
              let preds =
                List.map
                  (fun branch ->
                    leading_predicate_from (depth + 1) (branch ^ continuation) 0
                  )
                  branches
              in
              if List.exists (function None -> true | Some _ -> false) preds
              then
                None
              else
                let preds = List.filter_map (fun p -> p) preds in
                Some ((fun c -> List.exists (fun p -> p c) preds), after_close)
      )

  (* A whole "match"/"begin" pattern is very often itself a top-level
     alternation with no enclosing group at all (e.g.
     ["\b(is|new)\b|\b(true|false)\b|([$_[:alpha:]][$_[:alnum:]]*)..."] --
     common for a single rule that recognizes several keyword families plus
     a generic identifier fallback). [leading_predicate_from] only ever
     looks at the first atom it finds, so without this, a pattern like that
     would be analyzed as if its first alternative were the whole pattern,
     silently losing every other alternative -- in the example, a plain
     identifier starting with any letter other than one of the keywords'
     first letters would be wrongly excluded. [split_top_level] returns the
     whole string unchanged (as the single element of a one-element list)
     when there's no top-level '|', so this also covers the single-branch
     case uniformly. *)
  let leading_predicate source =
    let branches = split_top_level source in
    let preds =
      List.map (fun branch -> leading_predicate_from 0 branch 0) branches
    in
    if List.exists (function None -> true | Some _ -> false) preds then
      None
    else
      let preds = List.filter_map (fun p -> p) preds in
      Some (fun c -> List.exists (fun p -> p c) preds)

  let cache : (string, (char -> bool) option) Hashtbl.t = Hashtbl.create 512

  let predicate_of source =
    match Hashtbl.find_opt cache source with
    | Some p ->
        p
    | None ->
        let p = try leading_predicate source with _ -> None in
        Hashtbl.replace cache source p;
        p

  (* [ch] is [None] when [pos] is at the very end of the line: there's no
     character there for a non-zero-width atom to match, but zero-width-only
     patterns (and anything this module didn't confidently analyze) must
     still be allowed to try, so that case always answers "maybe". *)
  let may_match_at source ch =
    match (predicate_of source, ch) with
    | None, _ | Some _, None ->
        true
    | Some pred, Some ch ->
        pred ch
end

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
let search_candidates_at_pos ~line ~pos ~anchor candidates =
  let options = anchor_options ~anchor ~pos in
  let ch =
    if pos < String.length line then
      Some line.[pos]
    else
      None
  in
  let rec go idx = function
    | [] ->
        None
    | candidate :: rest -> (
        if not (First_byte.may_match_at (candidate_regex_source candidate) ch)
        then
          go (idx + 1) rest
        else
          let regex = candidate_regex candidate in
          match
            try Oniguruma.match_ regex line pos options
            with Oniguruma.Error _ -> None
          with
          | None ->
              go (idx + 1) rest
          | Some region ->
              let end_ = Oniguruma.Region.capture_end region 0 in
              let matched = { region; regex; end_ } in
              if has_progress pos end_ then
                Some (idx, candidate, Nonempty_match matched)
              else
                Some (idx, candidate, Empty_match matched)
      )
  in
  go 0 candidates

let frame_scopes grammar = function
  | [] ->
      [ grammar.scope_name ]
  | se :: _ ->
      se.stack_scopes

let frame_repos grammar = function
  | [] ->
      [ grammar.repository ]
  | se :: _ ->
      se.stack_repos

let frame_grammar grammar = function
  | [] ->
      grammar
  | se :: _ ->
      se.stack_grammar

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
      | None ->
          k ()
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
              match_line ~t ~grammar ~stack ~anchor ~pos:matched.end_ ~toks
                ~line (next_pats grammar stack)
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
              let toks =
                emit_scope_token scopes d.delim_name matched.end_ toks
              in
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
                ~pos:end_ ~toks ~line d.delim_patterns
        )
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
    | End, No_match ->
        k ()
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
    | While, _ ->
        error "Unreachable"
  in
  if pos > len then
    let end_scopes =
      match stack with
      | [] ->
          scopes
      | se :: _ ->
          add_scope scopes se.stack_delim.delim_name
    in
    (remove_empties ({ scopes = end_scopes; ending = len } :: toks), stack)
  else
    let continue () =
      match_line ~t
        ~grammar:(frame_grammar grammar stack)
        ~stack ~anchor ~pos:(pos + 1) ~toks ~line
        ( match stack with
        | [] ->
            rem_pats
        | se :: _ ->
            se.stack_delim.delim_patterns
        )
    in
    match stack with
    | [] ->
        try_pats (frame_repos grammar stack) grammar rem_pats ~k:continue
    | se :: stack' -> (
        match se.stack_delim.delim_kind with
        | While ->
            try_pats
              (frame_repos grammar stack)
              se.stack_grammar rem_pats ~k:continue
        | End ->
            if se.stack_delim.delim_apply_end_pattern_last then
              try_pats (frame_repos grammar stack) se.stack_grammar rem_pats
                ~k:(fun () -> try_delim_end se stack' ~k:continue
              )
            else
              try_delim_end se stack' ~k:(fun () ->
                  try_pats
                    (frame_repos grammar stack)
                    se.stack_grammar rem_pats ~k:continue
              )
      )

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
    | [] ->
        []
    | tok :: rest ->
        if tok.ending <= pos then
          []
        else
          tok :: take_until_pos rest
  in
  remove_empties (take_until_pos sub_toks) @ toks

let () = retokenize_ref := retokenize_line

let tokenize_exn t grammar stack line =
  let rec try_while_rules pos anchor toks rem_stack = function
    | [] ->
        (toks, pos, anchor, rem_stack)
    | se :: stack -> (
        match se.stack_delim.delim_kind with
        | End ->
            try_while_rules pos anchor toks (se :: rem_stack) stack
        | While ->
            let rec loop pos' =
              if pos' = String.length line then
                (toks, pos, anchor, rem_stack)
              else
                match match_pattern se.stack_end_re line pos' anchor with
                | No_match | Empty_match _ ->
                    loop (pos' + 1)
                | Nonempty_match matched ->
                    let toks =
                      let toks =
                        if pos' > pos then
                          { scopes = se.stack_scopes; ending = pos' } :: toks
                        else
                          toks
                      in
                      let toks =
                        handle_captures ~t ~grammar:se.stack_grammar ~line
                          se.stack_prev_scopes se.stack_delim.delim_name pos'
                          matched.end_ matched.region
                          se.stack_delim.delim_end_captures toks
                      in
                      emit_scope_token se.stack_prev_scopes
                        se.stack_delim.delim_name matched.end_ toks
                    in
                    try_while_rules matched.end_ (Some matched.end_) toks
                      (se :: rem_stack) stack
            in
            loop pos
      )
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
      (fun se -> { se with stack_enter_pos = None; stack_resume_anchor = None })
      stack
  in
  (toks, stack)
