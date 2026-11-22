let font_size = 14.0
let line_height = 1.3
let char_width = 0.6
let padding = 10.0

let font_family =
  "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, \
   Courier New, monospace"

let font_style_attrs (style : Style.font_style) =
  let decoration =
    match (style.underline, style.strikethrough) with
    | true, true ->
        Some "underline line-through"
    | true, false ->
        Some "underline"
    | false, true ->
        Some "line-through"
    | false, false ->
        None
  in
  List.filter_map Fun.id
    [
      Option.map (Printf.sprintf "text-decoration=\"%s\"") decoration;
      ( if style.italic then
          Some "font-style=\"italic\""
        else
          None
      );
      ( if style.bold then
          Some "font-weight=\"bold\""
        else
          None
      );
    ]

let render_token (token : Token.t) =
  let style = Token.style token in
  let text = Escape.to_string Escape.xml token.text in
  let attrs =
    font_style_attrs style.font_style
    @ [ Printf.sprintf "fill=\"%s\"" (Color.to_hex style.foreground) ]
  in
  let attrs =
    match token.decoration with
    | None ->
        attrs
    | Some dec ->
        let esc = Render_decoration.escape_xml dec in
        Option.to_list (Option.map (Printf.sprintf "style=\"%s\"") esc.style)
        @ Option.to_list (Option.map (Printf.sprintf "class=\"%s\"") esc.class_)
        @ attrs
  in
  Printf.sprintf "<tspan %s>%s</tspan>" (String.concat " " attrs) text

let strip_trailing_newline line =
  match List.rev line with
  | [] ->
      []
  | (last : Token.t) :: rest ->
      let len = String.length last.text in
      if len > 0 && last.text.[len - 1] = '\n' then
        let text = String.sub last.text 0 (len - 1) in
        if text = "" then
          List.rev rest
        else
          List.rev ({ last with text } :: rest)
      else
        line

type placed = { token : Token.t; column : int; cells : int }

let place_line line =
  let rec go column = function
    | [] ->
        ([], column)
    | (token : Token.t) :: rest ->
        let text, next = Render_cells.expand_tabs ~column token.text in
        let placed =
          { token = { token with text }; column; cells = next - column }
        in
        let others, last = go next rest in
        (placed :: others, last)
  in
  go 0 line

let cell_width = font_size *. char_width

let render_background ~page ~row_top { token; column; cells } =
  match (Token.style token).background with
  | Some (color : Color.t)
    when color.a > 0 && cells > 0 && not (Color.equal (Color.opaque color) page)
    ->
      let opacity =
        if color.a = 255 then
          ""
        else
          Printf.sprintf " fill-opacity=\"%.3g\"" (float_of_int color.a /. 255.)
      in
      Some
        (Printf.sprintf
           "  <rect x=\"%.1f\" y=\"%.1f\" width=\"%.1f\" height=\"%.1f\" \
            fill=\"%s\"%s/>"
           (padding +. (float_of_int column *. cell_width))
           row_top
           (float_of_int cells *. cell_width)
           (font_size *. line_height)
           (Color.to_hex (Color.opaque color))
           opacity
        )
  | _ ->
      None

let render_text ~y ~fill placed =
  let tokens =
    String.concat "" (List.map (fun p -> render_token p.token) placed)
  in
  Printf.sprintf
    "  <text x=\"%.0f\" y=\"%.1f\" font-family=\"%s\" font-size=\"%.0fpx\"%s \
     xml:space=\"preserve\">%s</text>"
    padding y font_family font_size fill tokens

let render (theme : Theme.theme) code =
  let code = List.map strip_trailing_newline code in
  let row_height = font_size *. line_height in
  let num_lines = List.length code in
  let placed = List.map place_line code in
  let max_cells =
    List.fold_left (fun acc (_, cells) -> max acc cells) 0 placed
  in
  let width = (float_of_int max_cells *. cell_width) +. (padding *. 2.0) in
  let height = (float_of_int num_lines *. row_height) +. (padding *. 2.0) in
  let row_top i = padding +. (float_of_int i *. row_height) in
  let page = Color.opaque theme.bg in
  let backgrounds =
    List.concat
      (List.mapi
         (fun i (line, _) ->
           List.filter_map (render_background ~page ~row_top:(row_top i)) line
         )
         placed
      )
  in
  let fill = Printf.sprintf " fill=\"%s\"" (Color.to_hex theme.fg) in
  let texts =
    List.mapi
      (fun i (line, _) -> render_text ~y:(row_top i +. font_size) ~fill line)
      placed
  in
  let body = String.concat "\n" (backgrounds @ texts) in
  let background = Color.to_hex theme.bg in
  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%.0f\" height=\"%.0f\" \
     font-family=\"%s\" font-size=\"%.0fpx\">\n\
    \ <rect width=\"100%%\" height=\"100%%\" fill=\"%s\"/>\n\
     %s\n\
     </svg>"
    width height font_family font_size background body
