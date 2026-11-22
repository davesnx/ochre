let target_bytes_per_run = 300_000

let median xs =
  let sorted = List.sort Float.compare xs in
  List.nth sorted (List.length sorted / 2)

let lines_of source =
  let parts = String.split_on_char '\n' source in
  let last = List.length parts - 1 in
  List.concat
    (List.mapi
       (fun i part ->
         if i < last then
           [ part ^ "\n" ]
         else if part = "" then
           []
         else
           [ part ]
       )
       parts
    )

let usage () =
  prerr_endline "Usage: bench.exe RUNS SAMPLE...  (RUNS >= 1)";
  exit 2

let () =
  let runs, files =
    match Array.to_list Sys.argv with
    | _ :: runs :: (_ :: _ as files) -> (
        match int_of_string_opt runs with
        | Some runs when runs >= 1 ->
            (runs, files)
        | _ ->
            usage ()
      )
    | _ ->
        usage ()
  in
  let t = TmLanguage.create () in
  let grammars =
    List.map
      (fun (lang, json) ->
        let grammar =
          TmLanguage.of_yojson_exn (Yojson.Basic.from_string json)
        in
        TmLanguage.add_grammar t grammar;
        (lang, grammar)
      )
      Tm_grammars.all
  in
  let samples =
    List.map
      (fun path ->
        let lang = Filename.remove_extension (Filename.basename path) in
        match List.assoc_opt lang grammars with
        | Some grammar ->
            ( lang,
              grammar,
              lines_of (In_channel.with_open_bin path In_channel.input_all)
            )
        | None ->
            Printf.eprintf "No bundled grammar for %s\n" path;
            exit 2
      )
      files
  in
  let tokenize grammar lines =
    ignore
      ( List.fold_left
          (fun stack line ->
            snd
              (TmLanguage.tokenize_exn ~time_limit:Float.infinity t grammar
                 stack line
              )
          )
          TmLanguage.empty lines
        : TmLanguage.stack
        )
  in
  List.iter (fun (_, grammar, lines) -> tokenize grammar lines) samples;
  let passes lines =
    let bytes = List.fold_left (fun n line -> n + String.length line) 0 lines in
    max 1 (target_bytes_per_run / max 1 bytes)
  in
  let time_sample (_, grammar, lines) =
    let start = Unix.gettimeofday () in
    for _ = 1 to passes lines do
      tokenize grammar lines
    done;
    Unix.gettimeofday () -. start
  in
  let runs = List.init runs (fun _ -> List.map time_sample samples) in
  List.iteri
    (fun i (lang, _, lines) ->
      Printf.printf "%s %.6f %d\n" lang
        (median (List.map (fun run -> List.nth run i) runs))
        (passes lines)
    )
    samples;
  Printf.printf "total %.6f\n"
    (median (List.map (List.fold_left ( +. ) 0.0) runs))
