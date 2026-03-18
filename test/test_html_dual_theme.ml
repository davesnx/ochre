let render_page ~highlighter ~source =
  let open Test_html_common.Html in
  let highlighted =
    Ochre.to_html highlighter ~theme:Ochre.Theme.light
      ~extra_themes:[ ("dark", Ochre.Theme.dark) ]
      ~lang:"ocaml" source
  in
  let css =
    [
      ":root { --page-bg: #f5f5f5; --page-fg: #111827; --card-bg: #ffffff; }";
      "body { margin:0; padding:24px; font-family: ui-monospace, \
       SFMono-Regular, Menlo, monospace; background: var(--page-bg); color: \
       var(--page-fg); }";
      ".page { max-width: 960px; margin: 0 auto; display: grid; gap: 16px; }";
      ".toolbar { display:flex; align-items:center; justify-content:center; }";
      ".toggle { display: inline-flex; align-items: center; gap: 10px; }";
      ".toggle input { width:42px; height:24px; }";
      ".label { font-size: 12px; letter-spacing: 0.08em; text-transform: \
       uppercase; opacity: 0.75; }";
      "#theme-label { display:inline-block; width:5ch; text-align:center; }";
      "pre.ochre { margin: 0; padding: 24px 20px; border-radius: 10px; \
       overflow-x: auto; }";
      ":root[data-theme=\"dark\"] .ochre, :root[data-theme=\"dark\"] .ochre \
       span { --ochre: var(--ochre-dark); --ochre-bg: var(--ochre-dark-bg); \
       --ochre-font-style: var(--ochre-dark-font-style); --ochre-font-weight: \
       var(--ochre-dark-font-weight); --ochre-text-decoration: \
       var(--ochre-dark-text-decoration); }";
    ]
  in
  let script =
    [
      "(function () {";
      "  var root = document.documentElement;";
      "  var toggle = document.getElementById('theme-toggle');";
      "  var label = document.getElementById('theme-label');";
      "  function setTheme(mode) {";
      "    root.setAttribute('data-theme', mode);";
      "    label.textContent = mode === 'dark' ? 'Dark' : 'Light';";
      "    toggle.checked = mode === 'dark';";
      "  }";
      "  setTheme('light');";
      "  toggle.addEventListener('change', function () {";
      "    setTheme(toggle.checked ? 'dark' : 'light');";
      "  });";
      "})();";
    ]
  in
  render
    (page ~lang:"en"
       ~attrs:[ ("data-theme", "light") ]
       ~head:
         (head
            [
              void ~attrs:[ ("charset", "utf-8") ] "meta";
              void
                ~attrs:
                  [
                    ("name", "viewport");
                    ("content", "width=device-width, initial-scale=1");
                  ]
                "meta";
              component "title" [ "ochre dual-theme HTML preview" ];
              component "style" css;
            ]
         )
       ~body:
         (body
            [
              div
                ~attrs:[ ("class", "page") ]
                [
                  div
                    ~attrs:[ ("class", "toolbar") ]
                    [
                      component "label"
                        ~attrs:[ ("class", "toggle"); ("for", "theme-toggle") ]
                        [
                          component "span"
                            ~attrs:[ ("class", "label") ]
                            [ "Theme" ];
                          void
                            ~attrs:
                              [
                                ("id", "theme-toggle");
                                ("type", "checkbox");
                                ("aria-label", "Toggle dark mode");
                              ]
                            "input";
                          component "span"
                            ~attrs:[ ("id", "theme-label") ]
                            [ "Light" ];
                        ];
                    ];
                  highlighted;
                ];
              component "script" script;
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
     (* toggle light and dark theme *)\n\
     let greet = \"hello from ochre\""
  in
  if Array.length Sys.argv > 1 && Sys.argv.(1) = "--preview" then
    print_endline (render_page ~highlighter ~source)
  else
    let page = render_page ~highlighter ~source in
    let port = Test_html_common.port_from_env () in
    try
      Test_html_common.serve_html ~name:"ochre dual-theme preview" ~port
        ~html:page
    with Unix.Unix_error (Unix.EADDRINUSE, "bind", _) ->
      Printf.eprintf
        "Port %d is already in use. Stop the existing process or run with \
         PORT=<n> (e.g. PORT=5001 make test-browser-dual).\n"
        port;
      exit 2
