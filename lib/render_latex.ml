open Token

let escape_latex str =
  let buf = Buffer.create (String.length str * 2) in
  String.iter
    (function
      | ' ' ->
          Buffer.add_string buf "\\ "
      | '\n' ->
          ()
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

let nibble_of_hex = function
  | '0' .. '9' as c ->
      Some (Char.code c - Char.code '0')
  | 'a' .. 'f' as c ->
      Some (10 + Char.code c - Char.code 'a')
  | 'A' .. 'F' as c ->
      Some (10 + Char.code c - Char.code 'A')
  | _ ->
      None

let parse_hex_byte s i =
  if i + 1 >= String.length s then
    None
  else
    match (nibble_of_hex s.[i], nibble_of_hex s.[i + 1]) with
    | Some hi, Some lo ->
        Some ((hi lsl 4) lor lo)
    | _ ->
        None

let parse_hex_color color =
  let hex =
    if String.starts_with ~prefix:"#" color then
      String.sub color 1 (String.length color - 1)
    else
      color
  in
  match String.length hex with
  | 3 | 4 -> (
      match
        (nibble_of_hex hex.[0], nibble_of_hex hex.[1], nibble_of_hex hex.[2])
      with
      | Some r, Some g, Some b ->
          Some ((r lsl 4) lor r, (g lsl 4) lor g, (b lsl 4) lor b)
      | _ ->
          None
    )
  | 6 | 8 -> (
      match
        (parse_hex_byte hex 0, parse_hex_byte hex 2, parse_hex_byte hex 4)
      with
      | Some r, Some g, Some b ->
          Some (r, g, b)
      | _ ->
          None
    )
  | _ ->
      None

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

let luminance (r, g, b) =
  ((0.2126 *. float_of_int r)
  +. (0.7152 *. float_of_int g)
  +. (0.0722 *. float_of_int b)
  )
  /. 255.

let contrast_fallback_fg bg_rgb =
  if luminance bg_rgb >= 0.5 then
    (0, 0, 0)
  else
    (255, 255, 255)

let effective_background_rgb theme_bg token =
  match token.Token.background with
  | Some color -> (
      match parse_hex_color color with
      | Some rgb ->
          rgb
      | None -> (
          match parse_hex_color theme_bg with
          | Some rgb ->
              rgb
          | None ->
              (0, 0, 0)
        )
    )
  | None -> (
      match parse_hex_color theme_bg with Some rgb -> rgb | None -> (0, 0, 0)
    )

let render_token ~theme_bg (token : styled_token) =
  let text = escape_latex token.text in
  let styled = wrap_font_styles token.font_style text in
  match token.foreground with
  | Some color ->
      let rgb =
        match parse_hex_color color with
        | Some rgb ->
            rgb
        | None ->
            contrast_fallback_fg (effective_background_rgb theme_bg token)
      in
      Printf.sprintf "\\textcolor[HTML]{%s}{%s}" (hex_of_rgb rgb) styled
  | None ->
      styled

let render_line ~theme_bg line =
  String.concat "" (List.map (render_token ~theme_bg) line)

let render theme (code : highlighted_code) =
  let lines = List.map (render_line ~theme_bg:theme.Theme.bg) code in
  let code_content = String.concat "\\\\\n" lines in
  let bg_rgb =
    match parse_hex_color theme.Theme.bg with
    | Some rgb ->
        rgb
    | None ->
        (0, 0, 0)
  in
  let fg_rgb =
    match parse_hex_color theme.Theme.fg with
    | Some rgb ->
        rgb
    | None ->
        contrast_fallback_fg bg_rgb
  in
  Printf.sprintf "\\begin{ochrehighlight}{%s}{%s}\n%s\n\\end{ochrehighlight}"
    (hex_of_rgb bg_rgb) (hex_of_rgb fg_rgb) code_content
