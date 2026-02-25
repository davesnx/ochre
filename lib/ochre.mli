(** Ochre - Syntax highlighter using TextMate grammars and themes.

    Ochre uses TextMate grammars (the same engine as VS Code) and themes
    to produce accurate syntax highlighting in multiple output formats.

    {2 Quick start}

    {[
      let theme = Ochre.Theme.load_from_file "path/to/theme.json" in
      let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
      let html = Ochre.highlight_to_html hl ~theme ~lang:"ocaml" source_code
    ]} *)

(** {1 Token types} *)

module Token : sig
  (** Hex color string (e.g. ["#ff0000"]). *)
  type color = string

  (** Font style that can be applied to a token. *)
  type font_style = Token.font_style =
    | Bold
    | Italic
    | Underline
    | Strikethrough

  (** A token with resolved styling from a theme.

      Each token represents a fragment of source code with its associated
      colors and font styles, as determined by TextMate scope matching. *)
  type styled_token = Token.styled_token = {
    text : string;
    foreground : color option;
    background : color option;
    font_style : font_style list;
    scopes : string list;
  }

  (** A line of styled tokens. *)
  type line = styled_token list

  (** Complete highlighted code: a list of lines, each containing styled tokens. *)
  type highlighted_code = line list
end

(** {1 Themes} *)

module Theme : sig
  (** Hex color string (e.g. ["#569cd6"]). *)
  type color = string

  (** Font style variants. *)
  type font_style = Token.font_style =
    | Bold
    | Italic
    | Underline
    | Strikethrough

  (** Color and style settings resolved from a theme rule. *)
  type token_color_settings = Theme.token_color_settings = {
    foreground : color option;
    background : color option;
    font_style : font_style list;
  }

  (** A rule mapping TextMate scopes to visual settings.

      Each rule contains a list of scope selectors and the styling
      to apply when a token matches one of those selectors. *)
  type token_color_rule = Theme.token_color_rule = {
    scope : string list;
    settings : token_color_settings;
  }

  (** A loaded theme with resolved default colors and token coloring rules. *)
  type theme = Theme.theme = {
    name : string;
    fg : color;
    bg : color;
    token_colors : token_color_rule list;
  }

  (** Load a theme from a VS Code theme JSON file.

      Falls back to the filename as the theme name when none is specified
      in the JSON.

      Raises an exception if the file contains invalid JSON. *)
  val load_from_file : string -> theme

  (** Parse a theme from a JSON string.

      {[
        let theme = Ochre.Theme.load_from_string {|{
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
  val load_from_string : string -> theme
end

(** {1 Highlighter} *)

(** Highlighter instance. Holds loaded grammars and tokenization state. *)
type t

(** Create a new highlighter with the given grammar files.

    Each grammar is a path to a [.tmLanguage.json] file. The language
    identifier is derived from the filename (e.g.
    ["ocaml.tmLanguage.json"] registers as ["ocaml"]).

    {[
      let hl = Ochre.create
        ~grammars:["/usr/share/grammars/ocaml.tmLanguage.json"] ()
    ]} *)
val create : grammars:string list -> unit -> t

(** {1 Highlighting} *)

(** Highlight source code and return styled tokens.

    Use this when you need full control over rendering.

    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let tokens = Ochre.highlight_to_tokens hl ~theme ~lang:"ocaml" code in
      List.iter (fun line ->
        List.iter (fun (tok : Ochre.Token.styled_token) ->
          Printf.printf "%s" tok.text
        ) line
      ) tokens
    ]} *)
val highlight_to_tokens :
  t -> theme:Theme.theme -> lang:string -> string -> Token.highlighted_code

(** Highlight source code to HTML with inline styles.

    Produces a self-contained [<pre><code>...</code></pre>] block.

    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let html = Ochre.highlight_to_html hl ~theme ~lang:"ocaml" "let x = 42"
    ]} *)
val highlight_to_html :
  t -> theme:Theme.theme -> lang:string -> string -> string

(** Highlight source code to ANSI terminal escape sequences.

    Produces text with embedded 24-bit ANSI color codes for terminal display.

    Raises [Failure] if the grammar for [lang] cannot be found. *)
val highlight_to_ansi :
  t -> theme:Theme.theme -> lang:string -> string -> string

(**/**)
module Scope = Scope
module Render_html = Render_html
module Render_ansi = Render_ansi
