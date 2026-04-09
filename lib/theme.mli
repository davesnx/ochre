(** Theme definitions for syntax highlighting.

    A theme maps TextMate scopes to colors and font styles. Ochre ships with
    several built-in themes and can load any VS Code / TextMate theme from JSON.
*)

type color = string
(** {2 color}

    Hex color string (e.g. ["#569cd6"]). *)

(** {2 font_style}

    Font style variants. *)
type font_style = Token.font_style = Bold | Italic | Underline | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list option;
}
(** {2 token_color_settings}

    Color and style settings resolved from a theme rule. *)

type token_color_rule = {
  name : string option;
  scope : string list;
  settings : token_color_settings;
}
(** {2 token_color_rule}

    A rule mapping TextMate scopes to visual settings. Each rule contains a list
    of scope selectors and the styling to apply when a token matches one of
    those selectors. *)

type theme = {
  name : string;
  colors : (string * color) list;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}
(** {2 theme}

    A loaded theme with default foreground/background colors and a list of token
    coloring rules. *)

val load : string -> theme
(** {2 load}

    Load a theme from a VS Code theme JSON file.

    Falls back to the filename as the theme name when none is specified in the
    JSON. Raises an exception if the file contains invalid JSON.

    {[
      let theme = Theme.load "/path/to/theme.json"
    ]} *)

val load_from_string : ?base_dir:string -> string -> theme
(** {2 load_from_string}

    Parse a theme from a raw JSON string.

    When [~base_dir] is provided, ["include"] paths in the JSON are resolved
    relative to that directory (same as {!load} does with the file's parent
    directory). When omitted, ["include"] fields are silently ignored.

    {[
      let theme =
        Theme.load_from_string
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
    ]} *)

val make :
  name:string ->
  ?colors:(string * color) list ->
  token_colors:token_color_rule list ->
  unit ->
  theme
(** {2 make}

    Make a new TextMate-style theme from ordered token rules.

    {[
      let theme =
        Theme.make ~name:"my-theme"
          ~colors:
            [
              ("editor.foreground", "#d4d4d4"); ("editor.background", "#1e1e1e");
            ]
          ~token_colors:
            [
              Theme.rule ~scope:[ "comment" ] ~foreground:"#6a9955" ();
              Theme.rule ~scope:[ "keyword" ] ~foreground:"#569cd6" ();
            ]
          ()
    ]} *)

val rule :
  ?name:string ->
  ?scope:string list ->
  ?foreground:color ->
  ?background:color ->
  ?font_style:font_style list ->
  unit ->
  token_color_rule
(** {2 rule}

    Construct a token color rule.

    Omitting [scope] creates a scope-less rule (often used for default text
    styling in TextMate themes). Omitting [font_style] means "not specified";
    passing [[]] clears inherited font styles.

    {[
      Theme.rule ~scope:[ "comment" ] ~foreground:"#6a9955"
        ~font_style:[ Italic ] ()
    ]} *)

val available_names : string list
(** {2 available_names}

    Names of all built-in themes. *)

val find : string -> theme option
(** {2 find}

    Look up a built-in theme by name. Returns [None] when the name is not
    recognised. *)

val themes : (string * theme) list
(** {2 themes}

    All built-in themes as [(name, theme)] pairs. *)

(** {2 Built-in themes} *)

val dark : theme
val light : theme
val tokyonight : theme
val everforest : theme
val ayu : theme
val catppuccin : theme
val catppuccin_macchiato : theme
val gruvbox : theme
val kanagawa : theme
val nord : theme
val matrix : theme
val one_dark : theme
