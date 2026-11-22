type color = string

type font_style = Token.font_style = Bold | Italic | Underline | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list option;
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

val load : ?base_dir:string -> string -> (theme, string) result

val is_valid_color : string -> bool

val load_exn : ?base_dir:string -> string -> theme

val load_from_file : string -> (theme, string) result

val load_from_file_exn : string -> theme

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
  ?font_style:font_style list ->
  unit ->
  token_color_rule

val default : theme
