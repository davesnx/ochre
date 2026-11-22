type t = {
  tm_collection : TmLanguage.t;
  grammars : (string * TmLanguage.grammar) list;
}

type file_format = Json | Plist

let describe_json_error msg = String.map (function '\n' -> ' ' | c -> c) msg

let strip_path_prefix path msg =
  let prefix = path ^ ": " in
  if String.starts_with ~prefix msg then
    String.sub msg (String.length prefix)
      (String.length msg - String.length prefix)
  else
    msg

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
  if
    Filename.check_suffix base ".tmLanguage"
    || Filename.check_suffix base ".plist"
  then
    Plist
  else
    Json

let error_message ?path = function
  | Yojson.Json_error msg ->
      "invalid JSON: " ^ describe_json_error msg
  | TmLanguage.Error msg ->
      msg
  | Sys_error msg -> (
      match path with Some path -> strip_path_prefix path msg | None -> msg
    )
  | exn ->
      Printexc.to_string exn

let is_fatal = function
  | Out_of_memory | Stack_overflow | Sys.Break ->
      true
  | _ ->
      false

let read_grammar ~lang ?path read =
  match read () with
  | grammar ->
      Ok (lang, path, grammar)
  | exception exn when not (is_fatal exn) ->
      Error
        (Error.Grammar_error { lang; path; message = error_message ?path exn })

let grammar_of_string json_string =
  TmLanguage.of_yojson_exn (Yojson.Basic.from_string json_string)

let grammar_of_file path =
  match format_of_path path with
  | Json ->
      TmLanguage.of_yojson_exn (Yojson.Basic.from_file path)
  | Plist ->
      In_channel.with_open_bin path (fun ic ->
          TmLanguage.of_plist_exn (Plist_xml.from_channel ic)
      )

let collect read entries =
  let rec go seen acc = function
    | [] ->
        Ok (List.rev acc)
    | entry :: rest -> (
        match read entry with
        | Error _ as error ->
            error
        | Ok (lang, path, grammar) ->
            if List.mem lang seen then
              Error
                (Error.Grammar_error
                   {
                     lang;
                     path;
                     message =
                       "duplicate grammar id: each grammar must be registered \
                        under a unique id";
                   }
                )
            else
              go (lang :: seen) ((lang, grammar) :: acc) rest
      )
  in
  match go [] [] entries with
  | Error _ as error ->
      error
  | Ok grammars ->
      let tm_collection = TmLanguage.create () in
      List.iter (fun (_, g) -> TmLanguage.add_grammar tm_collection g) grammars;
      Ok { tm_collection; grammars }

let load grammars =
  collect
    (fun (lang, json) -> read_grammar ~lang (fun () -> grammar_of_string json))
    grammars

let load_from_files paths =
  collect
    (fun path ->
      read_grammar ~lang:(lang_id_of_path path) ~path (fun () ->
          grammar_of_file path
      )
    )
    paths

let find_grammar t lang_id = List.assoc_opt lang_id t.grammars
let tm_collection t = t.tm_collection
