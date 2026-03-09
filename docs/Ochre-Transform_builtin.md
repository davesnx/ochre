
# Module `Ochre.Transform_builtin`

```ocaml
val line_highlight : ?background:string -> int list -> Transform.t
```
line\_highlight

Highlights the given line indices (0-based) by setting every token's background color.

Default background: `"#ffffff22"`.

```ocaml
  Ochre.to_html_with hl
    ~transforms:[ Ochre.Transform_builtin.line_highlight [ 0; 2 ] ]
    ~theme ~lang:"ocaml" code
```
```ocaml
val word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  string list ->
  Transform.t
```
word\_highlight

Highlights tokens whose text matches one of the given words.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```ocaml
  Ochre.to_html_with hl
    ~transforms:[ Ochre.Transform_builtin.word_highlight [ "x"; "y" ] ]
    ~theme ~lang:"ocaml" code
```
```ocaml
val diff_markers : Transform.t
```
diff\_markers

Strips leading `+` or `-` from the first token of each line and applies a green or red background to the entire line.

```ocaml
val scope_marker : ?background:string -> string -> Transform.t
```
scope\_marker

Highlights tokens that have at least one scope starting with `prefix`.

Default background: `"#ffff0033"`.

```ocaml
val notation_highlight : ?background:string -> unit -> Transform.t
```
notation\_highlight

Notation-based line highlight. Scans token text for `[!code highlight]` comments, removes them, and sets the background color on the entire line. Mirrors Shiki's `transformerNotationHighlight`.

Default background: `"#ffffff22"`.

```ocaml
  let code = "let x = 42 // [!code highlight]\nlet y = 10" in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```
```ocaml
val notation_diff : 
  ?add_background:string ->
  ?remove_background:string ->
  unit ->
  Transform.t
```
notation\_diff

Notation-based diff markers. Scans token text for `[!code ++]` and `[!code --]` comments, removes them, and applies green or red backgrounds to the entire line. Mirrors Shiki's `transformerNotationDiff`.

Default add background: `"#22883322"`. Default remove background: `"#88222222"`.

```ocaml
  let code = "let x = 42 // [!code ++]\nlet y = 10 // [!code --]" in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```
```ocaml
val notation_word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  unit ->
  Transform.t
```
notation\_word\_highlight

Notation-based word highlight. Scans token text for `[!code word:xxx]` comments, removes them, and highlights all occurrences of `xxx` on that line. Mirrors Shiki's `transformerNotationWordHighlight`.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```ocaml
  let code = "let x = 42 // [!code word:x]" in
  let transforms =
    [ Ochre.Transform_builtin.notation_word_highlight () ]
  in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```