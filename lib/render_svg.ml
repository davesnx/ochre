open Token

let font_size = 14.0
let line_height = 1.3
let char_width = 0.6
let padding = 10.0

let font_family =
  "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, \
   Courier New, monospace"

let font_style_attrs styles =
  let attrs = [] in
  let attrs =
    if List.mem Bold styles then
      "font-weight=\"bold\"" :: attrs
    else
      attrs
  in
  let attrs =
    if List.mem Italic styles then
      "font-style=\"italic\"" :: attrs
    else
      attrs
  in
  let has_underline = List.mem Underline styles in
  let has_strike = List.mem Strikethrough styles in
  let attrs =
    match (has_underline, has_strike) with
    | true, true ->
        "text-decoration=\"underline line-through\"" :: attrs
    | true, false ->
        "text-decoration=\"underline\"" :: attrs
    | false, true ->
        "text-decoration=\"line-through\"" :: attrs
    | false, false ->
        attrs
  in
  attrs

let render_token (token : styled_token) =
  let text = Escape.to_string Escape.xml token.text in
  let attrs = [] in
  let attrs =
    match Option.bind token.foreground Escape.css_color with
    | Some color ->
        Printf.sprintf "fill=\"%s\"" color :: attrs
    | None ->
        attrs
  in
  let attrs = font_style_attrs token.font_style @ attrs in
  let attrs =
    match token.decoration with
    | None ->
        attrs
    | Some dec -> (
        let esc = Render_decoration.escape_xml dec in
        let attrs =
          match esc.class_ with
          | Some c ->
              Printf.sprintf "class=\"%s\"" c :: attrs
          | None ->
              attrs
        in
        match esc.style with
        | Some s ->
            Printf.sprintf "style=\"%s\"" s :: attrs
        | None ->
            attrs
      )
  in
  if attrs = [] then
    text
  else
    Printf.sprintf "<tspan %s>%s</tspan>" (String.concat " " attrs) text

(* Each source line keeps its trailing '\n' as the last character of its last
   token (see [Ochre.split_lines]). SVG already positions each line with its
   own [y], so that newline is neither needed nor visible; keeping it would
   both inflate the computed width and leave a literal newline inside a
   [tspan]. Drop it, the way [render_latex]'s escaper drops embedded '\n'. *)
let strip_trailing_newline line =
  match List.rev line with
  | [] ->
      []
  | (last : styled_token) :: rest ->
      let len = String.length last.text in
      if len > 0 && last.text.[len - 1] = '\n' then
        let text = String.sub last.text 0 (len - 1) in
        if text = "" then
          List.rev rest
        else
          List.rev ({ last with text } :: rest)
      else
        line

type placed = { token : styled_token; column : int; cells : int }

let place_line line =
  let rec go column = function
    | [] ->
        ([], column)
    | (token : styled_token) :: rest ->
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
  match token.background with
  | None ->
      None
  | Some color -> (
      let fill =
        match Color.parse_rgba color with
        | Some (rgb, alpha) when alpha = 0. || rgb = page ->
            None
        | Some ((r, g, b), alpha) ->
            let opacity =
              if alpha >= 1. then
                ""
              else
                Printf.sprintf " fill-opacity=\"%.3g\"" alpha
            in
            Some (Printf.sprintf "fill=\"#%02X%02X%02X\"%s" r g b opacity)
        | None ->
            Option.map (Printf.sprintf "fill=\"%s\"") (Escape.css_color color)
      in
      match fill with
      | Some fill when cells > 0 ->
          Some
            (Printf.sprintf
               "  <rect x=\"%.1f\" y=\"%.1f\" width=\"%.1f\" height=\"%.1f\" \
                %s/>"
               (padding +. (float_of_int column *. cell_width))
               row_top
               (float_of_int cells *. cell_width)
               (font_size *. line_height) fill
            )
      | _ ->
          None
    )

let render_text ~y ~fill placed =
  let tokens =
    String.concat "" (List.map (fun p -> render_token p.token) placed)
  in
  Printf.sprintf
    "  <text x=\"%.0f\" y=\"%.1f\" font-family=\"%s\" font-size=\"%.0fpx\"%s \
     xml:space=\"preserve\">%s</text>"
    padding y font_family font_size fill tokens

let render theme (code : highlighted_code) =
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
  let page = Color.page_background theme.Theme.bg in
  let backgrounds =
    List.concat
      (List.mapi
         (fun i (line, _) ->
           List.filter_map (render_background ~page ~row_top:(row_top i)) line
         )
         placed
      )
  in
  let fill =
    match Escape.css_color theme.Theme.fg with
    | Some color ->
        Printf.sprintf " fill=\"%s\"" color
    | None ->
        ""
  in
  let texts =
    List.mapi
      (fun i (line, _) -> render_text ~y:(row_top i +. font_size) ~fill line)
      placed
  in
  let body = String.concat "\n" (backgrounds @ texts) in
  let background =
    Option.value (Escape.css_color theme.Theme.bg) ~default:"none"
  in
  Printf.sprintf
    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"%.0f\" height=\"%.0f\" \
     font-family=\"%s\" font-size=\"%.0fpx\">\n\
    \ <rect width=\"100%%\" height=\"100%%\" fill=\"%s\"/>\n\
     %s\n\
     </svg>"
    width height font_family font_size background body
