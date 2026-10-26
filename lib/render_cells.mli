(** Display columns of text, for the renderers that place text on a grid. *)

val tab_width : int

val scalar_width : int -> int
(** Cells taken by a Unicode scalar value: 0 for combining marks and zero-width
    characters, 2 for East Asian wide and fullwidth characters, 1 otherwise. *)

val expand_tabs : column:int -> string -> string * int
(** [expand_tabs ~column text] replaces each tab by spaces up to the next
    multiple of {!tab_width}, starting at [column]. It returns the new text and
    the column after it. A carriage return takes no cell and a byte that is not
    valid UTF-8 takes one. *)
