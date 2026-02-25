let token ?(fg = None) ?(bg = None) ?(styles = []) text
    : Ochre.Token.styled_token =
  { text; foreground = fg; background = bg; font_style = styles; scopes = [] }

let theme : Ochre.Theme.theme =
  { name = "test"; fg = "#d4d4d4"; bg = "#1e1e1e"; token_colors = [] }

let () =
  match Sys.argv.(1) with
  | "plain" ->
    print_endline (Ochre.Render_html.render theme [ [ token "hello world" ] ])
  | "colored" ->
    print_endline
      (Ochre.Render_html.render theme
         [ [ token ~fg:(Some "#ff0000") "red text" ] ])
  | "styled" ->
    print_endline
      (Ochre.Render_html.render theme
         [
           [
             token ~fg:(Some "#00ff00")
               ~styles:[ Bold; Italic ]
               "styled";
           ];
         ])
  | "escaping" ->
    print_endline
      (Ochre.Render_html.render theme
         [ [ token {|<div class="test">&amp;</div>|} ] ])
  | "multi-line" ->
    print_endline
      (Ochre.Render_html.render theme
         [
           [
             token ~fg:(Some "#569cd6") "let";
             token " x = ";
             token ~fg:(Some "#b5cea8") "42";
           ];
           [
             token ~fg:(Some "#569cd6") "let";
             token " y = ";
             token ~fg:(Some "#b5cea8") "10";
           ];
         ])
  | "background" ->
    print_endline
      (Ochre.Render_html.render theme
         [
           [
             token ~fg:(Some "#fff") ~bg:(Some "#f00") "highlighted";
           ];
         ])
  | "empty" ->
    print_endline (Ochre.Render_html.render theme [ [] ])
  | "all-styles" ->
    print_endline
      (Ochre.Render_html.render theme
         [
           [
             token
               ~fg:(Some "#abc")
               ~styles:[ Bold; Italic; Underline; Strikethrough ]
               "everything";
           ];
         ])
  | s -> Printf.eprintf "unknown: %s\n" s; exit 1
