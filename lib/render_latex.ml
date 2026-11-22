let escape_latex str =
  let buf = Buffer.create (String.length str * 2) in
  String.iter
    (fun c ->
      match c with
      | ' ' ->
          Buffer.add_string buf "\\ "
      | '\n' | '\r' ->
          ()
      | '\000' .. '\031' | '\127' ->
          Buffer.add_string buf "\\textasciicircum{}";
          Buffer.add_char buf (Char.chr (Char.code c lxor 0x40))
      | '\\' ->
          Buffer.add_string buf "\\textbackslash{}"
      | '{' ->
          Buffer.add_string buf "\\{"
      | '}' ->
          Buffer.add_string buf "\\}"
      | '%' ->
          Buffer.add_string buf "\\%"
      | '$' ->
          Buffer.add_string buf "\\$"
      | '#' ->
          Buffer.add_string buf "\\#"
      | '&' ->
          Buffer.add_string buf "\\&"
      | '_' ->
          Buffer.add_string buf "\\_"
      | '~' ->
          Buffer.add_string buf "\\textasciitilde{}"
      | '^' ->
          Buffer.add_string buf "\\textasciicircum{}"
      | c ->
          Buffer.add_char buf c
    )
    str;
  Buffer.contents buf

let hex (color : Color.t) =
  Printf.sprintf "%02x%02x%02x" color.r color.g color.b

let wrap_font_styles (style : Style.font_style) inner =
  List.fold_left
    (fun acc (on, command) ->
      if on then
        Printf.sprintf "\\%s{%s}" command acc
      else
        acc
    )
    inner
    [
      (style.bold, "textbf");
      (style.italic, "textit");
      (style.underline, "underline");
      (style.strikethrough, "sout");
    ]

let render_token ~page ~column (style : Style.t) text =
  let expanded, column = Render_cells.expand_tabs ~column text in
  let styled = wrap_font_styles style.font_style (escape_latex expanded) in
  let behind =
    match style.background with
    | Some background ->
        Color.blend ~over:page background
    | None ->
        page
  in
  let styled =
    Printf.sprintf "\\textcolor[HTML]{%s}{%s}"
      (hex (Color.blend ~over:behind style.foreground))
      styled
  in
  let boxed =
    if Color.equal behind page then
      styled
    else
      Printf.sprintf "{\\setlength{\\fboxsep}{0pt}\\colorbox[HTML]{%s}{%s}}"
        (hex behind) styled
  in
  (boxed, column)

let render_line ~page line =
  let _, parts =
    List.fold_left
      (fun (column, parts) (token : Token.t) ->
        let part, column =
          render_token ~page ~column (Token.style token) token.text
        in
        (column, part :: parts)
      )
      (0, []) line
  in
  String.concat "" (List.rev parts)

let render (theme : Theme.theme) lines =
  let page = Color.opaque theme.bg in
  let code_content =
    String.concat "\\\\\n" (List.map (render_line ~page) lines)
  in
  Printf.sprintf "\\begin{ochrehighlight}{%s}{%s}\n%s\n\\end{ochrehighlight}"
    (hex page) (hex theme.fg) code_content
