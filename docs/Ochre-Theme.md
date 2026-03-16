
# Module `Ochre.Theme`

```ocaml
type color = string
```
color

Hex color string (e.g. `"#569cd6"`).

```ocaml
type font_style = Token.font_style = 
  | Bold
  | Italic
  | Underline
  | Strikethrough
```
font\_style

Font style variants.

```ocaml
type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list;
}
```
token\_color\_settings

Color and style settings resolved from a theme rule.

```ocaml
type token_color_rule = {
  scope : string list;
  settings : token_color_settings;
}
```
token\_color\_rule

A rule mapping TextMate scopes to visual settings. Each rule contains a list of scope selectors and the styling to apply when a token matches one of those selectors.

```ocaml
type theme = {
  name : string;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}
```
theme

A loaded theme with default foreground/background colors and a list of token coloring rules.

```ocaml
val load : string -> theme
```
load

Load a theme from a VS Code theme JSON file.

Falls back to the filename as the theme name when none is specified in the JSON. Raises an exception if the file contains invalid JSON.

```ocaml
  let theme = Ochre.Theme.load "/path/to/theme.json"
```
```ocaml
val load_from_string : string -> theme
```
load\_from\_string

Parse a theme from a raw JSON string.

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
```ocaml
val make : 
  name:string ->
  fg:color ->
  bg:color ->
  comment:color ->
  string:color ->
  number:color ->
  keyword:color ->
  fn:color ->
  typ:color ->
  theme
```
make

Make a new theme.

```ocaml
  let theme =
    Ochre.Theme.make ~name:"my-theme" ~fg:"#d4d4d4" ~bg:"#1e1e1e"
      ~comment:"#6a9955" ~string:"#ce9178" ~number:"#b5cea8"
      ~keyword:"#569cd6" ~fn:"#dcdcaa" ~typ:"#4ec9b0"
```
```ocaml
val available_names : string list
```
available\_names

Names of all built-in themes.

```ocaml
val find : string -> theme option
```
find

Look up a built-in theme by name. Returns `None` when the name is not recognised.


### Built-in themes

```ocaml
val dark : theme
```
```ocaml
val light : theme
```
```ocaml
val tokyonight : theme
```
```ocaml
val everforest : theme
```
```ocaml
val ayu : theme
```
```ocaml
val catppuccin : theme
```
```ocaml
val catppuccin_macchiato : theme
```
```ocaml
val gruvbox : theme
```
```ocaml
val kanagawa : theme
```
```ocaml
val nord : theme
```
```ocaml
val matrix : theme
```
```ocaml
val one_dark : theme
```