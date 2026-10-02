type t = {
  tm_collection : TmLanguage.t;
  grammars : (string * TmLanguage.grammar) list;
}

type file_format = Json | Plist

(* Yojson's own message already names the line/byte range; just fold its
   embedded newline so the error reads as one line. *)
let describe_json_error msg = String.map (function '\n' -> ' ' | c -> c) msg

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
      let json =
        try Yojson.Basic.from_file path
        with Yojson.Json_error msg ->
          failwith
            (Printf.sprintf "%s: invalid JSON: %s" path (describe_json_error msg)
            )
      in
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

let check_no_duplicate_ids loaded =
  let seen = Hashtbl.create (List.length loaded) in
  List.iter
    (fun (lang_id, _) ->
      if Hashtbl.mem seen lang_id then
        failwith
          (Printf.sprintf
             "Duplicate grammar id '%s': each grammar must be registered under \
              a unique id"
             lang_id
          )
      else
        Hashtbl.add seen lang_id ()
    )
    loaded

let load_exn grammars =
  Exn_utils.wrap_exn (fun () ->
      let tm_collection = TmLanguage.create () in
      let loaded =
        List.map
          (fun (lang_id, json_string) ->
            let grammar =
              try load_grammar_from_string json_string
              with Yojson.Json_error msg ->
                failwith
                  (Printf.sprintf "grammar '%s': invalid JSON: %s" lang_id
                     (describe_json_error msg)
                  )
            in
            TmLanguage.add_grammar tm_collection grammar;
            (lang_id, grammar)
          )
          grammars
      in
      check_no_duplicate_ids loaded;
      { tm_collection; grammars = loaded }
  )

let load grammars = try Ok (load_exn grammars) with Failure msg -> Error msg

let load_from_files_exn grammars =
  Exn_utils.wrap_exn (fun () ->
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
      check_no_duplicate_ids loaded;
      { tm_collection; grammars = loaded }
  )

let load_from_files grammars =
  try Ok (load_from_files_exn grammars) with Failure msg -> Error msg

let find_grammar t lang_id = List.assoc_opt lang_id t.grammars

let tm_collection t = t.tm_collection
