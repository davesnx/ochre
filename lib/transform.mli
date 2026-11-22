type token = Token.t

type line = token list

type document = line list

type attributes = JSX.attribute list

type attribute_hooks = {
  pre : (document -> attributes -> attributes) option;
  line : (line_index:int -> line -> attributes -> attributes) option;
  span :
    (line_index:int -> column:int -> token -> attributes -> attributes) option;
}

type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
  attributes : (document -> attribute_hooks) option;
}

val make :
  ?before_line:(line_index:int -> line -> line) ->
  ?after_line:(line_index:int -> line -> line) ->
  ?before_render:(document -> document) ->
  ?after_render:(document -> document) ->
  ?attributes:(document -> attribute_hooks) ->
  string ->
  t

val run_checked :
  check:(t -> token -> 'e option) ->
  t list ->
  document ->
  (document * attribute_hooks list, 'e) result

val run_with_hooks : t list -> document -> document * attribute_hooks list

val run : t list -> document -> document
