(** ANSI terminal renderer for highlighted code.

    Produces text with embedded 24-bit ANSI color escape sequences, suitable for
    direct terminal output. *)

val render : Theme.theme -> Token.highlighted_code -> string
(** Render highlighted code to an ANSI-escaped string.

    Uses true-color (24-bit) escape sequences for foreground and background
    colors, with proper reset codes between tokens. *)
