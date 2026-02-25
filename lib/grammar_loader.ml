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
  else base

let load_grammar_from_file path =
  let json = Yojson.Basic.from_file path in
  TmLanguage.of_yojson_exn json

let create ~grammars () =
  let tm_collection = TmLanguage.create () in
  let loaded =
    List.map
      (fun path ->
        let grammar = load_grammar_from_file path in
        TmLanguage.add_grammar tm_collection grammar;
        (lang_id_of_path path, grammar))
      grammars
  in
  { tm_collection; grammars = loaded }

let find_grammar t lang_id =
  match List.assoc_opt lang_id t.grammars with
  | Some grammar -> grammar
  | None ->
      failwith (Printf.sprintf "Grammar not found for language: %s" lang_id)

let tm_collection t = t.tm_collection
