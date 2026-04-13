let grammar_json =
  {|{
  "scopeName": "source.ocaml",
  "name": "ocaml",
  "patterns": [
    { "match": "\\(\\*[^\\n]*\\*\\)", "name": "comment.block.ocaml" },
    { "match": "\\b(let|in|fun|match|with|type|module)\\b", "name": "keyword.control.ocaml" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.ocaml" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.ocaml" }
  ]
}|}

let attrs attrs = List.map (fun (name, value) -> (name, `String value)) attrs

let serve_html ~name ~port ~html =
  let headers = [ ("content-type", "text/html; charset=utf-8") ] in
  let server =
    Tiny_httpd.create ~enable_logging:false ~addr:"0.0.0.0" ~port ()
  in
  Tiny_httpd.set_top_handler server (fun _req ->
      Tiny_httpd.Response.make_string ~headers (Ok html)
  );
  Printf.printf "Serving %s at http://0.0.0.0:%d (Ctrl+C to stop)\n%!" name port;
  match Tiny_httpd.run server with Ok () -> () | Error e -> raise e

let port_from_env () =
  match Sys.getenv_opt "PORT" with
  | None ->
      5000
  | Some value -> (
      match int_of_string_opt (String.trim value) with
      | Some p when p > 0 && p < 65536 ->
          p
      | _ ->
          5000
    )
