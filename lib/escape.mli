(** Escaping of strings for the contexts they are written into.

    Every string that comes from a source file, a theme, an option or a label
    must go through the function for its context before it is written to HTML,
    SVG or CSS. *)

val html : Buffer.t -> string -> unit
(** [html buf s] appends [s] to [buf], escaped for HTML text and for double- or
    single-quoted HTML attribute values: the five characters ampersand,
    less-than, greater-than, apostrophe and quotation mark become entities.
    Bytes that are not valid UTF-8 and NUL become U+FFFD. Other control
    characters are kept. *)

val xml : Buffer.t -> string -> unit
(** [xml buf s] is like {!html}, and also replaces every character that XML 1.0
    forbids, even as a character reference, by U+FFFD: C0 controls other than
    tab, line feed and carriage return, U+FFFE and U+FFFF. Carriage return is
    written as [&#13;] so that an XML parser does not turn it into a line feed.
    The result is always valid XML character data and attribute-value content.
*)

val xml_attr : Buffer.t -> string -> unit
(** [xml_attr buf s] is like {!xml}, for XML attribute values: tab and line feed
    are written as [&#9;] and [&#10;], because an XML parser would normalise
    them to spaces. *)

val to_string : (Buffer.t -> string -> unit) -> string -> string
(** [to_string html s] is [s] escaped to a new string. *)

val css_ident : string -> string
(** [css_ident s] replaces every byte of [s] outside [A-Za-z0-9_-] by ['_']. The
    result is safe inside a CSS class name, a custom-property name and an HTML
    attribute. The function is idempotent. *)

val css_color : string -> string option
(** [css_color s] is [Some s] when [s] is a plain CSS colour: [#rgb], [#rgba],
    [#rrggbb], [#rrggbbaa], a keyword made of letters, or one of the functions
    [rgb rgba hsl hsla hwb lab lch oklab oklch] with arguments made of digits,
    letters and [. , % / + -] and spaces. Otherwise [None]. A [Some] value
    cannot end a CSS declaration, a string or an HTML attribute. *)
