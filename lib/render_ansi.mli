(** ANSI terminal renderer for highlighted code.

    Produces text with embedded 24-bit ANSI color escape sequences, suitable for
    direct terminal output. *)

val render : Theme.theme -> Token.highlighted_code -> string
(** Render highlighted code to an ANSI-escaped string.

    Uses true-color (24-bit) escape sequences for foreground and background
    colors, with proper reset codes between tokens.

    The source text is untrusted: a control character would move the cursor or
    rewrite the terminal. Before output, each character of the source text is
    neutralised:
    - tab and line feed are kept, and so is a carriage return that is directly
      followed by a line feed;
    - every other C0 control character and DEL (for example ESC) becomes caret
      notation, as [cat -v] shows it: ESC is [^\[], DEL is [^?];
    - each C1 control character (U+0080 to U+009F) and each byte that is not
      valid UTF-8 becomes U+FFFD.

    The escape sequences that the renderer emits itself are not affected. *)
