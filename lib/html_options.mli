type style_mode = Inline_styles | Css_classes of { class_prefix : string }

type default_color = Default_color | No_default_color

type t = {
  style_mode : style_mode;
  default_color : default_color;
  pre_class : string option;
  code_class : string option;
  line_numbers : bool;
  css_variable_prefix : string;
  scopes_as_data_attrs : bool;
}

val normalize_css_variable_prefix : string -> string

val default : t

val make :
  ?style_mode:style_mode ->
  ?default_color:default_color ->
  ?pre_class:string ->
  ?code_class:string ->
  ?line_numbers:bool ->
  ?css_variable_prefix:string ->
  ?scopes_as_data_attrs:bool ->
  unit ->
  t
