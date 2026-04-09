type rgb = int * int * int

val parse_hex_color : string -> rgb option
val luminance : rgb -> float
val contrast_fallback_fg : rgb -> rgb
val effective_background_rgb : string -> Token.styled_token -> rgb
