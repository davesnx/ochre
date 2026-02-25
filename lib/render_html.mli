(** HTML renderer for highlighted code.

    Produces a self-contained [<pre><code>...</code></pre>] block with inline
    CSS styles for colors and font styles. *)

val render : Theme.theme -> Token.highlighted_code -> string
(** Render highlighted code to an HTML string.

    The output includes the theme's default foreground and background colors on
    the [<pre>] element, and per-token inline styles on [<span>] elements. *)
