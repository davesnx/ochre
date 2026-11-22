
# Module `Ochre.Theme`


### color

```ocaml
type color = Color.t
```

### token\_color\_settings

```ocaml
type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : Style.font_style option;
}
```
Color and style settings of a theme rule. `None` inherits the value of the enclosing scope. A `font_style` of [`Style.plain`](./Ochre-Style.md#val-plain) is the `"none"` or empty `"fontStyle"` of the theme JSON: it resets the font style.


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


### warning

```ocaml
type warning = {
  path : string option; (* The file that holds the value, if any. *)
  location : string; (* Where the value is, such as "tokenColors[2].settings.foreground" or "colors.editor.background". *)
  value : string; (* The value that was dropped. *)
}
```
A color that is not `#rgb`, `#rgba`, `#rrggbb` or `#rrggbbaa`. As in vscode-textmate, loading drops it, so the rule or the `colors` entry acts as if the value were not there.

```ocaml
val warning_to_string : warning -> string
```
A message for humans.


### load

```ocaml
val load : 
  ?base_dir:string ->
  string ->
  (theme * warning list, Error.t) Stdlib.result
```
Load a theme from a raw JSON string. Returns the theme and one warning for each color that was dropped.

When `~base_dir` is provided, `"include"` paths in the JSON are resolved relative to that directory (same as [`load_from_file`](./#val-load_from_file) does with the file's parent directory). When omitted, an `"include"` is an [`Error.t.Theme_error`](./Ochre-Error.md#type-t.Theme_error).

Returns [`Error.t.Theme_error`](./Ochre-Error.md#type-t.Theme_error) when the JSON is malformed or an included file cannot be read, and [`Error.t.Include_cycle`](./Ochre-Error.md#type-t.Include_cycle) when included files include each other.

```ocaml
let result =
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

### load\_from\_file

```ocaml
val load_from_file : string -> (theme * warning list, Error.t) Stdlib.result
```
Load a theme from a VS Code theme JSON file, like [`load`](./#val-load) with the file's directory as `base_dir`.

Falls back to the filename as the theme name when none is specified in the JSON.

```ocaml
match Ochre.Theme.load_from_file "/path/to/theme.json" with
| Ok (theme, warnings) ->
    List.iter
      (fun w -> prerr_endline (Ochre.Theme.warning_to_string w))
      warnings;
    theme
| Error e ->
    failwith (Ochre.Error.to_string e)
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
        ("editor.foreground", Ochre.Color.rgb 0xd4 0xd4 0xd4);
        ("editor.background", Ochre.Color.rgb 0x1e 0x1e 0x1e);
      ]
    ~token_colors:
      [
        Ochre.Theme.rule ~scope:[ "comment" ]
          ~foreground:(Ochre.Color.rgb 0x6a 0x99 0x55)
          ();
        Ochre.Theme.rule ~scope:[ "keyword" ]
          ~foreground:(Ochre.Color.oklch 0.65 0.12 250.)
          ();
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
  ?font_style:Style.font_style ->
  unit ->
  token_color_rule
```
Construct a token color rule.
