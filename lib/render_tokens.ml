let render_token (t : Token.styled_token) =
  Printf.sprintf "{%s}[%s]" t.text (String.concat "," t.scopes)

let render_line line = String.concat "" (List.map render_token line)
let render _theme code = String.concat "\n" (List.map render_line code)
