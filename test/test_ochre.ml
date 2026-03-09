let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.test" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.test" }
  ]
}|}

let highlight () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.create ~grammars:[ path ] () in
  Sys.remove path;
  hl

let test_theme_loading () =
  let theme_json =
    {|
    {
      "name": "test-theme",
      "colors": {
        "editor.foreground": "#000000",
        "editor.background": "#ffffff"
      },
      "tokenColors": [
        {
          "scope": "comment",
          "settings": {
            "foreground": "#888888",
            "fontStyle": "italic"
          }
        }
      ]
    }
  |}
  in
  let theme = Ochre.Theme.load_from_string theme_json in
  Alcotest.(check string) "theme name" "test-theme" theme.name;
  Alcotest.(check string) "theme fg" "#000000" theme.fg;
  Alcotest.(check string) "theme bg" "#ffffff" theme.bg;
  Alcotest.(check int) "token_colors length" 1 (List.length theme.token_colors)

let test_scope_matching () =
  let hl = highlight () in
  let theme =
    Ochre.Theme.load_from_string
      {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
  in
  let tokens = Ochre.to_tokens hl ~theme ~lang:"test" "let x = 42" in
  match tokens with
  | (first :: _) :: _ ->
      Alcotest.(check (option string))
        "keyword gets red" (Some "#ff0000") first.foreground
  | _ ->
      Alcotest.fail "expected at least one token"

let test_capture_arrays_in_grammar () =
  let grammar_with_capture_array =
    {|{
    "scopeName": "source.capture-array",
    "name": "capture-array",
    "patterns": [
      {
        "begin": "(let)",
        "end": "$",
        "beginCaptures": [
          { "name": "keyword.control.test" }
        ]
      }
    ]
  }|}
  in
  let hl =
    Ochre.create_from_json
      ~grammars:[ ("capture-array", grammar_with_capture_array) ]
      ()
  in
  let theme =
    Ochre.Theme.load_from_string
      {|{
      "name": "test",
      "colors": {
        "editor.foreground": "#d4d4d4",
        "editor.background": "#1e1e1e"
      },
      "tokenColors": []
    }|}
  in
  let _ = Ochre.to_tokens hl ~theme ~lang:"capture-array" "let x = 1" in
  ()

let test_transform_empty_passthrough () =
  let hl = highlight () in
  let theme =
    Ochre.Theme.load_from_string
      {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
  in
  let tokens = Ochre.to_tokens hl ~theme ~lang:"test" "let x = 42" in
  let tokens_with =
    Ochre.to_tokens_with hl ~transforms:[] ~theme ~lang:"test" "let x = 42"
  in
  Alcotest.(check int)
    "same number of lines" (List.length tokens) (List.length tokens_with);
  List.iter2
    (fun line1 line2 ->
      List.iter2
        (fun (t1 : Ochre.Token.styled_token) (t2 : Ochre.Token.styled_token) ->
          Alcotest.(check string) "same text" t1.text t2.text;
          Alcotest.(check (option string)) "same fg" t1.foreground t2.foreground;
          Alcotest.(check (option string)) "same bg" t1.background t2.background
        )
        line1 line2
    )
    tokens tokens_with

let test_transform_ordering () =
  let doc : Ochre.Token.highlighted_code =
    [
      [
        {
          Ochre.Token.text = "let";
          foreground = Some "#ff0000";
          background = None;
          font_style = [];
          scopes = [ "keyword.control.test"; "source.test" ];
          decoration = None;
        };
      ];
    ]
  in
  let t1 =
    Ochre.Transform.make "first" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.styled_token) ->
            { tok with background = Some "#111111" }
          )
          line
    )
  in
  let t2 =
    Ochre.Transform.make "second" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.styled_token) ->
            { tok with background = Some "#222222" }
          )
          line
    )
  in
  let result = Ochre.Transform.run [ t1; t2 ] doc in
  match result with
  | [ [ tok ] ] ->
      Alcotest.(check (option string))
        "last transform wins" (Some "#222222") tok.background
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_transform_determinism () =
  let doc : Ochre.Token.highlighted_code =
    [
      [
        {
          Ochre.Token.text = "a";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
      [
        {
          Ochre.Token.text = "b";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
      [
        {
          Ochre.Token.text = "c";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
    ]
  in
  let transforms =
    [
      Ochre.Transform_builtin.line_highlight [ 0; 2 ];
      Ochre.Transform.make "tag" ~after_line:(fun ~line_index:_ line ->
          List.map
            (fun (tok : Ochre.Token.styled_token) ->
              {
                tok with
                foreground =
                  Some (Option.value ~default:"none" tok.foreground ^ "-tagged");
              }
            )
            line
      );
    ]
  in
  let run_once () = Ochre.Transform.run transforms doc in
  let r1 = run_once () in
  let r2 = run_once () in
  List.iter2
    (fun line1 line2 ->
      List.iter2
        (fun (t1 : Ochre.Token.styled_token) (t2 : Ochre.Token.styled_token) ->
          Alcotest.(check string) "deterministic text" t1.text t2.text;
          Alcotest.(check (option string))
            "deterministic fg" t1.foreground t2.foreground;
          Alcotest.(check (option string))
            "deterministic bg" t1.background t2.background
        )
        line1 line2
    )
    r1 r2

let test_transform_line_highlight () =
  let doc : Ochre.Token.highlighted_code =
    [
      [
        {
          Ochre.Token.text = "a";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
      [
        {
          Ochre.Token.text = "b";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok0 ]; [ tok1 ] ] ->
      Alcotest.(check (option string))
        "line 0 highlighted" (Some "#ffffff22") tok0.background;
      Alcotest.(check (option string)) "line 1 unchanged" None tok1.background
  | _ ->
      Alcotest.fail "expected 2 lines with 1 token each"

let test_transform_before_render_then_line () =
  let doc : Ochre.Token.highlighted_code =
    [
      [
        {
          Ochre.Token.text = "x";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
          decoration = None;
        };
      ];
    ]
  in
  let log = ref [] in
  let t =
    Ochre.Transform.make "logger"
      ~before_render:(fun doc ->
        log := "before_render" :: !log;
        doc
      )
      ~before_line:(fun ~line_index:_ line ->
        log := "before_line" :: !log;
        line
      )
      ~after_line:(fun ~line_index:_ line ->
        log := "after_line" :: !log;
        line
      )
      ~after_render:(fun doc ->
        log := "after_render" :: !log;
        doc
      )
  in
  let _ = Ochre.Transform.run [ t ] doc in
  let order = List.rev !log in
  Alcotest.(check (list string))
    "hook execution order"
    [ "before_render"; "before_line"; "after_line"; "after_render" ]
    order

let make_tok text =
  {
    Ochre.Token.text;
    foreground = None;
    background = None;
    font_style = [];
    scopes = [];
    decoration = None;
  }

let test_decoration_empty_passthrough () =
  let tokens = [ [ make_tok "hello" ] ] in
  let result = Ochre.Decoration.apply ~source:"hello" [] tokens in
  match result with
  | [ [ tok ] ] ->
      Alcotest.(check string) "text unchanged" "hello" tok.text;
      Alcotest.(check bool) "no decoration" true (tok.decoration = None)
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_decoration_whole_token () =
  (* Decorate "hello" (chars 0-5) which is exactly one token *)
  let tokens = [ [ make_tok "hello" ] ] in
  let d =
    Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 5) ()
  in
  let result = Ochre.Decoration.apply ~source:"hello" [ d ] tokens in
  match result with
  | [ [ tok ] ] -> (
      Alcotest.(check string) "text unchanged" "hello" tok.text;
      match tok.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "class set" (Some "hl") dec.class_
      | None ->
          Alcotest.fail "expected decoration"
    )
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_decoration_token_splitting () =
  (* Source: "console.log" as a single token. Decorate chars 0-7 ("console") *)
  let tokens = [ [ make_tok "console.log" ] ] in
  let d =
    Ochre.Decoration.make ~class_:"target" ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 7) ()
  in
  let result = Ochre.Decoration.apply ~source:"console.log" [ d ] tokens in
  match result with
  | [ [ t1; t2 ] ] ->
      Alcotest.(check string) "first fragment" "console" t1.text;
      Alcotest.(check string) "second fragment" ".log" t2.text;
      ( match t1.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "decorated" (Some "target") dec.class_
      | None ->
          Alcotest.fail "first fragment should be decorated"
      );
      Alcotest.(check bool) "second not decorated" true (t2.decoration = None)
  | [ toks ] ->
      Alcotest.fail
        (Printf.sprintf "expected 2 tokens, got %d: [%s]" (List.length toks)
           (String.concat ", "
              (List.map
                 (fun (t : Ochre.Token.styled_token) ->
                   Printf.sprintf "%S" t.text
                 )
                 toks
              )
           )
        )
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_mid_token_split () =
  (* Source: "abcdef" as one token. Decorate chars 2-4 ("cd") *)
  let tokens = [ [ make_tok "abcdef" ] ] in
  let d =
    Ochre.Decoration.make ~class_:"mid" ~start:(Ochre.Decoration.pos 0 2)
      ~end_:(Ochre.Decoration.pos 0 4) ()
  in
  let result = Ochre.Decoration.apply ~source:"abcdef" [ d ] tokens in
  match result with
  | [ [ t1; t2; t3 ] ] ->
      Alcotest.(check string) "before" "ab" t1.text;
      Alcotest.(check string) "middle" "cd" t2.text;
      Alcotest.(check string) "after" "ef" t3.text;
      Alcotest.(check bool) "before not decorated" true (t1.decoration = None);
      ( match t2.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "middle decorated" (Some "mid") dec.class_
      | None ->
          Alcotest.fail "middle should be decorated"
      );
      Alcotest.(check bool) "after not decorated" true (t3.decoration = None)
  | [ toks ] ->
      Alcotest.fail
        (Printf.sprintf "expected 3 tokens, got %d" (List.length toks))
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_multi_token () =
  (* Source: "let x" = two tokens "let" + " x". Decorate chars 0-5 (all) *)
  let tokens = [ [ make_tok "let"; make_tok " x" ] ] in
  let d =
    Ochre.Decoration.make ~class_:"all" ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 5) ()
  in
  let result = Ochre.Decoration.apply ~source:"let x" [ d ] tokens in
  match result with
  | [ [ t1; t2 ] ] -> (
      Alcotest.(check string) "first" "let" t1.text;
      Alcotest.(check string) "second" " x" t2.text;
      match (t1.decoration, t2.decoration) with
      | Some d1, Some d2 ->
          Alcotest.(check (option string)) "t1 class" (Some "all") d1.class_;
          Alcotest.(check (option string)) "t2 class" (Some "all") d2.class_
      | _ ->
          Alcotest.fail "both tokens should be decorated"
    )
  | _ ->
      Alcotest.fail "expected 1 line with 2 tokens"

let test_decoration_negative_character () =
  (* Source: "hello\nworld". Decorate line 0, chars 0 to -1 (whole line content,
     not including newline). -1 resolves to character 5 for a 5-char line. *)
  let tokens =
    [ [ make_tok "hello"; make_tok "\n" ]; [ make_tok "world"; make_tok "\n" ] ]
  in
  let d =
    Ochre.Decoration.make ~class_:"line0" ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 (-1))
      ()
  in
  let result = Ochre.Decoration.apply ~source:"hello\nworld" [ d ] tokens in
  match result with
  | [ line0; line1 ] ->
      (* "hello" should be decorated, "\n" should not *)
      let hello = List.nth line0 0 in
      let newline = List.nth line0 1 in
      ( match hello.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "hello decorated" (Some "line0") dec.class_
      | None ->
          Alcotest.fail "hello should be decorated"
      );
      Alcotest.(check bool)
        "newline not decorated" true
        (newline.decoration = None);
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          Alcotest.(check bool)
            "line1 not decorated" true (tok.decoration = None)
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_decoration_overlapping () =
  (* Source: "abcd". Two decorations overlap on "bc" *)
  let tokens = [ [ make_tok "abcd" ] ] in
  let d1 =
    Ochre.Decoration.make ~class_:"first" ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 3) ()
  in
  let d2 =
    Ochre.Decoration.make ~class_:"second" ~start:(Ochre.Decoration.pos 0 1)
      ~end_:(Ochre.Decoration.pos 0 4) ()
  in
  let result = Ochre.Decoration.apply ~source:"abcd" [ d1; d2 ] tokens in
  match result with
  | [ toks ] -> (
      (* Should have splits: "a" (first only), "bc" (both), "d" (second only) *)
      Alcotest.(check int) "3 fragments" 3 (List.length toks);
      let t1 = List.nth toks 0 in
      let t2 = List.nth toks 1 in
      let t3 = List.nth toks 2 in
      Alcotest.(check string) "frag1" "a" t1.text;
      Alcotest.(check string) "frag2" "bc" t2.text;
      Alcotest.(check string) "frag3" "d" t3.text;
      (* "a" should have class "first" only *)
      ( match t1.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "a class" (Some "first") dec.class_
      | None ->
          Alcotest.fail "a should be decorated"
      );
      (* "bc" should have both classes merged *)
      ( match t2.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "bc class" (Some "first second") dec.class_
      | None ->
          Alcotest.fail "bc should be decorated"
      );
      (* "d" should have class "second" only *)
      match t3.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "d class" (Some "second") dec.class_
      | None ->
          Alcotest.fail "d should be decorated"
    )
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_multiline () =
  (* Source: "ab\ncd". Decoration spans from line 0 char 1 to line 1 char 1 *)
  let tokens =
    [ [ make_tok "ab"; make_tok "\n" ]; [ make_tok "cd"; make_tok "\n" ] ]
  in
  let d =
    Ochre.Decoration.make ~class_:"span" ~start:(Ochre.Decoration.pos 0 1)
      ~end_:(Ochre.Decoration.pos 1 1) ()
  in
  let result = Ochre.Decoration.apply ~source:"ab\ncd" [ d ] tokens in
  match result with
  | [ line0; line1 ] ->
      (* Line 0: "a" (not decorated), "b" (decorated), "\n" (decorated) *)
      let l0_texts =
        List.map (fun (t : Ochre.Token.styled_token) -> t.text) line0
      in
      Alcotest.(check (list string)) "line0 texts" [ "a"; "b"; "\n" ] l0_texts;
      let a = List.nth line0 0 in
      let b = List.nth line0 1 in
      Alcotest.(check bool) "a not decorated" true (a.decoration = None);
      ( match b.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "b decorated" (Some "span") dec.class_
      | None ->
          Alcotest.fail "b should be decorated"
      );
      (* Line 1: "c" (decorated), "d" (not decorated), "\n" (not decorated) *)
      let l1_texts =
        List.map (fun (t : Ochre.Token.styled_token) -> t.text) line1
      in
      Alcotest.(check (list string)) "line1 texts" [ "c"; "d"; "\n" ] l1_texts;
      let c = List.nth line1 0 in
      let d_tok = List.nth line1 1 in
      ( match c.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "c decorated" (Some "span") dec.class_
      | None ->
          Alcotest.fail "c should be decorated"
      );
      Alcotest.(check bool) "d not decorated" true (d_tok.decoration = None)
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_decoration_with_highlighter () =
  let hl = highlight () in
  let theme =
    Ochre.Theme.load_from_string
      {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
  in
  let source = "let x = 42" in
  let decorations =
    [
      Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
        ~end_:(Ochre.Decoration.pos 0 3) ();
    ]
  in
  let tokens =
    Ochre.to_tokens_with hl ~decorations ~transforms:[] ~theme ~lang:"test"
      source
  in
  match tokens with
  | [ first :: _ ] -> (
      Alcotest.(check string) "first token text" "let" first.text;
      match first.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "first token decorated" (Some "hl") dec.class_
      | None ->
          Alcotest.fail "first token should be decorated"
    )
  | _ ->
      Alcotest.fail "expected at least one line with tokens"

let make_comment text =
  {
    Ochre.Token.text;
    foreground = Some "#888888";
    background = None;
    font_style = [ Ochre.Token.Italic ];
    scopes = [ "comment.line.test"; "source.test" ];
    decoration = None;
  }

let test_notation_highlight_basic () =
  (* Simulate: "let x = 42 # [!code highlight]\n" *)
  let doc =
    [
      [
        { (make_tok "let") with foreground = Some "#ff0000" };
        make_tok " x = ";
        { (make_tok "42") with foreground = Some "#0000ff" };
        make_tok " ";
        make_comment "# [!code highlight]";
        make_tok "\n";
      ];
      [ make_tok "let y = 10"; make_tok "\n" ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line0; line1 ] ->
      (* Line 0: all tokens should have background, comment removed *)
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "line0 token %S highlighted" tok.text)
              (Some "#ffffff22") tok.background
        )
        line0;
      (* Verify the comment token is removed *)
      let texts =
        List.map (fun (t : Ochre.Token.styled_token) -> t.text) line0
      in
      Alcotest.(check bool)
        "comment removed"
        (not (List.exists (fun t -> String.length t > 0 && t.[0] = '#') texts))
        true;
      (* Line 1: no background *)
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          Alcotest.(check (option string))
            "line1 not highlighted" None tok.background
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_notation_highlight_no_match () =
  let doc = [ [ make_tok "let x = 42"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; nl ] ] ->
      Alcotest.(check string) "text unchanged" "let x = 42" tok.text;
      Alcotest.(check string) "newline kept" "\n" nl.text;
      Alcotest.(check (option string)) "no background" None tok.background
  | _ ->
      Alcotest.fail "expected 1 line with 2 tokens"

let test_notation_diff_add () =
  (* Line with [!code ++] should get green background *)
  let doc =
    [
      [
        make_tok "let x = 42";
        make_tok " ";
        make_comment "# [!code ++]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "token %S has add bg" tok.text)
              (Some "#22883322") tok.background
        )
        line;
      let texts =
        List.map (fun (t : Ochre.Token.styled_token) -> t.text) line
      in
      Alcotest.(check bool)
        "notation removed"
        (not (List.exists (fun t -> String.length t > 0 && t.[0] = '#') texts))
        true
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_diff_remove () =
  (* Line with [!code --] should get red background *)
  let doc =
    [
      [
        make_tok "let y = 10";
        make_tok " ";
        make_comment "# [!code --]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "token %S has remove bg" tok.text)
              (Some "#88222222") tok.background
        )
        line
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_diff_no_match () =
  let doc = [ [ make_tok "let z = 0"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; _ ] ] ->
      Alcotest.(check (option string)) "no background" None tok.background
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_word_highlight_basic () =
  (* "let x = 42 # [!code word:x]" - "x" in " x = " should be highlighted *)
  let doc =
    [
      [
        make_tok "let";
        make_tok " x = ";
        make_tok "42";
        make_tok " ";
        make_comment "# [!code word:x]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      (* Find the "x" token - it should be highlighted *)
      let x_tokens =
        List.filter (fun (t : Ochre.Token.styled_token) -> t.text = "x") line
      in
      Alcotest.(check bool) "found x token" true (List.length x_tokens > 0);
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          Alcotest.(check (option string))
            "x foreground" (Some "#ffff00") tok.foreground;
          Alcotest.(check bool)
            "x bold" true
            (List.mem Ochre.Token.Bold tok.font_style)
        )
        x_tokens;
      (* Verify the comment is removed *)
      let has_comment =
        List.exists
          (fun (t : Ochre.Token.styled_token) ->
            String.length t.text > 0 && t.text.[0] = '#'
          )
          line
      in
      Alcotest.(check bool) "comment removed" false has_comment
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_word_highlight_no_match () =
  let doc = [ [ make_tok "let x = 42"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; _ ] ] ->
      Alcotest.(check string) "unchanged" "let x = 42" tok.text;
      Alcotest.(check (option string)) "no fg change" None tok.foreground
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_highlight_with_highlighter () =
  let hl = highlight () in
  let theme =
    Ochre.Theme.load_from_string
      {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "comment", "settings": { "foreground": "#888888", "fontStyle": "italic" } },
        { "scope": "keyword", "settings": { "foreground": "#ff0000", "fontStyle": "bold" } },
        { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
      ]
    }|}
  in
  let source = "let x = 42 # [!code highlight]\nlet y = 10" in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let tokens = Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test" source in
  match tokens with
  | [ line0; line1 ] ->
      (* Line 0: highlighted *)
      let visible0 =
        List.filter
          (fun (t : Ochre.Token.styled_token) ->
            String.trim t.text <> "" && t.text <> "\n"
          )
          line0
      in
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          Alcotest.(check (option string))
            (Printf.sprintf "%S bg" tok.text)
            (Some "#ffffff22") tok.background
        )
        visible0;
      (* Verify no comment token in output *)
      let all_texts =
        List.map (fun (t : Ochre.Token.styled_token) -> t.text) line0
      in
      Alcotest.(check bool)
        "no comment in line0"
        (not
           (List.exists
              (fun t ->
                String.length t > 0
                && String.sub t 0 (min 1 (String.length t)) = "#"
              )
              all_texts
           )
        )
        true;
      (* Line 1: not highlighted *)
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "%S no bg" tok.text)
              None tok.background
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let () =
  let open Alcotest in
  run "Ochre"
    [
      ("theme", [ test_case "Load theme from string" `Quick test_theme_loading ]);
      ( "scope",
        [ test_case "Scope matching via tokens" `Quick test_scope_matching ]
      );
      ( "grammar",
        [
          test_case "Accept capture arrays" `Quick
            test_capture_arrays_in_grammar;
        ]
      );
      ( "transform",
        [
          test_case "Empty transforms passthrough" `Quick
            test_transform_empty_passthrough;
          test_case "Transform ordering (last wins)" `Quick
            test_transform_ordering;
          test_case "Transform determinism" `Quick test_transform_determinism;
          test_case "Line highlight builtin" `Quick
            test_transform_line_highlight;
          test_case "Hook execution order" `Quick
            test_transform_before_render_then_line;
        ]
      );
      ( "notation-transform",
        [
          test_case "Notation highlight basic" `Quick
            test_notation_highlight_basic;
          test_case "Notation highlight no match" `Quick
            test_notation_highlight_no_match;
          test_case "Notation diff add" `Quick test_notation_diff_add;
          test_case "Notation diff remove" `Quick test_notation_diff_remove;
          test_case "Notation diff no match" `Quick test_notation_diff_no_match;
          test_case "Notation word highlight basic" `Quick
            test_notation_word_highlight_basic;
          test_case "Notation word highlight no match" `Quick
            test_notation_word_highlight_no_match;
          test_case "Notation highlight with highlighter" `Quick
            test_notation_highlight_with_highlighter;
        ]
      );
      ( "decoration",
        [
          test_case "Empty decorations passthrough" `Quick
            test_decoration_empty_passthrough;
          test_case "Whole token decoration" `Quick test_decoration_whole_token;
          test_case "Token splitting at boundary" `Quick
            test_decoration_token_splitting;
          test_case "Mid-token split" `Quick test_decoration_mid_token_split;
          test_case "Multi-token decoration" `Quick test_decoration_multi_token;
          test_case "Negative character position" `Quick
            test_decoration_negative_character;
          test_case "Overlapping decorations" `Quick test_decoration_overlapping;
          test_case "Multiline decoration" `Quick test_decoration_multiline;
          test_case "Decoration with highlighter" `Quick
            test_decoration_with_highlighter;
        ]
      );
    ]
