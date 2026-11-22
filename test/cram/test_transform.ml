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
  let hl = Support.get_ok (Ochre.load_from_files [ path ]) in
  Sys.remove path;
  let theme = fst (Support.get_ok (Ochre.Theme.load theme_json)) in
  (hl, theme)

let print_token = Support.print_token

let () =
  let hl, theme = setup () in
  match Sys.argv.(1) with
  | "no-transforms" ->
      let tokens =
        (Ochre.highlight ~transforms:[] ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "line-highlight" ->
      let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42\nlet y = 10"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "word-highlight" ->
      let transforms = [ Ochre.Transform_builtin.word_highlight [ "let" ] ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "diff-markers" ->
      let transforms = [ Ochre.Transform_builtin.diff_markers ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "+let x = 42\n-let y = 10\n let z = 0"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "scope-marker" ->
      let transforms = [ Ochre.Transform_builtin.scope_marker "keyword" ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "html-with-transform" ->
      let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
      let html =
        Ochre.to_html
          (Ochre.highlight ~transforms ~theme
             ~lang:(Support.get_ok (Ochre.lang hl "test"))
             "let x = 42\nlet y = 10"
          )
      in
      print_endline html
  | "combined" ->
      let transforms =
        [
          Ochre.Transform_builtin.line_highlight [ 0 ];
          Ochre.Transform_builtin.word_highlight [ "let" ];
        ]
      in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42\nlet y = 10"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "notation-highlight" ->
      let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42 # [!code highlight]\nlet y = 10"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "notation-diff" ->
      let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42 # [!code ++]\nlet y = 10 # [!code --]\nlet z = 0"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "notation-word-highlight" ->
      let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42 # [!code word:x]"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "notation-highlight-no-match" ->
      let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42\nlet y = 10"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "notation-diff-mixed" ->
      let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
      let tokens =
        (Ochre.highlight ~transforms ~theme
           ~lang:(Support.get_ok (Ochre.lang hl "test"))
           "let x = 42 # [!code ++]\nlet y = 10\nlet z = 0 # [!code --]"
        )
          .lines
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
