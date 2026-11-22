type position = { offset : int; line : int; column : int; length : int }

type decoration_properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type styles

type t = {
  text : string;
  position : position;
  scopes : string list;
  styles : styles;
  decoration : decoration_properties option;
}

type line = t list

val make_styles : Theme.theme array -> Style.t array -> styles
val style : t -> Style.t
val style_at : int -> t -> Style.t
val style_count : t -> int
val all_styles : t -> Style.t list
val reorder_styles : int array -> t -> t
val map_style : (Theme.theme -> Style.t -> Style.t) -> t -> t
val slice : t -> pos:int -> len:int -> t
val sub : t -> pos:int -> len:int -> t option
val insert_before : t -> string -> t
val insert_after : t -> string -> t
