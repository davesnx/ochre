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

let render_page ~highlighter ~source =
  let open Test_html_common.Html in
  let render_theme name =
    match Ochre.Theme.find name with
    | Some theme ->
        let highlighted =
          Ochre.to_html highlighter ~theme ~lang:"ocaml" source
        in
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
              [ name ];
            highlighted;
          ]
    | None ->
        section
          [ node "p" [ Printf.sprintf "Missing built-in theme: %s" name ] ]
  in
  let rendered_sections = List.map render_theme preview_themes in
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
                      "padding:24px;display:grid;gap:24px;max-width:960px;margin:0 \
                       auto;"
                    );
                  ]
                rendered_sections;
            ]
         )
       ()
    )

let () =
  let highlighter =
    Ochre.create_from_json
      ~grammars:[ ("ocaml", Test_html_common.grammar_json) ]
      ()
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
    let port = Test_html_common.port_from_env () in
    try Test_html_common.serve_html ~name:"ochre preview" ~port ~html:page
    with Unix.Unix_error (Unix.EADDRINUSE, "bind", _) ->
      Printf.eprintf
        "Port %d is already in use. Stop the existing process or run with \
         PORT=<n> (e.g. PORT=5001 make test-browser).\n"
        port;
      exit 2
