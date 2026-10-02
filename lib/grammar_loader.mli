type t

(** Each [lang_id] must be unique within a single load. A duplicate id is an
    error: [load]/[load_from_files] return [Error], the [_exn] variants raise
    [Failure], naming the repeated id. *)

val load : (string * string) list -> (t, string) result
(** Returns [Error msg] when a grammar fails to parse or a [lang_id] is
    duplicated. *)

val load_exn : (string * string) list -> t
(** Like {!load} but raises [Failure] on failure. *)

val load_from_files : string list -> (t, string) result
(** Returns [Error msg] when a file cannot be read, a grammar fails to parse, or
    two files derive the same language id. *)

val load_from_files_exn : string list -> t
(** Like {!load_from_files} but raises [Failure] on failure. *)

val find_grammar : t -> string -> TmLanguage.grammar option
val tm_collection : t -> TmLanguage.t
