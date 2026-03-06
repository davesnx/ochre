(** Ochre - Syntax highlighter using TextMate grammars and themes.

    Ochre uses TextMate grammars (the same engine as VS Code) and themes to
    produce accurate syntax highlighting in multiple output formats.

    {2 Quick start}

    {[
      let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
      let html = Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
    ]} *)

(** {1 Token types} *)

module Token : sig
  type color = string
  (** Hex color string (e.g. ["#ff0000"]). *)

  (** Font style that can be applied to a token. *)
  type font_style = Token.font_style =
    | Bold
    | Italic
    | Underline
    | Strikethrough

  type decoration_properties = Token.decoration_properties = {
    class_ : string option;
    style : string option;
    data : (string * string) list;
  }
  (** Properties attached by a decoration.

      These are format-agnostic: renderers map them to HTML attributes, ANSI
      codes, LaTeX commands, or SVG attributes as appropriate. *)

  type styled_token = Token.styled_token = {
    text : string;
    foreground : color option;
    background : color option;
    font_style : font_style list;
    scopes : string list;
    decoration : decoration_properties option;
  }
  (** A token with resolved styling from a theme.

      Each token represents a fragment of source code with its associated colors
      and font styles, as determined by TextMate scope matching. When a
      decoration targets this token, the [decoration] field carries the
      associated properties. *)

  type line = styled_token list
  (** A line of styled tokens. *)

  type highlighted_code = line list
  (** Complete highlighted code: a list of lines, each containing styled tokens.
  *)
end

(** {1 Themes} *)

module Theme : sig
  type color = string
  (** Hex color string (e.g. ["#569cd6"]). *)

  (** Font style variants. *)
  type font_style = Token.font_style =
    | Bold
    | Italic
    | Underline
    | Strikethrough

  type token_color_settings = Theme.token_color_settings = {
    foreground : color option;
    background : color option;
    font_style : font_style list;
  }
  (** Color and style settings resolved from a theme rule. *)

  type token_color_rule = Theme.token_color_rule = {
    scope : string list;
    settings : token_color_settings;
  }
  (** A rule mapping TextMate scopes to visual settings.

      Each rule contains a list of scope selectors and the styling to apply when
      a token matches one of those selectors. *)

  type theme = Theme.theme = {
    name : string;
    fg : color;
    bg : color;
    token_colors : token_color_rule list;
  }
  (** A loaded theme with resolved default colors and token coloring rules. *)

  val load : string -> theme
  (** Load a theme from a VS Code theme JSON file.

      Falls back to the filename as the theme name when none is specified in the
      JSON.

      Raises an exception if the file contains invalid JSON. *)

  val available_names : string list
  (** Names of built-in themes that can be loaded without a file path. *)

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
  (** Built-in themes exposed as values. *)

  val make : string -> theme option
  (** Load a built-in theme by name.

      Supports names like [dark], [light], and [tokyonight]. Returns [None] when
      the name is not a built-in theme. *)

  val load_from_string : string -> theme
  (** Parse a theme from a JSON string.

      {[
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
      ]} *)
end

(** {1 HTML options} *)

module Html_options : sig
  (** How token colors are expressed in the output. *)
  type style_mode = Html_options.style_mode =
    | Inline_styles  (** Emit [style="color:..."] on each [<span>]. Default. *)
    | Css_classes of { class_prefix : string }
        (** Replace inline styles with deterministic CSS class names. *)

  (** Whether the primary theme's colors are emitted inline. *)
  type default_color = Html_options.default_color =
    | Default_color
        (** Emit inline [color:] and [background-color:]. Default. *)
    | No_default_color
        (** Suppress inline colors. All colors from CSS custom properties. *)

  type t = Html_options.t = {
    style_mode : style_mode;
    default_color : default_color;
    pre_class : string option;
    code_class : string option;
    line_numbers : bool;
    css_variable_prefix : string;
    scopes_as_data_attrs : bool;
  }
  (** The full set of HTML rendering options. *)

  val default : t
  (** Default options (backward compatible with legacy output). *)

  val make :
    ?style_mode:style_mode ->
    ?default_color:default_color ->
    ?pre_class:string ->
    ?code_class:string ->
    ?line_numbers:bool ->
    ?css_variable_prefix:string ->
    ?scopes_as_data_attrs:bool ->
    unit ->
    t
  (** Construct options with defaults for any unspecified fields. *)
end

(** {1 Highlighter} *)

type t
(** Highlighter instance. Holds loaded grammars and tokenization state. *)

type output_format =
  | Html
  | Ansi
  | Latex
  | Svg
  | Tokens  (** Supported output formats. *)

val output_formats : (string * output_format) list
(** Mapping of CLI/output format names to typed variants. *)

val string_of_output_format : output_format -> string
(** Convert a format variant to its canonical lowercase name. *)

val output_format_of_string : string -> output_format option
(** Parse a lowercase/uppercase format name into a variant. *)

val create : grammars:string list -> unit -> t
(** Create a new highlighter with the given grammar files.

    Each grammar is a path to a [.tmLanguage.json] file. The language identifier
    is derived from the filename (e.g. ["ocaml.tmLanguage.json"] registers as
    ["ocaml"]).

    {[
      let hl =
        Ochre.create
          ~grammars:[ "/usr/share/grammars/ocaml.tmLanguage.json" ]
          ()
    ]} *)

val create_from_json : grammars:(string * string) list -> unit -> t
(** Create a highlighter from grammar JSON strings.

    Each pair is [(lang_id, json_content)] where [lang_id] is the language
    identifier and [json_content] is the raw TextMate grammar JSON.

    {[
      let hl =
        Ochre.create_from_json ~grammars:[ ("ocaml", Tm_grammar_ocaml.json) ] ()
    ]} *)

(** {1 Highlighting} *)

val to_tokens :
  t -> theme:Theme.theme -> lang:string -> string -> Token.highlighted_code
(** Highlight source code and return styled tokens.

    Use this when you need full control over rendering.

    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
      List.iter
        (fun line ->
          List.iter
            (fun (tok : Ochre.Token.styled_token) ->
              Printf.printf "%s" tok.text)
            line)
        tokens
    ]} *)

val to_html :
  t ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
(** Highlight source code to HTML.

    {2 Single theme}

    Pass [~theme] for a self-contained block with inline styles:

    {[
      Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
    ]}

    {2 Multiple themes}

    Pass [~themes] with labelled extra themes. Each label becomes a CSS custom
    property prefix ([--ochre-<label>]). The default theme's colors are emitted
    as direct CSS properties; extra themes' colors become CSS variables:

    {[
      Ochre.to_html hl ~theme:Ochre.Theme.light
        ~themes:[ ("dark", Ochre.Theme.nord) ]
        ~lang:"ocaml" "let x = 42"
    ]}

    {2 Options}

    Pass [~options] to control rendering behaviour:

    {[
      let opts =
        Ochre.Html_options.make ~line_numbers:true
          ~default_color:No_default_color ()
      in
      Ochre.to_html hl ~options:opts ~theme ~lang:"ocaml" code
    ]}

    When [~theme] is omitted but [~themes] is provided, the first entry becomes
    the default.

    Pair with {!html_dark_mode_css} or {!html_css_for_theme} to activate
    alternate themes via CSS.

    @raise Invalid_argument if neither [~theme] nor [~themes] is provided. *)

val html_dark_mode_css : string
(** CSS snippet that activates the ["dark"] theme variant via
    [@media (prefers-color-scheme: dark)].

    {[
      @media (prefers-color-scheme: dark) {
        .ochre,
        .ochre span {
          color: var(--ochre-dark) !important;
          background-color: var(--ochre-dark-bg) !important;
          font-style: var(--ochre-dark-font-style) !important;
          font-weight: var(--ochre-dark-font-weight) !important;
          text-decoration: var(--ochre-dark-text-decoration) !important;
        }
      }
    ]}

    Include this in a [<style>] tag or external stylesheet. *)

val html_css_for_theme : ?prefix:string -> string -> string
(** [html_css_for_theme ?prefix label] returns a CSS rule body that activates
    the theme stored under [--ochre-<label>-*] variables.

    Pass [~prefix] to match a custom {!Html_options.css_variable_prefix}.
    Default: ["--ochre-"].

    Wrap this in your own selector (a media query, a [.dark] class, a
    [data-theme] attribute selector, etc.) to control when the theme activates.

    {[
      (* For a class-based toggle: *)
      Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_css_for_theme "dark")
    ]} *)

val to_ansi : t -> theme:Theme.theme -> lang:string -> string -> string
(** Highlight source code to ANSI terminal escape sequences.

    Produces text with embedded 24-bit ANSI color codes for terminal display.

    Raises [Failure] if the grammar for [lang] cannot be found. *)

val to_latex : t -> theme:Theme.theme -> lang:string -> string -> string
(** Highlight source code to LaTeX with [\textcolor] commands.

    Produces a block wrapped in an [ochrehighlight] environment. Requires the
    [xcolor] and [soul] LaTeX packages.

    Raises [Failure] if the grammar for [lang] cannot be found. *)

val to_svg : t -> theme:Theme.theme -> lang:string -> string -> string
(** Highlight source code to a self-contained SVG element.

    Produces an [<svg>] with monospace [<text>] elements and per-token [<tspan>]
    styling. Suitable for embedding in documents or rendering as an image.

    Raises [Failure] if the grammar for [lang] cannot be found. *)

val to_debug_tokens : t -> theme:Theme.theme -> lang:string -> string -> string
(** Highlight source code and render each token as [{text}[scope1,scope2,...]].

    Useful for debugging grammar and scope matching.

    Raises [Failure] if the grammar for [lang] cannot be found. *)

val to_string :
  t ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Highlight source code to one of the supported output formats. *)

(** {1 Decorations} *)

module Decoration : sig
  type position = Decoration.position = { line : int; character : int }
  (** 0-indexed position in source code.

      Negative [character] values count from the end of the line: [-1] means the
      line end, [-2] means one character before the end, etc. *)

  type properties = Decoration.properties = {
    class_ : string option;
    style : string option;
    data : (string * string) list;
  }
  (** Properties to attach to a decorated range. *)

  type t = Decoration.t = {
    start : position;
    end_ : position;
    properties : properties;
  }
  (** A decoration targeting a range from [start] (inclusive) to [end_]
      (exclusive). *)

  val pos : int -> int -> position
  (** [pos line character] creates a position. *)

  val make :
    ?class_:string ->
    ?style:string ->
    ?data:(string * string) list ->
    start:position ->
    end_:position ->
    unit ->
    t
  (** Create a decoration.

      {[
        let d =
          Ochre.Decoration.make ~class_:"highlighted"
            ~start:(Ochre.Decoration.pos 0 0)
            ~end_:(Ochre.Decoration.pos 0 11)
            ()
      ]} *)

  val apply :
    source:string -> t list -> Token.highlighted_code -> Token.highlighted_code
  (** [apply ~source decorations tokens] maps decoration ranges onto tokens,
      splitting tokens at boundaries and attaching properties.

      Overlapping decorations are merged: classes are space-concatenated, styles
      are semicolon-concatenated, data attributes are merged (later wins). *)
end

(** {1 Transforms} *)

module Transform : sig
  type token = Token.styled_token
  (** Alias for a styled token. *)

  type line = token list
  (** A line of styled tokens. *)

  type document = line list
  (** The full highlighted document (list of lines). *)

  type t = Transform.t = {
    name : string;
    before_line : (line_index:int -> line -> line) option;
    after_line : (line_index:int -> line -> line) option;
    before_render : (document -> document) option;
    after_render : (document -> document) option;
  }
  (** A transform with named hooks.

      Each hook is optional. The pipeline calls them in this order:
      + [before_render] on the full document
      + [before_line] for each line (by index)
      + [after_line] for each line (by index)
      + [after_render] on the full document

      When multiple transforms are provided, each hook phase folds over all
      transforms in list order before moving to the next phase. *)

  val make :
    ?before_line:(line_index:int -> line -> line) ->
    ?after_line:(line_index:int -> line -> line) ->
    ?before_render:(document -> document) ->
    ?after_render:(document -> document) ->
    string ->
    t
  (** [make ?before_line ?after_line ?before_render ?after_render name] creates
      a transform with the given hooks. *)

  val run : t list -> document -> document
  (** [run transforms document] applies all transforms to the document.

      Transforms are applied in list order. An empty list returns the document
      unchanged. *)
end

(** {1 Built-in transforms} *)

module Transform_builtin : sig
  val line_highlight : ?background:string -> int list -> Transform.t
  (** [line_highlight ~background lines] highlights the given line indices
      (0-based) by setting every token's background color.

      Default background: ["#ffffff22"]. *)

  val word_highlight :
    ?foreground:string ->
    ?font_style:Token.font_style list ->
    string list ->
    Transform.t
  (** [word_highlight ~foreground ~font_style words] highlights tokens whose
      text matches one of the given words.

      Default foreground: ["#ffff00"]. Default font style: [[Bold]]. *)

  val diff_markers : Transform.t
  (** Strips leading [+] or [-] from the first token of each line and applies a
      green or red background to the entire line. *)

  val scope_marker : ?background:string -> string -> Transform.t
  (** [scope_marker ~background prefix] highlights tokens that have at least one
      scope starting with [prefix].

      Default background: ["#ffff0033"]. *)

  val notation_highlight : ?background:string -> unit -> Transform.t
  (** Notation-based line highlight. Scans token text for [[!code highlight]]
      comments, removes them, and sets the background color on the entire line.

      This mirrors Shiki's [transformerNotationHighlight]. Lines containing the
      magic comment get highlighted; the comment itself is stripped from the
      output.

      Default background: ["#ffffff22"].

      {[
        let code = "let x = 42 // [!code highlight]\nlet y = 10" in
        let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
        Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
      ]} *)

  val notation_diff :
    ?add_background:string -> ?remove_background:string -> unit -> Transform.t
  (** Notation-based diff markers. Scans token text for [[!code ++]] and
      [[!code --]] comments, removes them, and applies green or red backgrounds
      to the entire line.

      This mirrors Shiki's [transformerNotationDiff].

      Default add background: ["#22883322"]. Default remove background:
      ["#88222222"].

      {[
        let code = "let x = 42 // [!code ++]\nlet y = 10 // [!code --]" in
        let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
        Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
      ]} *)

  val notation_word_highlight :
    ?foreground:string ->
    ?font_style:Token.font_style list ->
    unit ->
    Transform.t
  (** Notation-based word highlight. Scans token text for [[!code word:xxx]]
      comments, removes them, and highlights all occurrences of [xxx] on that
      line with the given foreground color and font style.

      This mirrors Shiki's [transformerNotationWordHighlight].

      Default foreground: ["#ffff00"]. Default font style: [[Bold]].

      {[
        let code = "let x = 42 // [!code word:x]" in
        let transforms =
          [ Ochre.Transform_builtin.notation_word_highlight () ]
        in
        Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
      ]} *)
end

(** {1 Highlighting with transforms and decorations}

    These functions are like their counterparts above but accept an optional
    [~decorations] list and a required [~transforms] list. Decorations are
    applied after tokenization/theming but before transforms. The original
    functions behave as if [~decorations:[]] and [~transforms:[]] were passed.
*)

val to_tokens_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
(** Like {!to_tokens} but applies decorations and transforms before returning.
*)

val to_html_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
(** Like {!to_html} but applies decorations and transforms before rendering.

    Accepts the same [~theme] / [~themes] / [~options] parameters as {!to_html}.
*)

val to_ansi_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_ansi} but applies decorations and transforms before rendering. *)

val to_latex_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_latex} but applies decorations and transforms before rendering. *)

val to_svg_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_svg} but applies decorations and transforms before rendering. *)

val to_debug_tokens_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_debug_tokens} but applies decorations and transforms before
    rendering. *)

val to_string_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_string} but applies decorations and transforms before rendering.
*)
