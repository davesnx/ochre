let tokens grammar_json lines = List.concat (Util.tokens [ grammar_json ] lines)

let scopes_testable = Alcotest.(list (pair string (list string)))

let check name grammar lines expected =
  Alcotest.test_case name `Quick (fun () ->
      Alcotest.check scopes_testable name expected (tokens grammar lines)
  )

let captures_and_end_captures =
  check "captures applies to the begin side, endCaptures to the end side"
    {|{"scopeName":"source.t","patterns":[{"begin":"\\{","end":"\\}",
       "captures":{"0":{"name":"cap"}},
       "endCaptures":{"0":{"name":"endcap"}}}]}|}
    [ "{}\n" ]
    [ ("{", [ "cap" ]); ("}", [ "endcap" ]); ("\n", []) ]

let captures_fallback_both_sides =
  check "captures is the fallback for both sides"
    {|{"scopeName":"source.t","patterns":[{"begin":"\\{","end":"\\}",
       "captures":{"0":{"name":"cap"}}}]}|}
    [ "{}\n" ]
    [ ("{", [ "cap" ]); ("}", [ "cap" ]); ("\n", []) ]

let apply_end_pattern_last_true =
  check "applyEndPatternLast accepts JSON true"
    {|{"scopeName":"source.t","patterns":[{"begin":"\"","end":"\"",
       "name":"str","applyEndPatternLast":true,
       "patterns":[{"match":"\"\"","name":"esc"}]}]}|}
    [ "\"a\"\"b\"\n" ]
    [
      ("\"", [ "str" ]);
      ("a", [ "str" ]);
      ("\"\"", [ "str"; "esc" ]);
      ("b", [ "str" ]);
      ("\"", [ "str" ]);
      ("\n", []);
    ]

let patterns_only_rule_ignores_name =
  check "a rule with only patterns ignores its name"
    {|{"scopeName":"source.t","patterns":[{"name":"wrap",
       "patterns":[{"match":"x","name":"x"}]}]}|}
    [ "x\n" ]
    [ ("x", [ "x" ]); ("\n", []) ]

let empty_match_is_ignored =
  check "an empty match is ignored"
    {|{"scopeName":"source.t","patterns":[{"match":"","name":"never"},
       {"match":"x","name":"x"}]}|}
    [ "x\n" ]
    [ ("x", [ "x" ]); ("\n", []) ]

let empty_begin_still_begins =
  check "an empty begin is a zero-width begin"
    {|{"scopeName":"source.t","patterns":[{"begin":"","end":"y","name":"blk",
       "patterns":[{"match":"x","name":"x"}]}]}|}
    [ "xy\n" ]
    [ ("x", [ "blk"; "x" ]); ("y", [ "blk" ]); ("\n", [ "blk" ]) ]

let empty_match_with_patterns =
  check "an empty match on a rule without begin leaves a patterns-only rule"
    {|{"scopeName":"source.t","patterns":[{"match":"","name":"never",
       "patterns":[{"match":"x","name":"x"}]}]}|}
    [ "x\n" ]
    [ ("x", [ "x" ]); ("\n", []) ]

let empty_end_never_matches =
  check "an empty end never ends the rule"
    {|{"scopeName":"source.t","patterns":[{"begin":"@","end":"","name":"blk"}]}|}
    [ "@a\n"; "b\n" ]
    [ ("@", [ "blk" ]); ("a\n", [ "blk" ]); ("b\n", [ "blk" ]) ]

let () =
  Alcotest.run "Grammar loading"
    [
      ( "vscode-textmate",
        [
          captures_and_end_captures;
          captures_fallback_both_sides;
          apply_end_pattern_last_true;
          patterns_only_rule_ignores_name;
          empty_match_is_ignored;
          empty_begin_still_begins;
          empty_match_with_patterns;
          empty_end_never_matches;
        ]
      );
    ]
