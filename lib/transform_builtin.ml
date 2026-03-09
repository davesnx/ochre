let line_highlight ?(background = "#ffffff22") lines =
  Transform.make "line-highlight" ~after_line:(fun ~line_index line ->
      if List.mem line_index lines then
        List.map
          (fun (tok : Token.styled_token) ->
            { tok with background = Some background }
          )
          line
      else
        line
  )

let word_highlight ?(foreground = "#ffff00") ?(font_style = [ Token.Bold ])
    words =
  Transform.make "word-highlight" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if List.mem tok.text words then
            { tok with foreground = Some foreground; font_style }
          else
            tok
        )
        line
  )

let diff_markers =
  Transform.make "diff-markers" ~before_render:(fun doc ->
      List.map
        (fun line ->
          match line with
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '+' ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some "#22883322" }
                )
                ({
                   first with
                   text = String.sub text 1 (String.length text - 1);
                 }
                :: rest
                )
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '-' ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some "#88222222" }
                )
                ({
                   first with
                   text = String.sub text 1 (String.length text - 1);
                 }
                :: rest
                )
          | line ->
              line
        )
        doc
  )

let scope_marker ?(background = "#ffff0033") scope_prefix =
  Transform.make "scope-marker" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if
            List.exists
              (fun s ->
                String.length s >= String.length scope_prefix
                && String.sub s 0 (String.length scope_prefix) = scope_prefix
              )
              tok.scopes
          then
            { tok with background = Some background }
          else
            tok
        )
        line
  )

(* --- Notation-based transforms ---

   These transforms scan token text for magic comment patterns like
   [// [!code highlight]], remove the comment, and apply styling to the line.
   They mirror Shiki's transformerNotationHighlight, transformerNotationDiff,
   and transformerNotationWordHighlight. *)

(** Helper: check if a string contains a substring, returning the index. *)
let string_find_opt ~pattern s =
  let plen = String.length pattern in
  let slen = String.length s in
  if plen > slen then
    None
  else
    let found = ref None in
    let i = ref 0 in
    while !found = None && !i <= slen - plen do
      if String.sub s !i plen = pattern then found := Some !i;
      incr i
    done;
    !found

(** Helper: trim trailing whitespace from a string. *)
let rtrim s =
  let len = String.length s in
  let i = ref (len - 1) in
  while !i >= 0 && (s.[!i] = ' ' || s.[!i] = '\t') do
    decr i
  done;
  if !i < len - 1 then
    String.sub s 0 (!i + 1)
  else
    s

(** Helper: check if a string consists only of whitespace. *)
let is_whitespace_only s =
  let len = String.length s in
  let rec check i =
    if i >= len then
      true
    else
      match s.[i] with ' ' | '\t' -> check (i + 1) | _ -> false
  in
  check 0

(** Helper: scan a line of tokens for a notation pattern. Returns
    [Some token_index] or [None]. *)
let find_notation_in_line ~pattern line =
  let rec scan i = function
    | [] ->
        None
    | (tok : Token.styled_token) :: rest -> (
        match string_find_opt ~pattern tok.text with
        | Some _ ->
            Some i
        | None ->
            scan (i + 1) rest
      )
  in
  scan 0 line

(** Helper: remove the notation comment from a line of tokens.

    When a token contains the magic comment pattern (e.g.
    [// [!code highlight]]), the entire token is removed (since it's typically a
    comment token whose sole purpose is the notation). Any preceding
    whitespace-only tokens are also removed, and trailing whitespace on the new
    last visible token is trimmed. Trailing tokens that are pure whitespace or
    newlines after the removed notation are preserved (newlines) or dropped
    (spaces). *)
let remove_notation ~pattern line =
  match find_notation_in_line ~pattern line with
  | None ->
      None
  | Some tok_idx ->
      let tokens = Array.of_list line in
      let len = Array.length tokens in
      (* Collect tokens: skip the matched token and any preceding
         whitespace-only tokens *)
      let skip_before = ref tok_idx in
      while
        !skip_before > 0
        && is_whitespace_only tokens.(!skip_before - 1).Token.text
      do
        decr skip_before
      done;
      let result = ref [] in
      for i = 0 to len - 1 do
        if i >= !skip_before && i <= tok_idx then
          ()
        (* skip the notation token and preceding whitespace *)
        else
          let tok = tokens.(i) in
          (* Skip pure-whitespace tokens that immediately follow the removed
             notation, but keep newlines *)
          if
            i = tok_idx + 1
            && is_whitespace_only tok.Token.text
            && String.length tok.text > 0
          then
            ()
          else
            result := tok :: !result
      done;
      let cleaned = List.rev !result in
      (* Trim trailing whitespace from the last non-newline token *)
      let rec trim_last = function
        | [] ->
            []
        | [ tok ] ->
            let t = rtrim tok.Token.text in
            if String.length t > 0 then
              [ { tok with Token.text = t } ]
            else
              []
        | [ tok; nl ] when nl.Token.text = "\n" ->
            let t = rtrim tok.Token.text in
            if String.length t > 0 then
              [ { tok with Token.text = t }; nl ]
            else
              [ nl ]
        | tok :: rest ->
            tok :: trim_last rest
      in
      Some (trim_last cleaned)

let notation_highlight ?(background = "#ffffff22") () =
  let pattern = "[!code highlight]" in
  Transform.make "notation-highlight" ~before_render:(fun doc ->
      List.map
        (fun line ->
          match remove_notation ~pattern line with
          | Some cleaned ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some background }
                )
                cleaned
          | None ->
              line
        )
        doc
  )

let notation_diff ?(add_background = "#22883322")
    ?(remove_background = "#88222222") () =
  let add_pattern = "[!code ++]" in
  let remove_pattern = "[!code --]" in
  Transform.make "notation-diff" ~before_render:(fun doc ->
      List.map
        (fun line ->
          match remove_notation ~pattern:add_pattern line with
          | Some cleaned ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some add_background }
                )
                cleaned
          | None -> (
              match remove_notation ~pattern:remove_pattern line with
              | Some cleaned ->
                  List.map
                    (fun (tok : Token.styled_token) ->
                      { tok with background = Some remove_background }
                    )
                    cleaned
              | None ->
                  line
            )
        )
        doc
  )

(** Helper: extract the word from a [!code word:xxx] pattern in a token. Returns
    [Some word] if found. *)
let extract_word_from_token (tok : Token.styled_token) =
  let pattern = "[!code word:" in
  match string_find_opt ~pattern tok.text with
  | None ->
      None
  | Some idx ->
      let after_pattern = idx + String.length pattern in
      let text = tok.text in
      let len = String.length text in
      (* Find the closing ] *)
      let rec find_close i =
        if i >= len then
          None
        else if text.[i] = ']' then
          Some (String.sub text after_pattern (i - after_pattern))
        else
          find_close (i + 1)
      in
      find_close after_pattern

(** Helper: scan a line for [!code word:xxx] and extract the word. *)
let find_word_notation line =
  let rec scan = function
    | [] ->
        None
    | tok :: rest -> (
        match extract_word_from_token tok with
        | Some word ->
            Some word
        | None ->
            scan rest
      )
  in
  scan line

let notation_word_highlight ?(foreground = "#ffff00")
    ?(font_style = [ Token.Bold ]) () =
  let base_pattern = "[!code word:" in
  Transform.make "notation-word-highlight" ~before_render:(fun doc ->
      (* First pass: collect words from all lines, then process *)
      List.map
        (fun line ->
          match find_word_notation line with
          | Some word ->
              (* Build the full pattern to remove: [!code word:xxx] *)
              let full_pattern = base_pattern ^ word ^ "]" in
              let cleaned =
                match remove_notation ~pattern:full_pattern line with
                | Some c ->
                    c
                | None ->
                    line
              in
              (* Highlight all occurrences of the word in this line *)
              List.concat_map
                (fun (tok : Token.styled_token) ->
                  (* Split token text on the word and highlight matches *)
                  let word_len = String.length word in
                  let text = tok.text in
                  let text_len = String.length text in
                  if word_len = 0 || text_len = 0 then
                    [ tok ]
                  else
                    let parts = ref [] in
                    let pos = ref 0 in
                    while !pos <= text_len - word_len do
                      if String.sub text !pos word_len = word then begin
                        (* Emit any text before this match *)
                          if
                            !pos
                            >
                            match !parts with
                            | [] ->
                                0
                            | _ ->
                                let rec sum = function
                                  | [] ->
                                      0
                                  | (t : Token.styled_token) :: rest ->
                                      String.length t.text + sum rest
                                in
                                sum (List.rev !parts)
                          then begin
                            let start =
                              let rec sum = function
                                | [] ->
                                    0
                                | (t : Token.styled_token) :: rest ->
                                    String.length t.text + sum rest
                              in
                              sum (List.rev !parts)
                            in
                            let before_text =
                              String.sub text start (!pos - start)
                            in
                            parts := { tok with text = before_text } :: !parts
                          end;
                          parts :=
                            {
                              tok with
                              text = word;
                              foreground = Some foreground;
                              font_style;
                            }
                            :: !parts;
                          pos := !pos + word_len
                      end else
                        incr pos
                    done;
                    (* Emit remaining text *)
                    let consumed =
                      let rec sum = function
                        | [] ->
                            0
                        | (t : Token.styled_token) :: rest ->
                            String.length t.text + sum rest
                      in
                      sum !parts
                    in
                    if consumed < text_len then
                      parts :=
                        {
                          tok with
                          text = String.sub text consumed (text_len - consumed);
                        }
                        :: !parts;
                    List.rev !parts
                )
                cleaned
          | None ->
              line
        )
        doc
  )
