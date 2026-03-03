
# Module `Ochre.Transform_builtin`

```
val line_highlight : ?background:string -> int list -> Transform.t
```
`line_highlight ~background lines` highlights the given line indices (0-based) by setting every token's background color.

Default background: `"#ffffff22"`.

```
val word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  string list ->
  Transform.t
```
`word_highlight ~foreground ~font_style words` highlights tokens whose text matches one of the given words.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```
val diff_markers : Transform.t
```
Strips leading `+` or `-` from the first token of each line and applies a green or red background to the entire line.

```
val scope_marker : ?background:string -> string -> Transform.t
```
`scope_marker ~background prefix` highlights tokens that have at least one scope starting with `prefix`.

Default background: `"#ffff0033"`.

```
val notation_highlight : ?background:string -> unit -> Transform.t
```
Notation-based line highlight. Scans token text for `[!code highlight]` comments, removes them, and sets the background color on the entire line.

This mirrors Shiki's `transformerNotationHighlight`. Lines containing the magic comment get highlighted; the comment itself is stripped from the output.

Default background: `"#ffffff22"`.

```ocaml
  let code = "let x = 42 // [!code highlight]\nlet y = 10" in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```
```
val notation_diff : 
  ?add_background:string ->
  ?remove_background:string ->
  unit ->
  Transform.t
```
Notation-based diff markers. Scans token text for `[!code ++]` and `[!code --]` comments, removes them, and applies green or red backgrounds to the entire line.

This mirrors Shiki's `transformerNotationDiff`.

Default add background: `"#22883322"`. Default remove background: `"#88222222"`.

```ocaml
  let code = "let x = 42 // [!code ++]\nlet y = 10 // [!code --]" in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```
```
val notation_word_highlight : 
  ?foreground:string ->
  ?font_style:Token.font_style list ->
  unit ->
  Transform.t
```
Notation-based word highlight. Scans token text for `[!code word:xxx]` comments, removes them, and highlights all occurrences of `xxx` on that line with the given foreground color and font style.

This mirrors Shiki's `transformerNotationWordHighlight`.

Default foreground: `"#ffff00"`. Default font style: `[Bold]`.

```ocaml
  let code = "let x = 42 // [!code word:x]" in
  let transforms =
    [ Ochre.Transform_builtin.notation_word_highlight () ]
  in
  Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
```