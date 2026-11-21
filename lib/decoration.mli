type position = { line : int; character : int }

type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type t = { start : position; end_ : position; properties : properties }

val pos : int -> int -> position

val make :
  ?class_:string ->
  ?style:string ->
  ?data:(string * string) list ->
  start:position ->
  end_:position ->
  unit ->
  t

val apply :
  source:string -> t list -> Token.highlighted_code -> Token.highlighted_code
