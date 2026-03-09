
# Module `Ochre.Html_options`

```ocaml
type style_mode = 
  | Inline_styles (* Emit style="color:..." on each <span>. Default. *)
  | Css_classes of {
    class_prefix : string;
  } (* Replace inline styles with deterministic CSS class names. *)
```
style\_mode

How token colors are expressed in the output.

```ocaml
type default_color = 
  | Default_color (* Emit inline color: and background-color:. Default. *)
  | No_default_color (* Suppress inline colors. All colors from CSS custom properties. *)
```
default\_color

Whether the primary theme's colors are emitted inline.

```ocaml
type t = {
  style_mode : style_mode;
  default_color : default_color;
  pre_class : string option;
  code_class : string option;
  line_numbers : bool;
  css_variable_prefix : string;
  scopes_as_data_attrs : bool;
}
```
t

The full set of HTML rendering options.

```ocaml
val default : t
```
default

Default options (backward compatible with legacy output).

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
make

Construct options with defaults for any unspecified fields.

```ocaml
  let opts =
    Ochre.Html_options.make ~line_numbers:true
      ~default_color:No_default_color ()
```