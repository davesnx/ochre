type token = Token.t

type line = token list

type document = line list

type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
}

val make :
  ?before_line:(line_index:int -> line -> line) ->
  ?after_line:(line_index:int -> line -> line) ->
  ?before_render:(document -> document) ->
  ?after_render:(document -> document) ->
  string ->
  t

val run_checked :
  check:(t -> token -> 'e option) -> t list -> document -> (document, 'e) result

val run : t list -> document -> document
