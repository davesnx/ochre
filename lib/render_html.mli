(** HTML renderer for highlighted code.

    Produces a self-contained [<pre><code>...</code></pre>] block. By default
    uses inline CSS styles for colors and font styles, matching the legacy
    output. Pass [~options] to control style mode, line numbers, CSS variable
    prefix, and other rendering behaviour. *)

(** {2 Class registry}

    When using [Html_options.Css_classes] mode, the renderer collects a mapping
    from inline styles to generated class names. Use {!collect_classes} after
    rendering to extract a CSS stylesheet. *)

type class_registry
(** Opaque type holding style-to-class mappings. *)

val render :
  ?options:Html_options.t ->
  Theme.theme ->
  ?extra_themes:(string * Theme.theme * Token.highlighted_code) list ->
  Token.highlighted_code ->
  string
(** Render highlighted code to an HTML string.

    {3 Default (backward-compatible) output}

    {[
      <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"
           tabindex="0">
        <code>
          <span class="line">...</span>
        </code>
      </pre>
    ]}

    {3 Multi-theme output}

    When [~extra_themes] is provided, each [(label, theme, tokens)] entry adds
    CSS custom properties ([--ochre-<label>], [--ochre-<label>-bg], etc.) to
    every token, and the [<pre>] element carries all theme names and variables.

    {3 Options}

    Pass [~options] to control:
    - [style_mode]: inline styles (default) or CSS classes
    - [default_color]: whether the primary theme gets inline [color:]
    - [line_numbers]: add [data-line="N"] to each line span
    - [css_variable_prefix]: custom prefix for CSS vars (default ["--ochre-"])
    - [pre_class] / [code_class]: extra classes on wrapper elements
    - [scopes_as_data_attrs]: add [data-scope="..."] on token spans *)

val theme_css : ?prefix:string -> string -> string
(** [theme_css ?prefix label] returns a CSS rule that activates the theme stored
    under CSS custom properties with the given prefix and label.

    Default prefix: ["--ochre-"].

    {[
      theme_css "dark"
    ]}

    produces:

    {[
      .ochre,
      .ochre span {
        color: var(--ochre-dark) !important;
        background-color: var(--ochre-dark-bg) !important;
        ...
      }
    ]}

    Wrap this in your own selector (e.g. a media query, a [.dark] class rule, or
    a [data-theme="dark"]) to control when the theme activates. *)

val theme_prefers_dark_css : ?prefix:string -> unit -> string
(** [theme_prefers_dark_css ?prefix ()] returns {!theme_css} for ["dark"]
    wrapped in an [@media (prefers-color-scheme: dark)] query.

    Pass [~prefix] to match a custom {!Html_options.css_variable_prefix}. *)

val collect_classes : class_registry -> string
(** Extract a CSS stylesheet from a class registry.

    Returns CSS rules mapping each generated class name to its styles. Only
    meaningful after rendering with [Css_classes] style mode. *)

val render_theme_css :
  class_prefix:string -> Theme.theme -> Token.highlighted_code -> string
(** [render_theme_css ~class_prefix theme code] generates a complete CSS
    stylesheet for the given theme and highlighted code. Walks all tokens to
    discover unique styles and maps each to a deterministic class name. *)
