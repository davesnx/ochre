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
  let hl = Ochre.load_from_files_exn [ path ] in
  Sys.remove path;
  let theme = Ochre.Theme.load_exn theme_json in
  (hl, theme)

let () =
  let hl, theme = setup () in
  match Sys.argv.(1) with
  | "html-class" ->
      let source = "let x = 42" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"highlighted-word"
            ~start:(Ochre.Decoration.pos 0 0) ~end_:(Ochre.Decoration.pos 0 3)
            ();
        ]
      in
      print_endline
        (Ochre.to_html hl ~decorations ~transforms:[] ~theme ~lang:"test" source)
  | "html-class-and-style" ->
      let source = "let x = 42" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"focus"
            ~style:"border-bottom:2px solid red"
            ~start:(Ochre.Decoration.pos 0 8)
            ~end_:(Ochre.Decoration.pos 0 10)
            ();
        ]
      in
      print_endline
        (Ochre.to_html hl ~decorations ~transforms:[] ~theme ~lang:"test" source)
  | "html-data-attrs" ->
      let source = "let x = 42" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"annotated"
            ~data:[ ("tooltip", "variable binding") ]
            ~start:(Ochre.Decoration.pos 0 0) ~end_:(Ochre.Decoration.pos 0 3)
            ();
        ]
      in
      print_endline
        (Ochre.to_html hl ~decorations ~transforms:[] ~theme ~lang:"test" source)
  | "html-split" ->
      (* Decorate "x =" which spans mid-token *)
      let source = "let x = 42" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"target"
            ~start:(Ochre.Decoration.pos 0 4) ~end_:(Ochre.Decoration.pos 0 7)
            ();
        ]
      in
      print_endline
        (Ochre.to_html hl ~decorations ~transforms:[] ~theme ~lang:"test" source)
  | "debug-tokens" ->
      let source = "let x = 42" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
            ~end_:(Ochre.Decoration.pos 0 3) ();
        ]
      in
      print_endline
        (Ochre.to_debug_tokens hl ~decorations ~transforms:[] ~theme
           ~lang:"test" source
        )
  | "multiline-html" ->
      let source = "let x = 42\nlet y = 10" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"span" ~start:(Ochre.Decoration.pos 0 4)
            ~end_:(Ochre.Decoration.pos 1 5) ();
        ]
      in
      print_endline
        (Ochre.to_html hl ~decorations ~transforms:[] ~theme ~lang:"test" source)
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
