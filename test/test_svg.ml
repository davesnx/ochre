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
    | "" | "\r" -> ()
    | _ -> consume_headers ()
    | exception End_of_file -> ()
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
  | None -> 5000
  | Some value -> (
      match int_of_string_opt (String.trim value) with
      | Some p when p > 0 && p < 65536 -> p
      | _ -> 5000
    )

let with_full_width_svg svg =
  let prefix = "<svg " in
  let prefix_len = String.length prefix in
  if String.length svg >= prefix_len && String.sub svg 0 prefix_len = prefix
  then
    "<svg style=\"width:100%\" "
    ^ String.sub svg prefix_len (String.length svg - prefix_len)
  else svg

let render_svg ~highlighter ~source name =
  match Ochre.Theme.make name with
  | Some theme -> Ochre.to_svg highlighter ~theme ~lang:"ocaml" source
  | None ->
      Printf.eprintf "Missing built-in theme: %s\n" name;
      exit 1

let svg_body svg =
  match String.index_opt svg '>' with
  | None -> svg
  | Some open_end ->
      let close_tag = "</svg>" in
      let close_tag_len = String.length close_tag in
      let len = String.length svg in
      if
        len >= close_tag_len
        && String.sub svg (len - close_tag_len) close_tag_len = close_tag
      then String.sub svg (open_end + 1) (len - open_end - close_tag_len - 1)
      else String.sub svg (open_end + 1) (len - open_end - 1)

let render_theme_gallery_svg ~highlighter ~source =
  let card_width = 280 in
  let page_width = 320 in
  let top_padding = 24 in
  let block_height = 120 in
  let page_height = top_padding + (List.length preview_themes * block_height) in
  let theme_blocks =
    List.mapi
      (fun idx name ->
        let y = top_padding + (idx * block_height) in
        let body = render_svg ~highlighter ~source name |> svg_body in
        String.concat "\n"
          [
            Printf.sprintf
              "<text x=\"20\" y=\"%d\" font-size=\"12px\" \
               font-family=\"monospace\" fill=\"#6b7280\" \
               letter-spacing=\"0.08em\">%s</text>"
              (y + 12) name;
            Printf.sprintf
              "<svg x=\"20\" y=\"%d\" width=\"%d\" height=\"79\" \
               xmlns=\"http://www.w3.org/2000/svg\">"
              (y + 20) card_width;
            body;
            "</svg>";
          ]
      )
      preview_themes
  in
  String.concat "\n"
    ([
       Printf.sprintf
         "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%d\" height=\"%d\">"
         page_width page_height;
       Printf.sprintf
         "<rect x=\"0\" y=\"0\" width=\"%d\" height=\"%d\" fill=\"#f5f5f5\"/>"
         page_width page_height;
     ]
    @ theme_blocks @ [ "</svg>" ]
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
  if Array.length Sys.argv > 1 && Sys.argv.(1) = "--github-preview" then
    print_endline (render_theme_gallery_svg ~highlighter ~source)
  else
    let render_theme name =
      let svg = render_svg ~highlighter ~source name in
      let svg = with_full_width_svg svg in
      [
        "<section style=\"display:grid;gap:8px\">";
        Printf.sprintf
          "<div \
           style=\"font-size:12px;letter-spacing:0.08em;text-transform:uppercase;color:#6b7280\">%s</div>"
          name;
        "<div style=\"overflow:auto;background:#fff\">";
        svg;
        "</div>";
        "</section>";
      ]
    in
    let rendered_sections =
      List.concat (List.map render_theme preview_themes)
    in
    let page =
      String.concat "\n"
        ([
           "<!doctype html>";
           "<html lang=\"en\">";
           "<head><meta charset=\"utf-8\"><title>Ochre SVG \
            preview</title></head>";
           "<body \
            style=\"margin:0;background:#f5f5f5;font-family:ui-monospace,monospace\">";
           "<div style=\"padding:24px;display:grid;gap:24px;\">";
         ]
        @ rendered_sections
        @ [ "</div>"; "</body></html>" ]
        )
    in
    let port = port_from_env () in
    try serve_html ~port ~html:page
    with Unix.Unix_error (Unix.EADDRINUSE, "bind", _) ->
      Printf.eprintf
        "Port %d is already in use. Stop the existing process or run with \
         PORT=<n> (e.g. PORT=5001 make test-svg-serve).\n"
        port;
      exit 2
