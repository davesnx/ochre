let reset = "\x1b[0m"
let bold = "\x1b[1m"
let italic = "\x1b[3m"
let underline = "\x1b[4m"
let strikethrough = "\x1b[9m"

let foreground_color_ansi (c : Color.t) =
  Printf.sprintf "\x1b[38;2;%d;%d;%dm" c.r c.g c.b

let background_color_ansi (c : Color.t) =
  Printf.sprintf "\x1b[48;2;%d;%d;%dm" c.r c.g c.b

let font_style_codes (style : Style.font_style) =
  List.filter_map
    (fun (on, code) ->
      if on then
        Some code
      else
        None
    )
    [
      (style.bold, bold);
      (style.italic, italic);
      (style.underline, underline);
      (style.strikethrough, strikethrough);
    ]

let replacement = "\xEF\xBF\xBD"

let neutralise ?(cr_before_lf = false) text =
  let length = String.length text in
  let buf = Buffer.create length in
  let rec loop i =
    if i < length then
      let c = String.unsafe_get text i in
      match c with
      | '\t' | '\n' ->
          Buffer.add_char buf c;
          loop (i + 1)
      | '\r'
        when (i + 1 < length && text.[i + 1] = '\n')
             || (i + 1 = length && cr_before_lf) ->
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

let render_token ?cr_before_lf ~(theme : Theme.theme) (style : Style.t) text =
  let page = Color.opaque theme.bg in
  let background =
    Option.bind style.background (fun (color : Color.t) ->
        if color.a = 0 then
          None
        else
          Some (Color.blend ~over:page color)
    )
  in
  let behind = Option.value background ~default:page in
  let codes =
    font_style_codes style.font_style
    @ Option.to_list (Option.map background_color_ansi background)
    @ [ foreground_color_ansi (Color.blend ~over:behind style.foreground) ]
  in
  String.concat "" codes ^ neutralise ?cr_before_lf text ^ reset

let render_line ~theme (line : Token.line) =
  let rec next_starts_with_lf = function
    | [] ->
        false
    | (token : Token.t) :: rest ->
        if token.text = "" then
          next_starts_with_lf rest
        else
          token.text.[0] = '\n'
  in
  let rec render = function
    | [] ->
        []
    | (token : Token.t) :: rest ->
        let cr_before_lf = next_starts_with_lf rest in
        render_token ~cr_before_lf ~theme (Token.style token) token.text
        :: render rest
  in
  String.concat "" (render line)

let render theme lines = String.concat "" (List.map (render_line ~theme) lines)
