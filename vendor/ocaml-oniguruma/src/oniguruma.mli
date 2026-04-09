(** Bindings to K.Kosako's {{:https://github.com/kkos/oniguruma} Oniguruma}
    library. Also see the
    {{:https://github.com/kkos/oniguruma/blob/master/doc/API} Oniguruma API
     documentation}. *)

type _ t
(** A regular expression. The phantom type parameter indicates the encoding, so
    that regular expressions for different encodings may not be mixed. *)

type 'enc regex = 'enc t
(** Alias for {!type:t}. Useful when working with existential regex collections
    (for example {!module:RegSet}). *)

exception Error of string [@ocaml.warn_on_literal_pattern]
(** The exception raised upon Oniguruma errors. *)

(** Character encodings. *)
module Encoding : sig
  type _ t
  (** A character encoding. The phantom type parameter indicates the encoding.
  *)

  type ascii
  val ascii : ascii t

  type iso_8859_1
  val iso_8859_1 : iso_8859_1 t

  type iso_8859_2
  val iso_8859_2 : iso_8859_2 t

  type iso_8859_3
  val iso_8859_3 : iso_8859_3 t

  type iso_8859_4
  val iso_8859_4 : iso_8859_4 t

  type iso_8859_5
  val iso_8859_5 : iso_8859_5 t

  type iso_8859_6
  val iso_8859_6 : iso_8859_6 t

  type iso_8859_7
  val iso_8859_7 : iso_8859_7 t

  type iso_8859_8
  val iso_8859_8 : iso_8859_8 t

  type iso_8859_9
  val iso_8859_9 : iso_8859_9 t

  type iso_8859_10
  val iso_8859_10 : iso_8859_10 t

  type iso_8859_11
  val iso_8859_11 : iso_8859_11 t

  type iso_8859_13
  val iso_8859_13 : iso_8859_13 t

  type iso_8859_14
  val iso_8859_14 : iso_8859_14 t

  type iso_8859_15
  val iso_8859_15 : iso_8859_15 t

  type iso_8859_16
  val iso_8859_16 : iso_8859_16 t

  type utf8
  val utf8 : utf8 t

  type utf16_be
  val utf16_be : utf16_be t

  type utf16_le
  val utf16_le : utf16_le t

  type utf32_be
  val utf32_be : utf32_be t

  type utf32_le
  val utf32_le : utf32_le t

  type euc_jp
  val euc_jp : euc_jp t

  type euc_tw
  val euc_tw : euc_tw t

  type euc_kr
  val euc_kr : euc_kr t

  type euc_cn
  val euc_cn : euc_cn t

  type sjis
  val sjis : sjis t

  type koi8_r
  val koi8_r : koi8_r t

  type cp1251
  val cp1251 : cp1251 t

  type big5
  val big5 : big5 t

  type gb18030
  val gb18030 : gb18030 t
end

(** Regex options. *)
module Options : sig
  type _ t
  (** An option. The phantom type parameter indicates whether it is compile-time
      or search-time. *)

  val ( <+> ) : 'a t -> 'a t -> 'a t
  (** Combines options.

      This operation is:

      - Associative: [(x <+> y) <+> z = x <+> (y <+> z)]
      - Commutative: [x <+> y = y <+> x]
      - Idempotent: [x <+> x = x] *)

  val none : _ t
  (** No options. The identity element of {!val:(<+>)}:

      - [none <+> x = x]
      - [x <+> none = x] *)

  type compile_time
  (** Represents compile-time options. *)

  val singleline : compile_time t
  val multiline : compile_time t
  val ignorecase : compile_time t
  val extend : compile_time t
  val find_longest : compile_time t
  val find_not_empty : compile_time t
  val negate_singleline : compile_time t
  val dont_capture_group : compile_time t
  val capture_group : compile_time t
  val ignorecase_is_ascii : compile_time t
  val word_is_ascii : compile_time t
  val digit_is_ascii : compile_time t
  val space_is_ascii : compile_time t
  val posix_is_ascii : compile_time t
  val text_segment_extended_grapheme_cluster : compile_time t
  val text_segment_word : compile_time t

  type search_time
  (** Represents search-time options. *)

  val notbol : search_time t
  val noteol : search_time t
  val not_begin_position : search_time t
  val not_begin_string : search_time t
  val not_end_string : search_time t
  val posix_region : search_time t
  val check_validity_of_string : search_time t
  val callback_each_match : search_time t
end

(** The syntax type. *)
module Syntax : sig
  type t
  (** The regular expression dialect. *)

  val asis : t
  val posix_basic : t
  val posix_extended : t
  val emacs : t
  val grep : t
  val gnu_regex : t
  val java : t
  val perl : t
  val perl_ng : t
  val default : t
end

(** Match results. *)
module Region : sig
  type t
  (** The capture groups returned by a search or match. *)

  external length : t -> int = "ocaml_onig_region_length"
  (** [length region] gets the number of captures. *)

  external capture_beg : t -> int -> int = "ocaml_onig_capture_beg"
  (** [capture_beg region idx] gets the string position of the capture at the
      index. The capture at index 0 is the entire match. The string position is
      an offset in bytes. Returns -1 if the capture group wasn't found. Raises
      {!exception:Invalid_argument} if the index is out of bounds. *)

  external capture_end : t -> int -> int = "ocaml_onig_capture_end"
  (** [capture_end region idx] gets the string position of the capture at the
      index. The capture at index 0 is the entire match. The string position is
      an offset in bytes. Returns -1 if the capture group wasn't found. Raises
      {!exception:Invalid_argument} if the index is out of bounds. *)
end

(** Per-call match parameters. *)
module MatchParam : sig
  type t
  (** Per-search/match parameter set for tuning limits. *)

  external create : unit -> t = "ocaml_onig_new_match_param"
  (** [create ()] allocates and initializes a match parameter set with the
      current global defaults. *)

  external set_match_stack_limit_size : t -> int -> unit
    = "ocaml_onig_match_param_set_match_stack_limit"
  (** [set_match_stack_limit_size mp limit] sets the match stack limit for this
      parameter set. *)

  external set_retry_limit_in_match : t -> int -> unit
    = "ocaml_onig_match_param_set_retry_limit_in_match"
  (** [set_retry_limit_in_match mp limit] sets the retry limit during matching
      for this parameter set. *)

  external set_retry_limit_in_search : t -> int -> unit
    = "ocaml_onig_match_param_set_retry_limit_in_search"
  (** [set_retry_limit_in_search mp limit] sets the retry limit during searching
      for this parameter set. *)
end

module RegSet : sig
  type t
  (** A set of regular expressions that can be searched simultaneously. *)

  external create : _ regex array -> t = "ocaml_onig_regset_new"
  (** [create regexes] creates a regex set from [regexes].

      Ownership of regex internals is transferred to the regset (matching
      Oniguruma's C API). After creating the regset, use the set for searching
      instead of reusing those regex values directly. *)

  external search :
    t ->
    string ->
    int ->
    int ->
    Options.search_time Options.t ->
    (int * Region.t) option = "ocaml_onig_regset_search"
  (** [search set string start range options] searches [string] for the leftmost
      match across all regexes in [set] using [ONIG_REGSET_POSITION_LEAD].

      Returns [Some (idx, region)] where [idx] is the 0-based index of the
      matched regex from the array passed to {!create}. Returns [None] on
      mismatch. Raises {!exception:Error} on other Oniguruma errors. *)
end

external create :
  string ->
  Options.compile_time Options.t ->
  'enc Encoding.t ->
  Syntax.t ->
  ('enc t, string) result = "ocaml_onig_new"
(** [create pattern options encoding syntax] creates a regex. *)

external search :
  'enc t ->
  string ->
  int ->
  int ->
  Options.search_time Options.t ->
  Region.t option = "ocaml_onig_search"
(** [search regex string start range option] searches
    [String.sub string start range] for [regex]. Raises {!exception:Error} if
    there is an error (other than a mismatch).

    @param regex The pattern to search for
    @param string The string to search
    @param start The string position to start searching from, as a byte offset
    @param range The string position to stop searching at, as a byte offset
    @param option Search options *)

external match_ :
  'enc t -> string -> int -> Options.search_time Options.t -> Region.t option
  = "ocaml_onig_match"
(** [match_ regex string pos options] matches [regex] against [string] at
    position [pos]. Raises {!exception:Error} if there is an error (other than a
    mismatch).

    @param regex The pattern to match
    @param string The string to match against
    @param pos The position of the string to match at, as a byte offset
    @param options Match options *)

external search_with_param :
  'enc t ->
  string ->
  int ->
  int ->
  Options.search_time Options.t ->
  MatchParam.t ->
  Region.t option
  = "ocaml_onig_search_with_param_bc" "ocaml_onig_search_with_param"
(** Like {!val:search} but with per-call match parameters. *)

external match_with_param :
  'enc t ->
  string ->
  int ->
  Options.search_time Options.t ->
  MatchParam.t ->
  Region.t option = "ocaml_onig_match_with_param"
(** Like {!val:match_} but with per-call match parameters. *)

external scan :
  _ t ->
  string ->
  Options.search_time Options.t ->
  (int -> int -> Region.t -> bool) ->
  int = "ocaml_onig_scan"
(** [scan regex string options callback] finds all non-overlapping matches of
    [regex] in [string]. For each match, [callback count pos region] is called
    where [count] is the 1-based match number and [pos] is the byte offset.
    Return [true] from [callback] to continue scanning, [false] to stop. Returns
    the number of matches found. *)

external num_captures : _ t -> int = "ocaml_onig_num_captures"
(** The number of capture groups in the regex. The entire match itself does not
    count as a capture group. *)

external name_to_group_numbers : _ t -> string -> int array
  = "ocaml_onig_name_to_group_numbers"
(** [name_to_group_numbers regex name] is the group number array of [name] in
    [regex]. *)

external number_of_names : _ t -> int = "ocaml_onig_number_of_names"
(** The number of distinct named capture groups in the regex. *)

external number_of_capture_histories : _ t -> int
  = "ocaml_onig_number_of_capture_histories"
(** The number of capture histories in the regex. *)

external noname_group_capture_is_active : _ t -> bool
  = "ocaml_onig_noname_group_capture_is_active"
(** [true] if unnamed group captures are active for this regex. When
    {!Options.dont_capture_group} is used with named groups present, this
    returns [false]. *)

external get_options : _ t -> Options.compile_time Options.t
  = "ocaml_onig_get_options"
(** The compile-time options the regex was created with. *)

external foreach_name : _ t -> (string -> int array -> bool) -> unit
  = "ocaml_onig_foreach_name"
(** [foreach_name regex f] calls [f name group_numbers] for each named capture
    group. Return [true] from [f] to continue iteration, [false] to stop early.
*)

external name_to_backref_number : _ t -> string -> Region.t -> int
  = "ocaml_onig_name_to_backref_number"
(** [name_to_backref_number regex name region] resolves a named capture to the
    specific group number that matched in [region]. Useful when multiple groups
    share a name. Raises {!exception:Error} if the name is not found. *)

external get_match_stack_limit_size : unit -> int
  = "ocaml_onig_get_match_stack_limit_size"

external set_match_stack_limit_size : int -> unit
  = "ocaml_onig_set_match_stack_limit_size"

external get_retry_limit_in_match : unit -> int
  = "ocaml_onig_get_retry_limit_in_match"

external set_retry_limit_in_match : int -> unit
  = "ocaml_onig_set_retry_limit_in_match"

external get_retry_limit_in_search : unit -> int
  = "ocaml_onig_get_retry_limit_in_search"

external set_retry_limit_in_search : int -> unit
  = "ocaml_onig_set_retry_limit_in_search"

external get_parse_depth_limit : unit -> int
  = "ocaml_onig_get_parse_depth_limit"

external set_parse_depth_limit : int -> unit
  = "ocaml_onig_set_parse_depth_limit"

external set_capture_num_limit : int -> unit
  = "ocaml_onig_set_capture_num_limit"

external get_subexp_call_limit_in_search : unit -> int
  = "ocaml_onig_get_subexp_call_limit_in_search"

external set_subexp_call_limit_in_search : int -> unit
  = "ocaml_onig_set_subexp_call_limit_in_search"

external get_subexp_call_max_nest_level : unit -> int
  = "ocaml_onig_get_subexp_call_max_nest_level"

external set_subexp_call_max_nest_level : int -> unit
  = "ocaml_onig_set_subexp_call_max_nest_level"

val version : string
(** The Oniguruma version string. This is the version of the underlying C
    library, not this OCaml binding library. *)
