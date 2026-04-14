
# Module `Ochre`

Syntax highlighter using TextMate grammars and themes.

Ochre turns source code into highlighted output using TextMate grammars (the same tokenizer that powers VS Code) and TextMate/VS Code themes. It supports HTML, ANSI terminal colors, LaTeX, and SVG output formats.

```ocaml
  let highlighter = Ochre.create_exn [ ("ocaml", ocaml_grammar_json) ] in
  let html =
    Ochre.to_html highlighter ~theme:Ochre.Theme.nord ~lang:"ocaml"
      "let x = 42"
```

## Create a highlighter

The highlighter holds loaded grammars and drives tokenization. Create one with [`create`](./#val-create) or [`create_from_files`](./#val-create_from_files), then pass it to any backend function.

```ocaml
type t
```
Highlighter instance. Holds loaded grammars and tokenization state.

```ocaml
val create : (string * string) list -> (t, string) Stdlib.result
```
create

Create a highlighter from grammar JSON strings.

Each pair is `(lang_id, json_content)` where `lang_id` is the language identifier and `json_content` is the raw TextMate grammar JSON.

Returns `Error msg` when a grammar fails to parse.

```ocaml
  match Ochre.create [ ("ocaml", Tm_grammar_ocaml.json) ] with
  | Ok hl ->
      Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
  | Error msg ->
      failwith msg
```
```ocaml
val create_exn : (string * string) list -> t
```
create\_exn

Create a highlighter from grammar JSON strings and raise on failure.

Like [`create`](./#val-create) but raises on failure.

```ocaml
  let hl = Ochre.create_exn [ ("ocaml", Tm_grammar_ocaml.json) ]
```
```ocaml
val create_from_files : string list -> (t, string) Stdlib.result
```
create\_from\_files

Create a new highlighter from grammar files on disk.

Each grammar is a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `"ocaml.tmLanguage.json"` registers as `"ocaml"`).

Returns `Error msg` when a file cannot be read or a grammar fails to parse.

```ocaml
  match
    Ochre.create_from_files [ "/usr/share/grammars/ocaml.tmLanguage.json" ]
  with
  | Ok hl ->
      Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
  | Error msg ->
      failwith msg
```
```ocaml
val create_from_files_exn : string list -> t
```
create\_from\_files\_exn

Like [`create_from_files`](./#val-create_from_files) but raises on failure.

```ocaml
  let hl =
    Ochre.create_from_files_exn
      [ "/usr/share/grammars/ocaml.tmLanguage.json" ]
```

## Tokens

Tokens are the basic unit of highlighted code. After tokenization, each fragment of source code becomes a [`Token.styled_token`](./Ochre-Token.md#type-styled_token) carrying colors, font styles, and scope information resolved from a theme.

```ocaml
module Token : sig ... end
```

## Themes

A theme maps TextMate scopes to colors and font styles. Ochre ships with several built-in themes and can load any VS Code / TextMate theme from JSON.

```ocaml
module Theme : sig ... end
```

## Backends

Ochre can render highlighted code to several output formats. All backends share the same pattern: pass a highlighter, a theme, a language, and the source code.

- **HTML** — Self-contained `<pre><code>` blocks with inline styles or CSS classes. Supports multi-theme via CSS custom properties, line numbers, and configurable class prefixes.
- **ANSI** — 24-bit color escape sequences for terminal display.
- **LaTeX** — `\textcolor` commands inside an `ochrehighlight` environment. Requires the `xcolor` and `soul` packages.
- **SVG** — Standalone `<svg>` elements with monospace `<text>` and per-token `<tspan>` styling.
- **Tokens** — Structured token output for full rendering control.
- **Debug tokens** — Raw token text for debugging grammar and scope matching.
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
        (fun (tok : Ochre.Token.styled_token) -> Printf.printf "%s" tok.text)
        line
    )
    tokens
```

### HTML options

```ocaml
module Html_options : sig ... end
```
```ocaml
val to_html : 
  t ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?extra_themes:(string * Theme.theme) list ->
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

Pass `~extra_themes` with labelled extra themes. Each label becomes a CSS custom property prefix (`--ochre-<label>`). The default theme is emitted as base fallback variables (`var(--ochre-bg,<bg>)`, `var(--ochre,<fg>)`), while extra themes are emitted as label-scoped variables.

```ocaml
  Ochre.to_html hl ~theme:Ochre.Theme.light
    ~extra_themes:[ ("dark", Ochre.Theme.nord) ]
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
When `~theme` is omitted but `~extra_themes` is provided, the first entry becomes the default. When neither `~theme` nor `~extra_themes` is provided, [`Theme.dark`](./Ochre-Theme.md#val-dark) is used as the default.

Pair with [`html_theme_css`](./#val-html_theme_css) to activate alternate themes via CSS.

```ocaml
val html_theme_css : string -> string
```
html\_theme\_css

`html_theme_css label` returns a CSS rule that maps base variables (`--ochre-*`) to the label-scoped variables (`--ochre-<label>-*`).

Wrap this in your own selector (a media query, a `.dark` class, a `data-theme` attribute selector, etc.) to control when the theme activates.

```ocaml
  Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
```
```ocaml
val html_render_theme_css : 
  class_prefix:string ->
  Theme.theme ->
  Token.highlighted_code ->
  string
```
html\_render\_theme\_css

`html_render_theme_css ~class_prefix theme code` generates a complete CSS stylesheet for the given theme and highlighted code when using [`Html_options.style_mode.Css_classes`](./Ochre-Html_options.md#type-style_mode.Css_classes) mode. Walks all tokens to discover unique styles and maps each to a deterministic class name prefixed with `class_prefix`.

```ocaml
  let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
  let css = Ochre.html_render_theme_css ~class_prefix:"oc-" theme tokens in
  Printf.printf "<style>%s</style>" css
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
  | Tokens (* Supported output formats. Use with to_string to select a backend at runtime. *)
```
output\_format

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

### Result-returning variants

These wrap the corresponding exception-raising functions and return `(string, string) result` instead of raising. `Failure`, `TmLanguage.Error`, and `Oniguruma.Error` are caught and returned as `Error msg`.

```ocaml
val to_html_result : 
  t ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?extra_themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  (string, string) Stdlib.result
```
to\_html\_result

Like [`to_html`](./#val-to_html) but returns a `result` instead of raising.

```ocaml
val to_ansi_result : 
  t ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  (string, string) Stdlib.result
```
to\_ansi\_result

Like [`to_ansi`](./#val-to_ansi) but returns a `result` instead of raising.

```ocaml
val to_latex_result : 
  t ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  (string, string) Stdlib.result
```
to\_latex\_result

Like [`to_latex`](./#val-to_latex) but returns a `result` instead of raising.

```ocaml
val to_svg_result : 
  t ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  (string, string) Stdlib.result
```
to\_svg\_result

Like [`to_svg`](./#val-to_svg) but returns a `result` instead of raising.


## Transforms

Transforms run after tokenization and theming, but before rendering. They can modify tokens, lines, or the entire document in a composable way.

```ocaml
module Transform : sig ... end
```

### Built-in transforms

Ready-to-use transforms for common highlighting patterns.

```ocaml
module Transform_builtin : sig ... end
```

## Decorations

Decorations attach format-agnostic properties (CSS class, inline style, data attributes) to ranges of source code identified by line/character position. They are applied after tokenization but before transforms.

```ocaml
module Decoration : sig ... end
```

## Highlighting with transforms and decorations

These functions combine backends with optional decorations and transforms. Decorations are applied after tokenization/theming but before transforms.

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
  ?extra_themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
```
to\_html\_with

Like [`to_html`](./#val-to_html) but applies decorations and transforms before rendering. Accepts the same `~theme` / `~extra_themes` / `~options` parameters as [`to_html`](./#val-to_html).

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
