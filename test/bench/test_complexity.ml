let ratio_limit = 2.5

let repeated_line ~prefix ~chunk ~suffix ~bytes =
  let count =
    (bytes - String.length prefix - String.length suffix) / String.length chunk
  in
  prefix ^ String.concat "" (List.init count (fun _ -> chunk)) ^ suffix

let cases =
  [
    ( "ocaml",
      Tm_grammars.ocaml,
      ("let x = ", "f (a + 1) * \"s\" :: [b; 2.0] @ ", "[]")
    );
    ( "javascript",
      Tm_grammars.javascript,
      ("var x = ", "f(a + 1) * \"s\" + [b, 2.0].length + ", "0;")
    );
    ("json", Tm_grammars.json, ("[", "{\"a\": [1, \"s\", true, null]}, ", "0]"));
  ]

let min_time_of trials f =
  f ();
  List.init trials (fun _ ->
      Gc.full_major ();
      let start = Unix.gettimeofday () in
      f ();
      Unix.gettimeofday () -. start
  )
  |> List.fold_left Float.min Float.infinity

let check_linear (lang, json, (prefix, chunk, suffix)) () =
  let grammar = TmLanguage.of_yojson_exn (Yojson.Basic.from_string json) in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  let time_for bytes =
    let line = repeated_line ~prefix ~chunk ~suffix ~bytes in
    min_time_of 5 (fun () ->
        ignore
          ( TmLanguage.tokenize_exn ~time_limit:Float.infinity t grammar
              TmLanguage.empty line
            : TmLanguage.token list * TmLanguage.stack
            )
    )
  in
  let t4 = time_for 4_000 in
  let t8 = time_for 8_000 in
  if t8 > t4 *. ratio_limit then
    Alcotest.failf
      "%s: a line twice as long took %.1fx as long (%.4f s -> %.4f s), limit \
       %.1fx"
      lang (t8 /. t4) t4 t8 ratio_limit

let () =
  Alcotest.run "complexity"
    [
      ( "long line",
        List.map
          (fun ((lang, _, _) as case) ->
            Alcotest.test_case lang `Quick (check_linear case)
          )
          cases
      );
    ]
