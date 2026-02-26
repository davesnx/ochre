
# Module `Ochre.Theme`

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
Font style variants.

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

```
val load : string -> theme
```
Load a theme from a VS Code theme JSON file.

Falls back to the filename as the theme name when none is specified in the JSON.

Raises an exception if the file contains invalid JSON.

```
val available_names : string list
```
Names of built-in themes that can be loaded without a file path.

```
val dark : theme
```
```
val light : theme
```
```
val tokyonight : theme
```
```
val everforest : theme
```
```
val ayu : theme
```
```
val catppuccin : theme
```
```
val catppuccin_macchiato : theme
```
```
val gruvbox : theme
```
```
val kanagawa : theme
```
```
val nord : theme
```
```
val matrix : theme
```
```
val one_dark : theme
```
Built-in themes exposed as values.

```
val make : string -> theme option
```
Load a built-in theme by name.

Supports names like `dark`, `light`, and `tokyonight`. Returns `None` when the name is not a built-in theme.

```
val load_from_string : string -> theme
```
Parse a theme from a JSON string.

```ocaml
  let theme =
    Ochre.Theme.load_from_string
      {|{
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