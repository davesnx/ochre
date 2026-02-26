open Token

let escape_latex str =
  let buf = Buffer.create (String.length str * 2) in
  String.iter
    (function
      | '\\' -> Buffer.add_string buf "\\textbackslash{}"
      | '{' -> Buffer.add_string buf "\\{"
      | '}' -> Buffer.add_string buf "\\}"
      | '%' -> Buffer.add_string buf "\\%"
      | '$' -> Buffer.add_string buf "\\$"
      | '#' -> Buffer.add_string buf "\\#"
      | '&' -> Buffer.add_string buf "\\&"
      | '_' -> Buffer.add_string buf "\\_"
      | '~' -> Buffer.add_string buf "\\textasciitilde{}"
      | '^' -> Buffer.add_string buf "\\textasciicircum{}"
      | c -> Buffer.add_char buf c)
    str;
  Buffer.contents buf

let strip_hash hex =
  if String.starts_with ~prefix:"#" hex then
    String.sub hex 1 (String.length hex - 1)
  else hex

let wrap_font_styles styles inner =
  List.fold_left
    (fun acc style ->
      match style with
      | Bold -> Printf.sprintf "\\textbf{%s}" acc
      | Italic -> Printf.sprintf "\\textit{%s}" acc
      | Underline -> Printf.sprintf "\\underline{%s}" acc
      | Strikethrough -> Printf.sprintf "\\sout{%s}" acc)
    inner styles

let render_token (token : styled_token) =
  let text = escape_latex token.text in
  let styled = wrap_font_styles token.font_style text in
  match token.foreground with
  | Some color ->
      Printf.sprintf "\\textcolor[HTML]{%s}{%s}" (strip_hash color) styled
  | None -> styled

let render_line line = String.concat "" (List.map render_token line)

let render theme (code : highlighted_code) =
  let lines = List.map render_line code in
  let code_content = String.concat "\n" lines in
  Printf.sprintf "\\begin{ochrehighlight}{%s}{%s}\n%s\n\\end{ochrehighlight}"
    (strip_hash theme.Theme.bg)
    (strip_hash theme.Theme.fg)
    code_content
