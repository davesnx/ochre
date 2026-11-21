val match_selector : string list -> string -> int option

val find_best_match :
  string list ->
  Theme.token_color_rule list ->
  Theme.token_color_settings option

type resolver

val resolver : Theme.token_color_rule list -> resolver

val resolve : resolver -> string list -> Theme.token_color_settings option
