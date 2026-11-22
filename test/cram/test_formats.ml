let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.test" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.test" }
  ]
}|}

let theme_json ~keyword_style =
  Printf.sprintf
    {|{
  "name": "test-theme",
  "colors": {
    "editor.foreground": "#d4d4d4",
    "editor.background": "#1e1e1e"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#888888", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#ff0000", "fontStyle": "%s" } },
    { "scope": "string", "settings": { "foreground": "#00ff00" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
  ]
}|}
    keyword_style

let hl = Support.get_ok (Ochre.load [ ("test", grammar_json) ])
let theme =
  fst (Support.get_ok (Ochre.Theme.load (theme_json ~keyword_style:"bold")))

let theme_underline_strike =
  fst
    (Support.get_ok
       (Ochre.Theme.load (theme_json ~keyword_style:"underline strikethrough"))
    )

let escaped s =
  let buf = Buffer.create (String.length s) in
  String.iter
    (fun c ->
      match c with
      | '\x1b' ->
          Buffer.add_string buf "\\e"
      | '\r' ->
          Buffer.add_string buf "\\r"
      | '\n' ->
          Buffer.add_string buf "\\n"
      | '\t' ->
          Buffer.add_string buf "\\t"
      | c ->
          Buffer.add_char buf c
    )
    s;
  Buffer.contents buf

let set_colors ~foreground ~background =
  Ochre.Transform.make "set-colors" ~after_line:(fun ~line_index:_ line ->
      List.map
        (Ochre.Token.map_style (fun _ (style : Ochre.Style.t) ->
             {
               style with
               foreground = Support.color foreground;
               background = Some (Support.color background);
             }
         )
        )
        line
  )

let highlight_first_line = Ochre.Transform_builtin.line_highlight [ 0 ]

let () =
  match Sys.argv.(1) with
  | "ansi-alpha" ->
      print_endline
        (escaped
           (Ochre.to_ansi
              (Ochre.highlight ~transforms:[ highlight_first_line ] ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "let x\nlet y"
              )
           )
        )
  | "ansi-diff" ->
      print_endline
        (escaped
           (Ochre.to_ansi
              (Ochre.highlight
                 ~transforms:[ Ochre.Transform_builtin.diff_markers ]
                 ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "+let x\n-let y\n"
              )
           )
        )
  | "svg-alpha" ->
      print_endline
        (Ochre.to_svg
           (Ochre.highlight ~transforms:[ highlight_first_line ] ~theme
              ~lang:(Support.get_ok (Ochre.lang hl "test"))
              "let x\nlet y"
           )
        )
  | "svg-diff" ->
      print_endline
        (Ochre.to_svg
           (Ochre.highlight
              ~transforms:[ Ochre.Transform_builtin.diff_markers ]
              ~theme
              ~lang:(Support.get_ok (Ochre.lang hl "test"))
              "+let x\n-let y\n"
           )
        )
  | "latex-alpha" ->
      print_endline
        (Ochre.to_latex
           (Ochre.highlight ~transforms:[ highlight_first_line ] ~theme
              ~lang:(Support.get_ok (Ochre.lang hl "test"))
              "let x\nlet y"
           )
        )
  | "latex-diff" ->
      print_endline
        (Ochre.to_latex
           (Ochre.highlight
              ~transforms:[ Ochre.Transform_builtin.diff_markers ]
              ~theme
              ~lang:(Support.get_ok (Ochre.lang hl "test"))
              "+let x\n-let y\n"
           )
        )
  | "ansi-crlf" ->
      print_endline
        (escaped
           (Ochre.to_ansi
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "# one\r\nlet\r\n"
              )
           )
        )
  | "ansi-lone-cr" ->
      print_endline
        (escaped
           (Ochre.to_ansi
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "a\rb\n"
              )
           )
        )
  | "html-crlf" ->
      print_endline
        (escaped
           (Ochre.to_html
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "# one\r\nlet\r\n"
              )
           )
        )
  | "html-lone-cr" ->
      print_endline
        (escaped
           (Ochre.to_html
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "a\rb\n"
              )
           )
        )
  | "latex-controls" ->
      print_endline
        (escaped
           (Ochre.to_latex
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "a\tb\r\n\tc\x01\x1bd\x7f\n"
              )
           )
        )
  | "svg-tabs" ->
      print_endline
        (escaped
           (Ochre.to_svg
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "\tlet\tx\n \t1\n"
              )
           )
        )
  | "svg-width" ->
      List.iter
        (fun source ->
          let svg =
            Ochre.to_svg
              (Ochre.highlight ~theme
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 source
              )
          in
          let start =
            Str.search_forward (Str.regexp "width=\"\\([0-9]+\\)\"") svg 0
          in
          ignore start;
          Printf.printf "%S -> width %s\n" source (Str.matched_group 1 svg)
        )
        [
          "abcd";
          "\xc3\xa9\xc3\xa9\xc3\xa9\xc3\xa9";
          "\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e\xe6\x97\xa5";
          "a\tb";
          "ab\r\n";
          "\xf0\x9f\x98\x80";
        ]
  | "html-underline-strike" ->
      print_endline
        (Ochre.to_html
           (Ochre.highlight ~theme:theme_underline_strike
              ~lang:(Support.get_ok (Ochre.lang hl "test"))
              "let x"
           )
        )
  | "html-underline-strike-dual" ->
      print_endline
        (Ochre.to_html
           (Support.get_ok
              (Ochre.highlight_themes ~theme
                 ~extra_themes:[ ("dark", theme_underline_strike) ]
                 ~lang:(Support.get_ok (Ochre.lang hl "test"))
                 "let x"
              )
           )
        )
  | "colors-ansi" ->
      List.iter
        (fun (foreground, background) ->
          let transforms = [ set_colors ~foreground ~background ] in
          print_endline
            (Printf.sprintf "%s on %s: %s" foreground background
               (escaped
                  (Ochre.to_ansi
                     (Ochre.highlight ~transforms ~theme
                        ~lang:(Support.get_ok (Ochre.lang hl "test"))
                        "x"
                     )
                  )
               )
            )
        )
        [
          ("#f00", "#00f");
          ("#f008", "#00f8");
          ("#ff0000", "#0000ff");
          ("#ff000080", "#0000ff80");
          ("#ff000000", "#0000ff00");
        ]
  | "colors-latex" ->
      List.iter
        (fun (foreground, background) ->
          let transforms = [ set_colors ~foreground ~background ] in
          print_endline
            (Printf.sprintf "%s on %s: %s" foreground background
               (Ochre.to_latex
                  (Ochre.highlight ~transforms ~theme
                     ~lang:(Support.get_ok (Ochre.lang hl "test"))
                     "x"
                  )
               )
            )
        )
        [
          ("#f00", "#00f");
          ("#f008", "#00f8");
          ("#ff0000", "#0000ff");
          ("#ff000080", "#0000ff80");
        ]
  | "theme-css-prefix" ->
      let options =
        Ochre.Html_options.make
          ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "c-" })
          ~css_variable_prefix:"--hl-" ()
      in
      let source = "let x = 1 # c" in
      let themed =
        Ochre.highlight ~theme
          ~lang:(Support.get_ok (Ochre.lang hl "test"))
          source
      in
      let html = Ochre.to_html ~options themed in
      let css =
        Ochre.html_render_theme_css ~css_variable_prefix:"--hl-"
          ~class_prefix:"c-" themed
      in
      let classes =
        let re = Str.regexp "class=\"\\(c-[0-9a-f]+\\)\"" in
        let rec all pos acc =
          match Str.search_forward re html pos with
          | _ ->
              all (Str.match_end ()) (Str.matched_group 1 html :: acc)
          | exception Not_found ->
              List.sort_uniq compare acc
        in
        all 0 []
      in
      let defined cls =
        try
          ignore
            (Str.search_forward (Str.regexp_string ("." ^ cls ^ " {")) css 0);
          true
        with Not_found -> false
      in
      List.iter
        (fun cls -> Printf.printf "class defined: %b\n" (defined cls))
        classes;
      print_string css
  | "theme-css-variables" ->
      print_endline (Ochre.html_theme_css ~css_variable_prefix:"--hl-" "dark")
  | "duplicate-labels" ->
      let attempt name extras =
        match
          Ochre.highlight_themes ~theme ~extra_themes:extras
            ~lang:(Support.get_ok (Ochre.lang hl "test"))
            "let"
        with
        | Ok _ ->
            Printf.printf "%s: rendered\n" name
        | Error error ->
            Printf.printf "%s: %s\n" name (Ochre.Error.to_string error)
      in
      attempt "primary and extra share a label" [ ("test-theme", theme) ];
      attempt "two extras" [ ("a b", theme); ("a_b", theme) ];
      attempt "distinct labels" [ ("a", theme); ("b", theme) ]
  | "transform-order" ->
      let log = ref [] in
      let hook name phase =
       fun ~line_index line ->
        log := Printf.sprintf "%s %s %d" name phase line_index :: !log;
        line
      in
      let make name =
        Ochre.Transform.make name ~before_line:(hook name "before")
          ~after_line:(hook name "after")
      in
      ignore (Ochre.Transform.run [ make "a"; make "b" ] [ []; []; [] ]);
      List.iter print_endline (List.rev !log)
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
