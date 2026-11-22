let source =
  String.concat "\n"
    [
      "(* fibonacci *)";
      "let rec fib n =";
      "  match n with";
      "  | 0 | 1 -> n";
      "  | n -> fib (n - 1) + fib (n - 2)";
      "";
      "let () = print_int (fib 10)";
    ]

let preview_themes =
  [
    "dark";
    "light";
    "tokyonight";
    "everforest";
    "ayu";
    "catppuccin";
    "catppuccin-macchiato";
    "gruvbox";
    "kanagawa";
    "nord";
    "matrix";
    "one-dark";
  ]

let lang_of grammar =
  match
    Result.bind
      (Ochre.load [ ("ocaml", grammar) ])
      (fun hl -> Ochre.lang hl "ocaml")
  with
  | Ok lang ->
      lang
  | Error error ->
      failwith (Ochre.Error.to_string error)

let () =
  let lang = lang_of Tm_grammars.ocaml in
  List.iter
    (fun name ->
      match Ochre.Theme.find name with
      | Some theme ->
          Printf.printf "== %s ==\n" name;
          print_string (Ochre.to_ansi (Ochre.highlight ~theme ~lang source));
          print_newline ();
          print_newline ()
      | None ->
          Printf.printf "Missing built-in theme: %s\n" name
    )
    preview_themes
