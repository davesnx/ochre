type t = {
  tm_collection : TmLanguage.t;
  grammars : (string * TmLanguage.grammar) list;
}

type file_format = Json | Plist

let lang_id_of_path path =
  let base = Filename.basename path in
  if Filename.check_suffix base ".tmLanguage.json" then
    Filename.chop_suffix base ".tmLanguage.json"
  else if Filename.check_suffix base ".json" then
    Filename.chop_suffix base ".json"
  else if Filename.check_suffix base ".tmLanguage" then
    Filename.chop_suffix base ".tmLanguage"
  else if Filename.check_suffix base ".plist" then
    Filename.chop_suffix base ".plist"
  else
    base

let format_of_path path =
  let base = Filename.basename path in
  if Filename.check_suffix base ".tmLanguage.json" then
    Json
  else if Filename.check_suffix base ".json" then
    Json
  else if Filename.check_suffix base ".tmLanguage" then
    Plist
  else if Filename.check_suffix base ".plist" then
    Plist
  else
    Json

let rec normalize_grammar_json = function
  | `Assoc fields ->
      `Assoc
        (List.map
           (fun (key, value) ->
             if is_capture_field key then
               (key, normalize_capture_map value)
             else
               (key, normalize_grammar_json value)
           )
           fields
        )
  | `List items ->
      `List (List.map normalize_grammar_json items)
  | value ->
      value

and normalize_capture_map = function
  | `Assoc _ as assoc ->
      normalize_grammar_json assoc
  | `List items ->
      `Assoc
        (List.mapi
           (fun idx item ->
             (string_of_int (idx + 1), normalize_grammar_json item)
           )
           items
        )
  | value ->
      normalize_grammar_json value

and is_capture_field key =
  key = "captures" || String.ends_with ~suffix:"Captures" key

let load_grammar_from_file path =
  match format_of_path path with
  | Json ->
      let json = Yojson.Basic.from_file path in
      TmLanguage.of_yojson_exn (normalize_grammar_json json)
  | Plist ->
      let ic = open_in path in
      let plist =
        Fun.protect
          ~finally:(fun () -> close_in ic)
          (fun () -> Plist_xml.from_channel ic)
      in
      TmLanguage.of_plist_exn plist

let load_grammar_from_string json_string =
  let json = Yojson.Basic.from_string json_string in
  TmLanguage.of_yojson_exn (normalize_grammar_json json)

let load_exn grammars =
  let tm_collection = TmLanguage.create () in
  let loaded =
    List.map
      (fun (lang_id, json_string) ->
        let grammar = load_grammar_from_string json_string in
        TmLanguage.add_grammar tm_collection grammar;
        (lang_id, grammar)
      )
      grammars
  in
  { tm_collection; grammars = loaded }

let load grammars =
  try Ok (load_exn grammars) with
  | Failure msg ->
      Error msg
  | exn ->
      Error (Printexc.to_string exn)

let load_from_files_exn grammars =
  let tm_collection = TmLanguage.create () in
  let loaded =
    List.map
      (fun path ->
        let grammar = load_grammar_from_file path in
        TmLanguage.add_grammar tm_collection grammar;
        (lang_id_of_path path, grammar)
      )
      grammars
  in
  { tm_collection; grammars = loaded }

let load_from_files grammars =
  try Ok (load_from_files_exn grammars) with
  | Failure msg ->
      Error msg
  | exn ->
      Error (Printexc.to_string exn)

let find_grammar t lang_id =
  match List.assoc_opt lang_id t.grammars with
  | Some grammar ->
      grammar
  | None ->
      failwith (Printf.sprintf "Grammar not found for language: %s" lang_id)

let tm_collection t = t.tm_collection
