(** Ochre - Syntax highlighter using TextMate grammars and themes.

    Ochre uses TextMate grammars (the same engine as VS Code) and themes to
    produce accurate syntax highlighting in multiple output formats.

    {2 Quick start}

    {[
      let hl = Ochre.create ~grammars:["/path/to/ocaml.tmLanguage.json"] () in
      let html = Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
    ]} *)

(** {1 Token types}

    Tokens are the basic unit of highlighted code. After tokenization, each
    fragment of source code becomes a {!Token.styled_token} carrying colors,
    font styles, and scope information resolved from a theme. *)

module Token : sig
  type color = string
  (** {2 color}

      Hex color string (e.g. ["#ff0000"]). *)

  (** {2 font_style}

      Font style that can be applied to a token. *)
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
  (** {2 decoration_properties}

      Format-agnostic properties attached by a decoration. Renderers map them to
      HTML attributes, ANSI codes, LaTeX commands, or SVG attributes as
      appropriate. *)

  type styled_token = Token.styled_token = {
    text : string;
    foreground : color option;
    background : color option;
    font_style : font_style list;
    scopes : string list;
    decoration : decoration_properties option;
  }
  (** {2 styled_token}

      A token with resolved styling from a theme. Each token represents a
      fragment of source code with its associated colors and font styles, as
      determined by TextMate scope matching. When a decoration targets this
      token, the [decoration] field carries the associated properties. *)

  type line = styled_token list
  (** {2 line}

      A line of styled tokens. *)

  type highlighted_code = line list
  (** {2 highlighted_code}

      Complete highlighted code: a list of lines, each containing styled tokens.
  *)
end

(** {1 Themes}

    A theme maps TextMate scopes to colors and font styles. Ochre ships with
    several built-in themes and can load any VS Code / TextMate theme from JSON.
*)

module Theme : sig
  type color = string
  (** {2 color}

      Hex color string (e.g. ["#569cd6"]). *)

  (** {2 font_style}

      Font style variants. *)
  type font_style = Token.font_style =
    | Bold
    | Italic
    | Underline
    | Strikethrough

  type token_color_settings = Theme.token_color_settings = {
    foreground : color option;
    background : color option;
    font_style : font_style list option;
  }
  (** {2 token_color_settings}

      Color and style settings resolved from a theme rule. *)

  type token_color_rule = Theme.token_color_rule = {
    name : string option;
    scope : string list;
    settings : token_color_settings;
  }
  (** {2 token_color_rule}

      A rule mapping TextMate scopes to visual settings. Each rule contains a
      list of scope selectors and the styling to apply when a token matches one
      of those selectors. *)

  type theme = Theme.theme = {
    name : string;
    colors : (string * color) list;
    fg : color;
    bg : color;
    token_colors : token_color_rule list;
  }
  (** {2 theme}

      A loaded theme with default foreground/background colors and a list of
      token coloring rules. *)

  val load : string -> theme
  (** {2 load}

      Load a theme from a VS Code theme JSON file.

      Falls back to the filename as the theme name when none is specified in the
      JSON. Raises an exception if the file contains invalid JSON.

      {[
        let theme = Ochre.Theme.load "/path/to/theme.json"
      ]} *)

  val load_from_string : string -> theme
  (** {2 load_from_string}

      Parse a theme from a raw JSON string.

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

      Construct a token color rule. *)

  val available_names : string list
  (** {2 available_names}

      Names of all built-in themes. *)

  val find : string -> theme option
  (** {2 find}

      Look up a built-in theme by name. Returns [None] when the name is not
      recognised. *)

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
end

(** {1 Highlighter}

    The highlighter holds loaded grammars and drives tokenization. Create one
    with {!val-create} or {!val-create_from_json}, then pass it to any backend
    function. *)

type t
(** Highlighter instance. Holds loaded grammars and tokenization state. *)

val create : grammars:string list -> unit -> t
(** {2 create}

    Create a new highlighter from grammar files on disk.

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
(** {2 create_from_json}

    Create a highlighter from grammar JSON strings.

    Each pair is [(lang_id, json_content)] where [lang_id] is the language
    identifier and [json_content] is the raw TextMate grammar JSON.

    {[
      let hl =
        Ochre.create_from_json ~grammars:[ ("ocaml", Tm_grammar_ocaml.json) ] ()
    ]} *)

val to_tokens :
  t -> theme:Theme.theme -> lang:string -> string -> Token.highlighted_code
(** {2 to_tokens}

    Highlight source code and return structured tokens. Use this when you need
    full control over rendering.

    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let tokens = Ochre.to_tokens hl ~theme ~lang:"ocaml" code in
      List.iter
        (fun line ->
          List.iter
            (fun (tok : Ochre.Token.styled_token) -> Printf.printf "%s" tok.text)
            line
        )
        tokens
    ]} *)

(** {1 Backends}

    Ochre can render highlighted code to several output formats. All backends
    share the same pattern: pass a highlighter, a theme, a language, and the
    source code.

    - {b HTML} — Self-contained [<pre><code>] blocks with inline styles or CSS
      classes. Supports multi-theme via CSS custom properties, line numbers, and
      configurable class prefixes.
    - {b ANSI} — 24-bit color escape sequences for terminal display.
    - {b LaTeX} — [\textcolor] commands inside an [ochrehighlight] environment.
      Requires the [xcolor] and [soul] packages.
    - {b SVG} — Standalone [<svg>] elements with monospace [<text>] and
      per-token [<tspan>] styling.
    - {b Tokens} — Raw token text for debugging grammar and scope matching. *)

(** {2 HTML options} *)

module Html_options : sig
  (** {2 style_mode}

      How token colors are expressed in the output. *)
  type style_mode = Html_options.style_mode =
    | Inline_styles  (** Emit [style="color:..."] on each [<span>]. Default. *)
    | Css_classes of { class_prefix : string }
        (** Replace inline styles with deterministic CSS class names. *)

  (** {2 default_color}

      Whether the primary theme's colors are emitted inline. *)
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
  (** {2 t}

      The full set of HTML rendering options. *)

  val default : t
  (** {2 default}

      Default options (backward compatible with legacy output). *)

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
  (** {2 make}

      Construct options with defaults for any unspecified fields.

      {[
        let opts =
          Ochre.Html_options.make ~line_numbers:true
            ~default_color:No_default_color ()
      ]} *)
end

val to_html :
  t ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?extra_themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
(** {2 to_html}

    Highlight source code to HTML.

    {3 Single theme}

    Pass [~theme] for a self-contained block with inline styles:

    {[
      Ochre.to_html hl ~theme:Ochre.Theme.nord ~lang:"ocaml" "let x = 42"
    ]}

    {3 Multiple themes}

    Pass [~extra_themes] with labelled extra themes. Each label becomes a CSS
    custom property prefix ([--ochre-<label>]). The default theme is emitted as
    base fallback variables ([var(--ochre-bg,<bg>)], [var(--ochre,<fg>)]), while
    extra themes are emitted as label-scoped variables.

    {[
      Ochre.to_html hl ~theme:Ochre.Theme.light
        ~extra_themes:[ ("dark", Ochre.Theme.nord) ]
        ~lang:"ocaml" "let x = 42"
    ]}

    {3 Options}

    Pass [~options] to control rendering behaviour:

    {[
      let opts =
        Ochre.Html_options.make ~line_numbers:true
          ~default_color:No_default_color ()
      in
      Ochre.to_html hl ~options:opts ~theme ~lang:"ocaml" code
    ]}

    When [~theme] is omitted but [~extra_themes] is provided, the first entry
    becomes the default. When neither [~theme] nor [~extra_themes] is provided,
    {!Theme.dark} is used as the default.

    Pair with {!val-html_theme_prefers_dark_css} or {!val-html_theme_css} to
    activate alternate themes via CSS. *)

val html_theme_css : ?prefix:string -> string -> string
(** {2 html_theme_css}

    [html_theme_css ?prefix label] returns a CSS rule that maps base variables
    ([--ochre-*]) to the label-scoped variables ([--ochre-<label>-*]).

    Pass [~prefix] to match a custom {!Html_options.css_variable_prefix}.
    Default: ["--ochre-"].

    Wrap this in your own selector (a media query, a [.dark] class, a
    [data-theme] attribute selector, etc.) to control when the theme activates.

    {[
      Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
    ]} *)

val html_theme_prefers_dark_css : string
(** {2 html_theme_prefers_dark_css}

    {!val-html_theme_css} for ["dark"] wrapped in an
    [@media (prefers-color-scheme: dark)] query.

    Include this in a [<style>] tag or external stylesheet.

    {[
      @media (prefers-color-scheme: dark) {
        .ochre,
        .ochre span {
          --ochre: var(--ochre-dark);
          --ochre-bg: var(--ochre-dark-bg);
          --ochre-font-style: var(--ochre-dark-font-style);
          --ochre-font-weight: var(--ochre-dark-font-weight);
          --ochre-text-decoration: var(--ochre-dark-text-decoration);
        }
      }
    ]} *)

val to_ansi : t -> theme:Theme.theme -> lang:string -> string -> string
(** {2 to_ansi}

    Highlight source code to ANSI terminal escape sequences.

    Produces text with embedded 24-bit ANSI color codes for terminal display.
    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let ansi = Ochre.to_ansi hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code in
      print_string ansi
    ]} *)

val to_latex : t -> theme:Theme.theme -> lang:string -> string -> string
(** {2 to_latex}

    Highlight source code to LaTeX with [\textcolor] commands.

    Produces a block wrapped in an [ochrehighlight] environment. Requires the
    [xcolor] and [soul] LaTeX packages. Raises [Failure] if the grammar for
    [lang] cannot be found.

    {[
      let latex =
        Ochre.to_latex hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
      in
      Printf.printf "\\begin{document}\n%s\n\\end{document}" latex
    ]} *)

val to_svg : t -> theme:Theme.theme -> lang:string -> string -> string
(** {2 to_svg}

    Highlight source code to a self-contained SVG element.

    Produces an [<svg>] with monospace [<text>] elements and per-token [<tspan>]
    styling. Suitable for embedding in documents or rendering as an image.
    Raises [Failure] if the grammar for [lang] cannot be found.

    {[
      let svg = Ochre.to_svg hl ~theme:Ochre.Theme.nord ~lang:"ocaml" code
    ]} *)

val to_debug_tokens : t -> theme:Theme.theme -> lang:string -> string -> string
(** {2 to_debug_tokens}

    Highlight source code and render each token as [{text}[scope1,scope2,...]].

    Useful for debugging grammar and scope matching. Raises [Failure] if the
    grammar for [lang] cannot be found. *)

(** {2 output_format}

    Supported output formats. Use with {!val-to_string} to select a backend at
    runtime. *)
type output_format = Html | Ansi | Latex | Svg | Tokens

val output_formats : (string * output_format) list
(** {2 output_formats}

    Mapping of format names to typed variants. *)

val string_of_output_format : output_format -> string
(** {2 string_of_output_format}

    Convert a format variant to its canonical lowercase name. *)

val output_format_of_string : string -> output_format option
(** {2 output_format_of_string}

    Parse a format name into a variant. Returns [None] for unrecognised names.
*)

val to_string :
  t ->
  format:output_format ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** {2 to_string}

    Highlight source code to one of the supported output formats.

    {[
      let output = Ochre.to_string hl ~format:Html ~theme ~lang:"ocaml" code
    ]} *)

(** {1 Decorations}

    Decorations attach format-agnostic properties (CSS class, inline style, data
    attributes) to ranges of source code identified by line/character position.
    They are applied after tokenization but before transforms. *)

module Decoration : sig
  type position = Decoration.position = { line : int; character : int }
  (** {2 position}

      0-indexed position in source code.

      Negative [character] values count from the end of the line: [-1] means the
      line end, [-2] means one character before the end, etc. *)

  type properties = Decoration.properties = {
    class_ : string option;
    style : string option;
    data : (string * string) list;
  }
  (** {2 properties}

      Properties to attach to a decorated range. *)

  type t = Decoration.t = {
    start : position;
    end_ : position;
    properties : properties;
  }
  (** {2 t}

      A decoration targeting a range from [start] (inclusive) to [end_]
      (exclusive). *)

  val pos : int -> int -> position
  (** {2 pos}

      [pos line character] creates a position. *)

  val make :
    ?class_:string ->
    ?style:string ->
    ?data:(string * string) list ->
    start:position ->
    end_:position ->
    unit ->
    t
  (** {2 make}

      Create a decoration.

      {[
        let d =
          Ochre.Decoration.make ~class_:"highlighted"
            ~start:(Ochre.Decoration.pos 0 0)
            ~end_:(Ochre.Decoration.pos 0 11)
            ()
      ]} *)

  val apply :
    source:string -> t list -> Token.highlighted_code -> Token.highlighted_code
  (** {2 apply}

      [apply ~source decorations tokens] maps decoration ranges onto tokens,
      splitting tokens at boundaries and attaching properties.

      Overlapping decorations are merged: classes are space-concatenated, styles
      are semicolon-concatenated, data attributes are merged (later wins). *)
end

(** {1 Transforms}

    Transforms run after tokenization and theming, but before rendering. They
    can modify tokens, lines, or the entire document in a composable way. *)

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
  (** {2 t}

      A transform with named hooks. Each hook is optional. The pipeline calls
      them in this order:

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
  (** {2 make}

      [make name] creates a transform with the given hooks.

      {[
        let bold_keywords =
          Ochre.Transform.make "bold-keywords"
            ~after_line:(fun ~line_index:_ line ->
              List.map
                (fun (tok : Ochre.Token.styled_token) ->
                  if tok.text = "let" || tok.text = "in" then
                    { tok with font_style = Bold :: tok.font_style }
                  else
                    tok
                )
                line
          )
      ]} *)

  val run : t list -> document -> document
  (** {2 run}

      [run transforms document] applies all transforms to the document.

      Transforms are applied in list order. An empty list returns the document
      unchanged. *)
end

(** {1 Built-in transforms}

    Ready-to-use transforms for common highlighting patterns. *)

module Transform_builtin : sig
  val line_highlight : ?background:string -> int list -> Transform.t
  (** {2 line_highlight}

      Highlights the given line indices (0-based) by setting every token's
      background color.

      Default background: ["#ffffff22"].

      {[
        Ochre.to_html_with hl
          ~transforms:[ Ochre.Transform_builtin.line_highlight [ 0; 2 ] ]
          ~theme ~lang:"ocaml" code
      ]} *)

  val word_highlight :
    ?foreground:string ->
    ?font_style:Token.font_style list ->
    string list ->
    Transform.t
  (** {2 word_highlight}

      Highlights tokens whose text matches one of the given words.

      Default foreground: ["#ffff00"]. Default font style: [[Bold]].

      {[
        Ochre.to_html_with hl
          ~transforms:[ Ochre.Transform_builtin.word_highlight [ "x"; "y" ] ]
          ~theme ~lang:"ocaml" code
      ]} *)

  val diff_markers : Transform.t
  (** {2 diff_markers}

      Strips leading [+] or [-] from the first token of each line and applies a
      green or red background to the entire line. *)

  val scope_marker : ?background:string -> string -> Transform.t
  (** {2 scope_marker}

      Highlights tokens that have at least one scope starting with [prefix].

      Default background: ["#ffff0033"]. *)

  val notation_highlight : ?background:string -> unit -> Transform.t
  (** {2 notation_highlight}

      Notation-based line highlight. Scans token text for [[!code highlight]]
      comments, removes them, and sets the background color on the entire line.
      Mirrors Shiki's [transformerNotationHighlight].

      Default background: ["#ffffff22"].

      {[
        let code = "let x = 42 // [!code highlight]\nlet y = 10" in
        let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
        Ochre.to_html_with hl ~transforms ~theme ~lang:"test" code
      ]} *)

  val notation_diff :
    ?add_background:string -> ?remove_background:string -> unit -> Transform.t
  (** {2 notation_diff}

      Notation-based diff markers. Scans token text for [[!code ++]] and
      [[!code --]] comments, removes them, and applies green or red backgrounds
      to the entire line. Mirrors Shiki's [transformerNotationDiff].

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
  (** {2 notation_word_highlight}

      Notation-based word highlight. Scans token text for [[!code word:xxx]]
      comments, removes them, and highlights all occurrences of [xxx] on that
      line. Mirrors Shiki's [transformerNotationWordHighlight].

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

    {[
      let code = "let x = 42\nlet y = 10" in
      let decorations =
        [
          Ochre.Decoration.make ~class_:"hl"
            ~start:(Ochre.Decoration.pos 0 4)
            ~end_:(Ochre.Decoration.pos 0 5)
            ();
        ]
      in
      let transforms = [ Ochre.Transform_builtin.line_highlight [ 1 ] ] in
      Ochre.to_html_with hl ~decorations ~transforms ~theme ~lang:"ocaml" code
    ]} *)

val to_tokens_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  Token.highlighted_code
(** {2 to_tokens_with}

    Like {!val-to_tokens} but applies decorations and transforms before
    returning. *)

val to_html_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  ?options:Html_options.t ->
  ?theme:Theme.theme ->
  ?extra_themes:(string * Theme.theme) list ->
  lang:string ->
  string ->
  string
(** {2 to_html_with}

    Like {!val-to_html} but applies decorations and transforms before rendering.
    Accepts the same [~theme] / [~extra_themes] / [~options] parameters as
    {!val-to_html}. *)

val to_ansi_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** {2 to_ansi_with}

    Like {!val-to_ansi} but applies decorations and transforms before rendering.
*)

val to_latex_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** {2 to_latex_with}

    Like {!val-to_latex} but applies decorations and transforms before
    rendering. *)

val to_svg_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** {2 to_svg_with}

    Like {!val-to_svg} but applies decorations and transforms before rendering.
*)

val to_debug_tokens_with :
  t ->
  ?decorations:Decoration.t list ->
  transforms:Transform.t list ->
  theme:Theme.theme ->
  lang:string ->
  string ->
  string
(** {2 to_debug_tokens_with}

    Like {!val-to_debug_tokens} but applies decorations and transforms before
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
(** {2 to_string_with}

    Like {!val-to_string} but applies decorations and transforms before
    rendering. *)
