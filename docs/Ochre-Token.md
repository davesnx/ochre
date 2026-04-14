
# Module `Ochre.Token`

```ocaml
type color = string
```
color

Hex color string (e.g. `"#ff0000"`).

```ocaml
type font_style = 
  | Bold
  | Italic
  | Underline
  | Strikethrough (* Font style that can be applied to a token. *)
```
font\_style

```ocaml
type decoration_properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}
```
decoration\_properties

Format-agnostic properties attached by a decoration. Renderers map them to HTML attributes, ANSI codes, LaTeX commands, or SVG attributes as appropriate.

```ocaml
type styled_token = {
  text : string;
  foreground : color option;
  background : color option;
  font_style : font_style list;
  scopes : string list;
  decoration : decoration_properties option;
}
```
styled\_token

A token with resolved styling from a theme. Each token represents a fragment of source code with its associated colors and font styles, as determined by TextMate scope matching. When a decoration targets this token, the `decoration` field carries the associated properties.

```ocaml
type line = styled_token list
```
line

A line of styled tokens.

```ocaml
type highlighted_code = line list
```
highlighted\_code

Complete highlighted code: a list of lines, each containing styled tokens.
