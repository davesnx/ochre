type rgb = int * int * int

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

let parse_rgba color =
  let hex =
    if String.starts_with ~prefix:"#" color then
      String.sub color 1 (String.length color - 1)
    else
      color
  in
  let nibble i = nibble_of_hex hex.[i] in
  let short i =
    match nibble i with Some n -> Some ((n lsl 4) lor n) | None -> None
  in
  let channels =
    match String.length hex with
    | 3 ->
        (short 0, short 1, short 2, Some 255)
    | 4 ->
        (short 0, short 1, short 2, short 3)
    | 6 ->
        ( parse_hex_byte hex 0,
          parse_hex_byte hex 2,
          parse_hex_byte hex 4,
          Some 255
        )
    | 8 ->
        ( parse_hex_byte hex 0,
          parse_hex_byte hex 2,
          parse_hex_byte hex 4,
          parse_hex_byte hex 6
        )
    | _ ->
        (None, None, None, None)
  in
  match channels with
  | Some r, Some g, Some b, Some a ->
      Some ((r, g, b), float_of_int a /. 255.)
  | _ ->
      None

let parse_hex_color color = Option.map fst (parse_rgba color)

let blend ~over:(or_, og, ob) (r, g, b) alpha =
  let mix top below =
    int_of_float
      (Float.round
         ((float_of_int top *. alpha) +. (float_of_int below *. (1. -. alpha)))
      )
  in
  (mix r or_, mix g og, mix b ob)

let resolve ~over color =
  Option.map (fun (rgb, alpha) -> blend ~over rgb alpha) (parse_rgba color)

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

let black = (0, 0, 0)

let page_background theme_bg =
  match parse_hex_color theme_bg with Some rgb -> rgb | None -> black

let effective_background_rgb theme_bg token =
  let page = page_background theme_bg in
  match Option.bind token.Token.background (resolve ~over:page) with
  | Some rgb ->
      rgb
  | None ->
      page
