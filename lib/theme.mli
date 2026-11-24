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

type problem =
  | Invalid_color of string
  | Wrong_type of { expected : string; found : string }

type warning = { path : string option; location : string; problem : problem }

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
