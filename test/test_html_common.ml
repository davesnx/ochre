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

module Html = struct
  type attr = string * string

  let render_attrs attrs =
    attrs
    |> List.map (fun (name, value) -> Printf.sprintf " %s=\"%s\"" name value)
    |> String.concat ""

  let open_tag ?(attrs = []) tag =
    Printf.sprintf "<%s%s>" tag (render_attrs attrs)

  let close_tag tag = Printf.sprintf "</%s>" tag

  let void ?(attrs = []) tag = Printf.sprintf "<%s%s>" tag (render_attrs attrs)

  let node ?(attrs = []) tag children =
    String.concat "\n" ([ open_tag ~attrs tag ] @ children @ [ close_tag tag ])

  let div ?(attrs = []) children = node ~attrs "div" children

  let section ?(attrs = []) children = node ~attrs "section" children

  let head children = node "head" children

  let body ?(attrs = []) children = node ~attrs "body" children

  let page ?(attrs = []) ~lang ~head ~body () =
    String.concat "\n"
      [
        "<!doctype html>";
        node ~attrs:(("lang", lang) :: attrs) "html" [ head; body ];
      ]

  let render html = html
end

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

let serve_html ~name ~port ~html =
  let open Unix in
  let sock = socket PF_INET SOCK_STREAM 0 in
  setsockopt sock SO_REUSEADDR true;
  bind sock (ADDR_INET (inet_addr_any, port));
  listen sock 16;
  Printf.printf "Serving %s at http://0.0.0.0:%d (Ctrl+C to stop)\n%!" name port;
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
