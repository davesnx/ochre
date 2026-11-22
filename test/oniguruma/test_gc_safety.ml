let re pat =
  match
    Oniguruma.create pat Oniguruma.Options.none Oniguruma.Encoding.utf8
      Oniguruma.Syntax.default
  with
  | Error err ->
      prerr_endline err;
      assert false
  | Ok regex ->
      regex

let failed = ref false

let fresh_subject i =
  let prefix = String.make (i mod 7) 'x' in
  String.concat "" [ prefix; "needle"; string_of_int i; "tail" ]

let expected_span i =
  let start = i mod 7 in
  (start, start + String.length "needle" + String.length (string_of_int i))

let region_span = function
  | None ->
      None
  | Some region ->
      Some
        ( Oniguruma.Region.capture_beg region 0,
          Oniguruma.Region.capture_end region 0
        )

let () =
  Gc.set { (Gc.get ()) with minor_heap_size = 4096 };
  let search_re = re "needle[0-9]+" in
  let mp = Oniguruma.MatchParam.create () in
  let mismatches = ref 0 in
  let check i got = if got <> Some (expected_span i) then incr mismatches in
  let iterations = 400_000 in
  for i = 1 to iterations do
    ignore (Sys.opaque_identity (Array.make (i mod 4093) 0));
    let s = fresh_subject i in
    check i
      (region_span
         (Oniguruma.search search_re s 0 (String.length s)
            Oniguruma.Options.none
         )
      );
    ignore (Sys.opaque_identity (Array.make (i mod 4091) 0));
    let s = fresh_subject i in
    check i
      (region_span
         (Oniguruma.search_with_param search_re s 0 (String.length s)
            Oniguruma.Options.none mp
         )
      );
    let start, _ = expected_span i in
    ignore (Sys.opaque_identity (Array.make (i mod 4079) 0));
    let s = fresh_subject i in
    check i
      (region_span (Oniguruma.match_ search_re s start Oniguruma.Options.none));
    ignore (Sys.opaque_identity (Array.make (i mod 4073) 0));
    let s = fresh_subject i in
    check i
      (region_span
         (Oniguruma.match_with_param search_re s start Oniguruma.Options.none mp)
      )
  done;
  if !mismatches <> 0 then (
    Printf.eprintf "gc safety: %d wrong results in %d iterations\n" !mismatches
      (4 * iterations);
    failed := true
  )

let () =
  Gc.set { (Gc.get ()) with minor_heap_size = 4096 };
  let r = re "needle[0-9]+" in
  let bad = ref 0 in
  for i = 1 to 20_000 do
    ignore (Sys.opaque_identity (Array.make (i mod 4093) 0));
    let s = fresh_subject i in
    let seen = ref [] in
    let count =
      Oniguruma.scan r (s ^ s) Oniguruma.Options.none (fun _ pos region ->
          for _ = 1 to 40 do
            ignore (Sys.opaque_identity (Array.make 200 0))
          done;
          seen := (pos, region_span (Some region)) :: !seen;
          true
      )
    in
    let b, e = expected_span i in
    let len = String.length s in
    if
      count <> 2
      || List.rev !seen
         <> [ (b, Some (b, e)); (len + b, Some (len + b, len + e)) ]
    then
      incr bad
  done;
  if !bad <> 0 then (
    Printf.eprintf "gc safety: %d wrong scans\n" !bad;
    failed := true
  )

let () = if !failed then exit 1
