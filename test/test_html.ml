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

let ocaml_source =
  "let answer = 42\n\
   (* open this in a browser *)\n\
   let greet = \"hello from ochre\""

let html_source =
  {|<!DOCTYPE html>
<html>
<head>
  <style>body { color: #333; font-family: sans-serif; }</style>
</head>
<body>
  <h1>Hello</h1>
  <script>
    const name = "world";
    console.log(name);
  </script>
</body>
</html>|}

let find_grammar name =
  match Tm_grammars.find name with
  | Some json ->
      (name, json)
  | None ->
      failwith (Printf.sprintf "grammar %s not found in tm-grammars" name)

let ocaml_highlighter =
  Ochre.create_from_json ~grammars:[ find_grammar "ocaml" ] ()

let html_highlighter =
  let grammars = List.map find_grammar [ "html"; "css"; "javascript" ] in
  Ochre.create_from_json ~grammars ()

let render_theme_block ~highlighter ~lang ~source theme_name =
  let open Test_html_common.Html in
  match Ochre.Theme.find theme_name with
  | Some theme ->
      let highlighted = Ochre.to_html highlighter ~theme ~lang source in
      section
        ~attrs:[ ("style", "display:grid;gap:8px") ]
        [
          div
            ~attrs:
              [
                ( "style",
                  "font-size:12px;letter-spacing:0.08em;text-transform:uppercase;color:#1f1f1f"
                );
              ]
            [ theme_name ];
          highlighted;
        ]
  | None ->
      section
        [
          Test_html_common.Html.node "p"
            [ Printf.sprintf "Missing built-in theme: %s" theme_name ];
        ]

let render_section ~highlighter ~lang ~source ~themes ~title =
  let open Test_html_common.Html in
  let theme_blocks =
    List.map (render_theme_block ~highlighter ~lang ~source) themes
  in
  div
    ~attrs:[ ("style", "display:grid;gap:24px") ]
    ([
       node "h2"
         ~attrs:[ ("style", "margin:0;font-size:18px;color:#1f1f1f") ]
         [ title ];
     ]
    @ theme_blocks
    )

let render_page () =
  let open Test_html_common.Html in
  let ocaml_section =
    render_section ~highlighter:ocaml_highlighter ~lang:"ocaml"
      ~source:ocaml_source ~themes:preview_themes ~title:"OCaml"
  in
  let html_section =
    render_section ~highlighter:html_highlighter ~lang:"html"
      ~source:html_source ~themes:preview_themes ~title:"HTML + CSS + JS"
  in
  render
    (page ~lang:"en"
       ~head:
         (head
            [
              void ~attrs:[ ("charset", "utf-8") ] "meta";
              node "title" [ "ochre HTML preview" ];
              node "style" [ "pre.ochre {padding: 24px 20px}" ];
            ]
         )
       ~body:
         (body
            ~attrs:
              [
                ( "style",
                  "margin:0;background:#f5f5f5;font-family:ui-monospace,monospace"
                );
              ]
            [
              div
                ~attrs:
                  [
                    ( "style",
                      "padding:24px;display:grid;gap:48px;max-width:960px;margin:0 \
                       auto;"
                    );
                  ]
                [ ocaml_section; html_section ];
            ]
         )
       ()
    )

let () =
  if Array.length Sys.argv > 1 && Sys.argv.(1) = "--preview" then
    print_endline (render_page ())
  else
    let page = render_page () in
    let port = Test_html_common.port_from_env () in
    try Test_html_common.serve_html ~name:"ochre preview" ~port ~html:page
    with Unix.Unix_error (Unix.EADDRINUSE, "bind", _) ->
      Printf.eprintf
        "Port %d is already in use. Stop the existing process or run with \
         PORT=<n> (e.g. PORT=5001 make test-browser).\n"
        port;
      exit 2
