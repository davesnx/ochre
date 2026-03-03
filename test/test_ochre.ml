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
  | _ -> Alcotest.fail "expected at least one token"

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
          Alcotest.(check (option string)) "same bg" t1.background t2.background)
        line1 line2)
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
        };
      ];
    ]
  in
  let t1 =
    Ochre.Transform.make "first" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.styled_token) ->
            { tok with background = Some "#111111" })
          line)
  in
  let t2 =
    Ochre.Transform.make "second" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.styled_token) ->
            { tok with background = Some "#222222" })
          line)
  in
  let result = Ochre.Transform.run [ t1; t2 ] doc in
  match result with
  | [ [ tok ] ] ->
      Alcotest.(check (option string))
        "last transform wins" (Some "#222222") tok.background
  | _ -> Alcotest.fail "expected 1 line with 1 token"

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
        };
      ];
      [
        {
          Ochre.Token.text = "b";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
        };
      ];
      [
        {
          Ochre.Token.text = "c";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
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
              })
            line);
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
            "deterministic bg" t1.background t2.background)
        line1 line2)
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
        };
      ];
      [
        {
          Ochre.Token.text = "b";
          foreground = None;
          background = None;
          font_style = [];
          scopes = [];
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
  | _ -> Alcotest.fail "expected 2 lines with 1 token each"

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
        };
      ];
    ]
  in
  let log = ref [] in
  let t =
    Ochre.Transform.make "logger"
      ~before_render:(fun doc ->
        log := "before_render" :: !log;
        doc)
      ~before_line:(fun ~line_index:_ line ->
        log := "before_line" :: !log;
        line)
      ~after_line:(fun ~line_index:_ line ->
        log := "after_line" :: !log;
        line)
      ~after_render:(fun doc ->
        log := "after_render" :: !log;
        doc)
  in
  let _ = Ochre.Transform.run [ t ] doc in
  let order = List.rev !log in
  Alcotest.(check (list string))
    "hook execution order"
    [ "before_render"; "before_line"; "after_line"; "after_render" ]
    order

let () =
  let open Alcotest in
  run "Ochre"
    [
      ("theme", [ test_case "Load theme from string" `Quick test_theme_loading ]);
      ( "scope",
        [ test_case "Scope matching via tokens" `Quick test_scope_matching ] );
      ( "grammar",
        [
          test_case "Accept capture arrays" `Quick
            test_capture_arrays_in_grammar;
        ] );
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
        ] );
    ]
