
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
