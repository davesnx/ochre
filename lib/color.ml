type t = { r : int; g : int; b : int; a : int }

let clip x = max 0 (min 255 x)
let rgba r g b a = { r = clip r; g = clip g; b = clip b; a = clip a }
let rgb r g b = rgba r g b 255

let nibble = function
  | '0' .. '9' as c ->
      Some (Char.code c - Char.code '0')
  | 'a' .. 'f' as c ->
      Some (10 + Char.code c - Char.code 'a')
  | 'A' .. 'F' as c ->
      Some (10 + Char.code c - Char.code 'A')
  | _ ->
      None

let of_hex s =
  let count = String.length s - 1 in
  let rec digits i acc =
    if i > count then
      Some (Array.of_list (List.rev acc))
    else
      match nibble s.[i] with
      | Some digit ->
          digits (i + 1) (digit :: acc)
      | None ->
          None
  in
  if count < 0 || s.[0] <> '#' || not (List.mem count [ 3; 4; 6; 8 ]) then
    None
  else
    Option.map
      (fun v ->
        let short i = (v.(i) lsl 4) lor v.(i) in
        let long i = (v.(2 * i) lsl 4) lor v.((2 * i) + 1) in
        match count with
        | 3 ->
            rgb (short 0) (short 1) (short 2)
        | 4 ->
            rgba (short 0) (short 1) (short 2) (short 3)
        | 6 ->
            rgb (long 0) (long 1) (long 2)
        | _ ->
            rgba (long 0) (long 1) (long 2) (long 3)
      )
      (digits 1 [])

let to_hex { r; g; b; a } =
  if a = 255 then
    Printf.sprintf "#%02x%02x%02x" r g b
  else
    Printf.sprintf "#%02x%02x%02x%02x" r g b a

let srgb_byte linear =
  let x = Float.min 1. (Float.max 0. linear) in
  let encoded =
    if x <= 0.0031308 then
      12.92 *. x
    else
      (1.055 *. Float.pow x (1. /. 2.4)) -. 0.055
  in
  int_of_float (Float.round (encoded *. 255.))

let oklch l c h =
  let radians = h *. Float.pi /. 180. in
  let a = c *. Float.cos radians and b = c *. Float.sin radians in
  let cube x = x *. x *. x in
  let l' = cube (l +. (0.3963377774 *. a) +. (0.2158037573 *. b)) in
  let m' = cube (l -. (0.1055613458 *. a) -. (0.0638541728 *. b)) in
  let s' = cube (l -. (0.0894841775 *. a) -. (1.2914855480 *. b)) in
  rgb
    (srgb_byte
       ((4.0767416621 *. l') -. (3.3077115913 *. m') +. (0.2309699292 *. s'))
    )
    (srgb_byte
       ((-1.2684380046 *. l') +. (2.6097574011 *. m') -. (0.3413193965 *. s'))
    )
    (srgb_byte
       ((-0.0041960863 *. l') -. (0.7034186147 *. m') +. (1.7076147010 *. s'))
    )

let equal = ( = )

let blend ~over top =
  let alpha = float_of_int top.a /. 255. in
  let mix a b =
    int_of_float
      (Float.round
         ((float_of_int a *. alpha) +. (float_of_int b *. (1. -. alpha)))
      )
  in
  rgb (mix top.r over.r) (mix top.g over.g) (mix top.b over.b)

let opaque color = { color with a = 255 }
