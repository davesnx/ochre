let reset = "\x1b[0m"
let bold = "\x1b[1m"
let italic = "\x1b[3m"
let underline = "\x1b[4m"
let strikethrough = "\x1b[9m"

let foreground_color_ansi (r, g, b) = Printf.sprintf "\x1b[38;2;%d;%d;%dm" r g b

let background_color_ansi (r, g, b) = Printf.sprintf "\x1b[48;2;%d;%d;%dm" r g b

let font_style_to_ansi v =
  match (v : Token.font_style) with
  | Bold ->
      bold
  | Italic ->
      italic
  | Underline ->
      underline
  | Strikethrough ->
      strikethrough

let render_token ~theme_bg (token : Token.styled_token) =
  let codes = [] in
  let bg_rgb = Color.effective_background_rgb theme_bg token in
  let codes =
    match token.foreground with
    | Some color -> (
        match Color.parse_hex_color color with
        | Some rgb ->
            foreground_color_ansi rgb :: codes
        | None ->
            foreground_color_ansi (Color.contrast_fallback_fg bg_rgb) :: codes
      )
    | None ->
        codes
  in
  let codes =
    match token.background with
    | Some color -> (
        match Color.parse_hex_color color with
        | Some rgb ->
            background_color_ansi rgb :: codes
        | None ->
            codes
      )
    | None ->
        codes
  in
  let codes = List.map font_style_to_ansi token.font_style @ codes in
  if codes = [] then
    token.text
  else
    String.concat "" codes ^ token.text ^ reset

let render_line ~theme_bg (line : Token.line) =
  String.concat "" (List.map (render_token ~theme_bg) line)

let render (theme : Theme.theme) (code : Token.highlighted_code) =
  let lines = List.map (render_line ~theme_bg:theme.bg) code in
  String.concat "\n" lines
