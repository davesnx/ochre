(** HTML renderer for highlighted code.

    Produces a self-contained [<pre><code>...</code></pre>] block. By default
    uses inline CSS styles for colors and font styles, matching the legacy
    output. Pass [~options] to control style mode, line numbers, CSS variable
    prefix, and other rendering behaviour. *)

(** {2 Untrusted strings}

    A theme name, a theme colour, an option and a label can come from outside
    the program. Each one is made safe for the place it is written to:
    - Colours (token colours, theme [fg] and [bg]) must be plain CSS colours:
      [#rgb], [#rgba], [#rrggbb], [#rrggbbaa], a keyword of letters, or an
      [rgb]-, [hsl]-, [hwb]-, [lab]-, [lch]-, [oklab]- or [oklch]-style function
      with numeric arguments. The renderer leaves out the declaration or
      attribute of any other value, instead of writing it.
    - Class prefixes, custom-property prefixes and extra-theme labels are
      written into CSS names: each byte outside [A-Za-z0-9_-] becomes ['_'].
    - Theme names, [pre_class], [code_class], decoration classes, and data
      values are HTML-escaped as attribute values.
    - Source text is HTML-escaped; bytes that are not valid UTF-8 and NUL become
      U+FFFD.

    {2 Class registry}

    When using [Html_options.Css_classes] mode, the renderer collects a mapping
    from inline styles to generated class names. Use {!render_theme_css} to
    extract a CSS stylesheet for a theme and a set of highlighted code. *)

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
      <pre class="ochre"
           style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)"
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
    - [scopes_as_data_attrs]: add [data-scope="..."] on token spans

    In [Css_classes] mode a token's theme style becomes a class (see
    {!Html_options.style_mode}); a decoration [style] and the extra-theme custom
    properties stay inline. *)

val theme_css : string -> string
(** [theme_css label] returns a CSS rule that activates the theme stored under
    CSS custom properties with the given label.

    {[
    theme_css "dark"
    ]}

    produces:

    {[
      .ochre,
      .ochre span {
        --ochre: var(--ochre-dark);
        --ochre-bg: var(--ochre-dark-bg);
        --ochre-font-style: var(--ochre-dark-font-style);
        --ochre-font-weight: var(--ochre-dark-font-weight);
        --ochre-text-decoration: var(--ochre-dark-text-decoration);
      }
    ]}

    [label] is sanitised: each byte outside [A-Za-z0-9_-] becomes ['_'].

    Wrap this in your own selector (e.g. a media query, a [.dark] class rule, or
    a [data-theme="dark"]) to control when the theme activates. *)

val render_theme_css :
  class_prefix:string -> Theme.theme -> Token.highlighted_code -> string
(** [render_theme_css ~class_prefix theme code] generates a complete CSS
    stylesheet for the given theme and highlighted code. Walks all tokens to
    discover unique styles and maps each to a deterministic class name. *)
