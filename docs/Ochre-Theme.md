
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
  font_style : font_style list option;
}
```
token\_color\_settings

Color and style settings resolved from a theme rule.

```ocaml
type token_color_rule = {
  name : string option;
  scope : string list;
  settings : token_color_settings;
}
```
token\_color\_rule

A rule mapping TextMate scopes to visual settings. Each rule contains a list of scope selectors and the styling to apply when a token matches one of those selectors.

```ocaml
type theme = {
  name : string;
  colors : (string * color) list;
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
val load_from_string : ?base_dir:string -> string -> theme
```
load\_from\_string

Parse a theme from a raw JSON string.

When `~base_dir` is provided, `"include"` paths in the JSON are resolved relative to that directory (same as [load](./#load) does with the file's parent directory). When omitted, `"include"` fields are silently ignored.

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
  ?colors:(string * color) list ->
  token_colors:token_color_rule list ->
  unit ->
  theme
```
make

Make a new TextMate-style theme from ordered token rules.

```ocaml
  let theme =
    Ochre.Theme.make ~name:"my-theme"
      ~colors:
        [
          ("editor.foreground", "#d4d4d4");
          ("editor.background", "#1e1e1e");
        ]
      ~token_colors:
        [
          Ochre.Theme.rule ~scope:[ "comment" ] ~foreground:"#6a9955" ();
          Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:"#569cd6" ();
        ]
      ()
```
```ocaml
val rule : 
  ?name:string ->
  ?scope:string list ->
  ?foreground:color ->
  ?background:color ->
  ?font_style:font_style list ->
  unit ->
  token_color_rule
```
rule

Construct a token color rule.

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