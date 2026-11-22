let re str =
  match
    Oniguruma.create str Oniguruma.Options.none Oniguruma.Encoding.ascii
      Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok regex ->
      regex

let () =
  let regset = Oniguruma.RegSet.create [| re "cd"; re "(a)(b)"; re "bc" |] in
  ( match Oniguruma.RegSet.search regset "xxabcd" 0 6 Oniguruma.Options.none with
  | None ->
      assert false
  | Some (index, region) ->
      assert (index = 1);
      assert (Oniguruma.Region.length region = 3);
      assert (Oniguruma.Region.capture_beg region 0 = 2);
      assert (Oniguruma.Region.capture_end region 0 = 4);
      assert (Oniguruma.Region.capture_beg region 1 = 2);
      assert (Oniguruma.Region.capture_end region 1 = 3);
      assert (Oniguruma.Region.capture_beg region 2 = 3);
      assert (Oniguruma.Region.capture_end region 2 = 4)
  );
  assert (
    Oniguruma.RegSet.search regset "zzzz" 0 4 Oniguruma.Options.none = None
  );

  let retained_regset =
    let regex = re "hello" in
    Oniguruma.RegSet.create [| regex |]
  in
  Gc.full_major ();
  match
    Oniguruma.RegSet.search retained_regset "well hello" 0 10
      Oniguruma.Options.none
  with
  | None ->
      assert false
  | Some (index, region) ->
      assert (index = 0);
      assert (Oniguruma.Region.capture_beg region 0 = 5);
      assert (Oniguruma.Region.capture_end region 0 = 10)
