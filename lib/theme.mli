type color = string
type font_style = Token.font_style = Bold | Italic | Underline | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list;
}

type token_color_rule = { scope : string list; settings : token_color_settings }

type theme = {
  name : string;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}

val available_names : string list
val make : string -> theme option
val load : string -> theme
val load_from_string : string -> theme
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
