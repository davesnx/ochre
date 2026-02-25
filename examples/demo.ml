(* Demo of ochre library usage *)

let demo_html () =
  let source_code = {|
let hello name =
  Printf.printf "Hello, %s!\n" name

let () = hello "World"
|} in

  (* Create highlighter with theme *)
  let highlighter = Ochre.create () in

  (* Load theme *)
  Ochre.load_theme_from_file highlighter "examples/themes/simple-dark.json";

  (* For this demo, we'll just show the concept since we need a grammar *)
  Printf.printf "Source code:\n%s\n" source_code;
  Printf.printf "\nNote: To highlight, you need to provide a TextMate grammar file\n";
  Printf.printf "for the language and add its directory with add_grammar_path.\n"

let demo_theme_loading () =
  let theme = Ochre.Theme.load_from_file "examples/themes/simple-dark.json" in
  Printf.printf "Theme: %s\n" theme.name;
  Printf.printf "Foreground: %s\n" theme.fg;
  Printf.printf "Background: %s\n" theme.bg;
  Printf.printf "Token rules: %d\n" (List.length theme.token_colors)

let () =
  demo_theme_loading ();
  demo_html ()
