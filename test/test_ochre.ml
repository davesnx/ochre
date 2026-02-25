let test_theme_loading () =
  let theme_json = {|
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
  |} in
  let theme = Ochre.Theme.load_from_string theme_json in
  Alcotest.(check string) "theme name" "test-theme" theme.name;
  Alcotest.(check string) "theme fg" "#000000" theme.fg;
  Alcotest.(check string) "theme bg" "#ffffff" theme.bg;
  Alcotest.(check int)
    "token_colors length" 1
    (List.length theme.token_colors)

let test_scope_matching () =
  let scopes = [ "source.js"; "meta.function.js"; "variable.parameter.js" ] in
  let result = Ochre.Scope.match_selector scopes "variable.parameter" in
  Alcotest.(check bool) "should match" true (Option.is_some result)

let () =
  let open Alcotest in
  run "Ochre"
    [
      ( "theme",
        [ test_case "Load theme from string" `Quick test_theme_loading ] );
      ( "scope",
        [ test_case "Scope matching" `Quick test_scope_matching ] );
    ]
