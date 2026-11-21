type class_registry

val render :
  ?options:Html_options.t ->
  ?label:string ->
  Theme.theme ->
  ?extra_themes:(string * Theme.theme * Token.highlighted_code) list ->
  Token.highlighted_code ->
  string

val theme_css : ?css_variable_prefix:string -> string -> string

val render_theme_css :
  ?css_variable_prefix:string ->
  class_prefix:string ->
  Theme.theme ->
  Token.highlighted_code ->
  string
