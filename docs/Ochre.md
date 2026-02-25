
# Module `Ochre`

Ochre \- Syntax highlighter using TextMate grammars and themes.

Ochre uses TextMate grammars (the same engine as VS Code) and themes to produce accurate syntax highlighting in multiple output formats.


### Quick start

```ocaml
  let theme = Ochre.Theme.load_from_file "path/to/theme.json" in
  let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
  let html = Ochre.to_html hl ~theme ~lang:"ocaml" source_code
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
val to_html : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code to HTML with inline styles.

Produces a self-contained `<pre><code>...</code></pre>` block.

Raises `Failure` if the grammar for `lang` cannot be found.

```ocaml
  let html = Ochre.to_html hl ~theme ~lang:"ocaml" "let x = 42"
```
```
val to_ansi : t -> theme:Theme.theme -> lang:string -> string -> string
```
Highlight source code to ANSI terminal escape sequences.

Produces text with embedded 24-bit ANSI color codes for terminal display.

Raises `Failure` if the grammar for `lang` cannot be found.
