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
    ("dark-plus", Tm_themes.dark_plus);
    ("light-plus", Tm_themes.light_plus);
    ("tokyo-night", Tm_themes.tokyo_night);
    ("everforest-dark", Tm_themes.everforest_dark);
    ("ayu-dark", Tm_themes.ayu_dark);
    ("catppuccin-mocha", Tm_themes.catppuccin_mocha);
    ("catppuccin-macchiato", Tm_themes.catppuccin_macchiato);
    ("gruvbox-dark-medium", Tm_themes.gruvbox_dark_medium);
    ("kanagawa-wave", Tm_themes.kanagawa_wave);
    ("nord", Tm_themes.nord);
    ("one-dark-pro", Tm_themes.one_dark_pro);
  ]

let () =
  let highlighter = Ochre.load_exn [ ("ocaml", Tm_grammars.ocaml) ] in
  List.iter
    (fun (name, json) ->
      let theme = Ochre.Theme.load_exn json in
      Printf.printf "== %s ==\n" name;
      print_string (Ochre.to_ansi highlighter ~theme ~lang:"ocaml" source);
      print_newline ();
      print_newline ()
    )
    preview_themes
