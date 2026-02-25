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

let () =
  let open Alcotest in
  run "Ochre"
    [
      ("theme", [ test_case "Load theme from string" `Quick test_theme_loading ]);
      ( "scope",
        [ test_case "Scope matching via tokens" `Quick test_scope_matching ] );
    ]
