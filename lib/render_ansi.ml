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

let render_token ~theme_bg (token : Token.styled_token) =
  let codes = [] in
  let bg_rgb = effective_background_rgb theme_bg token in
  let codes =
    match token.foreground with
    | Some color -> (
        match parse_hex_color color with
        | Some rgb ->
            foreground_color_ansi rgb :: codes
        | None ->
            foreground_color_ansi (contrast_fallback_fg bg_rgb) :: codes
      )
    | None ->
        codes
  in
  let codes =
    match token.background with
    | Some color -> (
        match parse_hex_color color with
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
