type color = Color.t

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : Style.font_style option;
}

type token_color_rule = {
  name : string option;
  scope : string list;
  settings : token_color_settings;
}

type theme = {
  name : string;
  colors : (string * color) list;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}

type warning = { path : string option; location : string; value : string }

val warning_to_string : warning -> string

val load : ?base_dir:string -> string -> (theme * warning list, Error.t) result

val load_from_file : string -> (theme * warning list, Error.t) result

val make :
  name:string ->
  ?colors:(string * color) list ->
  token_colors:token_color_rule list ->
  unit ->
  theme

val rule :
  ?name:string ->
  ?scope:string list ->
  ?foreground:color ->
  ?background:color ->
  ?font_style:Style.font_style ->
  unit ->
  token_color_rule

val available_names : string list

val find : string -> theme option

val themes : (string * theme) list

val dark : theme
val light : theme
val tokyonight : theme
val everforest : theme
val ayu : theme
val catppuccin : theme
val catppuccin_macchiato : theme
val gruvbox : theme
val kanagawa : theme
val nord : theme
val matrix : theme
val one_dark : theme
