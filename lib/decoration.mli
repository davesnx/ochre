(** Decorations for attaching properties to source-code ranges.

    Decorations target ranges of source code by line/character position and
    attach format-agnostic properties (CSS class, inline style, data
    attributes). The {!apply} function maps these ranges onto tokens, splitting
    tokens at decoration boundaries when necessary. *)

type position = { line : int; character : int }
(** 0-indexed position in source code.

    Negative [character] values count from the end of the line: [-1] means the
    line end (after the last character), [-2] means one character before the
    end, etc. *)

type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}
(** Properties to attach to a decorated range.

    - [class_] maps to an HTML [class] attribute (or equivalent in other
      formats).
    - [style] maps to an inline [style] attribute.
    - [data] maps to [data-*] attributes in HTML; ignored in other formats. *)

type t = { start : position; end_ : position; properties : properties }
(** A decoration targeting a range from [start] (inclusive) to [end_]
    (exclusive). *)

val pos : int -> int -> position
(** [pos line character] creates a position. Shorthand for [{line; character}].
*)

val make :
  ?class_:string ->
  ?style:string ->
  ?data:(string * string) list ->
  start:position ->
  end_:position ->
  unit ->
  t
(** [make ?class_ ?style ?data ~start ~end_ ()] creates a decoration.

    {[
      let d =
        Decoration.make ~class_:"highlighted" ~start:(Decoration.pos 0 0)
          ~end_:(Decoration.pos 0 11) ()
    ]} *)

val apply :
  source:string -> t list -> Token.highlighted_code -> Token.highlighted_code
(** [apply ~source decorations tokens] maps decoration ranges onto tokens.

    For each decoration, the source range is resolved to token boundaries.
    Tokens that partially overlap a decoration are split so the decoration wraps
    exactly the targeted characters. When multiple decorations overlap, their
    properties are merged: classes are space-concatenated, styles are
    semicolon-concatenated, and data attributes are merged (later decorations
    override earlier ones for duplicate keys).

    Negative character positions are resolved relative to line lengths.

    An empty decoration list returns the tokens unchanged. *)
