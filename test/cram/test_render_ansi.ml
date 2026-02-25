let token ?(fg = None) ?(bg = None) ?(styles = []) text
    : Ochre.Token.styled_token =
  { text; foreground = fg; background = bg; font_style = styles; scopes = [] }

let theme : Ochre.Theme.theme =
  { name = "test"; fg = "#d4d4d4"; bg = "#1e1e1e"; token_colors = [] }

let print_escaped s =
  String.iter
    (fun c ->
      if c = '\x1b' then print_string "\\e" else print_char c)
    s;
  print_newline ()

let () =
  match Sys.argv.(1) with
  | "plain" ->
    print_escaped (Ochre.Render_ansi.render theme [ [ token "hello" ] ])
  | "colored" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [ [ token ~fg:(Some "#ff0000") "red" ] ])
  | "bold" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [ [ token ~fg:(Some "#00ff00") ~styles:[ Bold ] "bold green" ] ])
  | "background" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [ [ token ~fg:(Some "#fff") ~bg:(Some "#f00") "alert" ] ])
  | "multi-token" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [
           [
             token ~fg:(Some "#ff0000") "red ";
             token "plain ";
             token ~fg:(Some "#0000ff") "blue";
           ];
         ])
  | "multi-line" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [
           [ token ~fg:(Some "#ff0000") "line1" ];
           [ token ~fg:(Some "#00ff00") "line2" ];
         ])
  | "all-styles" ->
    print_escaped
      (Ochre.Render_ansi.render theme
         [
           [
             token
               ~styles:[ Bold; Italic; Underline; Strikethrough ]
               "styled";
           ];
         ])
  | s -> Printf.eprintf "unknown: %s\n" s; exit 1
