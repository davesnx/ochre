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

let preview_themes =
  [
    "tokyonight";
    "everforest";
    "ayu";
    "catppuccin";
    "catppuccin-macchiato";
    "gruvbox";
    "kanagawa";
    "nord";
    "matrix";
    "one-dark";
  ]

let read_http_request ic =
  let rec consume_headers () =
    match input_line ic with
    | "" | "\r" ->
        ()
    | _ ->
        consume_headers ()
    | exception End_of_file ->
        ()
  in
  (match input_line ic with _ -> () | exception End_of_file -> ());
  consume_headers ()

let serve_html ~port ~html =
  let open Unix in
  let sock = socket PF_INET SOCK_STREAM 0 in
  setsockopt sock SO_REUSEADDR true;
  bind sock (ADDR_INET (inet_addr_any, port));
  listen sock 16;
  Printf.printf
    "Serving ochre preview at http://0.0.0.0:%d (Ctrl+C to stop)\n%!" port;
  while true do
    let client, _ = accept sock in
    let ic = in_channel_of_descr client in
    let oc = out_channel_of_descr client in
    read_http_request ic;
    let body = html in
    Printf.fprintf oc "HTTP/1.1 200 OK\r\n";
    Printf.fprintf oc "Content-Type: text/html; charset=utf-8\r\n";
    Printf.fprintf oc "Content-Length: %d\r\n" (String.length body);
    Printf.fprintf oc "Connection: close\r\n\r\n";
    output_string oc body;
    flush oc;
    close_in_noerr ic;
    close_out_noerr oc
  done;
  close sock

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

let render_page ~highlighter ~source =
  let render_theme name =
    match Ochre.Theme.make name with
    | Some theme ->
        let highlighted =
          Ochre.to_html highlighter ~theme ~lang:"ocaml" source
        in
        [
          "<section style=\"display:grid;gap:8px\">";
          Printf.sprintf
            "<div \
             style=\"font-size:12px;letter-spacing:0.08em;text-transform:uppercase;color:#6b7280\">%s</div>"
            name;
          highlighted;
          "</section>";
        ]
    | None ->
        [
          "<section>";
          Printf.sprintf "<p>Missing built-in theme: %s</p>" name;
          "</section>";
        ]
  in
  let rendered_sections = List.concat (List.map render_theme preview_themes) in
  String.concat "\n"
    ([
       "<!doctype html>";
       "<html lang=\"en\">";
       "<head><meta charset=\"utf-8\"><title>ochre HTML preview</title></head>";
       "<body \
        style=\"margin:0;background:#f5f5f5;font-family:ui-monospace,monospace\">";
       "<div style=\"padding:24px;display:grid;gap:24px;\">";
     ]
    @ rendered_sections
    @ [ "</div>"; "</body></html>" ]
    )

let () =
  let highlighter =
    Ochre.create_from_json ~grammars:[ ("ocaml", grammar_json) ] ()
  in
  let source =
    "let answer = 42\n\
     (* open this in a browser *)\n\
     let greet = \"hello from ochre\""
  in
  if Array.length Sys.argv > 1 && Sys.argv.(1) = "--preview" then
    print_endline (render_page ~highlighter ~source)
  else
    let page = render_page ~highlighter ~source in
    let port = port_from_env () in
    try serve_html ~port ~html:page
    with Unix.Unix_error (Unix.EADDRINUSE, "bind", _) ->
      Printf.eprintf
        "Port %d is already in use. Stop the existing process or run with \
         PORT=<n> (e.g. PORT=5001 make test-browser).\n"
        port;
      exit 2
