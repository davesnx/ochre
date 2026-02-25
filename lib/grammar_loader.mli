type t

val create : grammars:string list -> unit -> t

val find_grammar : t -> string -> TmLanguage.grammar

val tm_collection : t -> TmLanguage.t
