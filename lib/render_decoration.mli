(** Shared escaping for decoration-supplied strings, used by both the HTML and
    SVG renderers.

    A decoration's [class_], [style], and [data] values come from the caller of
    {!Decoration.make}, not from the tokenized source text, so they are not
    guaranteed safe to interpolate into a markup attribute. *)

type escaped = {
  class_ : string option;  (** [class_], HTML/XML-attribute-escaped. *)
  style : string option;  (** [style], HTML/XML-attribute-escaped. *)
  data : (string * string) list;
      (** [(key, escaped_value)] pairs. Keys are not escaped: {!Decoration.make}
          already rejects keys that are not safe to use in a [data-*] attribute
          name. *)
}

val escape : Token.decoration_properties -> escaped
(** Escape the caller-supplied strings in a decoration's properties. *)
