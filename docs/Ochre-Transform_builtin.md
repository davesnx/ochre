
# Module `Ochre.Transform_builtin`


### line\_highlight

```ocaml
val line_highlight : ?background:string -> int list -> Transform.t
```
Highlights the given line indices (0-based) by setting every token's background color.

Default background: `"#8888883a"`.

```ocaml
Ochre.to_html hl
  ~transforms:[ Ochre.Transform_builtin.line_highlight [ 0; 2 ] ]
  ~theme ~lang:"ocaml" code
```

### word\_highlight

```ocaml
val word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  string list ->
  Transform.t
```
Highlights tokens whose text matches one of the given words.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```ocaml
Ochre.to_html hl
  ~transforms:[ Ochre.Transform_builtin.word_highlight [ "x"; "y" ] ]
  ~theme ~lang:"ocaml" code
```

### diff\_markers

```ocaml
val diff_markers : Transform.t
```
Strips leading `+` or `-` from the first token of each line and applies a green or red background to the entire line.


### scope\_marker

```ocaml
val scope_marker : ?background:string -> string -> Transform.t
```
Highlights tokens that have at least one scope starting with `prefix`.

Default background: `"#ffff0033"`.


### notation\_highlight

```ocaml
val notation_highlight : ?background:string -> unit -> Transform.t
```
Notation-based line highlight. Finds a `[!code highlight]` or `[!code hl]` marker in the comment that ends a line, removes it, and sets the background color on the entire line. Mirrors Shiki's `transformerNotationHighlight`, and so do the rules below, which hold for the three notation transforms.

The marker must be inside the last comment of the line: a `//`, `#`, `;`, `%` or `--` comment that runs to the end of the line, or a `/* */`, `<!-- -->`, `(* *)`, `{- -}` or `--[[ ]]` comment that closes at the end of the line. A comment is found from its comment scope when the grammar gives one, and from its opener otherwise, so plain text and Markdown work too. A marker in a string, or in a block comment that code follows, is left alone. The whole comment goes, with the blanks before it, when the marker was all it held; other text in the comment stays. The newline stays.

`[!code highlight:3]` applies to three lines. When the comment is alone on its line, the line is removed and the marker applies to the lines below it.

Default background: `"#8888883a"`.

```ocaml
let code = "let x = 42 // [!code highlight]\nlet y = 10" in
let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
Ochre.to_html hl ~transforms ~theme ~lang:"test" code
```

### notation\_diff

```ocaml
val notation_diff : 
  ?add_background:string ->
  ?remove_background:string ->
  unit ->
  Transform.t
```
Notation-based diff markers. Finds `[!code ++]` and `[!code --]` markers in comments, removes them, and applies green or red backgrounds to the entire line. Mirrors Shiki's `transformerNotationDiff`; see [`notation_highlight`](./#val-notation_highlight) for where a marker may sit and what is removed.

Default add background: `"#22883322"`. Default remove background: `"#88222222"`.

```ocaml
let code = "let x = 42 // [!code ++]\nlet y = 10 // [!code --]" in
let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
Ochre.to_html hl ~transforms ~theme ~lang:"test" code
```

### notation\_word\_highlight

```ocaml
val notation_word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  unit ->
  Transform.t
```
Notation-based word highlight. Finds `[!code word:xxx]` markers in comments, removes them, and highlights all occurrences of `xxx`, across token boundaries. Without a count the highlight runs from the line of the marker to the end of the code; `[!code word:xxx:2]` limits it to two lines. A backslash escapes a character of the word. Mirrors Shiki's `transformerNotationWordHighlight`; see [`notation_highlight`](./#val-notation_highlight) for where a marker may sit and what is removed.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```ocaml
let code = "let x = 42 // [!code word:x]" in
let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
Ochre.to_html hl ~transforms ~theme ~lang:"test" code
```