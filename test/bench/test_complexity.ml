let ratio_limit = 7.0

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

let time_per_call f =
  Gc.full_major ();
  let start = Sys.time () in
  let rec go calls =
    f ();
    let elapsed = Sys.time () -. start in
    if elapsed >= 0.05 then
      elapsed /. float_of_int calls
    else
      go (calls + 1)
  in
  go 1

let min_times_interleaved trials f g =
  f ();
  g ();
  List.init trials (fun _ -> (time_per_call f, time_per_call g))
  |> List.fold_left
       (fun (a, b) (x, y) -> (Float.min a x, Float.min b y))
       (Float.infinity, Float.infinity)

let check_linear (lang, json, (prefix, chunk, suffix)) () =
  let grammar = TmLanguage.of_yojson_exn (Yojson.Basic.from_string json) in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  let tokenize bytes =
    let line = repeated_line ~prefix ~chunk ~suffix ~bytes in
    fun () ->
      ignore
        ( TmLanguage.tokenize_exn ~max_line_length:max_int
            ~time_limit:Float.infinity t grammar TmLanguage.empty line
          : TmLanguage.token list * TmLanguage.stack
          )
  in
  let small, large =
    min_times_interleaved 5 (tokenize 16_000) (tokenize 64_000)
  in
  if large > small *. ratio_limit then
    Alcotest.failf
      "%s: a line four times as long took %.1fx as long (%.4f s -> %.4f s), \
       limit %.1fx"
      lang (large /. small) small large ratio_limit

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
