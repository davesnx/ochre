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

let replacement = "\xEF\xBF\xBD"

let neutralise text =
  let length = String.length text in
  let buf = Buffer.create length in
  let rec loop i =
    if i < length then
      let c = String.unsafe_get text i in
      match c with
      | '\t' | '\n' ->
          Buffer.add_char buf c;
          loop (i + 1)
      | '\r' when i + 1 < length && text.[i + 1] = '\n' ->
          Buffer.add_char buf c;
          loop (i + 1)
      | '\000' .. '\031' | '\127' ->
          Buffer.add_char buf '^';
          Buffer.add_char buf (Char.chr (Char.code c lxor 0x40));
          loop (i + 1)
      | '\128' .. '\255' ->
          let d = String.get_utf_8_uchar text i in
          let n = Uchar.utf_decode_length d in
          let code = Uchar.to_int (Uchar.utf_decode_uchar d) in
          if Uchar.utf_decode_is_valid d && not (code >= 0x80 && code <= 0x9F)
          then
            Buffer.add_substring buf text i n
          else
            Buffer.add_string buf replacement;
          loop (i + n)
      | _ ->
          Buffer.add_char buf c;
          loop (i + 1)
  in
  loop 0;
  Buffer.contents buf

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
  let text = neutralise token.text in
  if codes = [] then
    text
  else
    String.concat "" codes ^ text ^ reset

let render_line ~theme_bg (line : Token.line) =
  String.concat "" (List.map (render_token ~theme_bg) line)

let render (theme : Theme.theme) (code : Token.highlighted_code) =
  let lines = List.map (render_line ~theme_bg:theme.bg) code in
  String.concat "" lines
