let demo_html () =
  let source_code =
    {|
let hello name =
  Printf.printf "Hello, %s!\n" name

let () = hello "World"
|}
  in

  let _highlighter = Ochre.create ~grammars:[] () in

  Printf.printf "Source code:\n%s\n" source_code;
  Printf.printf
    "\nNote: To highlight, you need to provide .tmLanguage.json grammar files\n";
  Printf.printf "via ~grammars when calling Ochre.create.\n"

let demo_theme_loading () =
  let theme = Ochre.Theme.load "examples/themes/simple-dark.json" in
  Printf.printf "Theme: %s\n" theme.name;
  Printf.printf "Foreground: %s\n" theme.fg;
  Printf.printf "Background: %s\n" theme.bg;
  Printf.printf "Token rules: %d\n" (List.length theme.token_colors)

let () =
  demo_theme_loading ();
  demo_html ()
