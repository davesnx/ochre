let merge spans =
  List.fold_left
    (fun acc (text, scopes) ->
      match acc with
      | (text', scopes') :: rest when scopes = scopes' ->
          (text' ^ text, scopes) :: rest
      | _ ->
          (text, scopes) :: acc
    )
    [] spans
  |> List.rev

let chomp line =
  if String.ends_with ~suffix:"\n" line then
    String.sub line 0 (String.length line - 1)
  else
    line

let tokens grammars lines =
  List.map merge (Util.tokens grammars (List.map chomp lines))

let lines_testable = Alcotest.(list (list (pair string (list string))))

let check name grammars lines expected =
  Alcotest.test_case name `Quick (fun () ->
      Alcotest.check lines_testable name expected (tokens grammars lines)
  )

let scoped = {|{"scopeName":"source.t",|}

let begin_consumes_newline =
  check "\\G holds at the start of the line after a begin that consumed it"
    [
      scoped
      ^ {|"patterns":[{"begin":"x\\n","end":"bar","name":"blk",
          "patterns":[{"match":"\\Gfoo","name":"g"}]}]}|};
    ]
    [ "x\n"; "foo\n"; "bar\n" ]
    [
      [ ("x", [ "blk" ]) ]; [ ("foo", [ "blk"; "g" ]) ]; [ ("bar", [ "blk" ]) ];
    ]

let begin_stops_before_newline =
  check "\\G is false at the start of the line when the begin kept the newline"
    [
      scoped
      ^ {|"patterns":[{"begin":"x","end":"bar","name":"blk",
          "patterns":[{"match":"\\Gfoo","name":"g"}]}]}|};
    ]
    [ "x\n"; "foo\n"; "bar\n" ]
    [ [ ("x", [ "blk" ]) ]; [ ("foo", [ "blk" ]) ]; [ ("bar", [ "blk" ]) ] ]

let start_of_text_first_line_only =
  check "\\A matches on the first line only and ^ still matches on every line"
    [
      scoped
      ^ {|"patterns":[{"match":"\\Afoo","name":"first"},
          {"match":"^bar","name":"bol"}]}|};
    ]
    [ "foo\n"; "foo\n"; "bar\n" ]
    [ [ ("foo", [ "first" ]) ]; [ ("foo", []) ]; [ ("bar", [ "bol" ]) ] ]

let end_of_text_never_before_newline =
  check "\\z does not match at the end of a line that ends in a newline"
    [ scoped ^ {|"patterns":[{"begin":"BEGIN","end":"\\z","name":"blk"}]}|} ]
    [ "BEGIN\n"; "more\n"; "again\n" ]
    [
      [ ("BEGIN", [ "blk" ]) ];
      [ ("more", [ "blk" ]) ];
      [ ("again", [ "blk" ]) ];
    ]

let match_without_advance_stops_line =
  check "a match that does not advance stops the line"
    [
      scoped
      ^ {|"patterns":[{"match":"(?=x)","name":"m"},
          {"match":"x","name":"x"}]}|};
    ]
    [ "x\n"; "x\n" ]
    [ [ ("x", []) ]; [ ("x", []) ] ]

let begin_same_rule_without_advance_stops_line =
  check "a begin that pushes the same rule without advancing stops the line"
    [
      scoped
      ^ {|"patterns":[{"begin":"(?=x)","end":"(?=y)","name":"b",
          "patterns":[{"include":"$self"},{"match":"x","name":"x"}]}]}|};
    ]
    [ "xy\n"; "z\n" ]
    [ [ ("xy", [ "b" ]) ]; [ ("z", [ "b" ]) ] ]

let end_without_advance_keeps_rule =
  check
    "an end that pops a rule entered at this position without advancing stops \
     the line and keeps the rule"
    [
      scoped
      ^ {|"patterns":[{"begin":"(?=a)","end":"(?=a)","name":"blk"},
          {"match":"a","name":"a"}]}|};
    ]
    [ "a\n"; "z\n" ]
    [ [ ("a", [ "blk" ]) ]; [ ("z", [ "blk" ]) ] ]

let match_without_advance_pops_frame =
  check "a match that does not advance inside a rule also pops that rule"
    [
      scoped
      ^ {|"patterns":[{"begin":"\\(","end":"\\)","name":"p","patterns":[
          {"match":"(?=x)","name":"m"},{"match":"x","name":"x"}]}]}|};
    ]
    [ "(ax)\n"; "b\n" ]
    [ [ ("(a", [ "p" ]); ("x)", []) ]; [ ("b", []) ] ]

let capture_patterns_use_item_repository =
  check "capture patterns resolve includes in the repository of their item"
    [
      scoped
      ^ {|"patterns":[{"include":"#outer"}],"repository":{"outer":{
          "patterns":[{"match":"(a)","captures":{"1":{"patterns":[
            {"include":"#inner"}]}}}],
          "repository":{"inner":{"match":"a","name":"in"}}}}}|};
    ]
    [ "a\n" ]
    [ [ ("a", [ "in" ]) ] ]

let include_scope_fragment =
  check "include scope#fragment reads the fragment in that grammar"
    [
      scoped ^ {|"patterns":[{"include":"source.u#frag"}]}|};
      {|{"scopeName":"source.u","patterns":[{"match":"y","name":"uy"}],
         "repository":{
           "frag":{"begin":"\\(","end":"\\)","name":"blk","patterns":[
             {"include":"#other"},{"include":"$self"}]},
           "other":{"match":"x","name":"ux"}}}|};
    ]
    [ "(xy)\n" ]
    [
      [
        ("(", [ "blk" ]);
        ("x", [ "blk"; "ux" ]);
        ("y", [ "blk"; "uy" ]);
        (")", [ "blk" ]);
      ];
    ]

let left_injection_beats_end =
  check "a left injection beats the end of the rule at the same position"
    [
      scoped
      ^ {|"patterns":[{"begin":"\\(","end":"\\)","name":"meta.blk"}],
          "injections":{"L:meta.blk":{"patterns":[
            {"match":"\\)","name":"inj"}]}}}|};
    ]
    [ "(a)\n"; "b\n" ]
    [
      [ ("(a", [ "meta.blk" ]); (")", [ "meta.blk"; "inj" ]) ];
      [ ("b", [ "meta.blk" ]) ];
    ]

let blocks injections =
  scoped
  ^ {|"patterns":[
      {"begin":"<a>","end":"</a>","name":"a.x","patterns":[{"include":"$self"}]},
      {"begin":"<b>","end":"</b>","name":"b.y","patterns":[{"include":"$self"}]},
      {"begin":"<c>","end":"</c>","name":"c.z","patterns":[{"include":"$self"}]}],
      "injections":{|}
  ^ injections ^ "}}"

let inj_rule = {|{"patterns":[{"match":"!","name":"inj"}]}|}

let injected selector = blocks (Printf.sprintf {|"%s":%s|} selector inj_rule)

let injected_in selector lines expected =
  check
    (Printf.sprintf "selector %S on %s" selector (String.concat " " lines))
    [ injected selector ]
    (List.map (fun l -> l ^ "\n") lines)
    expected

let selector_comma =
  [
    injected_in "a.x, b.y" [ "<a>!</a>" ]
      [
        [ ("<a>", [ "a.x" ]) ]
        @ [ ("!", [ "a.x"; "inj" ]) ]
        @ [ ("</a>", [ "a.x" ]) ];
      ];
    injected_in "a.x, b.y" [ "<b>!</b>" ]
      [
        [ ("<b>", [ "b.y" ]) ]
        @ [ ("!", [ "b.y"; "inj" ]) ]
        @ [ ("</b>", [ "b.y" ]) ];
      ];
    injected_in "a.x, b.y" [ "<c>!</c>" ] [ [ ("<c>!</c>", [ "c.z" ]) ] ];
  ]

let selector_pipe =
  [
    injected_in "(a.x | b.y)" [ "<b>!</b>" ]
      [
        [ ("<b>", [ "b.y" ]) ]
        @ [ ("!", [ "b.y"; "inj" ]) ]
        @ [ ("</b>", [ "b.y" ]) ];
      ];
    injected_in "(a.x | b.y)" [ "<c>!</c>" ] [ [ ("<c>!</c>", [ "c.z" ]) ] ];
    injected_in "a.x | b.y" [ "<b>!</b>" ] [ [ ("<b>!</b>", [ "b.y" ]) ] ];
    injected_in "b.y | a.x" [ "<b>!</b>" ]
      [
        [ ("<b>", [ "b.y" ]) ]
        @ [ ("!", [ "b.y"; "inj" ]) ]
        @ [ ("</b>", [ "b.y" ]) ];
      ];
  ]

let selector_exclusion =
  [
    injected_in "a.x -b.y" [ "<a>!<b>!</b></a>" ]
      [
        [
          ("<a>", [ "a.x" ]);
          ("!", [ "a.x"; "inj" ]);
          ("<b>!</b>", [ "a.x"; "b.y" ]);
          ("</a>", [ "a.x" ]);
        ];
      ];
  ]

let selector_group =
  [
    injected_in "(a.x | b.y) -c.z" [ "<a>!<c>!</c></a>" ]
      [
        [
          ("<a>", [ "a.x" ]);
          ("!", [ "a.x"; "inj" ]);
          ("<c>!</c>", [ "a.x"; "c.z" ]);
          ("</a>", [ "a.x" ]);
        ];
      ];
    injected_in "(a.x | b.y) -c.z" [ "<b>!</b>" ]
      [
        [ ("<b>", [ "b.y" ]) ]
        @ [ ("!", [ "b.y"; "inj" ]) ]
        @ [ ("</b>", [ "b.y" ]) ];
      ];
  ]

let selector_ancestor_order =
  [
    injected_in "a.x b.y" [ "<a><b>!</b></a>" ]
      [
        [
          ("<a>", [ "a.x" ]);
          ("<b>", [ "a.x"; "b.y" ]);
          ("!", [ "a.x"; "b.y"; "inj" ]);
          ("</b>", [ "a.x"; "b.y" ]);
          ("</a>", [ "a.x" ]);
        ];
      ];
    injected_in "a.x b.y" [ "<b><a>!</a></b>" ]
      [
        [
          ("<b>", [ "b.y" ]); ("<a>!</a>", [ "b.y"; "a.x" ]); ("</b>", [ "b.y" ]);
        ];
      ];
  ]

let competing_rule =
  scoped
  ^ {|"patterns":[
      {"begin":"<a>","end":"</a>","name":"a.x","patterns":[{"match":"!","name":"rule"}]},
      {"begin":"<b>","end":"</b>","name":"b.y","patterns":[{"match":"!","name":"rule"}]}],
      "injections":{"L:a.x, R:b.y":{"patterns":[{"match":"!","name":"inj"}]}}}|}

let selector_priority_per_alternative =
  check "L: and R: apply to their own alternative" [ competing_rule ]
    [ "<a>!</a>\n"; "<b>!</b>\n" ]
    [
      [ ("<a>", [ "a.x" ]); ("!", [ "a.x"; "inj" ]); ("</a>", [ "a.x" ]) ];
      [ ("<b>", [ "b.y" ]); ("!", [ "b.y"; "rule" ]); ("</b>", [ "b.y" ]) ];
    ]

let injector ?inject_to scope selector =
  Printf.sprintf
    {|{"scopeName":"%s","injectionSelector":"%s",%s"patterns":[{"match":"!","name":"%s"}]}|}
    scope selector
    ( match inject_to with
    | None ->
        ""
    | Some l ->
        Printf.sprintf {|"injectTo":[%s],|}
          (String.concat "," (List.map (Printf.sprintf "%S") l))
    )
    scope

let root_with_a =
  scoped ^ {|"patterns":[{"begin":"<a>","end":"</a>","name":"a.x"}]}|}

let inject_to_listed =
  check "a grammar injects into the root scope named in its injectTo"
    [ root_with_a; injector ~inject_to:[ "source.t" ] "source.i" "a.x" ]
    [ "<a>!</a>\n" ]
    [
      [ ("<a>", [ "a.x" ]); ("!", [ "a.x"; "source.i" ]); ("</a>", [ "a.x" ]) ];
    ]

let inject_to_other_scope =
  check "injectTo naming another scope does not inject into the root"
    [ root_with_a; injector ~inject_to:[ "source.other" ] "source.i" "a.x" ]
    [ "<a>!</a>\n" ]
    [ [ ("<a>!</a>", [ "a.x" ]) ] ]

let inject_to_missing =
  check "a grammar without injectTo does not inject anywhere"
    [ root_with_a; injector "source.i" "a.x" ]
    [ "<a>!</a>\n" ]
    [ [ ("<a>!</a>", [ "a.x" ]) ] ]

let inject_to_order =
  check "injection grammars apply in the order they were added"
    [
      root_with_a;
      injector ~inject_to:[ "source.t" ] "source.first" "a.x";
      injector ~inject_to:[ "source.t" ] "source.second" "a.x";
    ]
    [ "<a>!</a>\n" ]
    [
      [
        ("<a>", [ "a.x" ]); ("!", [ "a.x"; "source.first" ]); ("</a>", [ "a.x" ]);
      ];
    ]

let inject_to_selector_forms =
  check "injectionSelector supports alternatives, priority and exclusion"
    [
      scoped
      ^ {|"patterns":[
          {"begin":"<a>","end":"</a>","name":"a.x","patterns":[{"match":"!","name":"rule"}]},
          {"begin":"<b>","end":"</b>","name":"b.y","patterns":[{"match":"!","name":"rule"}]}]}|};
      injector ~inject_to:[ "source.t" ] "source.i" "L:a.x, R:b.y -a.x";
    ]
    [ "<a>!</a>\n"; "<b>!</b>\n" ]
    [
      [ ("<a>", [ "a.x" ]); ("!", [ "a.x"; "source.i" ]); ("</a>", [ "a.x" ]) ];
      [ ("<b>", [ "b.y" ]); ("!", [ "b.y"; "rule" ]); ("</b>", [ "b.y" ]) ];
    ]

let while_captures_use_content_name =
  check "while captures and the while match carry the contentName scope"
    [
      scoped
      ^ {|"patterns":[{"begin":"^>","while":"^>","name":"q",
          "contentName":"qc","whileCaptures":{"0":{"name":"wc"}}}]}|};
    ]
    [ ">a\n"; ">b\n"; "c\n" ]
    [
      [ (">", [ "q" ]); ("a", [ "q"; "qc" ]) ];
      [ (">", [ "q"; "qc"; "wc" ]); ("b", [ "q"; "qc" ]) ];
      [ ("c", []) ];
    ]

let base_survives_included_frame =
  check "$base and the root scope stay those of the first grammar"
    [
      scoped
      ^ {|"patterns":[{"include":"source.be#blk"},
          {"match":"r","name":"R"}]}|};
      {|{"scopeName":"source.be","patterns":[{"match":"e","name":"E"}],
         "repository":{"blk":{"begin":"<","end":">",
           "patterns":[{"include":"$base"}]}}}|};
    ]
    [ "<r e r>\n" ]
    [ [ ("<", []); ("r", [ "R" ]); (" e ", []); ("r", [ "R" ]); (">", []) ] ]

let rule_repository_is_not_for_captures =
  check "a repository beside begin is not used by its captures"
    [
      scoped
      ^ {|"patterns":[{"include":"#blk"}],"repository":{
          "r":{"match":"x","name":"outer"},
          "blk":{"begin":"<(x)","end":">","beginCaptures":{"1":{"patterns":[
            {"include":"#r"}]}},
            "repository":{"r":{"match":"x","name":"inner"}}}}}|};
    ]
    [ "<x>\n" ]
    [ [ ("<", []); ("x", [ "outer" ]); (">", []) ] ]

let begin_with_only_missing_include_is_dropped =
  check "a begin/end whose patterns are all unresolvable includes is dropped"
    [
      scoped
      ^ {|"patterns":[{"begin":"x","end":"y","name":"blk",
          "patterns":[{"include":"source.missing"}]},
          {"match":"x","name":"m"}]}|};
    ]
    [ "x\n" ]
    [ [ ("x", [ "m" ]) ] ]

let begin_with_empty_patterns_is_kept =
  check "a begin/end with an explicitly empty patterns list is kept"
    [
      scoped
      ^ {|"patterns":[{"begin":"x","end":"y","name":"blk","patterns":[]},
          {"match":"x","name":"m"}]}|};
    ]
    [ "x\n" ]
    [ [ ("x", [ "blk" ]) ] ]

let begin_with_some_resolvable_include_is_kept =
  check
    "a begin/end with one resolvable pattern beside a missing include is kept"
    [
      scoped
      ^ {|"patterns":[{"begin":"x","end":"y","name":"blk",
          "patterns":[{"include":"source.missing"},{"match":"z","name":"z"}]},
          {"match":"x","name":"m"}]}|};
    ]
    [ "xz\n" ]
    [ [ ("x", [ "blk" ]); ("z", [ "blk"; "z" ]) ] ]

let repository_bare_include_is_followed =
  check "a repository item that is only an include is followed"
    [
      scoped
      ^ {|"patterns":[{"include":"#a"}],
          "repository":{"a":{"include":"#b"},"b":{"match":"x","name":"m"}}}|};
    ]
    [ "x\n" ]
    [ [ ("x", [ "m" ]) ] ]

let long_line_leaves_next_line_state =
  Alcotest.test_case "a line over the cap leaves the next line's state alone"
    `Quick (fun () ->
      let grammar =
        scoped
        ^ {|"patterns":[{"begin":"<","end":">","name":"blk","patterns":[
            {"match":"\\G\\w+","name":"g"},{"match":"\\w+","name":"w"}]}]}|}
      in
      let line = String.make 9999 'a' ^ "<bbb\n" in
      Alcotest.check lines_testable "second line"
        [ [ ("ab cd", []) ] ]
        [ List.nth (tokens [ grammar ] [ line; "ab cd\n" ]) 1 ]
  )

let deep_nesting_is_fast =
  Alcotest.test_case "10,000 nested frames tokenize within a second" `Quick
    (fun () ->
      let t = TmLanguage.create () in
      let grammar =
        TmLanguage.of_yojson_exn
          (Yojson.Basic.from_string
             (scoped
            ^ {|"patterns":[{"begin":"\\[","end":"\\]","name":"n",
                 "patterns":[{"include":"$self"}]}]}|}
             )
          )
      in
      TmLanguage.add_grammar t grammar;
      let start = Unix.gettimeofday () in
      let toks, _ =
        TmLanguage.tokenize_exn t grammar TmLanguage.empty
          (String.make 10_000 '[' ^ "\n")
      in
      let elapsed = Unix.gettimeofday () -. start in
      Alcotest.(check bool) "tokens" true (toks <> []);
      Alcotest.(check bool)
        (Printf.sprintf "took %.2f s" elapsed)
        true (elapsed < 1.0)
  )

let () =
  Alcotest.run "Tokenizer as vscode-textmate"
    [
      ( "anchors",
        [
          begin_consumes_newline;
          begin_stops_before_newline;
          start_of_text_first_line_only;
          end_of_text_never_before_newline;
        ]
      );
      ( "endless loops",
        [
          match_without_advance_stops_line;
          begin_same_rule_without_advance_stops_line;
          end_without_advance_keeps_rule;
          match_without_advance_pops_frame;
        ]
      );
      ( "includes",
        [ capture_patterns_use_item_repository; include_scope_fragment ]
      );
      ( "dropped rules",
        [
          begin_with_only_missing_include_is_dropped;
          begin_with_empty_patterns_is_kept;
          begin_with_some_resolvable_include_is_kept;
          repository_bare_include_is_followed;
        ]
      );
      ( "base grammar",
        [
          base_survives_included_frame;
          rule_repository_is_not_for_captures;
          long_line_leaves_next_line_state;
          deep_nesting_is_fast;
        ]
      );
      ( "injections and while",
        [ left_injection_beats_end; while_captures_use_content_name ]
      );
      ("injection selector comma", selector_comma);
      ("injection selector pipe", selector_pipe);
      ("injection selector exclusion", selector_exclusion);
      ("injection selector group", selector_group);
      ("injection selector ancestor order", selector_ancestor_order);
      ("injection selector priority", [ selector_priority_per_alternative ]);
      ( "injectTo",
        [
          inject_to_listed;
          inject_to_other_scope;
          inject_to_missing;
          inject_to_order;
          inject_to_selector_forms;
        ]
      );
    ]
