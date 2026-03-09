
# Module `Ochre`

Ochre \- Syntax highlighter using TextMate grammars and themes.

Ochre uses TextMate grammars (the same engine as VS Code) and themes to produce accurate syntax highlighting in multiple output formats.


### Quick start

```ocaml
  let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
  let html = Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
```

## Token types

Tokens are the basic unit of highlighted code. After tokenization, each fragment of source code becomes a [`Token.styled_token`](./Ochre-Token.md#type-styled_token) carrying colors, font styles, and scope information resolved from a theme.

```ocaml
module Token : sig ... end
```

## Themes

A theme maps TextMate scopes to colors and font styles. Ochre ships with several built-in themes and can load any VS Code / TextMate theme from JSON.

```ocaml
module Theme : sig ... end
```

## Highlighter

The highlighter holds loaded grammars and drives tokenization. Create one with [`create`](./#val-create) or [`create_from_json`](./#val-create_from_json), then pass it to any backend function.

```ocaml
type t
```
Highlighter instance. Holds loaded grammars and tokenization state.

```ocaml
val create : grammars:string list -> unit -> t
```
create

Create a new highlighter from grammar files on disk.

Each grammar is a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `"ocaml.tmLanguage.json"` registers as `"ocaml"`).

```ocaml
  let hl =
    Ochre.create
      ~grammars:[ "/usr/share/grammars/ocaml.tmLanguage.json" ]
      ()
```
```ocaml
val create_from_json : grammars:(string * string) list -> unit -> t
```
create\_from\_json

Create a highlighter from grammar JSON strings.

Each pair is `(lang_id, json_content)` where `lang_id` is the language identifier and `json_content` is the raw TextMate grammar JSON.

```ocaml
  let hl =
    Ochre.create_from_json ~grammars:[ ("ocaml", Tm_grammar_ocaml.json) ] ()
```
```ocaml
val to_tokens : 
  t ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
```
to\_tokens

Highlight source code and return structured tokens. Use this when you need full control over rendering.

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

## Backends

Ochre can render highlighted code to several output formats. All backends share the same pattern: pass a highlighter, a theme, a language, and the source code.

- **HTML** — Self-contained `<pre><code>` blocks with inline styles or CSS classes. Supports multi-theme via CSS custom properties, line numbers, and configurable class prefixes.
- **ANSI** — 24-bit color escape sequences for terminal display.
- **LaTeX** — `\textcolor` commands inside an `ochrehighlight` environment. Requires the `xcolor` and `soul` packages.
- **SVG** — Standalone `<svg>` elements with monospace `<text>` and per-token `<tspan>` styling.
- **Tokens** — Raw token text for debugging grammar and scope matching.

### HTML options

```ocaml
module Html_options : sig ... end
```
```ocaml
val to_html : 
  t ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
```
to\_html

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
Options

Pass `~options` to control rendering behaviour:

```ocaml
  let opts =
    Ochre.Html_options.make ~line_numbers:true
      ~default_color:No_default_color ()
  in
  Ochre.to_html hl ~options:opts ~theme ~lang:"ocaml" code
```
When `~theme` is omitted but `~themes` is provided, the first entry becomes the default. When neither `~theme` nor `~themes` is provided, [`Theme.dark`](./Ochre-Theme.md#val-dark) is used as the default.

Pair with [`html_theme_prefers_dark_css`](./#val-html_theme_prefers_dark_css) or [`html_theme_css`](./#val-html_theme_css) to activate alternate themes via CSS.

```ocaml
val html_theme_css : ?prefix:string -> string -> string
```
html\_theme\_css

`html_theme_css ?prefix label` returns a CSS rule that activates the theme stored under `--ochre-<label>-*` variables.

Pass `~prefix` to match a custom [`Html_options.t.css_variable_prefix`](./Ochre-Html_options.md#type-t.css_variable_prefix). Default: `"--ochre-"`.

Wrap this in your own selector (a media query, a `.dark` class, a `data-theme` attribute selector, etc.) to control when the theme activates.

```ocaml
  Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
```
```ocaml
val html_theme_prefers_dark_css : string
```
html\_theme\_prefers\_dark\_css

[`html_theme_css`](./#val-html_theme_css) for `"dark"` wrapped in an `@media (prefers-color-scheme: dark)` query.

Include this in a `<style>` tag or external stylesheet.

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
```ocaml
val to_ansi : t -> theme:Theme.theme -> lang:string -> string -> string
```
to\_ansi

Highlight source code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let ansi = Ochre.to_ansi hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code in
  print_string ansi
```
```ocaml
val to_latex : t -> theme:Theme.theme -> lang:string -> string -> string
```
to\_latex

Highlight source code to LaTeX with `\textcolor` commands.

Produces a block wrapped in an `ochrehighlight` environment. Requires the `xcolor` and `soul` LaTeX packages. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let latex =
    Ochre.to_latex hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
  in
  Printf.printf "\\begin{document}\n%s\n\\end{document}" latex
```
```ocaml
val to_svg : t -> theme:Theme.theme -> lang:string -> string -> string
```
to\_svg

Highlight source code to a self-contained SVG element.

Produces an `<svg>` with monospace `<text>` elements and per-token `<tspan>` styling. Suitable for embedding in documents or rendering as an image. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let svg = Ochre.to_svg hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
```
```ocaml
val to_debug_tokens : t -> theme:Theme.theme -> lang:string -> string -> string
```
to\_debug\_tokens

Highlight source code and render each token as `{text}[scope1,scope2,...]`.

Useful for debugging grammar and scope matching. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
type output_format = 
  | Html
  | Ansi
  | Latex
  | Svg
  | Tokens
```
output\_format

Supported output formats. Use with [`to_string`](./#val-to_string) to select a backend at runtime.

```ocaml
val output_formats : (string * output_format) list
```
output\_formats

Mapping of format names to typed variants.

```ocaml
val string_of_output_format : output_format -> string
```
string\_of\_output\_format

Convert a format variant to its canonical lowercase name.

```ocaml
val output_format_of_string : string -> output_format option
```
output\_format\_of\_string

Parse a format name into a variant. Returns `None` for unrecognised names.

```ocaml
val to_string : 
  t ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
to\_string

Highlight source code to one of the supported output formats.

```ocaml
  let output = Ochre.to_string hl ~format:Html ~theme ~lang:"ocaml" code
```

## Decorations

Decorations attach format-agnostic properties (CSS class, inline style, data attributes) to ranges of source code identified by line/character position. They are applied after tokenization but before transforms.

```ocaml
module Decoration : sig ... end
```

## Transforms

Transforms run after tokenization and theming, but before rendering. They can modify tokens, lines, or the entire document in a composable way.

```ocaml
module Transform : sig ... end
```

## Built-in transforms

Ready-to-use transforms for common highlighting patterns.

```ocaml
module Transform_builtin : sig ... end
```

## Highlighting with transforms and decorations

These functions are like their counterparts above but accept an optional `~decorations` list and a required `~transforms` list. Decorations are applied after tokenization/theming but before transforms. The original functions behave as if `~decorations:[]` and `~transforms:[]` were passed.

```ocaml
  let code = "let x = 42\nlet y = 10" in
  let decorations =
    [
      Ochre.Decoration.make ~class_:"hl"
        ~start:(Ochre.Decoration.pos 0 4)
        ~end_:(Ochre.Decoration.pos 0 5)
        ();
    ]
  in
  let transforms = [ Ochre.Transform_builtin.line_highlight [ 1 ] ] in
  Ochre.to_html_with hl ~decorations ~transforms ~theme ~lang:"ocaml" code
```
```ocaml
val to_tokens_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
```
to\_tokens\_with

Like [`to_tokens`](./#val-to_tokens) but applies decorations and transforms before returning.

```ocaml
val to_html_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
```
to\_html\_with

Like [`to_html`](./#val-to_html) but applies decorations and transforms before rendering. Accepts the same `~theme` / `~themes` / `~options` parameters as [`to_html`](./#val-to_html).

```ocaml
val to_ansi_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
to\_ansi\_with

Like [`to_ansi`](./#val-to_ansi) but applies decorations and transforms before rendering.

```ocaml
val to_latex_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
to\_latex\_with

Like [`to_latex`](./#val-to_latex) but applies decorations and transforms before rendering.

```ocaml
val to_svg_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
to\_svg\_with

Like [`to_svg`](./#val-to_svg) but applies decorations and transforms before rendering.

```ocaml
val to_debug_tokens_with : 
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
to\_debug\_tokens\_with

Like [`to_debug_tokens`](./#val-to_debug_tokens) but applies decorations and transforms before rendering.

```ocaml
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
to\_string\_with

Like [`to_string`](./#val-to_string) but applies decorations and transforms before rendering.
