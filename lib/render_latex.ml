open Token

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

let hex_of_rgb (r, g, b) = Printf.sprintf "%02X%02X%02X" r g b

let wrap_font_styles styles inner =
  List.fold_left
    (fun acc style ->
      match style with
      | Bold ->
          Printf.sprintf "\\textbf{%s}" acc
      | Italic ->
          Printf.sprintf "\\textit{%s}" acc
      | Underline ->
          Printf.sprintf "\\underline{%s}" acc
      | Strikethrough ->
          Printf.sprintf "\\sout{%s}" acc
    )
    inner styles

let color_box ~theme_bg (token : styled_token) styled =
  let page = Color.page_background theme_bg in
  match Option.bind token.background (Color.resolve ~over:page) with
  | Some rgb when rgb <> page ->
      Printf.sprintf "{\\setlength{\\fboxsep}{0pt}\\colorbox[HTML]{%s}{%s}}"
        (hex_of_rgb rgb) styled
  | _ ->
      styled

let render_token ~theme_bg ~column (token : styled_token) =
  let expanded, column = Render_cells.expand_tabs ~column token.text in
  let text = escape_latex expanded in
  let styled = wrap_font_styles token.font_style text in
  let styled =
    match token.foreground with
    | Some color ->
        let behind = Color.effective_background_rgb theme_bg token in
        let rgb =
          match Color.resolve ~over:behind color with
          | Some rgb ->
              rgb
          | None ->
              Color.contrast_fallback_fg behind
        in
        Printf.sprintf "\\textcolor[HTML]{%s}{%s}" (hex_of_rgb rgb) styled
    | None ->
        styled
  in
  (color_box ~theme_bg token styled, column)

let render_line ~theme_bg line =
  let _, parts =
    List.fold_left
      (fun (column, parts) token ->
        let part, column = render_token ~theme_bg ~column token in
        (column, part :: parts)
      )
      (0, []) line
  in
  String.concat "" (List.rev parts)

let render theme (code : highlighted_code) =
  let lines = List.map (render_line ~theme_bg:theme.Theme.bg) code in
  let code_content = String.concat "\\\\\n" lines in
  let bg_rgb =
    match Color.parse_hex_color theme.Theme.bg with
    | Some rgb ->
        rgb
    | None ->
        (0, 0, 0)
  in
  let fg_rgb =
    match Color.parse_hex_color theme.Theme.fg with
    | Some rgb ->
        rgb
    | None ->
        Color.contrast_fallback_fg bg_rgb
  in
  Printf.sprintf "\\begin{ochrehighlight}{%s}{%s}\n%s\n\\end{ochrehighlight}"
    (hex_of_rgb bg_rgb) (hex_of_rgb fg_rgb) code_content
