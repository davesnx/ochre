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
      (** Replace the theme colour and font styles of each token by a
          deterministic CSS class name [<prefix><hash>], where [<hash>] is the
          first 16 hexadecimal digits (64 bits) of the MD5 digest of the style
          text, so two different styles share a class only with probability
          about 2^-64 per pair. Use {!Render_html.render_theme_css} (exposed as
          {!Ochre.html_render_theme_css}) to extract a CSS stylesheet after
          rendering. The style of a decoration and the custom properties of
          extra themes are not themed: they stay in an inline [style] attribute,
          so they take effect without any stylesheet.

          [class_prefix] is used in a CSS selector. Each byte outside
          [A-Za-z0-9_-] is replaced by ['_'] before use, and a ['_'] is put in
          front when the result is empty or does not start with a letter or
          ['_'], so a class name is always a valid CSS identifier. *)

(** Whether the primary theme's colors are emitted as inline CSS properties.

    In multi-theme mode, extra themes always use CSS custom properties (e.g.
    [--ochre-dark:#fff]). This option controls the {i primary} theme. *)
type default_color =
  | Default_color
      (** Emit [color:] and [background-color:] inline for the primary theme.
          This is the default. *)
  | No_default_color
      (** Suppress inline colors on the primary theme. Every theme, the primary
          one included, is emitted as CSS custom properties ([--ochre-<label>],
          [--ochre-<label>-bg], ...); the page supplies [color:] and
          [background-color:] from them. Font styles of the primary theme are
          kept. Useful when the consumer controls all theme switching via CSS
          and wants to avoid [!important] overrides. *)

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
    - [pre_class]: extra class(es) for the [<pre>] element. HTML-escaped.
    - [code_class]: extra class(es) for the [<code>] element. HTML-escaped.
    - [line_numbers]: emit [data-line="N"] on each line [<span>].
    - [css_variable_prefix]: prefix for CSS custom properties (default
      ["--ochre-"]). {!make} appends a trailing ['-'] if missing, so a value
      built straight from this field always ends with ['-']. The renderer
      replaces each byte outside [A-Za-z0-9_-] by ['_'], because the prefix is
      part of CSS property names.
    - [scopes_as_data_attrs]: emit [data-scope="..."] on token [<span>]s. *)

val normalize_css_variable_prefix : string -> string
(** Appends a ['-'] when the prefix does not end with one. *)

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
(** Construct options with defaults for any unspecified fields.

    [css_variable_prefix] must end with ['-']; if the given value does not, a
    ['-'] is appended. *)
