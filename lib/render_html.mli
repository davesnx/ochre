type class_registry

val render : ?options:Html_options.t -> Themed.t -> string
val theme_css : ?css_variable_prefix:string -> string -> string

val render_theme_css :
  ?css_variable_prefix:string -> class_prefix:string -> Themed.t -> string

val render_whole_theme_css :
  ?css_variable_prefix:string -> class_prefix:string -> Theme.theme -> string
