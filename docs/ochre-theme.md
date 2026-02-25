
# Module `Ochre.Theme`

TextMate / VS Code theme loading and representation.

Themes define the color scheme used to style syntax-highlighted code. Ochre supports the same JSON format as VS Code themes, including the `colors` and `tokenColors` fields.

```
type color = string
```
Hex color string (e.g. `"#569cd6"`).

```
type font_style = Token.font_style = 
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
Font style variants, mirroring [`Token.font_style`](./Ochre-Token.md#type-font_style).

```
type token_color_settings = {
```
`foreground : color option;`
`background : color option;`
`font_style : font_style list;`
```
}
```
Color and style settings resolved from a theme rule.

```
type token_color_rule = {
```
`scope : string list;`
`settings : token_color_settings;`
```
}
```
A rule mapping TextMate scopes to visual settings.

Each rule contains a list of scope selectors and the styling to apply when a token matches one of those selectors.

```
type theme = {
```
`name : string;`
`fg : color;`
`bg : color;`
`token_colors : token_color_rule list;`
```
}
```
A loaded theme with resolved default colors and token coloring rules.

```ocaml
  let theme = Theme.load_from_file "path/to/dark-plus.json" in
  Printf.printf "Theme: %s (fg: %s, bg: %s)\n"
    theme.name theme.fg theme.bg
```
```
val load_from_file : string -> theme
```
Load a theme from a VS Code theme JSON file.

Falls back to the filename as the theme name when none is specified in the JSON.

Raises an exception if the file contains invalid JSON.

```
val load_from_string : string -> theme
```
Parse a theme from a JSON string.

```ocaml
  let theme = Theme.load_from_string {|{
    "name": "my-theme",
    "colors": {
      "editor.foreground": "#d4d4d4",
      "editor.background": "#1e1e1e"
    },
    "tokenColors": [
      { "scope": "comment",
        "settings": { "foreground": "#6a9955", "fontStyle": "italic" } }
    ]
  }|}
```