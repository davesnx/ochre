exception Timed_out

let () =
  Sys.set_signal Sys.sigalrm (Sys.Signal_handle (fun _ -> raise Timed_out))

let within seconds f =
  ignore
    (Unix.setitimer Unix.ITIMER_REAL
       { Unix.it_interval = 0.; it_value = seconds }
    );
  Fun.protect
    (fun () ->
      try f () with
      | Timed_out ->
          Alcotest.failf "did not finish within %.0f s" seconds
      | Stack_overflow ->
          Alcotest.fail "stack overflow"
    )
    ~finally:(fun () ->
      ignore
        (Unix.setitimer Unix.ITIMER_REAL
           { Unix.it_interval = 0.; it_value = 0. }
        )
    )

let load json_string =
  let grammar =
    TmLanguage.of_yojson_exn (Yojson.Basic.from_string json_string)
  in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  (t, grammar)

let spans line toks =
  let rec build start = function
    | [] ->
        []
    | tok :: rest ->
        let ending = TmLanguage.ending tok in
        (String.sub line start (ending - start), TmLanguage.scopes tok)
        :: build ending rest
  in
  build 0 toks

let check_well_formed line toks =
  let rec go prev = function
    | [] ->
        Alcotest.(check int)
          "last ending is the line length" (String.length line) prev
    | tok :: rest ->
        let ending = TmLanguage.ending tok in
        if ending <= prev then
          Alcotest.failf "ending %d does not follow %d in %S" ending prev line;
        if ending > String.length line then
          Alcotest.failf "ending %d is past the end of %S" ending line;
        go ending rest
  in
  go 0 toks

let tokenize ?max_line_length ?time_limit (t, grammar) stack line =
  let toks, stack =
    TmLanguage.tokenize_exn ?max_line_length ?time_limit t grammar stack line
  in
  check_well_formed line toks;
  (spans line toks, stack)

let tokenize_one ?max_line_length ?time_limit loaded line =
  fst (tokenize ?max_line_length ?time_limit loaded TmLanguage.empty line)

let scopes_of_text spans text =
  match List.find_opt (fun (t, _) -> t = text) spans with
  | Some (_, scopes) ->
      scopes
  | None ->
      Alcotest.failf "no token %S in [%s]" text
        (String.concat "; "
           (List.map (fun (t, _) -> Printf.sprintf "%S" t) spans)
        )

let has scope scopes = List.mem scope scopes

let grammar_json patterns =
  Printf.sprintf {|{"scopeName":"source.t","patterns":%s}|} patterns

let check_zero_width_begin_with_captures_past_match () =
  let loaded =
    load
      (grammar_json
         {|[{"begin":"(?=(export)\\s+(const))","end":"\\bconst\\b","name":"decl",
            "beginCaptures":{"1":{"name":"kw.export"},"2":{"name":"kw.const"}}}]|}
      )
  in
  let spans = tokenize_one loaded "export const x" in
  Alcotest.(check bool)
    "export keeps its capture scope" true
    (has "kw.export" (scopes_of_text spans "export"));
  Alcotest.(check bool)
    "a capture that starts after the match is dropped" false
    (List.exists (fun (_, scopes) -> has "kw.const" scopes) spans)

let check_capture_nested_in_capture_with_patterns () =
  let loaded =
    load
      (grammar_json
         {|[{"match":"a(b)c","captures":{
              "0":{"patterns":[{"match":"b","name":"inner"}]},
              "1":{"name":"group"}}}]|}
      )
  in
  let spans = tokenize_one loaded "abc" in
  Alcotest.(check bool)
    "the retokenized capture scopes its content" true
    (has "inner" (scopes_of_text spans "b"));
  Alcotest.(check bool)
    "a capture inside it is covered by the retokenization" false
    (has "group" (scopes_of_text spans "b"))

let check_capture_name_references () =
  let loaded =
    load
      (grammar_json
         {|[{"match":"(\\w+) (\\w+) (\\.\\w+)","captures":{
              "1":{"name":"kw.$1"},
              "2":{"name":"kw.${2:/upcase}.${2:/downcase}"},
              "3":{"name":"kw.$3.$9"}}}]|}
      )
  in
  let spans = tokenize_one loaded "foo Bar .baz" in
  Alcotest.(check bool) "$1" true (has "kw.foo" (scopes_of_text spans "foo"));
  Alcotest.(check bool)
    "${2:/upcase} and ${2:/downcase}" true
    (has "kw.BAR.bar" (scopes_of_text spans "Bar"));
  Alcotest.(check bool)
    "leading dots are dropped, an absent group is left as written" true
    (has "kw.baz.$9" (scopes_of_text spans ".baz"))

let check_rule_name_references () =
  let loaded =
    load
      (grammar_json
         {|[{"begin":"<(\\w+)>","end":"</\\1>","name":"tag.$1","contentName":"body.$1",
             "patterns":[{"match":"(\\d+)","name":"num.$1"}]}]|}
      )
  in
  let spans = tokenize_one loaded "<b>12</b>" in
  Alcotest.(check bool)
    "name of a begin/end rule" true
    (has "tag.b" (scopes_of_text spans "<b>"));
  Alcotest.(check bool)
    "contentName of a begin/end rule" true
    (has "body.b" (scopes_of_text spans "12"));
  Alcotest.(check bool)
    "name of a match rule" true
    (has "num.12" (scopes_of_text spans "12"));
  Alcotest.(check bool)
    "name at the end of the rule" true
    (has "tag.b" (scopes_of_text spans "</b>"))

let check_match_past_end_of_line () =
  List.iter
    (fun (pattern, line) ->
      let loaded =
        load
          (grammar_json
             (Printf.sprintf
                {|[{"match":"(%s)","name":"x","captures":{"0":{"name":"all"},"1":{"name":"group"}}}]|}
                pattern
             )
          )
      in
      ignore (tokenize_one loaded line)
    )
    [
      ("[^\\n@]", "\xC3");
      ("\\\\w", "\xC3");
      ("[^\\n@]+", "a \xF4");
      (".", "\xE2\x82");
    ]

let heredoc_grammar =
  grammar_json {|[{"begin":"<<(\\S+)","end":"^\\1$","name":"heredoc"}]|}

let two_group_heredoc_grammar =
  grammar_json {|[{"begin":"<<(\\S+)(y?)","end":"^\\1$","name":"heredoc"}]|}

let check_invalid_byte_in_back_referenced_end () =
  let loaded = load two_group_heredoc_grammar in
  let first, stack = tokenize loaded TmLanguage.empty "<<\x90x\n" in
  Alcotest.(check bool)
    "opens the rule" true
    (has "heredoc" (scopes_of_text first "<<\x90x"));
  let second, _ = tokenize loaded stack "line\n" in
  Alcotest.(check bool)
    "a rule that cannot end stays open" true
    (has "heredoc" (scopes_of_text second "line\n"))

let check_valid_back_referenced_end () =
  let loaded = load heredoc_grammar in
  let _, stack = tokenize loaded TmLanguage.empty "<<EOF\n" in
  let inside, stack = tokenize loaded stack "line\n" in
  let closing, stack = tokenize loaded stack "EOF\n" in
  let after, _ = tokenize loaded stack "line\n" in
  Alcotest.(check bool)
    "inside" true
    (has "heredoc" (scopes_of_text inside "line\n"));
  Alcotest.(check bool)
    "terminator" true
    (has "heredoc" (scopes_of_text closing "EOF"));
  Alcotest.(check bool)
    "after" false
    (has "heredoc" (scopes_of_text after "line\n"))

let rejected_at_load json =
  match load json with
  | exception TmLanguage.Error _ ->
      ()
  | _ ->
      Alcotest.fail "a malformed regex was accepted when reading the grammar"

let check_malformed_end_rejected_at_load () =
  rejected_at_load
    {|{"scopeName":"source.t","patterns":[{"begin":"a","end":"(","name":"x"}]}|};
  rejected_at_load
    {|{"scopeName":"source.t","patterns":[{"begin":"^a","while":"(","name":"x"}]}|};
  ignore
    (load
       {|{"scopeName":"source.t","patterns":[{"begin":"a","end":"b","name":"x"}]}|}
    )

let check_unusable_back_referenced_end_never_ends () =
  let loaded =
    load
      {|{"scopeName":"source.t","patterns":[{"begin":"(.)","end":"\\1(","name":"x"}]}|}
  in
  let _, stack = tokenize loaded TmLanguage.empty "ab\n" in
  let second, _ = tokenize loaded stack "ab\n" in
  Alcotest.(check bool)
    "the rule stays open" true
    (has "x" (scopes_of_text second "ab\n"))

let check_terminates name json line () =
  let loaded = load json in
  within 10. (fun () ->
      let spans = tokenize_one loaded line in
      Alcotest.(check string) name line (String.concat "" (List.map fst spans))
  )

let include_loops =
  [
    ( "include $self at the top level",
      {|{"scopeName":"source.t","patterns":[{"include":"$self"}]}|}
    );
    ( "include $base at the top level",
      {|{"scopeName":"source.t","patterns":[{"include":"$base"}]}|}
    );
    ( "include of its own scope name",
      {|{"scopeName":"source.t","patterns":[{"include":"source.t"}]}|}
    );
    ( "repository entry including itself",
      {|{"scopeName":"source.t","patterns":[{"include":"#a"}],"repository":{"a":{"patterns":[{"include":"#a"}]}}}|}
    );
    ( "repository entries including each other",
      {|{"scopeName":"source.t","patterns":[{"include":"#a"}],"repository":{"a":{"patterns":[{"include":"#b"}]},"b":{"patterns":[{"include":"#a"}]}}}|}
    );
    ( "capture including $self",
      {|{"scopeName":"source.t","patterns":[{"match":".+","captures":{"0":{"patterns":[{"include":"$self"}]}}}]}|}
    );
    ( "begin/end including $self through a loop",
      {|{"scopeName":"source.t","patterns":[{"include":"#a"}],"repository":{"a":{"patterns":[{"include":"$self"},{"match":"x","name":"x"}]}}}|}
    );
  ]

let check_loop_keeps_other_patterns () =
  let loaded =
    load
      {|{"scopeName":"source.t","patterns":[{"include":"#a"}],"repository":{"a":{"patterns":[{"include":"#a"},{"match":"x","name":"found"}]}}}|}
  in
  within 10. (fun () ->
      let spans = tokenize_one loaded "axb" in
      Alcotest.(check bool)
        "patterns next to the loop still match" true
        (has "found" (scopes_of_text spans "x"))
  )

let cubic_grammar =
  grammar_json
    {|[{"begin":"(\\w[-\\w]*)([-\"\\s\\w]*)(\\{)","end":"\\}","name":"block"},
       {"match":"\\.","name":"dot"}]|}

let check_pathological_line_is_bounded () =
  let loaded = load cubic_grammar in
  let line = String.make 100_000 'a' ^ "\n" in
  within 20. (fun () -> ignore (tokenize_one loaded line))

let many_leading_spaces_grammar =
  let alternatives =
    List.init 60 (fun i ->
        Printf.sprintf {|{"match":"\\s*\\\\begin\\{kind%d\\}","name":"k%d"}|} i
          i
    )
  in
  grammar_json ("[" ^ String.concat "," alternatives ^ "]")

let check_time_limit_bounds_scanning () =
  let loaded = load many_leading_spaces_grammar in
  let line = String.make 9_000 ' ' ^ "\n" in
  within 5. (fun () -> ignore (tokenize_one loaded line))

let check_rest_of_line_after_max_line_length () =
  let loaded =
    load
      (grammar_json
         {|[{"begin":"\"","end":"\"","name":"string",
             "patterns":[{"match":"\\w+","name":"word"}]}]|}
      )
  in
  let first, stack =
    tokenize ~max_line_length:10 loaded TmLanguage.empty
      "\"aaa bbb ccc ddd eee fff\n"
  in
  let last_text, last_scopes = List.nth first (List.length first - 1) in
  Alcotest.(check string)
    "the rest of the line is one token" "cc ddd eee fff\n" last_text;
  Alcotest.(check bool)
    "with the scopes in force at the cut" true
    (has "string" last_scopes && not (has "word" last_scopes));
  let second, _ = tokenize loaded stack "end\" x\n" in
  Alcotest.(check bool)
    "the next line starts from the state at the cut" true
    (has "string" (scopes_of_text second "end"));
  Alcotest.(check bool)
    "and closes the string" false
    (has "string" (scopes_of_text second " x\n"))

let check_cut_is_on_a_character_boundary () =
  let loaded = load (grammar_json {|[{"match":".","name":"c"}]|}) in
  let line = String.concat "" (List.init 10 (fun _ -> "\xC3\xA9")) ^ "\n" in
  let spans = tokenize ~max_line_length:5 loaded TmLanguage.empty line |> fst in
  List.iter
    (fun (text, _) ->
      Alcotest.(check bool) "valid UTF-8 token" true (String.is_valid_utf_8 text)
    )
    spans;
  Alcotest.(check int)
    "two characters are tokenized, the rest is one token" 3 (List.length spans)

let nested_includes_grammar =
  {|{"scopeName":"source.t","patterns":[{"include":"#paren"}],
     "repository":{
       "paren":{"begin":"\\(","end":"\\)","name":"paren","patterns":[{"include":"#paren"}],
                "repository":{"unused":{"match":"u","name":"u"}}}}}|}

let check_nested_includes_scale_linearly () =
  let loaded = load nested_includes_grammar in
  let line = String.make 80_000 '(' ^ "\n" in
  within 10. (fun () ->
      ignore
        (tokenize_one ~max_line_length:max_int ~time_limit:infinity loaded line)
  )

let diamond_grammar depth =
  let entries =
    List.init depth (fun i ->
        Printf.sprintf
          {|"r%d":{"patterns":[{"include":"#r%d"},{"include":"#r%d"}]}|} i
          (i + 1) (i + 1)
    )
    @ [ Printf.sprintf {|"r%d":{"match":"a","name":"found"}|} depth ]
  in
  Printf.sprintf
    {|{"scopeName":"source.t","patterns":[{"include":"#r0"}],"repository":{%s}}|}
    (String.concat "," entries)

let check_diamond_includes () =
  let loaded = within 10. (fun () -> load (diamond_grammar 26)) in
  within 10. (fun () ->
      let spans = tokenize_one loaded "aaa\n" in
      Alcotest.(check bool)
        "the rule at the bottom still matches" true
        (has "found" (scopes_of_text spans "a"))
  )

let check_include_order () =
  let loaded =
    load
      {|{"scopeName":"source.t","patterns":[{"include":"#a"},{"include":"#b"}],
         "repository":{
           "a":{"patterns":[{"include":"#c"}]},
           "b":{"patterns":[{"match":"x","name":"late"},{"include":"#c"}]},
           "c":{"match":"x","name":"early"}}}|}
  in
  let spans = tokenize_one loaded "x\n" in
  Alcotest.(check bool)
    "the first occurrence of a rule keeps its place" true
    (has "early" (scopes_of_text spans "x"))

let check_never_splits_a_character () =
  let loaded = load (grammar_json {|[{"match":"(?<=.)[^a]","name":"c"}]|}) in
  let spans = tokenize_one loaded "\xC3\xA9b\n" in
  List.iter
    (fun (text, _) ->
      Alcotest.(check bool)
        (Printf.sprintf "%S is valid UTF-8" text)
        true
        (String.is_valid_utf_8 text)
    )
    spans

let check_first_byte_is_conservative () =
  List.iter
    (fun (pattern, line, text) ->
      let loaded =
        load
          (grammar_json (Printf.sprintf {|[{"match":"%s","name":"m"}]|} pattern))
      in
      let spans = tokenize_one loaded line in
      Alcotest.(check bool)
        (Printf.sprintf "%s matches %S" pattern text)
        true
        (has "m" (scopes_of_text spans text))
    )
    [
      ("x{2}?y", "y\n", "y");
      ("x{2}*y", "y\n", "y");
      ("[a[^b]]", "z\n", "z");
      ("[a-z&&[^b]]", "z\n", "z");
    ]

let check_g_anchor_in_retokenized_capture () =
  let loaded =
    load
      (grammar_json
         {|[{"match":"x(abc)","captures":{"1":{"patterns":[
              {"match":"\\Gabc","name":"anchored"},{"match":"b","name":"b"}]}}}]|}
      )
  in
  let spans = tokenize_one loaded "xabc\n" in
  Alcotest.(check bool)
    "\\G does not match at the start of a retokenized capture" false
    (List.exists (fun (_, scopes) -> has "anchored" scopes) spans);
  Alcotest.(check bool)
    "other patterns still apply" true
    (has "b" (scopes_of_text spans "b"))

let check_time_limit_keeps_while_frames () =
  let loaded =
    load
      (grammar_json
         {|[{"begin":"^>","while":"^(?:>|k)","contentName":"inside","name":"quote"}]|}
      )
  in
  let _, stack = tokenize loaded TmLanguage.empty ">a\n" in
  let _, stack =
    tokenize ~time_limit:(-1.) loaded stack (String.make 40 'b' ^ "\n")
  in
  let spans, _ = tokenize loaded stack "k\n" in
  Alcotest.(check bool)
    "the rule is still open on the next line" true
    (List.exists (fun (_, scopes) -> has "inside" scopes) spans)

let check_empty_line () =
  let loaded = load (grammar_json {|[{"match":"a","name":"a"}]|}) in
  let toks, stack =
    TmLanguage.tokenize_exn (fst loaded) (snd loaded) TmLanguage.empty ""
  in
  Alcotest.(check int) "no tokens" 0 (List.length toks);
  let spans, _ = tokenize loaded stack "a\n" in
  Alcotest.(check bool)
    "the stack is usable" true
    (has "a" (scopes_of_text spans "a"))

let () =
  Alcotest.run "Robustness"
    [
      ( "captures",
        [
          Alcotest.test_case "Zero-width begin with captures past the match"
            `Quick check_zero_width_begin_with_captures_past_match;
          Alcotest.test_case "Capture nested in a capture with patterns" `Quick
            check_capture_nested_in_capture_with_patterns;
          Alcotest.test_case "References to groups in capture names" `Quick
            check_capture_name_references;
          Alcotest.test_case "References to groups in rule names" `Quick
            check_rule_name_references;
        ]
      );
      ( "invalid input",
        [
          Alcotest.test_case "Match that ends past the end of the line" `Quick
            check_match_past_end_of_line;
          Alcotest.test_case "Invalid byte in a back-referenced end" `Quick
            check_invalid_byte_in_back_referenced_end;
          Alcotest.test_case "Valid back-referenced end still ends" `Quick
            check_valid_back_referenced_end;
          Alcotest.test_case "A character is never split" `Quick
            check_never_splits_a_character;
          Alcotest.test_case "First-byte filter is conservative" `Quick
            check_first_byte_is_conservative;
          Alcotest.test_case "G anchor in a retokenized capture" `Quick
            check_g_anchor_in_retokenized_capture;
          Alcotest.test_case "Empty line" `Quick check_empty_line;
        ]
      );
      ( "regex errors",
        [
          Alcotest.test_case "Malformed static end or while is rejected on load"
            `Quick check_malformed_end_rejected_at_load;
          Alcotest.test_case "Unusable back-referenced end never ends" `Quick
            check_unusable_back_referenced_end_never_ends;
        ]
      );
      ( "include loops",
        List.map
          (fun (name, json) ->
            Alcotest.test_case name `Quick
              (check_terminates name json "abc def\n")
          )
          include_loops
        @ [
            Alcotest.test_case "Other patterns survive a loop" `Quick
              check_loop_keeps_other_patterns;
            Alcotest.test_case "Diamond of includes" `Quick
              check_diamond_includes;
            Alcotest.test_case "Includes keep their order" `Quick
              check_include_order;
          ]
      );
      ( "bounded work",
        [
          Alcotest.test_case "Pathological long line" `Quick
            check_pathological_line_is_bounded;
          Alcotest.test_case "Time limit bounds regex scanning" `Quick
            check_time_limit_bounds_scanning;
          Alcotest.test_case "Rest of the line after max_line_length" `Quick
            check_rest_of_line_after_max_line_length;
          Alcotest.test_case "Cut on a character boundary" `Quick
            check_cut_is_on_a_character_boundary;
          Alcotest.test_case "Time limit keeps while frames" `Quick
            check_time_limit_keeps_while_frames;
          Alcotest.test_case "Nested includes scale linearly" `Quick
            check_nested_includes_scale_linearly;
        ]
      );
    ]
