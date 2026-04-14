
# Module `Ochre.Html_options`


### style\_mode

```ocaml
type style_mode = 
  | Inline_styles (* Emit style="color:..." on each <span>. Default. *)
  | Css_classes of {
    class_prefix : string;
  } (* Replace inline styles with deterministic CSS class names. *)
```
How token colors are expressed in the output.


### default\_color

```ocaml
type default_color = 
  | Default_color (* Emit inline color: and background-color:. Default. *)
  | No_default_color (* Suppress inline colors. All colors from CSS custom properties. *)
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
  css_variable_prefix : string;
  scopes_as_data_attrs : bool;
}
```
The full set of HTML rendering options.


### default

```ocaml
val default : t
```
Default options (backward compatible with legacy output).


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