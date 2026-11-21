val html : Buffer.t -> string -> unit

val xml : Buffer.t -> string -> unit

val xml_attr : Buffer.t -> string -> unit

val to_string : (Buffer.t -> string -> unit) -> string -> string

val css_ident : string -> string

val css_color : string -> string option
