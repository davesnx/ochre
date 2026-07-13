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

let () =
  let highlighter = Ochre.load_exn [ ("ocaml", Tm_grammars.ocaml) ] in
  print_string
    (Ochre.to_debug_tokens highlighter ~theme:Ochre.Theme.nord ~lang:"ocaml"
       source
    )
