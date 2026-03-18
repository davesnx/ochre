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

let theme_json =
  {|{
  "name": "test-theme",
  "colors": {
    "editor.foreground": "#d4d4d4",
    "editor.background": "#1e1e1e"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#888888", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#ff0000", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#00ff00" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
  ]
}|}

let light_theme_json =
  {|{
  "name": "test-light",
  "colors": {
    "editor.foreground": "#24292e",
    "editor.background": "#ffffff"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#6a737d", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#d73a49", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#032f62" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#005cc5" } }
  ]
}|}

let dim_theme_json =
  {|{
  "name": "test-dim",
  "colors": {
    "editor.foreground": "#999999",
    "editor.background": "#111111"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#555555", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#aa5555", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#55aa55" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#5555aa" } }
  ]
}|}

let setup () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.create ~grammars:[ path ] () in
  Sys.remove path;
  let theme = Ochre.Theme.load_from_string theme_json in
  let light_theme = Ochre.Theme.load_from_string light_theme_json in
  let dim_theme = Ochre.Theme.load_from_string dim_theme_json in
  (hl, theme, light_theme, dim_theme)

let () =
  let hl, theme, light_theme, dim_theme = setup () in
  match Sys.argv.(1) with
  | "keyword-and-number" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "let x = 42")
  | "comment" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "# a comment")
  | "string" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" {|let s = "hello"|})
  | "multi-line" ->
      print_endline
        (Ochre.to_html hl ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "escaping" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "# <div>&amp;</div>")
  | "themes-one-extra" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-multi-line" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42\nlet y = 10"
        )
  | "themes-light-dark-vars" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("light", light_theme); ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-no-default" ->
      (* omit ~theme, first entry in ~extra_themes becomes default *)
      print_endline
        (Ochre.to_html hl
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-two-extras" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme); ("dim", dim_theme) ]
           ~lang:"test" "let x = 42"
        )
  | "theme-prefers-dark-css" ->
      print_endline Ochre.html_theme_prefers_dark_css
  | "theme-css" ->
      print_endline (Ochre.html_theme_css "dim")
  | "line-numbers" ->
      let options = Ochre.Html_options.make ~line_numbers:true () in
      print_endline
        (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "no-default-color" ->
      let options =
        Ochre.Html_options.make
          ~default_color:Ochre.Html_options.No_default_color ()
      in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "no-default-color-multi" ->
      let options =
        Ochre.Html_options.make
          ~default_color:Ochre.Html_options.No_default_color ()
      in
      print_endline
        (Ochre.to_html hl ~options ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "css-classes" ->
      let options =
        Ochre.Html_options.make
          ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "s-" })
          ()
      in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "custom-prefix" ->
      let options =
        Ochre.Html_options.make ~css_variable_prefix:"--shiki-" ()
      in
      print_endline
        (Ochre.to_html hl ~options ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "scopes-data" ->
      let options = Ochre.Html_options.make ~scopes_as_data_attrs:true () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "pre-class" ->
      let options = Ochre.Html_options.make ~pre_class:"my-code" () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "code-class" ->
      let options = Ochre.Html_options.make ~code_class:"language-test" () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
