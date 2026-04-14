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
    { "scope": "entity.name.function", "settings": { "foreground": "#ffff00" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
  ]
}|}

let setup () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.load_from_files_exn [ path ] in
  Sys.remove path;
  let theme = Ochre.Theme.load_exn theme_json in
  (hl, theme)

let print_escaped s =
  String.iter
    (fun c ->
      if c = '\x1b' then
        print_string "\\e"
      else
        print_char c
    )
    s;
  print_newline ()

let () =
  let hl, theme = setup () in
  match Sys.argv.(1) with
  | "keyword-and-number" ->
      print_escaped (Ochre.to_ansi hl ~theme ~lang:"test" "let x = 42")
  | "comment" ->
      print_escaped (Ochre.to_ansi hl ~theme ~lang:"test" "# a comment")
  | "multi-line" ->
      print_escaped
        (Ochre.to_ansi hl ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "compound-scope" ->
      let grammar =
        {|{
        "scopeName": "source.compound",
        "name": "compound",
        "patterns": [
          {
            "match": "x",
            "name": "meta.shell string.quoted.double entity.name.function.call"
          }
        ]
      }|}
      in
      let hl = Ochre.load_exn [ ("compound", grammar) ] in
      let theme =
        Ochre.Theme.load_exn
          {|{
          "name": "test-theme",
          "colors": {
            "editor.foreground": "#d4d4d4",
            "editor.background": "#1e1e1e"
          },
          "tokenColors": [
            { "scope": "string", "settings": { "foreground": "#00ff00" } },
            { "scope": "entity.name.function", "settings": { "foreground": "#ffff00" } }
          ]
        }|}
      in
      print_escaped (Ochre.to_ansi hl ~theme ~lang:"compound" "x")
  | "invalid-fg-dark-bg" ->
      let theme =
        Ochre.Theme.load_exn
          {|{
          "name": "invalid-dark",
          "colors": {
            "editor.foreground": "#d4d4d4",
            "editor.background": "#101010"
          },
          "tokenColors": [
            { "scope": "keyword", "settings": { "foreground": "var(--bad)" } }
          ]
        }|}
      in
      print_escaped (Ochre.to_ansi hl ~theme ~lang:"test" "let")
  | "invalid-fg-light-bg" ->
      let theme =
        Ochre.Theme.load_exn
          {|{
          "name": "invalid-light",
          "colors": {
            "editor.foreground": "#111111",
            "editor.background": "#f0f0f0"
          },
          "tokenColors": [
            { "scope": "keyword", "settings": { "foreground": "var(--bad)" } }
          ]
        }|}
      in
      print_escaped (Ochre.to_ansi hl ~theme ~lang:"test" "let")
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
