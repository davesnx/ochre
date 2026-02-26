open Token

let font_style_to_css = function
  | Bold -> "font-weight:bold"
  | Italic -> "font-style:italic"
  | Underline -> "text-decoration:underline"
  | Strikethrough -> "text-decoration:line-through"

let token_style_to_css token =
  let styles = [] in
  let styles =
    match token.foreground with
    | Some color -> ("color:" ^ color) :: styles
    | None -> styles
  in
  let styles =
    match token.background with
    | Some color -> ("background-color:" ^ color) :: styles
    | None -> styles
  in
  let styles = List.map font_style_to_css token.font_style @ styles in
  String.concat ";" styles

let render_token token =
  let style = token_style_to_css token in
  let buf = Buffer.create (String.length token.text) in
  Escape.html buf token.text;
  let text = Buffer.contents buf in
  if style = "" then text
  else Printf.sprintf "<span style=\"%s\">%s</span>" style text

let render_line line = String.concat "" (List.map render_token line)

let render theme code =
  let lines =
    List.map
      (fun line ->
        Printf.sprintf "<span class=\"line\">%s</span>" (render_line line))
      code
  in
  let code_content = String.concat "\n" lines in
  Printf.sprintf
    "<pre class=\"ochre\" style=\"background-color:%s;color:%s\"><code \
     style=\"display:block;padding:20px\">%s</code></pre>"
    theme.Theme.bg theme.Theme.fg code_content
