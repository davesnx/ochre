
# Module `Ochre`

Ochre \- Syntax highlighter using TextMate grammars and themes.

Ochre uses TextMate grammars (the same engine as VS Code) and themes to produce accurate syntax highlighting in multiple output formats.


### Quick start

```ocaml
  let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
  let html = Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
```

## Token types

```
module Token : sig ... end
```

## Themes

```
module Theme : sig ... end
```

## Highlighter

```
type t
```
Highlighter instance. Holds loaded grammars and tokenization state.

```
type output_format = 
```
```
| Html
```
```
| Ansi
```
```
| Latex
```
```
| Svg
```
```
| Tokens
```
Supported output formats.

```

```
```
val output_formats : (string * output_format) list
```
Mapping of CLI/output format names to typed variants.

```
val string_of_output_format : output_format -> string
```
Convert a format variant to its canonical lowercase name.

```
val output_format_of_string : string -> output_format option
```
Parse a lowercase/uppercase format name into a variant.

```
val create : grammars:string list -> unit -> t
```
Create a new highlighter with the given grammar files.

Each grammar is a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `"ocaml.tmLanguage.json"` registers as `"ocaml"`).

```ocaml
  let hl =
    Ochre.create
      ~grammars:[ "/usr/share/grammars/ocaml.tmLanguage.json" ]
      ()
```
```
val create_from_json : grammars:(string * string) list -> unit -> t
```
Create a highlighter from grammar JSON strings.

Each pair is `(lang_id, json_content)` where `lang_id` is the language identifier and `json_content` is the raw TextMate grammar JSON.

```ocaml
  let hl =
    Ochre.create_from_json ~grammars:[ ("ocaml", Tm_grammar_ocaml.json) ] ()
```

## Highlighting

```
val to_tokens : 
  t ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
```
Highlight source code and return styled tokens.

Use this when you need full control over rendering.

Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
  List.iter
    (fun line ->
      List.iter
        (fun (tok : Ochre.Token.styled_token) ->
          Printf.printf "%s" tok.text)
        line)
    tokens
```
```
val to_html : 
  t ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
```
Highlight source code to HTML.

Single theme

Pass `~theme` for a self-contained block with inline styles:

```ocaml
  Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
```
Multiple themes

Pass `~themes` with labelled extra themes. Each label becomes a CSS custom property prefix (`--ochre-<label>`). The default theme's colors are emitted as direct CSS properties; extra themes' colors become CSS variables:

```ocaml
  Ochre.to_html hl ~theme:Ochre.Theme.light
    ~themes:[ ("dark", Ochre.Theme.nord) ]
    ~lang:"ocaml" "let x = 42"
```
produces:

```ocaml
  <pre class="ochre ochre-themes light nord"
       style="background-color:#fff;color:#24292e;--ochre-dark-bg:#2e3440;--ochre-dark:#d8dee9"
       tabindex="0">
    <code>
      <span class="line">
        <span style="color:#d73a49;--ochre-dark:#81a1c1">let</span>
      </span>
    </code>
  </pre>
```
When `~theme` is omitted but `~themes` is provided, the first entry becomes the default.

Pair with [`html_dark_mode_css`](./#val-html_dark_mode_css) or [`html_css_for_theme`](./#val-html_css_for_theme) to activate alternate themes via CSS.

raises `Invalid_argument` if neither ~theme nor ~themes is provided.
```
val html_dark_mode_css : string
```
CSS snippet that activates the `"dark"` theme variant via `@media (prefers-color-scheme: dark)`.

```ocaml
  @media (prefers-color-scheme: dark) {
    .ochre,
    .ochre span {
      color: var(--ochre-dark) !important;
      background-color: var(--ochre-dark-bg) !important;
      font-style: var(--ochre-dark-font-style) !important;
      font-weight: var(--ochre-dark-font-weight) !important;
      text-decoration: var(--ochre-dark-text-decoration) !important;
    }
  }
```
Include this in a `<style>` tag or external stylesheet.

```
val html_css_for_theme : string -> string
```
`html_css_for_theme label` returns a CSS rule body that activates the theme stored under `--ochre-<label>-*` variables.

Wrap this in your own selector (a media query, a `.dark` class, a `data-theme` attribute selector, etc.) to control when the theme activates.

```ocaml
  (* For a class-based toggle: *)
  Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_css_for_theme "dark")
```
```
val to_ansi : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display.

Raises `Failure` if the grammar for `lang` cannot be found.

```
val to_latex : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code to LaTeX with `\textcolor` commands.

Produces a block wrapped in an `ochrehighlight` environment. Requires the `xcolor` and `soul` LaTeX packages.

Raises `Failure` if the grammar for `lang` cannot be found.

```
val to_svg : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code to a self-contained SVG element.

Produces an `<svg>` with monospace `<text>` elements and per-token `<tspan>` styling. Suitable for embedding in documents or rendering as an image.

Raises `Failure` if the grammar for `lang` cannot be found.

```
val to_debug_tokens : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code and render each token as `{text}[scope1,scope2,...]`.

Useful for debugging grammar and scope matching.

Raises `Failure` if the grammar for `lang` cannot be found.

```
val to_string : 
  t ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code to one of the supported output formats.


## Decorations

```
module Decoration : sig ... end
```

## Transforms

```
module Transform : sig ... end
```

## Built-in transforms

```
module Transform_builtin : sig ... end
```

## Highlighting with transforms and decorations

These functions are like their counterparts above but accept an optional `~decorations` list and a required `~transforms` list. Decorations are applied after tokenization/theming but before transforms. The original functions behave as if `~decorations:[]` and `~transforms:[]` were passed.

```
val to_tokens_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
```
Like [`to_tokens`](./#val-to_tokens) but applies decorations and transforms before returning.

```
val to_html_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
```
Like [`to_html`](./#val-to_html) but applies decorations and transforms before rendering.

Accepts the same `~theme` / `~themes` options as [`to_html`](./#val-to_html).

```
val to_ansi_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Like [`to_ansi`](./#val-to_ansi) but applies decorations and transforms before rendering.

```
val to_latex_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Like [`to_latex`](./#val-to_latex) but applies decorations and transforms before rendering.

```
val to_svg_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Like [`to_svg`](./#val-to_svg) but applies decorations and transforms before rendering.

```
val to_debug_tokens_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Like [`to_debug_tokens`](./#val-to_debug_tokens) but applies decorations and transforms before rendering.

```
val to_string_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Like [`to_string`](./#val-to_string) but applies decorations and transforms before rendering.
