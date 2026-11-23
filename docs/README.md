
# Module `Ochre`

Syntax highlighter using TextMate grammars and themes.

Ochre turns source code into highlighted output using TextMate grammars (the same tokenizer that powers VS Code) and TextMate/VS Code themes. It supports HTML, ANSI terminal colors, LaTeX, and SVG output formats.

```ocaml
let html =
  match Ochre.load [ ("ocaml", ocaml_grammar_json) ] with
  | Error e ->
      Error e
  | Ok highlighter -> (
      match Ochre.lang highlighter "ocaml" with
      | Error e ->
          Error e
      | Ok lang ->
          Ok
            (Ochre.to_html
               (Ochre.highlight ~theme:Ochre.Theme.nord ~lang "let x = 42")
            )
    )
```

## Errors

```ocaml
module Error : sig ... end
```

## Colors

```ocaml
module Color : sig ... end
```

## Styles

```ocaml
module Style : sig ... end
```

## Themes

A theme maps TextMate scopes to colors and font styles. Ochre ships with several built-in themes and can load any VS Code / TextMate theme from JSON.

```ocaml
module Theme : sig ... end
```

## Highlighter

The highlighter holds loaded grammars. Load one with [`load`](./#val-load) or [`load_from_files`](./#val-load_from_files), then look up a language with [`lang`](./#val-lang).

```ocaml
type t
```
Highlighter instance. Holds loaded grammars.


### load

```ocaml
val load : (string * string) list -> (t, Error.t) Stdlib.result
```
Load a highlighter from grammar JSON strings.

Each pair is `(lang_id, json_content)` where `lang_id` is the language identifier and `json_content` is the raw TextMate grammar JSON. Each `lang_id` must be unique.

Returns [`Error.t.Grammar_error`](./Ochre-Error.md#type-t.Grammar_error) when a grammar fails to parse or a `lang_id` is duplicated.

The first call to [`load`](./#val-load) or [`load_from_files`](./#val-load_from_files) in a process configures ochre's Oniguruma regex engine limits (retry and match-stack size) process-wide; later calls do not change them.

```ocaml
match
  Ochre.load
    [
      (Tm_grammar_ocaml.lang_id, Tm_grammar_ocaml.json);
      (Tm_grammar_ocaml_interface.lang_id, Tm_grammar_ocaml_interface.json);
    ]
with
| Ok hl ->
    hl
| Error e ->
    failwith (Ochre.Error.to_string e)
```

### load\_from\_files

```ocaml
val load_from_files : string list -> (t, Error.t) Stdlib.result
```
Load a highlighter from grammar files on disk.

Each grammar is a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `"ocaml.tmLanguage.json"` registers as `"ocaml"`) and must be unique across the given files.

Returns [`Error.t.Grammar_error`](./Ochre-Error.md#type-t.Grammar_error) with the path when a file cannot be read, a grammar fails to parse, or two files derive the same language id.


### Languages

```ocaml
module Lang : sig ... end
```
```ocaml
val lang : t -> string -> (Lang.t, Error.t) Stdlib.result
```
`lang hl id` looks up the language `id` in `hl`. The ids `"plaintext"`, `"text"` and `"txt"` always resolve, to plain text, unless a grammar is registered under that id. Returns [`Error.t.Unknown_language`](./Ochre-Error.md#type-t.Unknown_language) otherwise.

```ocaml
match Ochre.lang hl "ocaml" with
| Ok lang ->
    Ochre.to_html
      (Ochre.highlight ~theme:Ochre.Theme.nord ~lang "let x = 42")
| Error e ->
    failwith (Ochre.Error.to_string e)
```

## Tokens

Tokens are the basic unit of highlighted code. Each token is a fragment of the source with its TextMate scopes, its position in the source, and one [`Style.t`](./Ochre-Style.md#type-t) per theme.

```ocaml
module Token : sig ... end
```

## Decorations

Decorations attach format-agnostic properties (CSS class, inline style, data attributes) to ranges of source code identified by line/character position. They are applied after tokenization but before transforms.

[`Decoration.make`](./Ochre-Decoration.md#val-make) returns [`Error.t.Invalid_data_key`](./Ochre-Error.md#type-t.Invalid_data_key) when a data key is empty or holds a byte outside `A-Za-z0-9_-`, because the key becomes part of a `data-*` attribute name. Decorations and token decoration properties are private records, so every data key goes through this check.

```ocaml
module Decoration : sig ... end
```

## Transforms

Transforms run after tokenization, theming and decorations, but before rendering. They change structure (text, splitting, decorations) through the token fields, and style through [`Token.map_style`](./Ochre-Token.md#val-map_style), which runs once per theme. A token taken from another [`Themed`](./Ochre-Themed.md) value with the same number of themes keeps the styles it carries.

```ocaml
module Transform : sig ... end
```

### Built-in transforms

Ready-to-use transforms for common highlighting patterns. Each one sets its colours on the tokens, and in HTML also adds the class names of the Shiki transformers, so a page can style the marked code with CSS. Ochre ships no CSS. For example:

```css
.ochre .line.highlighted { background-color: #8888883a; }
.ochre .line.diff.add { background-color: #22883322; }
.ochre .line.diff.remove { background-color: #88222222; }
.ochre .highlighted-word { outline: 1px solid currentColor; }
.ochre.has-highlighted .line:not(.highlighted) { opacity: 0.6; }
```
```ocaml
module Transform_builtin : sig ... end
```

## Themed code

Highlighted code is tokenized once and styled under one or more themes.

```ocaml
module Themed : sig ... end
```

## Highlighting

```ocaml
val highlight : 
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  ?label:string ->
  theme:Theme.theme ->
  lang:Lang.t ->
  string ->
  Themed.t
```
`highlight ~theme ~lang source` tokenizes `source` and styles it with `theme`. Decorations are applied after tokenization and transforms run after decorations. `~label` names the theme for HTML with [`Html_options.default_color.No_default_color`](./Ochre-Html_options.md#type-default_color.No_default_color); it defaults to the theme name.

The source may contain bytes that are not valid UTF-8. They are kept byte for byte in the token texts. The tokenizer sees each such byte as an underscore, so it behaves like a non-ASCII letter.

```ocaml
let themed = Ochre.highlight ~theme:Ochre.Theme.nord ~lang code in
List.iter
  (List.iter (fun (tok : Ochre.Token.t) -> print_string tok.text))
  themed.lines
```
```ocaml
val highlight_themes : 
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  ?label:string ->
  theme:Theme.theme ->
  extra_themes:(string * Theme.theme) list ->
  lang:Lang.t ->
  string ->
  (Themed.t, Error.t) Stdlib.result
```
Like [`highlight`](./#val-highlight), styled with the default `theme` and each labelled extra theme. `source` is tokenized once, and each transform runs once: it changes the style under every theme with [`Token.map_style`](./Ochre-Token.md#val-map_style).

Returns [`Error.t.Duplicate_theme_label`](./Ochre-Error.md#type-t.Duplicate_theme_label) when two labels are equal after each byte outside `A-Za-z0-9_-` becomes `'_'`. The default theme takes part with `~label`, or its name. Returns [`Error.t.Foreign_token`](./Ochre-Error.md#type-t.Foreign_token) when a transform returns a token whose number of styles differs from the number of themes, such as a token taken from another [`Themed`](./Ochre-Themed.md) value.

```ocaml
match
  Ochre.highlight_themes ~label:"light" ~theme:Ochre.Theme.light
    ~extra_themes:[ ("dark", Ochre.Theme.nord) ]
    ~lang code
with
| Ok themed ->
    Ochre.to_html themed
| Error e ->
    failwith (Ochre.Error.to_string e)
```

## Backends

Ochre renders [`Themed`](./Ochre-Themed.md) code to several output formats. Render functions never fail.

- **HTML** — Self-contained `<pre><code>` blocks with inline styles or CSS classes. Shows every theme through CSS custom properties.
- **ANSI** — 24-bit color escape sequences for terminal display.
- **LaTeX** — `\textcolor` commands inside an `ochrehighlight` environment. Requires the `xcolor` and `ulem` packages.
- **SVG** — Standalone `<svg>` elements with monospace `<text>` and per-token `<tspan>` styling.
- **Debug tokens** — Raw token text for debugging grammar and scope matching.
ANSI, LaTeX and SVG show the default theme. Use [`Themed.select`](./Ochre-Themed.md#val-select) to show another one.


### HTML options

```ocaml
module Html_options : sig ... end
```

### to\_jsx

```ocaml
val to_jsx : ?options:Html_options.t -> Themed.t -> JSX.element
```
Render highlighted code to an html\_of\_jsx element: a `<pre>` that holds a `<code>`, with one `<span class="line">` per line. Put it in an html\_of\_jsx page, or render it with `JSX.render`. [`to_html`](./#val-to_html) returns `JSX.render (to_jsx ?options themed)`. Render the page with `JSX.render`, not `JSX.pp`: `JSX.pp` adds whitespace, which shows inside `<pre>`.

```ocaml
let page code =
  JSX.node "article" [] [ Ochre.to_jsx (Ochre.highlight ~theme ~lang code) ]
```

### to\_html

```ocaml
val to_html : ?options:Html_options.t -> Themed.t -> string
```
Render highlighted code to HTML.

Single theme

```ocaml
Ochre.to_html (Ochre.highlight ~theme:Ochre.Theme.nord ~lang "let x = 42")
```
Multiple themes

Each extra theme label becomes a CSS custom property prefix (`--ochre-<label>`). The default theme is emitted as base fallback variables (`var(--ochre-bg,<bg>)`, `var(--ochre,<fg>)`), while extra themes are emitted as label-scoped variables. With [`Html_options.default_color.No_default_color`](./Ochre-Html_options.md#type-default_color.No_default_color), the default theme is emitted as `--ochre-<label>` like an extra theme, with its label.

A token follows every theme for its colour, background, `font-weight`, `font-style` and `text-decoration`. When any theme gives a token a value for one of them, the token reads a variable for it, and every extra theme defines that variable, with the neutral value (`normal`, `none`, `transparent`, the theme colour) where the theme has none. So bold, italic, underline, strikethrough and token backgrounds of one theme neither leak into nor vanish from another. The token background uses `--ochre-token-bg`, not the page background `--ochre-bg`. Underline and strikethrough together give `underline line-through`.

Pair with [`html_theme_css`](./#val-html_theme_css) to activate alternate themes via CSS.

Light and dark themes

When there are exactly two themes, labelled `light` and `dark` (in either order), the colours and backgrounds of the `<pre>` and of each token are written as `light-dark(<light>, <dark>)`, in both style modes and with or without a default colour. The browser picks one from the `color-scheme` of the page; the output sets no `color-scheme` itself. With `:root { color-scheme: light dark; }` in the page stylesheet, the code follows the system setting. To switch with a control, set `color-scheme` on the root, for example `:root[data-theme="dark"] { color-scheme: dark; }`: these colours read no CSS variable, so [`html_theme_css`](./#val-html_theme_css) and `css_variable_prefix` do not change them. `font-weight`, `font-style` and `text-decoration` keep the variables above, with the default theme's value as fallback, inline also in [`Html_options.style_mode.Css_classes`](./Ochre-Html_options.md#type-style_mode.Css_classes) mode, so a font style that differs between the two themes still needs [`html_theme_css`](./#val-html_theme_css). Any other set of labels keeps the variable output described above.

```ocaml
let themed =
  Ochre.highlight_themes ~label:"light" ~theme:Ochre.Theme.light
    ~extra_themes:[ ("dark", Ochre.Theme.dark) ]
    ~lang code
in
Result.map Ochre.to_html themed
```

### html\_theme\_css

```ocaml
val html_theme_css : ?css_variable_prefix:string -> string -> string
```
`html_theme_css label` returns a CSS rule that maps base variables (`--ochre-*`) to the label-scoped variables (`--ochre-<label>-*`). `~css_variable_prefix` replaces `"--ochre-"`; give the prefix of the [`Html_options.t`](./Ochre-Html_options.md#type-t) that rendered the code.

Wrap this in your own selector (a media query, a `.dark` class, a `data-theme` attribute selector, etc.) to control when the theme activates.

For two themes labelled `light` and `dark`, the colours are written with `light-dark()` and read no variable, so this rule changes only their `font-weight`, `font-style` and `text-decoration`. Switch their colours with `color-scheme` on the root (see [`to_html`](./#val-to_html)).

```ocaml
Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
```

### html\_render\_theme\_css

```ocaml
val html_render_theme_css : 
  ?css_variable_prefix:string ->
  class_prefix:string ->
  Themed.t ->
  string
```
`html_render_theme_css ~class_prefix themed` generates a complete CSS stylesheet for the default theme of `themed` when using [`Html_options.style_mode.Css_classes`](./Ochre-Html_options.md#type-style_mode.Css_classes) mode. Walks all tokens to discover unique styles and maps each to a deterministic class name prefixed with `class_prefix`. Pass the `css_variable_prefix` of the [`Html_options.t`](./Ochre-Html_options.md#type-t) used to render the HTML as `~css_variable_prefix`; the class names depend on it. For light and dark themes (see [`to_html`](./#val-to_html)) the rules use `light-dark()`.


### to\_ansi

```ocaml
val to_ansi : Themed.t -> string
```
Render highlighted code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display. A terminal has no alpha channel: a translucent background, such as the one of the line-highlight transforms, is blended over the theme background, and a translucent foreground over the background behind it.

```ocaml
print_string
  (Ochre.to_ansi (Ochre.highlight ~theme:Ochre.Theme.nord ~lang code))
```

### to\_latex

```ocaml
val to_latex : Themed.t -> string
```
Render highlighted code to LaTeX with `\textcolor` commands.

Produces a block wrapped in an `ochrehighlight` environment. Requires the `xcolor` and `ulem` LaTeX packages (`\usepackage[normalem]{ulem}` provides `\sout` for strikethrough).

A token background, such as the one of the line-highlight transforms, is drawn with `\colorbox` in a group that sets `\fboxsep` to `0pt`. LaTeX has no alpha channel, so a translucent background is blended over the theme background, and a background equal to the theme background is not drawn. A tab becomes spaces up to the next multiple of 8 columns, a carriage return is dropped, and every other C0 control character and DEL is written in caret notation, like `cat -v`. The output was not compiled with TeX.


### to\_svg

```ocaml
val to_svg : Themed.t -> string
```
Render highlighted code to a self-contained SVG element.

Produces an `<svg>` with monospace `<text>` elements and per-token `<tspan>` styling. Suitable for embedding in documents or rendering as an image. The `<text>` has the theme foreground as `fill`. A token background, such as the one of the line-highlight transforms, is drawn as a `<rect>` behind the text; a background equal to the theme background is not drawn.

The width counts display cells: a Unicode scalar value is one cell, an East Asian wide or fullwidth character two, a combining mark none, and a carriage return none. A tab becomes spaces up to the next multiple of 8 cells, so the indentation survives `xml:space="preserve"`.


### to\_debug\_tokens

```ocaml
val to_debug_tokens : Themed.t -> string
```
Render each token as `{text}[scope1,scope2,...]`.

Useful for debugging grammar and scope matching. Styles are not part of this format, so it is the same under every theme.


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
  ?options:Html_options.t ->
  format:output_format ->
  Themed.t ->
  string
```
Render highlighted code to one of the supported output formats. `~options` applies only to [`Html`](./#type-output_format.Html).

```ocaml
let output = Ochre.to_string ~format:Html themed
```