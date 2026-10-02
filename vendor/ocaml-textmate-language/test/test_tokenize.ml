open Util

let toks_to_list toks =
  List.map (fun tok -> (TmLanguage.ending tok, TmLanguage.scopes tok)) toks

let make_grammar json =
  let grammar = TmLanguage.of_yojson_exn json in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  (t, grammar)

let ganchor_grammar ~scope_name ~end_pattern : Yojson.Basic.t =
  `Assoc
    [
      ("scopeName", `String scope_name);
      ("name", `String "ganchor");
      ( "patterns",
        `List
          [
            `Assoc
              [
                ("begin", `String "\"");
                ("end", `String end_pattern);
                ("name", `String "string.quoted.test");
              ];
            `Assoc
              [ ("match", `String "[a-zA-Z-]+"); ("name", `String "word.test") ];
          ]
      );
    ]

let parent_ganchor_grammar : Yojson.Basic.t =
  `Assoc
    [
      ("scopeName", `String "source.tmtest");
      ("name", `String "Test Lang");
      ( "patterns",
        `List
          [
            `Assoc
              [
                ("name", `String "source.test-lang");
                ("begin", `String "\\(");
                ("end", `String "\\G\\)");
                ( "beginCaptures",
                  `Assoc
                    [
                      ( "0",
                        `Assoc
                          [ ("name", `String "punctuation.parenthesis.open") ]
                      );
                    ]
                );
                ( "endCaptures",
                  `Assoc
                    [
                      ( "0",
                        `Assoc
                          [ ("name", `String "punctuation.parenthesis.close") ]
                      );
                    ]
                );
                ( "patterns",
                  `List
                    [
                      `Assoc
                        [
                          ("name", `String "keyword.control.test-lang");
                          ("match", `String "\\GA");
                        ];
                      `Assoc
                        [
                          ("name", `String "keyword.control.test-lang");
                          ("match", `String "\\GB");
                        ];
                    ]
                );
              ];
          ]
      );
      ("repository", `Assoc []);
    ]

let ganchor_while_grammar ~scope_name ~while_pattern : Yojson.Basic.t =
  `Assoc
    [
      ("scopeName", `String scope_name);
      ("name", `String "ganchor-while");
      ( "patterns",
        `List
          [
            `Assoc
              [
                ("begin", `String "A");
                ("while", `String while_pattern);
                ("name", `String "while.test");
              ];
            `Assoc
              [ ("match", `String "[a-zA-Z]+"); ("name", `String "word.test") ];
          ]
      );
    ]

let check_end_pattern_g_anchor () =
  let t, grammar =
    make_grammar
      (ganchor_grammar ~scope_name:"source.ganchor" ~end_pattern:"(?<!\\G)\"")
  in
  let toks, _ =
    TmLanguage.tokenize_exn t grammar TmLanguage.empty "cmd \"x\" -y"
  in
  Alcotest.(check (list (pair int (list string))))
    "g-anchor end pattern"
    [
      (3, [ "word.test"; "source.ganchor" ]);
      (4, [ "source.ganchor" ]);
      (5, [ "string.quoted.test"; "source.ganchor" ]);
      (6, [ "string.quoted.test"; "source.ganchor" ]);
      (7, [ "string.quoted.test"; "string.quoted.test"; "source.ganchor" ]);
      (8, [ "source.ganchor" ]);
      (10, [ "word.test"; "source.ganchor" ]);
    ]
    (toks_to_list toks)

let check_positive_g_anchor_fails_without_parent_anchor () =
  let t, grammar =
    make_grammar
      (ganchor_grammar ~scope_name:"source.ganchor.pos" ~end_pattern:"\\G\"")
  in
  let _, stack = TmLanguage.tokenize_exn t grammar TmLanguage.empty "\"" in
  let toks, _ = TmLanguage.tokenize_exn t grammar stack "\"x" in
  (* \G end pattern can't match without parent anchor, so string stays open *)
  Alcotest.(check (list (pair int (list string))))
    "positive \\G end fails without parent anchor"
    [
      (2, [ "string.quoted.test"; "string.quoted.test"; "source.ganchor.pos" ]);
    ]
    (toks_to_list toks)

let check_negative_g_anchor_matches_without_parent_anchor () =
  let t, grammar =
    make_grammar
      (ganchor_grammar ~scope_name:"source.ganchor.neg"
         ~end_pattern:"(?<!\\G)\""
      )
  in
  let _, stack = TmLanguage.tokenize_exn t grammar TmLanguage.empty "\"" in
  let toks, _ = TmLanguage.tokenize_exn t grammar stack "\"x" in
  (* Negative \G matches when anchor is unavailable, so string closes *)
  Alcotest.(check (list (pair int (list string))))
    "negative \\G end matches without parent anchor"
    [
      (1, [ "string.quoted.test"; "string.quoted.test"; "source.ganchor.neg" ]);
      (2, [ "word.test"; "source.ganchor.neg" ]);
    ]
    (toks_to_list toks)

let check_parent_g_anchor_in_nested_patterns () =
  let t, grammar = make_grammar parent_ganchor_grammar in
  let toks, _ = TmLanguage.tokenize_exn t grammar TmLanguage.empty "(AB)" in
  (* A matches \GA at anchor pos, B and ) don't match \G patterns *)
  Alcotest.(check (list (pair int (list string))))
    "nested patterns honor parent \\G anchor"
    [
      ( 1,
        [ "punctuation.parenthesis.open"; "source.test-lang"; "source.tmtest" ]
      );
      (2, [ "keyword.control.test-lang"; "source.test-lang"; "source.tmtest" ]);
      (4, [ "source.test-lang"; "source.test-lang"; "source.tmtest" ]);
    ]
    (toks_to_list toks)

let check_parent_g_anchor_closes_on_empty_content () =
  let t, grammar = make_grammar parent_ganchor_grammar in
  let toks, _ = TmLanguage.tokenize_exn t grammar TmLanguage.empty "()" in
  (* \G end matches immediately at anchor position, closing the group *)
  Alcotest.(check (list (pair int (list string))))
    "empty content closes with parent \\G anchor"
    [
      ( 1,
        [ "punctuation.parenthesis.open"; "source.test-lang"; "source.tmtest" ]
      );
      ( 2,
        [ "punctuation.parenthesis.close"; "source.test-lang"; "source.tmtest" ]
      );
    ]
    (toks_to_list toks)

let check_positive_g_anchor_while_fails_without_anchor () =
  let t, grammar =
    make_grammar
      (ganchor_while_grammar ~scope_name:"source.ganchor.while.pos"
         ~while_pattern:"\\G."
      )
  in
  let _, stack = TmLanguage.tokenize_exn t grammar TmLanguage.empty "A" in
  let toks, _ = TmLanguage.tokenize_exn t grammar stack "x" in
  (* \G while can't match without anchor, so while-scope is exited *)
  Alcotest.(check (list (pair int (list string))))
    "positive \\G while fails without anchor"
    [ (1, [ "word.test"; "source.ganchor.while.pos" ]) ]
    (toks_to_list toks)

let check_negative_g_anchor_while_matches_without_anchor () =
  let t, grammar =
    make_grammar
      (ganchor_while_grammar ~scope_name:"source.ganchor.while.neg"
         ~while_pattern:"(?<!\\G)."
      )
  in
  let _, stack = TmLanguage.tokenize_exn t grammar TmLanguage.empty "A" in
  let toks, _ = TmLanguage.tokenize_exn t grammar stack "x" in
  (* Negative \G while matches when anchor unavailable, so while-scope stays *)
  Alcotest.(check (list (pair int (list string))))
    "negative \\G while matches without anchor"
    [ (1, [ "while.test"; "source.ganchor.while.neg" ]) ]
    (toks_to_list toks)

let _one_token line scopes = [ { line; expected = [ (1, scopes) ] } ]
let _line_token line scopes = { line; expected = [ (1, scopes) ] }
let has_scope scope = List.exists (( = ) scope)

let spans_of_tokens line toks =
  let rec build start = function
    | [] ->
        []
    | tok :: rest ->
        let ending = TmLanguage.ending tok in
        let text = String.sub line start (ending - start) in
        (text, TmLanguage.scopes tok) :: build ending rest
  in
  build 0 toks

let tokenize_spans_from_json grammar_json line =
  let grammar =
    TmLanguage.of_yojson_exn (Yojson.Basic.from_string grammar_json)
  in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  let toks, _ = TmLanguage.tokenize_exn t grammar TmLanguage.empty line in
  spans_of_tokens line toks

let check_overlapping_begin_captures_opening_quote () =
  let grammar_json =
    {|{
  "scopeName": "source.overlap",
  "name": "overlap",
  "patterns": [
    {
      "begin": "((\"))",
      "end": "\"",
      "beginCaptures": {
        "1": {},
        "2": {
          "name": "string.quoted.double.test"
        }
      },
      "endCaptures": {
        "0": {
          "name": "string.quoted.double.test"
        }
      },
      "name": "meta.wrapper.test",
      "contentName": "string.quoted.double.test"
    }
  ]
}|}
  in
  let line = "\"x\"" in
  let spans = tokenize_spans_from_json grammar_json line in
  let quote_scopes =
    List.fold_left
      (fun acc (text, scopes) ->
        if text = "\"" then
          scopes :: acc
        else
          acc
      )
      [] spans
    |> List.rev
  in
  Alcotest.(check bool)
    "opening and closing quotes should both be string-scoped" true
    ( match quote_scopes with
    | [ opening; closing ] ->
        has_scope "string.quoted.double.test" opening
        && has_scope "string.quoted.double.test" closing
    | _ ->
        false
    )

let check_sibling_simple_then_nested_capture_ordering () =
  (* A match with three sibling captures: capture 1 has no nested patterns
     (so it is closed later, via handle_captures' internal stack, once a
     following capture's start position reaches its end), capture 2 is a
     sibling (not a child) that has nested patterns and starts right where
     capture 1 ends, and capture 3 is another simple sibling after capture 2.
     This is the shape markdown's ATX heading rule uses (a punctuation
     capture, then a heading-text capture with nested inline patterns,
     followed by more match content) and is what triggered the crash: the
     capture-with-patterns branch used to skip closing capture 1's pending
     stack frame, so it was only closed once capture 3 (or, with no capture
     3, the trailing pop at the end of handle_captures) finally reached it --
     by which point capture 2's tokens had already been emitted, producing a
     token whose [ending] was smaller than ones already emitted before it.
     Any consumer that reconstructs text with
     [String.sub line start (ending - start)] (as lib/ochre.ml's
     extract_tokens does) then gets a negative length and raises
     Invalid_argument. *)
  let grammar_json =
    {|{
  "scopeName": "source.siborder",
  "name": "siborder",
  "patterns": [
    {
      "match": "(#)(\\w+)(!)",
      "captures": {
        "1": { "name": "punctuation.hash.test" },
        "2": {
          "name": "entity.word.test",
          "patterns": [ { "match": "\\w+", "name": "word.inner.test" } ]
        },
        "3": { "name": "punctuation.bang.test" }
      },
      "name": "meta.siborder.test"
    }
  ]
}|}
  in
  let line = "#Title!" in
  let spans = tokenize_spans_from_json grammar_json line in
  Alcotest.(check string)
    "token texts reassemble the exact source" line
    (String.concat "" (List.map fst spans));
  Alcotest.(check bool)
    "the punctuation capture keeps its own scope" true
    (List.exists
       (fun (text, scopes) ->
         text = "#" && has_scope "punctuation.hash.test" scopes
       )
       spans
    )

(* The tests below exercise lib/ochre.ml's First_byte prefilter (in
   tokenizer.ml's search_candidates_at_pos): a static analysis of a
   pattern's source text that skips calling into Oniguruma for a candidate
   when the character at the current position confidently can't start a
   match for it. Each one matches a pattern via a construct the prefilter
   must either understand correctly or safely decline to optimize (fall
   back to always trying); a wrong confident answer would silently change
   tokenization rather than crash, so these check the actual matched text
   and scope end-to-end, the same way a real grammar bug would surface. *)

let single_pattern_grammar ~match_ ~name : Yojson.Basic.t =
  `Assoc
    [
      ("scopeName", `String "source.fbtest");
      ("name", `String "fbtest");
      ( "patterns",
        `List [ `Assoc [ ("match", `String match_); ("name", `String name) ] ]
      );
    ]

let matches_as ~match_ ~name ~line ~text ~scope =
  let grammar = single_pattern_grammar ~match_ ~name in
  let spans = tokenize_spans_from_json (Yojson.Basic.to_string grammar) line in
  List.exists
    (fun (span_text, scopes) -> span_text = text && has_scope scope scopes)
    spans

let check_inline_case_insensitive_flag () =
  (* "(?i)abc" must still match "ABC": a literal atom under an inline
     case-insensitive flag isn't just itself, so the prefilter must not
     narrow it to only its own (lowercase) byte -- confirmed by checking it
     bails entirely for a pattern containing "(?i", always trying the
     candidate for real. *)
  Alcotest.(check bool)
    "(?i)abc matches ABC" true
    (matches_as ~match_:"(?i)abc" ~name:"kw.ci.test" ~line:"ABC" ~text:"ABC"
       ~scope:"kw.ci.test"
    )

let check_extended_free_spacing_mode () =
  (* Under "(?x)", unescaped whitespace in the pattern is insignificant,
     not literal -- "(?x)a b" means "ab", not "a b". If the prefilter
     treated the space as a required literal byte, it would wrongly
     exclude the real match. *)
  Alcotest.(check bool)
    "(?x)a b matches ab" true
    (matches_as ~match_:"(?x)a b" ~name:"kw.ext.test" ~line:"ab" ~text:"ab"
       ~scope:"kw.ext.test"
    )

let check_unusual_escapes_and_operators_not_misoptimized () =
  (* Each of these uses a construct the prefilter doesn't try to fully
     understand (an unrecognized escaped letter, which could be a
     backreference, a hex/octal/unicode escape, or a shorthand class; or
     Oniguruma's "absent" operator): it must fall back to always trying
     the real match rather than guessing wrong. *)
  let cases =
    [
      ("\\Kbar", "constant.k.test", "foobar", "bar");
      (* \K resets the reported match start *)
      ("a\\Rb", "constant.r.test", "a\nb", "a\nb");
      (* \R: any linebreak sequence *)
      ("\\X+", "constant.x.test", "abc", "abc");
      (* \X: extended grapheme cluster *)
      ("(?~abc)", "constant.absent.test", "xyz", "xyz");
      (* absent operator: text not containing "abc" *)
      ("\\x{41}", "constant.hex.test", "A", "A");
      (* \x{..}: hex character escape *)
      ("\\101", "constant.octal.test", "A", "A")
      (* octal escape (0o101 = 'A') *);
    ]
  in
  List.iter
    (fun (match_, name, line, text) ->
      Alcotest.(check bool)
        (Printf.sprintf "%S matches %S" match_ line)
        true
        (matches_as ~match_ ~name ~line ~text ~scope:name)
    )
    cases

let check_h_shorthand_hex_digit () =
  Alcotest.(check bool)
    "\\h+ matches hex digits" true
    (matches_as ~match_:"\\h+" ~name:"constant.hex.digits.test" ~line:"a1F"
       ~text:"a1F" ~scope:"constant.hex.digits.test"
    )

let check_named_group_vs_lookbehind () =
  (* "(?<name>...)" is a named *capturing* group -- its content is real,
     analyzable pattern text, requiring 'c' here. "(?<=...)" is a
     lookbehind -- zero-width, so the requirement comes from whatever
     follows it, 'd' here. Confusing the two (treating a lookbehind as
     analyzable content, or a named group as zero-width) would silently
     change which byte is required. *)
  Alcotest.(check bool)
    "(?<grp>cat) matches cat" true
    (matches_as ~match_:"(?<grp>cat)" ~name:"named.group.test" ~line:"cat"
       ~text:"cat" ~scope:"named.group.test"
    );
  Alcotest.(check bool)
    "(?<=cat)dog matches dog after cat" true
    (matches_as ~match_:"(?<=cat)dog" ~name:"lookbehind.test" ~line:"catdog"
       ~text:"dog" ~scope:"lookbehind.test"
    )

let check_multibyte_utf8_first_byte () =
  (* "[[:alpha:]]" and other POSIX/shorthand classes are Unicode-category
     based under this tokenizer's UTF-8 encoding, not ASCII-only (confirmed
     empirically against the oniguruma binding: they match "e" with an
     acute accent, a 2-byte UTF-8 character) -- the prefilter must treat
     any non-ASCII byte as a possible match for a positive class like this,
     not just ASCII letters. A literal non-ASCII character (here, the same
     accented "e") must also still match itself. *)
  let eacute = "\xc3\xa9" in
  Alcotest.(check bool)
    "[[:alpha:]]+ matches e-acute" true
    (matches_as ~match_:"[[:alpha:]]+" ~name:"word.unicode.test" ~line:eacute
       ~text:eacute ~scope:"word.unicode.test"
    );
  Alcotest.(check bool)
    "a literal e-acute matches itself" true
    (matches_as ~match_:eacute ~name:"literal.unicode.test" ~line:eacute
       ~text:eacute ~scope:"literal.unicode.test"
    )

let check_optional_leading_atom_before_mandatory_byte () =
  (* "(a*)(b)": the first atom can match zero times, so the pattern's real
     first byte is 'a' *or* 'b' (if there are no leading a's). This is the
     general form of "a pattern that can match the empty string must never
     be skipped" -- here it's an optional leading part rather than the
     whole pattern, which is the shape that actually recurs in real
     grammars (see the "(^|\G)( {0,3})(...)" markdown list-marker pattern
     this was found against). *)
  Alcotest.(check bool)
    "(a*)(b) matches b with no leading a" true
    (matches_as ~match_:"(a*)(b)" ~name:"optional.lead.test" ~line:"b" ~text:"b"
       ~scope:"optional.lead.test"
    );
  Alcotest.(check bool)
    "(a*)(b) matches aaab" true
    (matches_as ~match_:"(a*)(b)" ~name:"optional.lead.test" ~line:"aaab"
       ~text:"aaab" ~scope:"optional.lead.test"
    )

let check_top_level_alternation_without_group () =
  (* A whole pattern can itself be a top-level alternation with no
     enclosing group at all (common for a single rule recognizing several
     keywords plus a generic identifier fallback, e.g.
     "\b(is|new)\b|([$_[:alpha:]][$_[:alnum:]]*)"). Found live in
     typescript's relational-operator pattern ("<=|>=|<>|[<>]") and several
     other bundled grammars: analyzing only the first alternative would
     wrongly exclude a candidate whenever the input matches a *later*
     alternative starting with a different byte. *)
  Alcotest.(check bool)
    "<=|>=|<>|[<>] matches a bare >" true
    (matches_as ~match_:"<=|>=|<>|[<>]" ~name:"relational.test" ~line:">"
       ~text:">" ~scope:"relational.test"
    );
  Alcotest.(check bool)
    "0|[1-9][0-9]* matches a nonzero digit" true
    (matches_as ~match_:"0|[1-9][0-9]*" ~name:"decimal.test" ~line:"42"
       ~text:"42" ~scope:"decimal.test"
    )

let check_leading_bracket_literal () =
  (* "[]\[]" (POSIX convention: a ']' right after '[' is a literal member,
     not the closing bracket) is a class matching ']' or '['. Found live in
     awk's index-operator pattern. Misreading the first ']' as the
     terminator would parse this as an empty, never-matching class. *)
  Alcotest.(check bool)
    "[]\\[] matches ]" true
    (matches_as ~match_:"([]\\[])" ~name:"bracket.test" ~line:"]" ~text:"]"
       ~scope:"bracket.test"
    );
  Alcotest.(check bool)
    "[]\\[] matches [" true
    (matches_as ~match_:"([]\\[])" ~name:"bracket.test" ~line:"[" ~text:"["
       ~scope:"bracket.test"
    )

let check_escaped_range_endpoint () =
  (* "[ -\[\]-~]" (found live in purescript's "characters" pattern): a
     class made of two ranges whose endpoints are escaped ("\[" and "\]").
     Misreading the escaping would corrupt both the computed byte set and
     where parsing continues afterward. *)
  Alcotest.(check bool)
    "[ -\\[\\]-~]+ matches a run of ordinary characters" true
    (matches_as ~match_:"[ -\\[\\]-~]+" ~name:"chars.test" ~line:"hello"
       ~text:"hello" ~scope:"chars.test"
    )

let check_injection_right_priority () =
  let t, grammar =
    make_grammar (Yojson.Basic.from_file "data/injection.json")
  in
  let toks, _ =
    TmLanguage.tokenize_exn t grammar TmLanguage.empty "<style>#ff0000</style>"
  in
  let spans = spans_of_tokens "<style>#ff0000</style>" toks in
  let color_span = List.find_opt (fun (text, _) -> text = "#ff0000") spans in
  Alcotest.(check bool)
    "injected color pattern matches inside embedded CSS scope" true
    ( match color_span with
    | Some (_, scopes) ->
        has_scope "constant.color.injected" scopes
    | None ->
        false
    )

let check_injection_left_priority () =
  let t, grammar =
    make_grammar (Yojson.Basic.from_file "data/injection_left.json")
  in
  let toks, _ = TmLanguage.tokenize_exn t grammar TmLanguage.empty "INJECTED" in
  let spans = spans_of_tokens "INJECTED" toks in
  let inj_span = List.find_opt (fun (text, _) -> text = "INJECTED") spans in
  Alcotest.(check bool)
    "L: injected pattern wins over regular word pattern" true
    ( match inj_span with
    | Some (_, scopes) ->
        has_scope "keyword.injected.left" scopes
    | None ->
        false
    )

let check_injection_no_match_outside_scope () =
  let t, grammar =
    make_grammar (Yojson.Basic.from_file "data/injection.json")
  in
  let toks, _ = TmLanguage.tokenize_exn t grammar TmLanguage.empty "hello" in
  let spans = spans_of_tokens "hello" toks in
  let has_injected =
    List.exists
      (fun (_, scopes) -> has_scope "constant.color.injected" scopes)
      spans
  in
  Alcotest.(check bool)
    "injection pattern does not match outside target scope" false has_injected

let () =
  Alcotest.run "Highlighting"
    [
      test_tokenize_json "data/a.json" "source.a"
        [
          [
            { line = "a"; expected = [ (1, [ "keyword.letter"; "source.a" ]) ] };
          ];
          [
            {
              line = "a(a)";
              expected =
                [
                  (1, [ "keyword.letter"; "source.a" ]);
                  ( 2,
                    [ "punctuation.paren.open"; "expression.group"; "source.a" ]
                  );
                  (3, [ "keyword.letter"; "expression.group"; "source.a" ]);
                  ( 4,
                    [
                      "punctuation.paren.close"; "expression.group"; "source.a";
                    ]
                  );
                ];
            };
          ];
          [
            {
              line = "a(";
              expected =
                [
                  (1, [ "keyword.letter"; "source.a" ]);
                  ( 2,
                    [ "punctuation.paren.open"; "expression.group"; "source.a" ]
                  );
                ];
            };
            {
              line = "a)";
              expected =
                [
                  (1, [ "keyword.letter"; "expression.group"; "source.a" ]);
                  ( 2,
                    [
                      "punctuation.paren.close"; "expression.group"; "source.a";
                    ]
                  );
                ];
            };
          ];
        ];
      test_tokenize_json "data/while.json" "source.while"
        [
          [
            {
              line = "a";
              expected =
                [ (1, [ "begin"; "expression.group"; "source.while" ]) ];
            };
          ];
          [
            {
              line = "ac";
              expected =
                [
                  (1, [ "begin"; "expression.group"; "source.while" ]);
                  (2, [ "keyword.letter"; "expression.group"; "source.while" ]);
                ];
            };
            {
              line = "bc";
              expected =
                [
                  (1, [ "while"; "expression.group"; "source.while" ]);
                  (2, [ "keyword.letter"; "expression.group"; "source.while" ]);
                ];
            };
          ];
        ];
      (* See https://github.com/microsoft/vscode-textmate/issues/25 *)
      test_tokenize_json "data/multiwhile.json" "source.multiwhile"
        [
          [
            {
              line = "X";
              expected = [ (1, [ "xbegin"; "xlist"; "source.multiwhile" ]) ];
            };
            {
              line = "xY";
              expected =
                [
                  (1, [ "xwhile"; "xlist"; "source.multiwhile" ]);
                  (2, [ "ybegin"; "ylist"; "xlist"; "source.multiwhile" ]);
                ];
            };
            {
              line = "yxy";
              expected =
                [
                  (1, [ "xlist"; "source.multiwhile" ]);
                  (2, [ "xwhile"; "xlist"; "source.multiwhile" ]);
                  (3, [ "ywhile"; "ylist"; "xlist"; "source.multiwhile" ]);
                ];
            };
            {
              line = "xy";
              expected =
                [
                  (1, [ "xwhile"; "xlist"; "source.multiwhile" ]);
                  (2, [ "ywhile"; "ylist"; "xlist"; "source.multiwhile" ]);
                ];
            };
            { line = "y"; expected = [ (1, [ "source.multiwhile" ]) ] };
          ];
        ];
      test_tokenize_json "data/groups.json" "source.groups"
        [
          [
            {
              line = "({#aaff59})";
              expected =
                [
                  ( 2,
                    [
                      "punctuation.paren.open";
                      "expression.group";
                      "source.groups";
                    ]
                  );
                  ( 9,
                    [ "keyword.operator"; "expression.group"; "source.groups" ]
                  );
                  ( 11,
                    [
                      "punctuation.paren.close";
                      "expression.group";
                      "source.groups";
                    ]
                  );
                ];
            };
          ];
        ];
      test_tokenize_json "data/zero_width_loop.json" "source.zero-width-loop"
        [ [ { line = "a"; expected = [ (1, [ "source.zero-width-loop" ]) ] } ] ];
      test_tokenize_json "data/zero_width_end_loop.json"
        "source.zero-width-end-loop"
        [
          [
            { line = "a"; expected = [ (1, [ "source.zero-width-end-loop" ]) ] };
            { line = "z"; expected = [ (1, [ "source.zero-width-end-loop" ]) ] };
          ];
        ];
      test_tokenize_json "data/zero_width_match_loop.json"
        "source.zero-width-match-loop"
        [
          [
            {
              line = "a";
              expected = [ (1, [ "source.zero-width-match-loop" ]) ];
            };
          ];
        ];
      ( "g-anchor-end-pattern",
        [
          Alcotest.test_case "Closes quoted scope after begin anchor" `Quick
            check_end_pattern_g_anchor;
          Alcotest.test_case "Positive \\G end fails without parent anchor"
            `Quick check_positive_g_anchor_fails_without_parent_anchor;
          Alcotest.test_case "Negative \\G end matches without parent anchor"
            `Quick check_negative_g_anchor_matches_without_parent_anchor;
        ]
      );
      ( "g-anchor-parent-and-while",
        [
          Alcotest.test_case "Nested patterns use parent \\G anchor" `Quick
            check_parent_g_anchor_in_nested_patterns;
          Alcotest.test_case "Empty content closes with parent \\G anchor"
            `Quick check_parent_g_anchor_closes_on_empty_content;
          Alcotest.test_case "Positive \\G while fails without anchor" `Quick
            check_positive_g_anchor_while_fails_without_anchor;
          Alcotest.test_case "Negative \\G while matches without anchor" `Quick
            check_negative_g_anchor_while_matches_without_anchor;
        ]
      );
      ( "overlapping-begin-captures",
        [
          Alcotest.test_case "Keeps string scope on opening quote" `Quick
            check_overlapping_begin_captures_opening_quote;
        ]
      );
      ( "sibling-capture-ordering",
        [
          Alcotest.test_case
            "Simple capture closes before a later sibling with nested patterns"
            `Quick check_sibling_simple_then_nested_capture_ordering;
        ]
      );
      ( "first-byte-prefilter",
        [
          Alcotest.test_case "Inline (?i) case-insensitive flag" `Quick
            check_inline_case_insensitive_flag;
          Alcotest.test_case "Extended (?x) free-spacing mode" `Quick
            check_extended_free_spacing_mode;
          Alcotest.test_case "Unusual escapes and operators" `Quick
            check_unusual_escapes_and_operators_not_misoptimized;
          Alcotest.test_case "\\h hex-digit shorthand" `Quick
            check_h_shorthand_hex_digit;
          Alcotest.test_case "Named group vs lookbehind" `Quick
            check_named_group_vs_lookbehind;
          Alcotest.test_case "Multibyte UTF-8 first byte" `Quick
            check_multibyte_utf8_first_byte;
          Alcotest.test_case "Optional leading atom before a mandatory byte"
            `Quick check_optional_leading_atom_before_mandatory_byte;
          Alcotest.test_case "Top-level alternation without a group" `Quick
            check_top_level_alternation_without_group;
          Alcotest.test_case "Leading ']' is a literal bracket member" `Quick
            check_leading_bracket_literal;
          Alcotest.test_case "Escaped range endpoint" `Quick
            check_escaped_range_endpoint;
        ]
      );
      ( "injections",
        [
          Alcotest.test_case "Right-priority injection into embedded scope"
            `Quick check_injection_right_priority;
          Alcotest.test_case
            "Left-priority injection wins over regular patterns" `Quick
            check_injection_left_priority;
          Alcotest.test_case "Injection does not match outside target scope"
            `Quick check_injection_no_match_outside_scope;
        ]
      );
    ]
