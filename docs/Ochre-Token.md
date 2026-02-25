
# Module `Ochre.Token`

```
type color = string
```
Hex color string (e.g. `"#ff0000"`).

```
type font_style = 
```
```
| Bold
```
```
| Italic
```
```
| Underline
```
```
| Strikethrough
```
```

```
Font style that can be applied to a token.

```
type styled_token = {
```
`text : string;`
`foreground : color option;`
`background : color option;`
`font_style : font_style list;`
`scopes : string list;`
```
}
```
A token with resolved styling from a theme.

Each token represents a fragment of source code with its associated colors and font styles, as determined by TextMate scope matching.

```
type line = styled_token list
```
A line of styled tokens.

```
type highlighted_code = line list
```
Complete highlighted code: a list of lines, each containing styled tokens.
