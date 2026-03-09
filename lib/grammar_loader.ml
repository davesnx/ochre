type t = {
  tm_collection : TmLanguage.t;
  grammars : (string * TmLanguage.grammar) list;
}

let lang_id_of_path path =
  let base = Filename.basename path in
  if Filename.check_suffix base ".tmLanguage.json" then
    Filename.chop_suffix base ".tmLanguage.json"
  else if Filename.check_suffix base ".json" then
    Filename.chop_suffix base ".json"
  else
    base

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
  let json = Yojson.Basic.from_file path in
  TmLanguage.of_yojson_exn (normalize_grammar_json json)

let load_grammar_from_string json_string =
  let json = Yojson.Basic.from_string json_string in
  TmLanguage.of_yojson_exn (normalize_grammar_json json)

let create ~grammars () =
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

let create_from_json ~grammars () =
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

let find_grammar t lang_id =
  match List.assoc_opt lang_id t.grammars with
  | Some grammar ->
      grammar
  | None ->
      failwith (Printf.sprintf "Grammar not found for language: %s" lang_id)

let tm_collection t = t.tm_collection
