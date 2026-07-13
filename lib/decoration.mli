(** Decorations for attaching properties to source-code ranges.

    Decorations target ranges of source code by line/character position and
    attach format-agnostic properties (CSS class, inline style, data
    attributes). The {!apply} function maps these ranges onto tokens, splitting
    tokens at decoration boundaries when necessary. *)

type position = { line : int; character : int }
(** {2 position}

    0-indexed position in source code. [character] counts Unicode scalar values,
    not UTF-8 bytes.

    Negative [character] values count Unicode scalar values from the end of the
    line: [-1] means the line end (after the last scalar), [-2] means one scalar
    before the end, etc. *)

type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}
(** {2 properties}

    Properties to attach to a decorated range.

    - [class_] maps to an HTML [class] attribute (or equivalent in other
      formats).
    - [style] maps to an inline [style] attribute.
    - [data] maps to [data-*] attributes in HTML; ignored in other formats. *)

type t = { start : position; end_ : position; properties : properties }
(** {2 t}

    A decoration targeting a range from [start] (inclusive) to [end_]
    (exclusive). *)

val pos : int -> int -> position
(** {2 pos}

    [pos line character] creates a position. Shorthand for [{line; character}].
*)

val make :
  ?class_:string ->
  ?style:string ->
  ?data:(string * string) list ->
  start:position ->
  end_:position ->
  unit ->
  t
(** {2 make}

    Create a decoration with the given properties and range.

    {[
    let d =
      Decoration.make ~class_:"highlighted" ~start:(Decoration.pos 0 0)
        ~end_:(Decoration.pos 0 11) ()
    ]} *)

val apply :
  source:string -> t list -> Token.highlighted_code -> Token.highlighted_code
(** {2 apply}

    [apply ~source decorations tokens] maps decoration ranges onto tokens.

    Tokens that partially overlap a decoration are split so the decoration wraps
    exactly the targeted characters. When multiple decorations overlap, their
    properties are merged: classes are space-concatenated, styles are
    semicolon-concatenated, and data attributes are merged (later decorations
    override earlier ones for duplicate keys).

    Character positions, including negative positions, are resolved in Unicode
    scalar values. Token offsets and splitting remain UTF-8 byte-based.

    Raises [Invalid_argument] if [source] is not valid UTF-8.

    For valid UTF-8 source, an empty decoration list returns the tokens
    unchanged.

    {[
      let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
      let decorated =
        Decoration.apply ~source:code
          [ Decoration.make ~class_:"hl"
              ~start:(Decoration.pos 0 0)
              ~end_:(Decoration.pos 0 3) () ]
          tokens
    ]} *)
