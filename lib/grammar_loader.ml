type t = {
  tm_collection : TmLanguage.t;
  mutable grammars : (string * TmLanguage.grammar) list;
  grammar_paths : string list;
}

let create ?(grammar_paths = []) () =
  { tm_collection = TmLanguage.create (); grammars = []; grammar_paths }

let find_grammar_file t lang_id =
  let possible_names =
    [ lang_id ^ ".tmLanguage.json"; lang_id ^ ".json"; lang_id ]
  in
  let rec search_paths paths =
    match paths with
    | [] -> None
    | path :: rest -> (
        let rec try_names names =
          match names with
          | [] -> search_paths rest
          | name :: rest_names ->
              let full_path = Filename.concat path name in
              if Sys.file_exists full_path then Some full_path
              else try_names rest_names
        in
        try_names possible_names)
  in
  search_paths t.grammar_paths

let load_grammar_from_file path =
  let json = Yojson.Basic.from_file path in
  TmLanguage.of_yojson_exn json

let load_grammar t lang_id =
  (* Check if already loaded *)
  match List.assoc_opt lang_id t.grammars with
  | Some grammar -> grammar
  | None -> (
      match find_grammar_file t lang_id with
      | Some path ->
          let grammar = load_grammar_from_file path in
          TmLanguage.add_grammar t.tm_collection grammar;
          t.grammars <- (lang_id, grammar) :: t.grammars;
          grammar
      | None ->
          failwith
            (Printf.sprintf "Grammar not found for language: %s" lang_id))

let add_grammar_path t path = { t with grammar_paths = path :: t.grammar_paths }
