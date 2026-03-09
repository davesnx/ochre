let hex_to_rgb hex =
  let hex =
    if String.starts_with ~prefix:"#" hex then
      String.sub hex 1 (String.length hex - 1)
    else
      hex
  in
  let len = String.length hex in
  if len = 6 then
    let r = int_of_string ("0x" ^ String.sub hex 0 2) in
    let g = int_of_string ("0x" ^ String.sub hex 2 2) in
    let b = int_of_string ("0x" ^ String.sub hex 4 2) in
    (r, g, b)
  else if len = 3 then
    let r =
      int_of_string ("0x" ^ String.make 1 hex.[0] ^ String.make 1 hex.[0])
    in
    let g =
      int_of_string ("0x" ^ String.make 1 hex.[1] ^ String.make 1 hex.[1])
    in
    let b =
      int_of_string ("0x" ^ String.make 1 hex.[2] ^ String.make 1 hex.[2])
    in
    (r, g, b)
  else
    (0, 0, 0)

let reset = "\x1b[0m"
let bold = "\x1b[1m"
let italic = "\x1b[3m"
let underline = "\x1b[4m"
let strikethrough = "\x1b[9m"

let foreground_color_ansi hex =
  let r, g, b = hex_to_rgb hex in
  Printf.sprintf "\x1b[38;2;%d;%d;%dm" r g b

let background_color_ansi hex =
  let r, g, b = hex_to_rgb hex in
  Printf.sprintf "\x1b[48;2;%d;%d;%dm" r g b

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

let render_token (token : Token.styled_token) =
  let codes = [] in
  let codes =
    match token.foreground with
    | Some color ->
        foreground_color_ansi color :: codes
    | None ->
        codes
  in
  let codes =
    match token.background with
    | Some color ->
        background_color_ansi color :: codes
    | None ->
        codes
  in
  let codes = List.map font_style_to_ansi token.font_style @ codes in
  if codes = [] then
    token.text
  else
    String.concat "" codes ^ token.text ^ reset

let render_line (line : Token.line) =
  String.concat "" (List.map render_token line)

let render (_theme : Theme.theme) (code : Token.highlighted_code) =
  let lines = List.map render_line code in
  String.concat "\n" lines
