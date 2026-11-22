(* Decides, from a pattern's source text alone, whether the character at a
   position could possibly be where that pattern starts matching. Used
   below to skip trying a candidate via Oniguruma entirely when the answer
   is confidently "no". This only ever needs to be conservative in one
   direction: every case it doesn't recognize (and anything it's unsure
   about) falls back to "maybe", which just forgoes the optimization; it
   must never answer "no" for a pattern that could actually match. *)
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
          Char.code c > 32 && Char.code c < 127 && not (is_alpha c || is_digit c)
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
      if
        (source.[!j] = '[' && not (!j + 1 < len && source.[!j + 1] = ':'))
        || (source.[!j] = '&' && !j + 1 < len && source.[!j + 1] = '&')
      then
        ok := false
      else if source.[!j] = '[' && !j + 1 < len && source.[!j + 1] = ':' then
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
        else if !j + 2 < len && source.[!j + 1] = '-' && source.[!j + 2] <> ']'
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
    let at i =
      if i < len then
        Some source.[i]
      else
        None
    in
    match source.[after] with
    | '?' | '*' ->
        true
    | '+' -> (
        match at (after + 1) with Some ('*' | '{') -> true | _ -> false
      )
    | '{' -> (
        match String.index_from_opt source after '}' with
        | None ->
            true
        | Some close -> (
            let body = String.sub source (after + 1) (close - after - 1) in
            if not (String.length body > 0 && body.[0] >= '1' && body.[0] <= '9')
            then
              true
            else
              match at (close + 1) with
              | Some ('*' | '{') ->
                  true
              | Some '?' ->
                  not (String.contains body ',')
              | _ ->
                  false
          )
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

(* [ch] is [None] when [pos] is at the very end of the line: there's no
   character there for a non-zero-width atom to match, but zero-width-only
   patterns (and anything this module didn't confidently analyze) must
   still be allowed to try, so that case always answers "maybe". *)
let may_match_at predicate ch =
  match (predicate, ch) with
  | None, _ | Some _, None ->
      true
  | Some pred, Some ch ->
      pred ch
