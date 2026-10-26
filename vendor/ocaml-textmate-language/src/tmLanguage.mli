type t
(** The collection of TextMate grammars. *)

type grammar
(** A TextMate grammar. *)

exception Error of string [@ocaml.warn_on_literal_pattern]
(** The error message is purely informational and is not to be matched on. *)

type plist =
  [ `Bool of bool
  | `Data of string
  | `Date of float * float option
  | `Float of float
  | `Int of int
  | `String of string
  | `Array of plist list
  | `Dict of (string * plist) list ]
(** A plist document. This is the same type as [t] defined in the
    {{:https://opam.ocaml.org/packages/plist-xml/} [plist-xml]} package (as of
    version 0.3.0), but is reproduced here as not to depend on [plist-xml]. *)

type ezjsonm =
  [ `Null
  | `Bool of bool
  | `Float of float
  | `String of string
  | `A of ezjsonm list
  | `O of (string * ezjsonm) list ]
(** A JSON document. This is the same type as [value] defined in the
    {{:https://opam.ocaml.org/packages/ezjsonm/} [ezjsonm]} package (as of
    version 1.2.0), but is reproduced here as not to depend on [ezjsonm]. *)

type yojson =
  [ `Null
  | `Bool of bool
  | `Int of int
  | `Float of float
  | `String of string
  | `Assoc of (string * yojson) list
  | `List of yojson list ]
(** A JSON document. This is the same type as [Basic.t] defined in the
    {{:https://opam.ocaml.org/packages/yojson/} [yojson]} package (as of version
    1.7.0), but is reproduced here as not to depend on [yojson]. *)

val create : unit -> t
(** Creates an empty collection of grammars. *)

val add_grammar : t -> grammar -> unit
(** Adds a grammar to the collection. *)

val find_by_name : t -> string -> grammar option
(** Finds a grammar by its [name] attribute. Case-insensitive. *)

val find_by_scope_name : t -> string -> grammar option
(** Finds a grammar by its [scopeName] attribute. Case-sensitive. *)

val find_by_filetype : t -> string -> grammar option
(** Finds a grammar by matching one of the strings in its [fileTypes] attribute.
    Case-sensitive. *)

val of_plist_exn : plist -> grammar
(** Reads a TextMate grammar from a PLIST file. Raises {!exception:Error} if the
    plist does not represent a valid TextMate grammar, or if a regex in it does
    not compile. An [end] or [while] regex that uses back-references is built
    from the text its [begin] matched, so it cannot be checked here: see
    {!val:tokenize_exn}. *)

val of_ezjsonm_exn : ezjsonm -> grammar
(** Reads a TextMate grammar from a JSON file. Raises {!exception:Error} if the
    plist does not represent a valid TextMate grammar, or if a regex in it does
    not compile. An [end] or [while] regex that uses back-references is built
    from the text its [begin] matched, so it cannot be checked here: see
    {!val:tokenize_exn}. *)

val of_yojson_exn : yojson -> grammar
(** Reads a TextMate grammar from a JSON file. Raises {!exception:Error} if the
    plist does not represent a valid TextMate grammar, or if a regex in it does
    not compile. An [end] or [while] regex that uses back-references is built
    from the text its [begin] matched, so it cannot be checked here: see
    {!val:tokenize_exn}. *)

type stack
(** The state of the tokenizer. *)

val empty : stack
(** The initial state of the tokenizer. *)

type token
(** A token of code. *)

val ending : token -> int
(** One past the index of the last character of the token.

    If [tok] is the first token of the line, [tok] spans the substring within
    interval \[[0], [ending tok]). If [tok] succeeds a token [prev], [tok] spans
    the substring within interval \[[ending prev], [ending tok]). *)

val scopes : token -> string list
(** The token's stack of TextMate grammar scopes. *)

val tokenize_exn :
  ?max_line_length:int ->
  ?time_limit:float ->
  t ->
  grammar ->
  stack ->
  string ->
  token list * stack
(** Usage: [let tokens, stack = tokenize_exn t grammar stack line]

    Tokenizes a line of code. Returns the list of tokens [tokens] and the
    updated tokenization state [stack].

    Precondition:

    - [line] must be a single line, including the newline character at the end.

    Postconditions:

    - [tokens] is nonempty.
    - The ending positions of [tokens] are strictly increasing.
    - The [ending] of the last token in [tokens] is always [String.length line].

    Never raises for any [line], including one that is not valid UTF-8. A
    malformed [end] or [while] regex is reported when the grammar is read, see
    {!val:of_yojson_exn}. An [include] of a repository entry or grammar that
    does not exist in [t] is ignored, and so is an [include] that leads back to
    itself.

    A rule whose [end] or [while] regex uses back-references ([\1]) has that
    regex built from the text its [begin] matched. If the result is not a valid
    regex, the rule can never end on its own: it stays open until the grammar
    stops it some other way.

    The time spent on one line is bounded, so that no input can hang the
    tokenizer. Two limits apply. Past either, the rest of the line becomes a
    single token with the scopes in force at that point, and the returned
    [stack] is the one in force there, so the next line starts from a consistent
    state.

    - [max_line_length] (default [10_000], at least [1]) is the number of bytes
      of the line that are tokenized. A regex can take time that grows with the
      square of the line, so only that prefix is matched. A line is cut at a
      character boundary. This limit does not depend on the machine.
    - [time_limit] (default [0.25] seconds) is the wall-clock time the regex
      matching of one line may take. It depends on the machine, but a line that
      is ordinary code never gets near it. Pass [infinity] to remove it.

    A single regex call is not interrupted. Its cost is bounded by Oniguruma's
    own retry limit ([Oniguruma.set_retry_limit_in_match]). *)
