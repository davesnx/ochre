(** TextMate grammar loading and caching. *)

(** Grammar loader state: holds the TextMate collection, loaded grammars,
    and search paths. *)
type t = {
  tm_collection : TmLanguage.t;
  mutable grammars : (string * TmLanguage.grammar) list;
  grammar_paths : string list;
}

(** Create a grammar loader with the given search paths. *)
val create : ?grammar_paths:string list -> unit -> t

(** Load a grammar by language identifier, searching configured paths.

    Returns a cached grammar if already loaded. Searches each path for
    [<lang>.tmLanguage.json], [<lang>.json], and [<lang>] in order.

    @raise Failure if no grammar file is found. *)
val load_grammar : t -> string -> TmLanguage.grammar

(** Return a new loader with an additional search path prepended. *)
val add_grammar_path : t -> string -> t
