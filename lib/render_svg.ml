open Token

let font_size = 14.0
let line_height = 1.4
let char_width = 0.6
let padding = 10.0

let font_family =
  "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, \
   Courier New, monospace"

let line_char_count line =
  List.fold_left
    (fun acc (tok : styled_token) -> acc + String.length tok.text)
    0 line

let font_style_attrs styles =
  let attrs = [] in
  let attrs =
    if List.mem Bold styles then "font-weight=\"bold\"" :: attrs else attrs
  in
  let attrs =
    if List.mem Italic styles then "font-style=\"italic\"" :: attrs else attrs
  in
  let has_underline = List.mem Underline styles in
  let has_strike = List.mem Strikethrough styles in
  let attrs =
    match (has_underline, has_strike) with
    | true, true -> "text-decoration=\"underline line-through\"" :: attrs
    | true, false -> "text-decoration=\"underline\"" :: attrs
    | false, true -> "text-decoration=\"line-through\"" :: attrs
    | false, false -> attrs
  in
  attrs

let render_token (token : styled_token) =
  let buf = Buffer.create (String.length token.text) in
  Escape.html buf token.text;
  let text = Buffer.contents buf in
  let attrs = [] in
  let attrs =
    match token.foreground with
    | Some color -> Printf.sprintf "fill=\"%s\"" color :: attrs
    | None -> attrs
  in
  let attrs = font_style_attrs token.font_style @ attrs in
  if attrs = [] then text
  else Printf.sprintf "<tspan %s>%s</tspan>" (String.concat " " attrs) text

let render_line ~y line =
  let tokens = String.concat "" (List.map render_token line) in
  Printf.sprintf
    "  <text x=\"%.0f\" y=\"%.1f\" xml:space=\"preserve\">%s</text>" padding y
    tokens

let render theme (code : highlighted_code) =
  let row_height = font_size *. line_height in
  let num_lines = List.length code in
  let max_chars =
    List.fold_left (fun acc line -> max acc (line_char_count line)) 0 code
  in
  let width =
    (float_of_int max_chars *. font_size *. char_width) +. (padding *. 2.0)
  in
  let height = (float_of_int num_lines *. row_height) +. (padding *. 2.0) in
  let lines =
    List.mapi
      (fun i line ->
        let y = padding +. (float_of_int i *. row_height) +. font_size in
        render_line ~y line)
      code
  in
  let body = String.concat "\n" lines in
  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%.0f\" height=\"%.0f\" \
     font-family=\"%s\" font-size=\"%.0fpx\">\n\
    \ <rect width=\"100%%\" height=\"100%%\" fill=\"%s\"/>\n\
     %s\n\
     </svg>"
    width height font_family font_size theme.Theme.bg body
