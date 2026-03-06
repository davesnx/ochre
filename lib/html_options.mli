(** Configurable options for HTML rendering.

    Controls the structure and styling strategy of the rendered HTML output. The
    default options produce the same output as the legacy [Render_html.render]
    for backward compatibility. *)

(** How token colors are expressed in the output. *)
type style_mode =
  | Inline_styles
      (** Emit [style="color:..."] on each [<span>]. This is the default and
          matches Shiki's default behaviour. *)
  | Css_classes of { class_prefix : string }
      (** Replace inline styles with deterministic CSS class names. Each unique
          style combination gets a class like [<prefix><hash>]. Use
          {!Render_html.collect_classes} to extract a CSS stylesheet after
          rendering. *)

(** Whether the primary theme's colors are emitted as inline CSS properties.

    In multi-theme mode, extra themes always use CSS custom properties (e.g.
    [--ochre-dark:#fff]). This option controls the {i primary} theme. *)
type default_color =
  | Default_color
      (** Emit [color:] and [background-color:] inline for the primary theme.
          This is the default. *)
  | No_default_color
      (** Suppress inline colors on the primary theme. All colors come from CSS
          custom properties only. Useful when the consumer controls all theme
          switching via CSS and wants to avoid [!important] overrides. *)

type t = {
  style_mode : style_mode;
  default_color : default_color;
  pre_class : string option;
  code_class : string option;
  line_numbers : bool;
  css_variable_prefix : string;
  scopes_as_data_attrs : bool;
}
(** The full set of HTML rendering options.

    - [style_mode]: inline styles (default) or CSS classes.
    - [default_color]: whether the primary theme gets inline colors.
    - [pre_class]: extra class(es) for the [<pre>] element.
    - [code_class]: extra class(es) for the [<code>] element.
    - [line_numbers]: emit [data-line="N"] on each line [<span>].
    - [css_variable_prefix]: prefix for CSS custom properties (default
      ["--ochre-"]).
    - [scopes_as_data_attrs]: emit [data-scope="..."] on token [<span>]s. *)

val default : t
(** Default options. Produces output identical to the legacy renderer: inline
    styles, no line numbers, ["--ochre-"] prefix, no scope attributes. *)

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
(** Construct options with defaults for any unspecified fields. *)
