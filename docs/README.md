
# Module `Ochre`

Syntax highlighter using TextMate grammars and themes.

Ochre turns source code into highlighted output using TextMate grammars (the same tokenizer that powers VS Code) and TextMate/VS Code themes. It supports HTML, ANSI terminal colors, LaTeX, and SVG output formats.

```ocaml
  let highlighter = Ochre.load_exn [ ("ocaml", ocaml_grammar_json) ] in
  let html =
    Ochre.to_html highlighter ~theme:Ochre.Theme.nord ~lang:"ocaml"
      "let x = 42"
```

## Highlighter

The highlighter holds loaded grammars and drives tokenization. Load one with [`load`](./#val-load) or [`load_from_files`](./#val-load_from_files), then pass it to any backend function.

```ocaml
type t
```
Highlighter instance. Holds loaded grammars and tokenization state.


### load

```ocaml
val load : (string * string) list -> (t, string) Stdlib.result
```
Load a highlighter from grammar JSON strings.

Each pair is `(lang_id, json_content)` where `lang_id` is the language identifier and `json_content` is the raw TextMate grammar JSON.

Returns `Error msg` when a grammar fails to parse.

```ocaml
match Ochre.load [ ("ocaml", Tm_grammar_ocaml.json) ] with
| Ok hl ->
    Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
| Error msg ->
    failwith msg
```

### load\_exn

```ocaml
val load_exn : (string * string) list -> t
```
Like [`load`](./#val-load) but raises on failure.

```ocaml
let hl = Ochre.load_exn [ ("ocaml", Tm_grammar_ocaml.json) ]
```

### load\_from\_files

```ocaml
val load_from_files : string list -> (t, string) Stdlib.result
```
Load a highlighter from grammar files on disk.

Each grammar is a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `"ocaml.tmLanguage.json"` registers as `"ocaml"`).

Returns `Error msg` when a file cannot be read or a grammar fails to parse.

```ocaml
match
  Ochre.load_from_files [ "/usr/share/grammars/ocaml.tmLanguage.json" ]
with
| Ok hl ->
    Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
| Error msg ->
    failwith msg
```

### load\_from\_files\_exn

```ocaml
val load_from_files_exn : string list -> t
```
Like [`load_from_files`](./#val-load_from_files) but raises on failure.

```ocaml
let hl =
  Ochre.load_from_files_exn [ "/usr/share/grammars/ocaml.tmLanguage.json" ]
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

### to\_tokens

```ocaml
val to_tokens : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
```
Highlight source code and return structured tokens. Use this when you need full control over rendering.

When `~decorations` or `~transforms` are provided, decorations are applied after tokenization and transforms run after decorations.

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

### to\_html

```ocaml
val to_html : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?extra_themes:(string * Theme.theme) list ->
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
  Ochre.Html_options.make ~line_numbers:true ~default_color:No_default_color
    ()
in
Ochre.to_html hl ~options:opts ~theme ~lang:"ocaml" code
```
When `~theme` is omitted but `~extra_themes` is provided, the first entry becomes the default. When neither `~theme` nor `~extra_themes` is provided, [`Theme.dark`](./Ochre-Theme.md#val-dark) is used as the default.

Pair with [`html_theme_css`](./#val-html_theme_css) to activate alternate themes via CSS.


### html\_theme\_css

```ocaml
val html_theme_css : string -> string
```
`html_theme_css label` returns a CSS rule that maps base variables (`--ochre-*`) to the label-scoped variables (`--ochre-<label>-*`).

Wrap this in your own selector (a media query, a `.dark` class, a `data-theme` attribute selector, etc.) to control when the theme activates.

```ocaml
Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
```

### html\_render\_theme\_css

```ocaml
val html_render_theme_css : 
  class_prefix:string ->
  Theme.theme ->
  Token.highlighted_code ->
  string
```
`html_render_theme_css ~class_prefix theme code` generates a complete CSS stylesheet for the given theme and highlighted code when using [`Html_options.style_mode.Css_classes`](./Ochre-Html_options.md#type-style_mode.Css_classes) mode. Walks all tokens to discover unique styles and maps each to a deterministic class name prefixed with `class_prefix`.

```ocaml
let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
let css = Ochre.html_render_theme_css ~class_prefix:"oc-" theme tokens in
Printf.printf "<style>%s</style>" css
```

### to\_ansi

```ocaml
val to_ansi : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
let ansi = Ochre.to_ansi hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code in
print_string ansi
```

### to\_latex

```ocaml
val to_latex : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code to LaTeX with `\textcolor` commands.

Produces a block wrapped in an `ochrehighlight` environment. Requires the `xcolor` and `soul` LaTeX packages. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
let latex = Ochre.to_latex hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code in
Printf.printf "\\begin{document}\n%s\n\\end{document}" latex
```

### to\_svg

```ocaml
val to_svg : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code to a self-contained SVG element.

Produces an `<svg>` with monospace `<text>` elements and per-token `<tspan>` styling. Suitable for embedding in documents or rendering as an image. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
let svg = Ochre.to_svg hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
```

### to\_debug\_tokens

```ocaml
val to_debug_tokens : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code and render each token as `{text}[scope1,scope2,...]`.

Useful for debugging grammar and scope matching. Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
let debug =
  Ochre.to_debug_tokens hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
in
print_string debug
```

### output\_format

```ocaml
type output_format = 
  | Html
  | Ansi
  | Latex
  | Svg
  | Tokens (* Supported output formats. Use with to_string to select a backend at runtime. *)
```

### output\_formats

```ocaml
val output_formats : (string * output_format) list
```
Mapping of format names to typed variants.


### string\_of\_output\_format

```ocaml
val string_of_output_format : output_format -> string
```
Convert a format variant to its canonical lowercase name.


### output\_format\_of\_string

```ocaml
val output_format_of_string : string -> output_format option
```
Parse a format name into a variant. Returns `None` for unrecognised names.


### to\_string

```ocaml
val to_string : 
  t ->
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
```
Highlight source code to one of the supported output formats.

```ocaml
let output = Ochre.to_string hl ~format:Html ~theme ~lang:"ocaml" code
```

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