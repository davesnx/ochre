val match_selector : string list -> string -> int option

val find_best_match :
  string list ->
  Theme.token_color_rule list ->
  Theme.token_color_settings option

type resolver

val resolver : Theme.token_color_rule list -> resolver

val resolve : resolver -> string list -> Theme.token_color_settings option

type palette = {
  foregrounds : Color.t list;
  backgrounds : Color.t option list;
  font_styles : Style.font_style list;
}

val palette : Theme.theme -> palette
val style : Theme.theme -> Theme.token_color_settings option -> Style.t
val produces : Theme.theme -> Style.t -> bool
