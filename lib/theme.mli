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
  font_style : font_style list;
}
(** {2 token_color_settings}

    Color and style settings resolved from a theme rule. *)

type token_color_rule = { scope : string list; settings : token_color_settings }
(** {2 token_color_rule}

    A rule mapping TextMate scopes to visual settings. Each rule contains a list
    of scope selectors and the styling to apply when a token matches one of
    those selectors. *)

type theme = {
  name : string;
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

val load_from_string : string -> theme
(** {2 load_from_string}

    Parse a theme from a raw JSON string.

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

val make : string -> theme option
(** {2 make}

    Look up a built-in theme by name. Returns [None] when the name is not
    recognised.

    {[
      match Theme.make "nord" with
      | Some theme -> theme
      | None -> failwith "unknown theme"
    ]} *)

val available_names : string list
(** {2 available_names}

    Names of all built-in themes. *)

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
