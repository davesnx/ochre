
# Module `Ochre.Html_options`


### style\_mode

```ocaml
type style_mode = 
  | Inline_styles (* Emit style="color:..." on each <span>. Default. *)
  | Css_classes of {
    class_prefix : string;
  } (* Replace inline styles with deterministic CSS class names: one class for the token colour, one for its background when it has one, and one for its font-weight, font-style and text-decoration when it has any. Each class sets different properties, so their order does not matter. *)
```
How token colors are expressed in the output.


### default\_color

```ocaml
type default_color = 
  | Default_color (* Emit inline color: and background-color:. Default. *)
  | No_default_color (* Suppress inline colors. Every theme, the primary one included, is emitted as CSS custom properties, and the page supplies color: and background-color:. Font styles are still applied. *)
```
Whether the primary theme's colors are emitted inline.


### t

```ocaml
type t = {
  style_mode : style_mode;
  default_color : default_color;
  pre_class : string option;
  code_class : string option;
  line_numbers : bool;
  css_variable_prefix : string; (* The prefix of the CSS variables, "--ochre-" by default. Two themes labelled light and dark write their colours with light-dark(), so for them the prefix names only the font variables. *)
  scopes_as_data_attrs : bool;
}
```
The full set of HTML rendering options.


### default

```ocaml
val default : t
```
Inline styles, default colors, no extra classes, no line numbers, the `--ochre-` variable prefix and no scope attributes.


### make

```ocaml
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
```
Construct options with defaults for any unspecified fields.

```ocaml
let opts =
  Ochre.Html_options.make ~line_numbers:true
    ~default_color:No_default_color ()
```