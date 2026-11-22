type t

val load : (string * string) list -> (t, Error.t) result
val load_from_files : string list -> (t, Error.t) result
val find_grammar : t -> string -> TmLanguage.grammar option
val tm_collection : t -> TmLanguage.t
