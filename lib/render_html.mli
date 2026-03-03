(** HTML renderer for highlighted code.

    Produces a self-contained [<pre><code>...</code></pre>] block with inline
    CSS styles for colors and font styles. *)

val render :
  Theme.theme ->
  ?themes:(string * Theme.theme * Token.highlighted_code) list ->
  Token.highlighted_code ->
  string
(** Render highlighted code to an HTML string.

    When called with just a theme and code, produces a single-theme block with
    the theme's default foreground and background on the [<pre>] element:

    {[
      <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4">
        <code style="display:block;padding:20px">...</code>
      </pre>
    ]}

    When [~themes] is provided, each [(label, theme, tokens)] entry adds CSS
    custom properties ([--ochre-<label>], [--ochre-<label>-bg], etc.) to every
    token, and the [<pre>] element carries all theme names and variables:

    {[
      <pre class="ochre ochre-themes light dark"
           style="background-color:#fff;color:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4"
           tabindex="0">
        <code>
          <span class="line">
            <span style="color:#d73a49;--ochre-dark:#ff0000">let</span>
          </span>
        </code>
      </pre>
    ]} *)

val css_for_theme : string -> string
(** [css_for_theme label] returns a CSS rule body that activates the theme
    stored under [--ochre-<label>-*] variables.

    {[
      css_for_theme "dark"
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

val dark_mode_css : string
(** A ready-to-use CSS snippet that activates the ["dark"] theme variant via
    [@media (prefers-color-scheme: dark)].

    Equivalent to wrapping {!css_for_theme}["dark"] in the media query. *)
