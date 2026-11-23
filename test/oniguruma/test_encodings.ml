let test enc pat str exp_regs =
  match
    Oniguruma.create pat Oniguruma.Options.none enc Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok regex -> (
      match
        Oniguruma.search regex str 0 (String.length str) Oniguruma.Options.none
      with
      | None ->
          prerr_endline pat;
          prerr_endline str;
          assert false
      | Some region ->
          Test_util.check_against region exp_regs
    )

let neg_test enc pat str =
  match
    Oniguruma.create pat Oniguruma.Options.none enc Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok regex -> (
      match
        Oniguruma.search regex str 0 (String.length str) Oniguruma.Options.none
      with
      | None ->
          ()
      | Some _ ->
          assert false
    )

let test_create_ok enc pat =
  match
    Oniguruma.create pat Oniguruma.Options.none enc Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok _ ->
      ()

let () =
  test Oniguruma.Encoding.iso_8859_1 "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.iso_8859_1 "\xe9" "\xe9" [ (0, 1) ];
  neg_test Oniguruma.Encoding.iso_8859_1 "\xe9" "e";

  test Oniguruma.Encoding.iso_8859_15 "a" "a" [ (0, 1) ];

  test_create_ok Oniguruma.Encoding.iso_8859_2 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_3 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_4 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_5 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_6 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_7 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_8 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_9 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_10 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_11 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_13 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_14 "a";
  test_create_ok Oniguruma.Encoding.iso_8859_16 "a";

  test Oniguruma.Encoding.euc_jp "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.sjis "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.koi8_r "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.cp1251 "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.big5 "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.gb18030 "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.euc_tw "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.euc_kr "a" "a" [ (0, 1) ];
  test Oniguruma.Encoding.euc_cn "a" "a" [ (0, 1) ];

  ignore Oniguruma.Encoding.utf16_be;
  ignore Oniguruma.Encoding.utf16_le;
  ignore Oniguruma.Encoding.utf32_be;
  ignore Oniguruma.Encoding.utf32_le
