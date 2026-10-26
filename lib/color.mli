type rgb = int * int * int

val parse_rgba : string -> (rgb * float) option
(** [parse_rgba s] reads [#rgb], [#rgba], [#rrggbb] or [#rrggbbaa] (the [#] is
    optional) and returns the colour with its alpha in [0.] to [1.]. Other forms
    give [None]. *)

val parse_hex_color : string -> rgb option
(** Like {!parse_rgba}, without the alpha. *)

val blend : over:rgb -> rgb -> float -> rgb
(** [blend ~over colour alpha] is [colour] at opacity [alpha] on top of [over],
    for outputs that have no alpha channel. *)

val resolve : over:rgb -> string -> rgb option
(** [resolve ~over s] is the opaque colour of [s] drawn over [over]. *)

val page_background : string -> rgb
(** The theme background as RGB; black when it is not a hex colour. *)

val luminance : rgb -> float
val contrast_fallback_fg : rgb -> rgb

val effective_background_rgb : string -> Token.styled_token -> rgb
(** The opaque background behind a token: its own background blended over the
    theme background, or the theme background. *)
