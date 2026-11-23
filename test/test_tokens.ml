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

let lang_of grammar =
  match
    Result.bind
      (Ochre.load
         [
           ("ocaml", grammar); ("ocaml-interface", Tm_grammars.ocaml_interface);
         ]
      )
      (fun hl -> Ochre.lang hl "ocaml")
  with
  | Ok lang ->
      lang
  | Error error ->
      failwith (Ochre.Error.to_string error)

let theme_of json =
  match Ochre.Theme.load json with
  | Ok (theme, _warnings) ->
      theme
  | Error error ->
      failwith (Ochre.Error.to_string error)

let () =
  print_string
    (Ochre.to_debug_tokens
       (Ochre.highlight ~theme:(theme_of Tm_themes.nord)
          ~lang:(lang_of Tm_grammars.ocaml)
          source
       )
    )
