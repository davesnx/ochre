let re ?(opts = Oniguruma.Options.none) str =
  match
    Oniguruma.create str opts Oniguruma.Encoding.ascii Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok r ->
      r

let () =
  assert (Oniguruma.number_of_names (re "a") = 0);
  assert (Oniguruma.number_of_names (re "(?<x>a)") = 1);
  assert (Oniguruma.number_of_names (re "(?<x>a)(?<y>b)") = 2);
  assert (Oniguruma.number_of_names (re "(?<x>a)(?<x>b)") = 1);

  let names = ref [] in
  Oniguruma.foreach_name (re "(?<alpha>a)(?<beta>b)(?<alpha>c)")
    (fun name groups ->
      names := (name, Array.to_list groups) :: !names;
      true
  );
  let sorted = List.sort (fun (a, _) (b, _) -> String.compare a b) !names in
  assert (sorted = [ ("alpha", [ 1; 3 ]); ("beta", [ 2 ]) ]);

  let names2 = ref [] in
  Oniguruma.foreach_name (re "(?<x>a)(?<y>b)(?<z>c)") (fun name _groups ->
      names2 := name :: !names2;
      List.length !names2 < 2
  );
  assert (List.length !names2 = 2);

  assert (Oniguruma.noname_group_capture_is_active (re "(a)") = true);
  assert (
    Oniguruma.noname_group_capture_is_active
      (re ~opts:Oniguruma.Options.dont_capture_group "(?<x>a)(b)")
    = false
  );

  let open Oniguruma.Options in
  let opts = ignorecase <+> multiline in
  let regex = re ~opts "a" in
  let got = Oniguruma.get_options regex in
  assert (got <+> ignorecase = got);
  assert (got <+> multiline = got);
  assert (got <+> singleline <> got);

  assert (Oniguruma.number_of_capture_histories (re "a") = 0);

  let regex2 = re "(?<x>a)|(?<x>b)" in
  match Oniguruma.search regex2 "b" 0 1 Oniguruma.Options.none with
  | None ->
      assert false
  | Some region ->
      let n = Oniguruma.name_to_backref_number regex2 "x" region in
      assert (n = 2)
