let create enc pat =
  match
    Oniguruma.create pat Oniguruma.Options.none enc Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok regex ->
      regex

let re pat = create Oniguruma.Encoding.utf8 pat

let re_ascii pat = create Oniguruma.Encoding.ascii pat

let none = Oniguruma.Options.none

let spans region =
  List.init (Oniguruma.Region.length region) (fun i ->
      ( Oniguruma.Region.capture_beg region i,
        Oniguruma.Region.capture_end region i
      )
  )

let () =
  let r = re "b" in
  assert (Oniguruma.search r "abc" 2 99 none = None);
  assert (Oniguruma.search r "abc" 0 99 none <> None);
  assert (Oniguruma.search r "abc" 4 4 none = None);
  assert (Oniguruma.search r "abc" (-1) 3 none = None);
  assert (Oniguruma.search r "abc" (1 lsl 40) 3 none = None);
  assert (Oniguruma.search r "abc" (1 lsl 32) 3 none = None);
  assert (Oniguruma.match_ r "abc" 4 none = None);
  assert (Oniguruma.match_ r "abc" (-1) none = None);
  assert (Oniguruma.match_ r "abc" (1 lsl 32) none = None);
  let mp = Oniguruma.MatchParam.create () in
  assert (Oniguruma.search_with_param r "abc" 0 (1 lsl 40) none mp <> None);
  assert (Oniguruma.search_with_param r "abc" 4 4 none mp = None);
  assert (Oniguruma.match_with_param r "abc" 4 none mp = None);
  assert (Oniguruma.match_with_param r "abc" (-1) none mp = None)

let () =
  List.iter
    (fun (pat, subject) ->
      match
        Oniguruma.search (re pat) subject 0 (String.length subject) none
      with
      | None ->
          ()
      | Some region ->
          List.iter
            (fun (b, e) ->
              assert (b <= String.length subject);
              assert (e <= String.length subject)
            )
            (spans region)
    )
    [
      ("\\w", "\xC3");
      ("[^\\n@]", "\xC3");
      ("\\w+", "a\xE2\x82");
      ("[^a]+", "\xF0\x9F");
    ];
  match Oniguruma.search (re "\\w") "\xC3" 0 1 none with
  | Some region ->
      assert (spans region = [ (0, 1) ])
  | None ->
      assert false

let () =
  let r = re_ascii "a" in
  let first = Oniguruma.RegSet.create [| r |] in
  ( match Oniguruma.RegSet.create [| r |] with
  | _ ->
      assert false
  | exception Failure _ ->
      ()
  );
  ( match Oniguruma.search r "a" 0 1 none with
  | _ ->
      assert false
  | exception Failure _ ->
      ()
  );
  let dup = re_ascii "b" in
  ( match Oniguruma.RegSet.create [| dup; dup |] with
  | _ ->
      assert false
  | exception Failure _ ->
      ()
  );
  let second = Oniguruma.RegSet.create [| dup |] in
  assert (Oniguruma.RegSet.search first "a" 0 1 none <> None);
  assert (Oniguruma.RegSet.search second "b" 0 1 none <> None);
  assert (Oniguruma.RegSet.search second "b" 2 1 none = None);
  assert (Oniguruma.RegSet.search second "b" 0 99 none <> None);
  Gc.full_major ();
  Gc.full_major ();
  assert (Oniguruma.RegSet.search first "xa" 0 2 none <> None)

exception Stop

let () =
  let r = re "a" in
  ( match
      Oniguruma.scan r "banana" none (fun count _ _ ->
          if count = 2 then
            raise Stop
          else
            true
      )
    with
  | _ ->
      assert false
  | exception Stop ->
      ()
  );
  assert (Oniguruma.scan r "banana" none (fun _ _ _ -> true) = 3);
  assert (Oniguruma.scan r "banana" none (fun _ _ _ -> false) >= 0)
