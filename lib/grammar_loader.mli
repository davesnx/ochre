type t

val load : (string * string) list -> (t, string) result
val load_exn : (string * string) list -> t
val load_from_files : string list -> (t, string) result
val load_from_files_exn : string list -> t
val find_grammar : t -> string -> TmLanguage.grammar
val tm_collection : t -> TmLanguage.t
