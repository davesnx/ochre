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

  type styled_token = Token.styled_token = {
    text : string;
    foreground : color option;
    background : color option;
    font_style : font_style list;
    scopes : string list;
  }
  (** A token with resolved styling from a theme.

      Each token represents a fragment of source code with its associated colors
      and font styles, as determined by TextMate scope matching. *)

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

val to_html : t -> theme:Theme.theme -> lang:string -> string -> string
(** Highlight source code to HTML with inline styles.

    Produces a self-contained [<pre><code>...</code></pre>] block.

    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let html = Ochre.to_html hl ~theme ~lang:"ocaml" "let x = 42"
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
end

(** {1 Highlighting with transforms}

    These functions are like their counterparts above but accept a [~transforms]
    list that is applied after tokenization and theming, before rendering. The
    original functions behave as if [~transforms:[]] were passed. *)

val to_tokens_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
(** Like {!to_tokens} but applies transforms before returning. *)

val to_html_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_html} but applies transforms before rendering. *)

val to_ansi_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_ansi} but applies transforms before rendering. *)

val to_latex_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_latex} but applies transforms before rendering. *)

val to_svg_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_svg} but applies transforms before rendering. *)

val to_debug_tokens_with :
  t ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_debug_tokens} but applies transforms before rendering. *)

val to_string_with :
  t ->
  transforms:Transform.t list ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** Like {!to_string} but applies transforms before rendering. *)
