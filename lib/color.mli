type rgb = int * int * int

val parse_rgba : string -> (rgb * float) option

val parse_hex_color : string -> rgb option

val blend : over:rgb -> rgb -> float -> rgb

val resolve : over:rgb -> string -> rgb option

val page_background : string -> rgb

val luminance : rgb -> float
val contrast_fallback_fg : rgb -> rgb

val effective_background_rgb : string -> Token.styled_token -> rgb
