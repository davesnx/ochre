type _ t

type 'enc regex = 'enc t

exception Error of string

external initialize : unit -> unit = "ocaml_onig_initialize"

external cleanup : unit -> unit = "ocaml_onig_end"

let () =
  Callback.register_exception "Oniguruma.Error" (Error "");
  Callback.register_exception "Oniguruma.Invalid_argument" (Invalid_argument "");
  Callback.register_exception "Oniguruma.Failure" (Failure "");
  initialize ();
  at_exit cleanup

module Encoding = struct
  type _ t

  type ascii
  external get_ascii : unit -> ascii t = "ocaml_get_onig_encoding_ascii"
  let ascii = get_ascii ()

  type iso_8859_1
  external get_iso_8859_1 : unit -> iso_8859_1 t
    = "ocaml_get_onig_encoding_iso_8859_1"
  let iso_8859_1 = get_iso_8859_1 ()

  type iso_8859_2
  external get_iso_8859_2 : unit -> iso_8859_2 t
    = "ocaml_get_onig_encoding_iso_8859_2"
  let iso_8859_2 = get_iso_8859_2 ()

  type iso_8859_3
  external get_iso_8859_3 : unit -> iso_8859_3 t
    = "ocaml_get_onig_encoding_iso_8859_3"
  let iso_8859_3 = get_iso_8859_3 ()

  type iso_8859_4
  external get_iso_8859_4 : unit -> iso_8859_4 t
    = "ocaml_get_onig_encoding_iso_8859_4"
  let iso_8859_4 = get_iso_8859_4 ()

  type iso_8859_5
  external get_iso_8859_5 : unit -> iso_8859_5 t
    = "ocaml_get_onig_encoding_iso_8859_5"
  let iso_8859_5 = get_iso_8859_5 ()

  type iso_8859_6
  external get_iso_8859_6 : unit -> iso_8859_6 t
    = "ocaml_get_onig_encoding_iso_8859_6"
  let iso_8859_6 = get_iso_8859_6 ()

  type iso_8859_7
  external get_iso_8859_7 : unit -> iso_8859_7 t
    = "ocaml_get_onig_encoding_iso_8859_7"
  let iso_8859_7 = get_iso_8859_7 ()

  type iso_8859_8
  external get_iso_8859_8 : unit -> iso_8859_8 t
    = "ocaml_get_onig_encoding_iso_8859_8"
  let iso_8859_8 = get_iso_8859_8 ()

  type iso_8859_9
  external get_iso_8859_9 : unit -> iso_8859_9 t
    = "ocaml_get_onig_encoding_iso_8859_9"
  let iso_8859_9 = get_iso_8859_9 ()

  type iso_8859_10
  external get_iso_8859_10 : unit -> iso_8859_10 t
    = "ocaml_get_onig_encoding_iso_8859_10"
  let iso_8859_10 = get_iso_8859_10 ()

  type iso_8859_11
  external get_iso_8859_11 : unit -> iso_8859_11 t
    = "ocaml_get_onig_encoding_iso_8859_11"
  let iso_8859_11 = get_iso_8859_11 ()

  type iso_8859_13
  external get_iso_8859_13 : unit -> iso_8859_13 t
    = "ocaml_get_onig_encoding_iso_8859_13"
  let iso_8859_13 = get_iso_8859_13 ()

  type iso_8859_14
  external get_iso_8859_14 : unit -> iso_8859_14 t
    = "ocaml_get_onig_encoding_iso_8859_14"
  let iso_8859_14 = get_iso_8859_14 ()

  type iso_8859_15
  external get_iso_8859_15 : unit -> iso_8859_15 t
    = "ocaml_get_onig_encoding_iso_8859_15"
  let iso_8859_15 = get_iso_8859_15 ()

  type iso_8859_16
  external get_iso_8859_16 : unit -> iso_8859_16 t
    = "ocaml_get_onig_encoding_iso_8859_16"
  let iso_8859_16 = get_iso_8859_16 ()

  type utf8
  external get_utf8 : unit -> utf8 t = "ocaml_get_onig_encoding_utf8"
  let utf8 = get_utf8 ()

  type utf16_be
  external get_utf16_be : unit -> utf16_be t
    = "ocaml_get_onig_encoding_utf16_be"
  let utf16_be = get_utf16_be ()

  type utf16_le
  external get_utf16_le : unit -> utf16_le t
    = "ocaml_get_onig_encoding_utf16_le"
  let utf16_le = get_utf16_le ()

  type utf32_be
  external get_utf32_be : unit -> utf32_be t
    = "ocaml_get_onig_encoding_utf32_be"
  let utf32_be = get_utf32_be ()

  type utf32_le
  external get_utf32_le : unit -> utf32_le t
    = "ocaml_get_onig_encoding_utf32_le"
  let utf32_le = get_utf32_le ()

  type euc_jp
  external get_euc_jp : unit -> euc_jp t = "ocaml_get_onig_encoding_euc_jp"
  let euc_jp = get_euc_jp ()

  type euc_tw
  external get_euc_tw : unit -> euc_tw t = "ocaml_get_onig_encoding_euc_tw"
  let euc_tw = get_euc_tw ()

  type euc_kr
  external get_euc_kr : unit -> euc_kr t = "ocaml_get_onig_encoding_euc_kr"
  let euc_kr = get_euc_kr ()

  type euc_cn
  external get_euc_cn : unit -> euc_cn t = "ocaml_get_onig_encoding_euc_cn"
  let euc_cn = get_euc_cn ()

  type sjis
  external get_sjis : unit -> sjis t = "ocaml_get_onig_encoding_sjis"
  let sjis = get_sjis ()

  type koi8_r
  external get_koi8_r : unit -> koi8_r t = "ocaml_get_onig_encoding_koi8_r"
  let koi8_r = get_koi8_r ()

  type cp1251
  external get_cp1251 : unit -> cp1251 t = "ocaml_get_onig_encoding_cp1251"
  let cp1251 = get_cp1251 ()

  type big5
  external get_big5 : unit -> big5 t = "ocaml_get_onig_encoding_big5"
  let big5 = get_big5 ()

  type gb18030
  external get_gb18030 : unit -> gb18030 t = "ocaml_get_onig_encoding_gb18030"
  let gb18030 = get_gb18030 ()
end

module Options = struct
  type _ t = int

  external option : int -> 'a t = "ocaml_onig_option"

  let ( <+> ) = ( lor )
  let none = option 0

  type compile_time

  let singleline = option 1
  let multiline = option 2
  let ignorecase = option 3
  let extend = option 4
  let find_longest = option 5
  let find_not_empty = option 6
  let negate_singleline = option 7
  let dont_capture_group = option 8
  let capture_group = option 9

  type search_time

  let ignorecase_is_ascii = option 13
  let word_is_ascii = option 14
  let digit_is_ascii = option 15
  let space_is_ascii = option 16
  let posix_is_ascii = option 17
  let text_segment_extended_grapheme_cluster = option 18
  let text_segment_word = option 19

  let notbol = option 10
  let noteol = option 11
  let not_begin_position = option 12
  let not_begin_string = option 20
  let not_end_string = option 21
  let posix_region = option 22
  let check_validity_of_string = option 23
  let callback_each_match = option 24
end

module Syntax = struct
  type t

  external get_asis : unit -> t = "ocaml_get_onig_syntax_asis"
  let asis = get_asis ()

  external get_posix_basic : unit -> t = "ocaml_get_onig_syntax_posix_basic"
  let posix_basic = get_posix_basic ()

  external get_posix_extended : unit -> t
    = "ocaml_get_onig_syntax_posix_extended"
  let posix_extended = get_posix_extended ()

  external get_emacs : unit -> t = "ocaml_get_onig_syntax_emacs"
  let emacs = get_emacs ()

  external get_grep : unit -> t = "ocaml_get_onig_syntax_grep"
  let grep = get_grep ()

  external get_gnu_regex : unit -> t = "ocaml_get_onig_syntax_gnu_regex"
  let gnu_regex = get_gnu_regex ()

  external get_java : unit -> t = "ocaml_get_onig_syntax_java"
  let java = get_java ()

  external get_perl : unit -> t = "ocaml_get_onig_syntax_perl"
  let perl = get_perl ()

  external get_perl_ng : unit -> t = "ocaml_get_onig_syntax_perl_ng"
  let perl_ng = get_perl_ng ()

  external get_default : unit -> t = "ocaml_get_onig_syntax_default"
  let default = get_default ()
end

module Region = struct
  type t

  external length : t -> int = "ocaml_onig_region_length"

  external capture_beg : t -> int -> int = "ocaml_onig_capture_beg"

  external capture_end : t -> int -> int = "ocaml_onig_capture_end"
end

module MatchParam = struct
  type t

  external create : unit -> t = "ocaml_onig_new_match_param"

  external set_match_stack_limit_size : t -> int -> unit
    = "ocaml_onig_match_param_set_match_stack_limit"

  external set_retry_limit_in_match : t -> int -> unit
    = "ocaml_onig_match_param_set_retry_limit_in_match"

  external set_retry_limit_in_search : t -> int -> unit
    = "ocaml_onig_match_param_set_retry_limit_in_search"
end

module RegSet = struct
  type t

  external create : _ regex array -> t = "ocaml_onig_regset_new"

  external search :
    t ->
    string ->
    int ->
    int ->
    Options.search_time Options.t ->
    (int * Region.t) option = "ocaml_onig_regset_search"
end

external create :
  string ->
  Options.compile_time Options.t ->
  'enc Encoding.t ->
  Syntax.t ->
  ('enc t, string) result = "ocaml_onig_new"

external search :
  'enc t ->
  string ->
  int ->
  int ->
  Options.search_time Options.t ->
  Region.t option = "ocaml_onig_search"

external match_ :
  'enc t -> string -> int -> Options.search_time Options.t -> Region.t option
  = "ocaml_onig_match"

external search_with_param :
  'enc t ->
  string ->
  int ->
  int ->
  Options.search_time Options.t ->
  MatchParam.t ->
  Region.t option
  = "ocaml_onig_search_with_param_bc" "ocaml_onig_search_with_param"

external match_with_param :
  'enc t ->
  string ->
  int ->
  Options.search_time Options.t ->
  MatchParam.t ->
  Region.t option = "ocaml_onig_match_with_param"

external scan :
  _ t ->
  string ->
  Options.search_time Options.t ->
  (int -> int -> Region.t -> bool) ->
  int = "ocaml_onig_scan"

external num_captures : _ t -> int = "ocaml_onig_num_captures"

external name_to_group_numbers : _ t -> string -> int array
  = "ocaml_onig_name_to_group_numbers"

external number_of_names : _ t -> int = "ocaml_onig_number_of_names"

external number_of_capture_histories : _ t -> int
  = "ocaml_onig_number_of_capture_histories"

external noname_group_capture_is_active : _ t -> bool
  = "ocaml_onig_noname_group_capture_is_active"

external get_options : _ t -> Options.compile_time Options.t
  = "ocaml_onig_get_options"

external foreach_name : _ t -> (string -> int array -> bool) -> unit
  = "ocaml_onig_foreach_name"

external name_to_backref_number : _ t -> string -> Region.t -> int
  = "ocaml_onig_name_to_backref_number"

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

external version_f : unit -> string = "ocaml_onig_version"
let version = version_f ()
