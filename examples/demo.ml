let demo_html () =
  let source_code =
    {|
let hello name =
  Printf.printf "Hello, %s!\n" name

let () = hello "World"
|}
  in

  Printf.printf "Source code:\n%s\n" source_code;
  Printf.printf
    "\nNote: To highlight, you need to provide .tmLanguage.json grammar files\n";
  Printf.printf "when calling Ochre.load_from_files.\n"

let demo_theme_loading () =
  match Ochre.Theme.load_from_file "examples/themes/simple-dark.json" with
  | Error error ->
      prerr_endline (Ochre.Error.to_string error)
  | Ok (theme, warnings) ->
      List.iter
        (fun warning -> prerr_endline (Ochre.Theme.warning_to_string warning))
        warnings;
      Printf.printf "Theme: %s\n" theme.name;
      Printf.printf "Foreground: %s\n" (Ochre.Color.to_hex theme.fg);
      Printf.printf "Background: %s\n" (Ochre.Color.to_hex theme.bg);
      Printf.printf "Token rules: %d\n" (List.length theme.token_colors)

let () =
  demo_theme_loading ();
  demo_html ()
