val match_selector : string list -> string -> int option

val find_best_match :
  string list ->
  Theme.token_color_rule list ->
  Theme.token_color_settings option

type resolver

val resolver : Theme.token_color_rule list -> resolver

val resolve : resolver -> string list -> Theme.token_color_settings option

val styles : Theme.token_color_rule list -> Theme.token_color_settings list
(** Every settings that {!resolve} can return for [rules], whatever the scope
    stack, plus the settings of an unmatched scope. May include settings that no
    scope stack reaches. *)

val styled_token :
  Theme.theme ->
  text:string ->
  scopes:string list ->
  Theme.token_color_settings option ->
  Token.styled_token
