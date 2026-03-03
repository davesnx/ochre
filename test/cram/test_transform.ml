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

let style_to_string = function
  | Ochre.Token.Bold -> "bold"
  | Italic -> "italic"
  | Underline -> "underline"
  | Strikethrough -> "strikethrough"

let print_token (tok : Ochre.Token.styled_token) =
  let text = String.trim tok.text in
  if text <> "" then begin
    Printf.printf "text: %S\n" text;
    Printf.printf "  fg: %s\n" (Option.value ~default:"none" tok.foreground);
    (match tok.background with
    | Some c -> Printf.printf "  bg: %s\n" c
    | None -> ());
    if tok.font_style <> [] then
      Printf.printf "  styles: [%s]\n"
        (String.concat ", " (List.map style_to_string tok.font_style));
    Printf.printf "  scopes: [%s]\n" (String.concat ", " tok.scopes)
  end

let () =
  let hl, theme = setup () in
  match Sys.argv.(1) with
  | "no-transforms" ->
      let tokens =
        Ochre.to_tokens_with hl ~transforms:[] ~theme ~lang:"test" "let x = 42"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "line-highlight" ->
      let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
      let tokens =
        Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test"
          "let x = 42\nlet y = 10"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "word-highlight" ->
      let transforms = [ Ochre.Transform_builtin.word_highlight [ "let" ] ] in
      let tokens =
        Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test" "let x = 42"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "diff-markers" ->
      let transforms = [ Ochre.Transform_builtin.diff_markers ] in
      let tokens =
        Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test"
          "+let x = 42\n-let y = 10\n let z = 0"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "scope-marker" ->
      let transforms = [ Ochre.Transform_builtin.scope_marker "keyword" ] in
      let tokens =
        Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test" "let x = 42"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | "html-with-transform" ->
      let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
      let html =
        Ochre.to_html_with hl ~transforms ~theme ~lang:"test"
          "let x = 42\nlet y = 10"
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
        Ochre.to_tokens_with hl ~transforms ~theme ~lang:"test"
          "let x = 42\nlet y = 10"
      in
      List.iter (fun line -> List.iter print_token line) tokens
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
