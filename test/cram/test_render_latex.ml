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

let setup () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.create ~grammars:[ path ] () in
  Sys.remove path;
  let theme = Ochre.Theme.load_from_string theme_json in
  (hl, theme)

let () =
  let hl, theme = setup () in
  match Sys.argv.(1) with
  | "keyword-and-number" ->
      print_endline (Ochre.to_latex hl ~theme ~lang:"test" "let x = 42")
  | "comment" ->
      print_endline (Ochre.to_latex hl ~theme ~lang:"test" "# a comment")
  | "string" ->
      print_endline (Ochre.to_latex hl ~theme ~lang:"test" {|let s = "hello"|})
  | "multi-line" ->
      print_endline
        (Ochre.to_latex hl ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "escaping" ->
      print_endline
        (Ochre.to_latex hl ~theme ~lang:"test" "# 100% of $x & y_{z}")
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
