let re str =
  match
    Oniguruma.create str Oniguruma.Options.none Oniguruma.Encoding.ascii
      Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok r ->
      r

let () =
  let mp = Oniguruma.MatchParam.create () in
  Oniguruma.MatchParam.set_match_stack_limit_size mp 0;
  Oniguruma.MatchParam.set_retry_limit_in_match mp 10000;
  Oniguruma.MatchParam.set_retry_limit_in_search mp 10000;

  let regex = re "a+" in
  ( match
      Oniguruma.search_with_param regex "bbaab" 0 5 Oniguruma.Options.none mp
    with
  | None ->
      assert false
  | Some region ->
      assert (Oniguruma.Region.capture_beg region 0 = 2);
      assert (Oniguruma.Region.capture_end region 0 = 4)
  );

  ( match Oniguruma.match_with_param regex "aab" 0 Oniguruma.Options.none mp with
  | None ->
      assert false
  | Some region ->
      assert (Oniguruma.Region.capture_beg region 0 = 0);
      assert (Oniguruma.Region.capture_end region 0 = 2)
  );

  assert (
    Oniguruma.match_with_param regex "bba" 0 Oniguruma.Options.none mp = None
  );

  let matches = ref [] in
  let count =
    Oniguruma.scan (re "[0-9]+") "abc 123 def 456 ghi" Oniguruma.Options.none
      (fun _count pos region ->
        let end_ = Oniguruma.Region.capture_end region 0 in
        matches := (pos, end_) :: !matches;
        true
    )
  in
  assert (count = 2);
  assert (List.rev !matches = [ (4, 7); (12, 15) ]);

  let early_stop_count =
    Oniguruma.scan (re "[a-z]+") "abc def ghi" Oniguruma.Options.none
      (fun _count _pos _region -> false
    )
  in
  assert (early_stop_count = 1);

  let orig_stack = Oniguruma.get_match_stack_limit_size () in
  Oniguruma.set_match_stack_limit_size 50000;
  assert (Oniguruma.get_match_stack_limit_size () = 50000);
  Oniguruma.set_match_stack_limit_size orig_stack;

  let orig_retry_match = Oniguruma.get_retry_limit_in_match () in
  Oniguruma.set_retry_limit_in_match 5000;
  assert (Oniguruma.get_retry_limit_in_match () = 5000);
  Oniguruma.set_retry_limit_in_match orig_retry_match;

  let orig_retry_search = Oniguruma.get_retry_limit_in_search () in
  Oniguruma.set_retry_limit_in_search 8000;
  assert (Oniguruma.get_retry_limit_in_search () = 8000);
  Oniguruma.set_retry_limit_in_search orig_retry_search;

  let orig_depth = Oniguruma.get_parse_depth_limit () in
  Oniguruma.set_parse_depth_limit 1000;
  assert (Oniguruma.get_parse_depth_limit () = 1000);
  Oniguruma.set_parse_depth_limit orig_depth;

  let orig_subexp = Oniguruma.get_subexp_call_limit_in_search () in
  Oniguruma.set_subexp_call_limit_in_search 2000;
  assert (Oniguruma.get_subexp_call_limit_in_search () = 2000);
  Oniguruma.set_subexp_call_limit_in_search orig_subexp;

  let orig_nest = Oniguruma.get_subexp_call_max_nest_level () in
  Oniguruma.set_subexp_call_max_nest_level 100;
  assert (Oniguruma.get_subexp_call_max_nest_level () = 100);
  Oniguruma.set_subexp_call_max_nest_level orig_nest;

  Oniguruma.set_capture_num_limit 1000
