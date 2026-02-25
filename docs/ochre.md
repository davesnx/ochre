
# Module `Ochre`

Ochre \- Syntax highlighter using TextMate grammars and themes.

Ochre uses TextMate grammars (the same engine as VS Code) and themes to produce accurate syntax highlighting in multiple output formats.


### Quick start

```ocaml
  let hl = Ochre.create ~grammar_paths:["/path/to/grammars"] () in
  Ochre.load_theme_from_file hl "path/to/theme.json";
  let html = Ochre.highlight_to_html hl ~lang:"ocaml" source_code
```

## Highlighter

```
type t
```
Highlighter instance. Holds the current theme and grammar loader state.

```
val create : ?theme:Theme.theme -> ?grammar_paths:string list -> unit -> t
```
Create a new highlighter.

parameter theme Optional pre-loaded theme.
parameter grammar\_paths Directories to search for .tmLanguage.json files.
```ocaml
  let hl = Ochre.create
    ~grammar_paths:["/usr/share/grammars"; "./my-grammars"] ()
```
```
val load_theme : t -> Theme.theme -> unit
```
Set the active theme for highlighting.

```
val load_theme_from_file : t -> string -> unit
```
Load a theme from a JSON file and set it as the active theme.

```ocaml
  Ochre.load_theme_from_file hl "themes/dark-plus.json"
```
```
val add_grammar_path : t -> string -> unit
```
Add a directory to the grammar search path.

Grammars are resolved by language identifier, trying `<lang>.tmLanguage.json`, `<lang>.json`, and `<lang>` in order.


## Highlighting

```
val highlight_to_tokens : t -> lang:string -> string -> Token.highlighted_code
```
Highlight source code and return styled tokens.

Use this when you need full control over rendering.

Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let tokens = Ochre.highlight_to_tokens hl ~lang:"ocaml" code in
  List.iter (fun line ->
    List.iter (fun (tok : Token.styled_token) ->
      Printf.printf "%s" tok.text
    ) line
  ) tokens
```
```
val highlight_to_html : t -> lang:string -> string -> string
```
Highlight source code to HTML with inline styles.

Produces a self-contained `<pre><code>...</code></pre>` block.

Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let html = Ochre.highlight_to_html hl ~lang:"ocaml" "let x = 42"
```
```
val highlight_to_ansi : t -> lang:string -> string -> string
```
Highlight source code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display.

Raises `Failure` if the grammar for `lang` cannot be found.


## Re-exported modules

```
module Token : sig ... end
```
Core types for styled syntax highlighting.

```
module Theme : sig ... end
```
TextMate / VS Code theme loading and representation.
