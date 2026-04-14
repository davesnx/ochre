
# Module `Ochre.Theme`


### color

```ocaml
type color = string
```
Hex color string (e.g. `"#569cd6"`).


### font\_style

```ocaml
type font_style = Token.font_style = 
  | Bold
  | Italic
  | Underline
  | Strikethrough (* Font style variants. *)
```

### token\_color\_settings

```ocaml
type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list option;
}
```
Color and style settings resolved from a theme rule.


### token\_color\_rule

```ocaml
type token_color_rule = {
  name : string option;
  scope : string list;
  settings : token_color_settings;
}
```
A rule mapping TextMate scopes to visual settings. Each rule contains a list of scope selectors and the styling to apply when a token matches one of those selectors.


### theme

```ocaml
type theme = {
  name : string;
  colors : (string * color) list;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}
```
A loaded theme with default foreground/background colors and a list of token coloring rules.


### load

```ocaml
val load : ?base_dir:string -> string -> (theme, string) Stdlib.result
```
Load a theme from a raw JSON string.

When `~base_dir` is provided, `"include"` paths in the JSON are resolved relative to that directory (same as [`load_from_file`](./#val-load_from_file) does with the file's parent directory). When omitted, `"include"` fields are silently ignored.

Returns `Error msg` when the JSON is malformed.

```ocaml
let theme =
  Ochre.Theme.load
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

### load\_exn

```ocaml
val load_exn : ?base_dir:string -> string -> theme
```
Like [`load`](./#val-load) but raises on failure.


### load\_from\_file

```ocaml
val load_from_file : string -> (theme, string) Stdlib.result
```
Load a theme from a VS Code theme JSON file.

Falls back to the filename as the theme name when none is specified in the JSON. Returns `Error msg` when the file cannot be read or contains invalid JSON.

```ocaml
match Ochre.Theme.load_from_file "/path/to/theme.json" with
| Ok theme ->
    theme
| Error msg ->
    failwith msg
```

### load\_from\_file\_exn

```ocaml
val load_from_file_exn : string -> theme
```
Like [`load_from_file`](./#val-load_from_file) but raises on failure.

```ocaml
let theme = Ochre.Theme.load_from_file_exn "/path/to/theme.json"
```

### make

```ocaml
val make : 
  name:string ->
  ?colors:(string * color) list ->
  token_colors:token_color_rule list ->
  unit ->
  theme
```
Make a new TextMate-style theme from ordered token rules.

```ocaml
let theme =
  Ochre.Theme.make ~name:"my-theme"
    ~colors:
      [
        ("editor.foreground", "#d4d4d4"); ("editor.background", "#1e1e1e");
      ]
    ~token_colors:
      [
        Ochre.Theme.rule ~scope:[ "comment" ] ~foreground:"#6a9955" ();
        Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:"#569cd6" ();
      ]
    ()
```

### rule

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
Construct a token color rule.


### available\_names

```ocaml
val available_names : string list
```
Names of all built-in themes.


### find

```ocaml
val find : string -> theme option
```
Look up a built-in theme by name. Returns `None` when the name is not recognised.

```ocaml
let theme = Ochre.Theme.find "nord"
```

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