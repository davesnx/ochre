(** Syntax highlighter using TextMate grammars and themes.

    Ochre turns source code into highlighted output using TextMate grammars (the
    same tokenizer that powers VS Code) and TextMate/VS Code themes. It supports
    HTML, ANSI terminal colors, LaTeX, and SVG output formats.

    {@ocaml[
    let html =
      match Ochre.load [ ("ocaml", ocaml_grammar_json) ] with
      | Error e ->
          Error e
      | Ok highlighter -> (
          match
            (Ochre.lang highlighter "ocaml", Ochre.Theme.load Tm_themes.nord)
          with
          | Error e, _ | _, Error e ->
              Error e
          | Ok lang, Ok (theme, _warnings) ->
              Ok (Ochre.to_html (Ochre.highlight ~theme ~lang "let x = 42"))
        )
    ]}

    Themes are data: load one from JSON with {!Theme.val-load}. The [tm-themes]
    package has every Shiki theme as a JSON string, such as [Tm_themes.nord].
    The examples below use a [theme] loaded this way. *)

(** {1 Errors} *)

module Error : sig
  (** Every error that loading grammars, themes and languages can return. *)
  type t = Error.t =
    | Unknown_language of string
        (** No grammar is registered under this language id. *)
    | Grammar_error of { lang : string; path : string option; message : string }
        (** A grammar cannot be read or parsed, or its id is a duplicate. [path]
            is the file, when the grammar came from a file. *)
    | Theme_error of { path : string option; message : string }
        (** A theme cannot be read or parsed. [path] is the file, when the theme
            came from a file. *)
    | Include_cycle of string list
        (** Theme files include each other. The list is the chain of paths, from
            the first file to the file that closes the cycle. *)
    | Duplicate_theme_label of string
        (** Two themes of a {!Themed} value have the same label. *)
    | Unknown_theme_label of string
        (** {!Themed.select} was given a label that no theme has. *)
    | Foreign_token of { transform : string }
        (** The transform returned a token taken from another {!Themed} value
            with a different number of themes. *)
    | Invalid_data_key of string
        (** A decoration data key is empty or holds a byte outside
            [A-Za-z0-9_-]. *)

  val to_string : t -> string
  (** A message for humans. *)
end

(** {1 Colors} *)

module Color : sig
  type t = Color.t = private { r : int; g : int; b : int; a : int }
  (** An sRGB color with an alpha channel. Each channel is a byte, from [0] to
      [255]; [a = 255] is opaque. *)

  val rgb : int -> int -> int -> t
  (** [rgb r g b] is an opaque color. Each value is clipped to [0]-[255]. *)

  val rgba : int -> int -> int -> int -> t
  (** [rgba r g b a] is a color with alpha [a]. Each value is clipped to
      [0]-[255]. *)

  val oklch : float -> float -> float -> t
  (** [oklch l c h] is the opaque sRGB color for the OKLCH lightness [l] (from
      [0.] to [1.]), chroma [c] and hue [h] in degrees. A color outside the sRGB
      gamut is clipped channel by channel. *)

  val of_hex : string -> t option
  (** [of_hex s] parses [#rgb], [#rgba], [#rrggbb] or [#rrggbbaa], in any case,
      as vscode-textmate does. Returns [None] for any other string, such as a
      CSS color name or [rgb()]. *)

  val to_hex : t -> string
  (** [to_hex c] is [#rrggbb] in lowercase, or [#rrggbbaa] when [c] is not
      opaque. HTML and SVG write colors in this form; LaTeX writes uppercase
      [RRGGBB] for the xcolor [HTML] model. *)

  val equal : t -> t -> bool
end

(** {1 Styles} *)

module Style : sig
  type font_style = Style.font_style = {
    bold : bool;
    italic : bool;
    underline : bool;
    strikethrough : bool;
  }
  (** The font style of a token. *)

  val plain : font_style
  (** No bold, italic, underline or strikethrough. *)

  type t = Style.t = {
    foreground : Color.t;
    background : Color.t option;
        (** [None] shows the theme background. A theme rule background equal to
            the theme background is [None]. *)
    font_style : font_style;
  }
  (** The style of a token under one theme. *)
end

(** {1 Themes}

    A theme maps TextMate scopes to colors and font styles. Ochre loads any VS
    Code / TextMate theme from JSON. The [tm-themes] package has the Shiki
    themes as OCaml strings. *)

module Theme : sig
  (** {2 color} *)

  type color = Color.t

  (** {2 token_color_settings} *)

  type token_color_settings = Theme.token_color_settings = {
    foreground : color option;
    background : color option;
    font_style : Style.font_style option;
  }
  (** Color and style settings of a theme rule. [None] inherits the value of the
      enclosing scope. A [font_style] of {!Style.plain} is the ["none"] or empty
      ["fontStyle"] of the theme JSON: it resets the font style. *)

  (** {2 token_color_rule} *)

  type token_color_rule = Theme.token_color_rule = {
    name : string option;
    scope : string list;
    settings : token_color_settings;
  }
  (** A rule mapping TextMate scopes to visual settings. Each rule contains a
      list of scope selectors and the styling to apply when a token matches one
      of those selectors. *)

  (** {2 theme} *)

  type theme = Theme.theme = {
    name : string;
    colors : (string * color) list;
    fg : color;
    bg : color;
    token_colors : token_color_rule list;
  }
  (** A loaded theme with default foreground/background colors and a list of
      token coloring rules. *)

  (** {2 warning} *)

  type warning = Theme.warning = {
    path : string option;  (** The file that holds the value, if any. *)
    location : string;
        (** Where the value is, such as ["tokenColors[2].settings.foreground"]
            or ["colors.editor.background"]. *)
    value : string;  (** The value that was dropped. *)
  }
  (** A color that is not [#rgb], [#rgba], [#rrggbb] or [#rrggbbaa]. As in
      vscode-textmate, loading drops it, so the rule or the [colors] entry acts
      as if the value were not there. *)

  val warning_to_string : warning -> string
  (** A message for humans. *)

  (** {2 load} *)

  val load :
    ?base_dir:string -> string -> (theme * warning list, Error.t) result
  (** Load a theme from a raw JSON string. Returns the theme and one warning for
      each color that was dropped.

      When [~base_dir] is provided, ["include"] paths in the JSON are resolved
      relative to that directory (same as {!val-load_from_file} does with the
      file's parent directory). When omitted, an ["include"] is an
      {!Error.Theme_error}.

      Returns {!Error.Theme_error} when the JSON is malformed or an included
      file cannot be read, and {!Error.Include_cycle} when included files
      include each other.

      {@ocaml[
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
      ]} *)

  (** {2 load_from_file} *)

  val load_from_file : string -> (theme * warning list, Error.t) result
  (** Load a theme from a VS Code theme JSON file, like {!val-load} with the
      file's directory as [base_dir].

      Falls back to the filename as the theme name when none is specified in the
      JSON.

      {@ocaml[
      match Ochre.Theme.load_from_file "/path/to/theme.json" with
      | Ok (theme, warnings) ->
          List.iter
            (fun w -> prerr_endline (Ochre.Theme.warning_to_string w))
            warnings;
          theme
      | Error e ->
          failwith (Ochre.Error.to_string e)
      ]} *)

  (** {2 make} *)

  val make :
    name:string ->
    ?colors:(string * color) list ->
    token_colors:token_color_rule list ->
    unit ->
    theme
  (** Make a new TextMate-style theme from ordered token rules.

      {@ocaml[
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
      ]} *)

  (** {2 rule} *)

  val rule :
    ?name:string ->
    ?scope:string list ->
    ?foreground:color ->
    ?background:color ->
    ?font_style:Style.font_style ->
    unit ->
    token_color_rule
  (** Construct a token color rule. *)
end

(** {1 Highlighter}

    The highlighter holds loaded grammars. Load one with {!val-load} or
    {!val-load_from_files}, then look up a language with {!val-lang}. *)

type t
(** Highlighter instance. Holds loaded grammars. *)

(** {2 load} *)

val load : (string * string) list -> (t, Error.t) result
(** Load a highlighter from grammar JSON strings.

    Each pair is [(lang_id, json_content)] where [lang_id] is the language
    identifier and [json_content] is the raw TextMate grammar JSON. Each
    [lang_id] must be unique.

    Returns {!Error.Grammar_error} when a grammar fails to parse or a [lang_id]
    is duplicated.

    The first call to {!val-load} or {!val-load_from_files} in a process
    configures ochre's Oniguruma regex engine limits (retry and match-stack
    size) process-wide; later calls do not change them.

    {@ocaml[
    match Ochre.load [ ("ocaml", Tm_grammar_ocaml.json) ] with
    | Ok hl ->
        hl
    | Error e ->
        failwith (Ochre.Error.to_string e)
    ]} *)

(** {2 load_from_files} *)

val load_from_files : string list -> (t, Error.t) result
(** Load a highlighter from grammar files on disk.

    Each grammar is a path to a [.tmLanguage.json] file. The language identifier
    is derived from the filename (e.g. ["ocaml.tmLanguage.json"] registers as
    ["ocaml"]) and must be unique across the given files.

    Returns {!Error.Grammar_error} with the path when a file cannot be read, a
    grammar fails to parse, or two files derive the same language id. *)

(** {2 Languages} *)

module Lang : sig
  type t
  (** A checked language: a loaded grammar with its grammar collection, or plain
      text. Render functions take a [Lang.t], so they never fail on an unknown
      language. *)

  val plaintext : t
  (** Plain text: one unstyled token per line, in the theme's default colors. *)

  val name : t -> string
  (** The language id that was looked up, or ["plaintext"]. *)
end

val lang : t -> string -> (Lang.t, Error.t) result
(** [lang hl id] looks up the language [id] in [hl]. The ids ["plaintext"],
    ["text"] and ["txt"] always resolve, to plain text, unless a grammar is
    registered under that id. Returns {!Error.Unknown_language} otherwise.

    {@ocaml[
    match Ochre.lang hl "ocaml" with
    | Ok lang ->
        Ochre.to_html (Ochre.highlight ~theme ~lang "let x = 42")
    | Error e ->
        failwith (Ochre.Error.to_string e)
    ]} *)

(** {1 Tokens}

    Tokens are the basic unit of highlighted code. Each token is a fragment of
    the source with its TextMate scopes, its position in the source, and one
    {!Style.t} per theme. *)

module Token : sig
  type position = Token.position = {
    offset : int;  (** Byte offset in the source. *)
    line : int;  (** Line, from [0]. *)
    column : int;  (** Byte offset in the line. *)
    length : int;  (** Number of source bytes the token covers. *)
  }
  (** Where a token comes from in the original source. Transforms never change
      the position of the text they keep: a token keeps the position of its
      source text when a transform removes other text, and a piece of a split
      token gets the position of its own bytes. A token that a transform inserts
      has a [length] of [0] at the insert point. *)

  type decoration_properties = Token.decoration_properties = private {
    class_ : string option;
    style : string option;
    data : (string * string) list;
  }
  (** Format-agnostic properties attached by a decoration. Only the HTML and SVG
      renderers apply them, mapping [class_]/[style]/[data] to HTML/SVG
      attributes; the ANSI and LaTeX renderers ignore decorations. *)

  type styles = Token.styles
  (** One {!Style.t} per theme of the {!Themed} value the token belongs to. *)

  type t = Token.t = {
    text : string;
    position : position;
    scopes : string list;
    styles : styles;
    decoration : decoration_properties option;
  }
  (** A token. Build new tokens from existing ones, with [{ token with ... }],
      {!val-sub}, {!val-insert_before} or {!val-insert_after}, so that they keep
      one style per theme. *)

  type line = t list
  (** A line of tokens. The last token of every line but the last ends with
      ["\n"]. *)

  val style : t -> Style.t
  (** The style of the token under the default theme. *)

  val all_styles : t -> Style.t list
  (** The styles of the token, one per theme, in the order of
      {!Themed.t.themes}: the default theme first, then the extra themes. *)

  val map_style : (Theme.theme -> Style.t -> Style.t) -> t -> t
  (** [map_style f token] applies [f] once per theme to the style of [token]
      under that theme.

      {@ocaml[
      let underline token =
        Ochre.Token.map_style
          (fun _theme style ->
            {
              style with
              font_style = { style.font_style with underline = true };
            }
          )
          token
      ]} *)

  val sub : t -> pos:int -> len:int -> t option
  (** [sub token ~pos ~len] is the token for the [len] bytes of [token.text]
      from byte [pos], with the position of those bytes. Returns [None] when the
      range is not inside [token.text]. *)

  val insert_before : t -> string -> t
  (** [insert_before token text] is a new token with [text], the scopes and
      styles of [token], no decoration, and a zero-length position at the start
      of [token]. *)

  val insert_after : t -> string -> t
  (** Like {!val-insert_before}, at the end of [token]. *)
end

(** {1 Themed code}

    Highlighted code is tokenized once and styled under one or more themes. *)

module Themed : sig
  type t = Themed.t = private {
    themes : (string * Theme.theme) * (string * Theme.theme) list;
        (** The labelled default theme, then the labelled extra themes. The
            default label is the [?label] given to {!val-highlight} or
            {!val-highlight_themes}, or the theme name. *)
    lines : Token.line list;
  }
  (** Highlighted code. Each token has one style per theme, in the order of
      [themes]. Make one with {!val-highlight} or {!val-highlight_themes}. *)

  val select : string -> t -> (t, Error.t) result
  (** [select label themed] makes the theme labelled [label] the default theme,
      and keeps the others as extra themes in their order. Renderers that show
      one theme, such as {!val-to_ansi}, show the default theme. Returns
      {!Error.Unknown_theme_label} when no theme has [label].

      {@ocaml[
      match Ochre.Themed.select "dark" themed with
      | Ok dark ->
          print_string (Ochre.to_ansi dark)
      | Error e ->
          prerr_endline (Ochre.Error.to_string e)
      ]} *)
end

(** {1 Decorations}

    Decorations attach format-agnostic properties (CSS class, inline style, data
    attributes) to ranges of source code identified by line/character position.
    They are applied after tokenization but before transforms.

    {!Decoration.val-make} returns {!Error.Invalid_data_key} when a data key is
    empty or holds a byte outside [A-Za-z0-9_-], because the key becomes part of
    a [data-*] attribute name. Decorations and token decoration properties are
    private records, so every data key goes through this check. *)

module Decoration : sig
  (** {2 position} *)

  type position = Decoration.position = { line : int; character : int }
  (** 0-indexed position in source code. [character] counts Unicode scalar
      values, not UTF-8 bytes.

      Negative [character] values count Unicode scalar values from the end of
      the line: [-1] means the line end, [-2] means one scalar before the end,
      etc. *)

  (** {2 properties} *)

  type properties = Decoration.properties = {
    class_ : string option;
    style : string option;
    data : (string * string) list;
  }
  (** Properties to attach to a decorated range. *)

  (** {2 t} *)

  type t = Decoration.t = private {
    start : position;
    end_ : position;
    properties : properties;
  }
  (** A decoration targeting a range from [start] (inclusive) to [end_]
      (exclusive). *)

  (** {2 pos} *)

  val pos : int -> int -> position
  (** [pos line character] creates a position. *)

  (** {2 make} *)

  val make :
    ?class_:string ->
    ?style:string ->
    ?data:(string * string) list ->
    start:position ->
    end_:position ->
    unit ->
    (t, Error.t) result
  (** Create a decoration. Returns {!Error.Invalid_data_key} when a key of
      [~data] is empty or holds a byte outside [A-Za-z0-9_-].

      {@ocaml[
      let d =
        Ochre.Decoration.make ~class_:"highlighted"
          ~start:(Ochre.Decoration.pos 0 0)
          ~end_:(Ochre.Decoration.pos 0 11)
          ()
      ]} *)

  (** {2 apply} *)

  val apply : source:string -> t list -> Token.line list -> Token.line list
  (** [apply ~source decorations lines] maps decoration ranges onto tokens,
      splitting tokens at boundaries and attaching properties. A token is
      matched by its {!Token.type-position}, so [source] must be the source the
      tokens come from.

      Overlapping decorations are merged: classes are space-concatenated, styles
      are semicolon-concatenated, data attributes are merged (later wins).

      Character positions are Unicode scalar positions; they are converted to
      the byte positions of the tokens once per line. Never raises: each byte
      that is not part of a valid UTF-8 sequence counts as one character.
      {!val-highlight} applies [~decorations] with this function, before
      transforms. *)
end

(** {1 Transforms}

    Transforms run after tokenization, theming and decorations, but before
    rendering. They change structure (text, splitting, decorations) through the
    token fields, and style through {!Token.map_style}, which runs once per
    theme. A token taken from another {!Themed} value with the same number of
    themes keeps the styles it carries. *)

module Transform : sig
  type token = Token.t
  type line = token list
  type document = line list

  (** {2 t} *)

  type t = Transform.t = {
    name : string;
    before_line : (line_index:int -> line -> line) option;
    after_line : (line_index:int -> line -> line) option;
    before_render : (document -> document) option;
    after_render : (document -> document) option;
  }
  (** A transform with named hooks. Each hook is optional. The pipeline calls
      them in this order:

      + [before_render] on the full document
      + [before_line] for each line (by index)
      + [after_line] for each line (by index)
      + [after_render] on the full document

      When multiple transforms are provided, each hook phase folds over all
      transforms in list order before moving to the next phase. *)

  (** {2 make} *)

  val make :
    ?before_line:(line_index:int -> line -> line) ->
    ?after_line:(line_index:int -> line -> line) ->
    ?before_render:(document -> document) ->
    ?after_render:(document -> document) ->
    string ->
    t
  (** [make name] creates a transform with the given hooks.

      {@ocaml[
      let bold_keywords =
        Ochre.Transform.make "bold-keywords"
          ~after_line:(fun ~line_index:_ line ->
            List.map
              (fun (tok : Ochre.Token.t) ->
                if tok.text = "let" || tok.text = "in" then
                  Ochre.Token.map_style
                    (fun _ style ->
                      {
                        style with
                        font_style = { style.font_style with bold = true };
                      }
                    )
                    tok
                else
                  tok
              )
              line
        )
      ]} *)

  (** {2 run} *)

  val run : t list -> document -> document
  (** [run transforms document] applies all transforms to the document.

      Transforms are applied in list order. An empty list returns the document
      unchanged. *)
end

(** {2 Built-in transforms}

    Ready-to-use transforms for common highlighting patterns. *)

module Transform_builtin : sig
  (** {2 line_highlight} *)

  val line_highlight : ?background:Color.t -> int list -> Transform.t
  (** Highlights the given line indices (0-based) by setting every token's
      background color, under every theme.

      Default background: ["#8888883a"].

      {@ocaml[
      Ochre.highlight
        ~transforms:[ Ochre.Transform_builtin.line_highlight [ 0; 2 ] ]
        ~theme ~lang code
      ]} *)

  (** {2 word_highlight} *)

  val word_highlight :
    ?foreground:Color.t ->
    ?font_style:Style.font_style ->
    string list ->
    Transform.t
  (** Highlights tokens whose text matches one of the given words, under every
      theme.

      Default foreground: ["#ffff00"]. Default font style: bold.

      {@ocaml[
      Ochre.highlight
        ~transforms:[ Ochre.Transform_builtin.word_highlight [ "x"; "y" ] ]
        ~theme ~lang code
      ]} *)

  (** {2 diff_markers} *)

  val diff_markers : Transform.t
  (** Strips leading [+] or [-] from the first token of each line and applies a
      green or red background to the entire line, under every theme. *)

  (** {2 scope_marker} *)

  val scope_marker : ?background:Color.t -> string -> Transform.t
  (** Highlights tokens that have at least one scope starting with [prefix].

      Default background: ["#ffff0033"]. *)

  (** {2 notation_highlight} *)

  val notation_highlight : ?background:Color.t -> unit -> Transform.t
  (** Notation-based line highlight. Finds a [[!code highlight]] or [[!code hl]]
      marker in the comment that ends a line, removes it, and sets the
      background color on the entire line. Mirrors Shiki's
      [transformerNotationHighlight], and so do the rules below, which hold for
      the three notation transforms.

      The marker must be inside the last comment of the line: a [//], [#], [;],
      [%] or [--] comment that runs to the end of the line, or a [/* */],
      [<!-- -->], [(* *)], [{- -}] or [--[[ ]]] comment that closes at the end
      of the line. A comment is found from its comment scope when the grammar
      gives one, and from its opener otherwise, so plain text and Markdown work
      too. A marker in a string, or in a block comment that code follows, is
      left alone. The whole comment goes, with the blanks before it, when the
      marker was all it held; other text in the comment stays. The newline
      stays.

      [[!code highlight:3]] applies to three lines. When the comment is alone on
      its line, the line is removed and the marker applies to the lines below
      it.

      Default background: ["#8888883a"].

      {@ocaml[
      let code = "let x = 42 // [!code highlight]\nlet y = 10" in
      let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
      Ochre.highlight ~transforms ~theme ~lang code
      ]} *)

  (** {2 notation_diff} *)

  val notation_diff :
    ?add_background:Color.t -> ?remove_background:Color.t -> unit -> Transform.t
  (** Notation-based diff markers. Finds [[!code ++]] and [[!code --]] markers
      in comments, removes them, and applies green or red backgrounds to the
      entire line. Mirrors Shiki's [transformerNotationDiff]; see
      {!val-notation_highlight} for where a marker may sit and what is removed.

      Default add background: ["#22883322"]. Default remove background:
      ["#88222222"].

      {@ocaml[
      let code = "let x = 42 // [!code ++]\nlet y = 10 // [!code --]" in
      let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
      Ochre.highlight ~transforms ~theme ~lang code
      ]} *)

  (** {2 notation_word_highlight} *)

  val notation_word_highlight :
    ?foreground:Color.t -> ?font_style:Style.font_style -> unit -> Transform.t
  (** Notation-based word highlight. Finds [[!code word:xxx]] markers in
      comments, removes them, and highlights all occurrences of [xxx], across
      token boundaries. Without a count the highlight runs from the line of the
      marker to the end of the code; [[!code word:xxx:2]] limits it to two
      lines. A backslash escapes a character of the word. Mirrors Shiki's
      [transformerNotationWordHighlight]; see {!val-notation_highlight} for
      where a marker may sit and what is removed.

      Default foreground: ["#ffff00"]. Default font style: bold.

      {@ocaml[
      let code = "let x = 42 // [!code word:x]" in
      let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
      Ochre.highlight ~transforms ~theme ~lang code
      ]} *)
end

(** {1 Highlighting} *)

val highlight :
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  ?label:string ->
  theme:Theme.theme ->
  lang:Lang.t ->
  string ->
  Themed.t
(** [highlight ~theme ~lang source] tokenizes [source] and styles it with
    [theme]. Decorations are applied after tokenization and transforms run after
    decorations. [~label] names the theme for HTML with
    {!Html_options.No_default_color}; it defaults to the theme name.

    The source may contain bytes that are not valid UTF-8. They are kept byte
    for byte in the token texts. The tokenizer sees each such byte as an
    underscore, so it behaves like a non-ASCII letter.

    {@ocaml[
    let themed = Ochre.highlight ~theme ~lang code in
    List.iter
      (List.iter (fun (tok : Ochre.Token.t) -> print_string tok.text))
      themed.lines
    ]} *)

val highlight_themes :
  ?decorations:Decoration.t list ->
  ?transforms:Transform.t list ->
  ?label:string ->
  theme:Theme.theme ->
  extra_themes:(string * Theme.theme) list ->
  lang:Lang.t ->
  string ->
  (Themed.t, Error.t) result
(** Like {!val-highlight}, styled with the default [theme] and each labelled
    extra theme. [source] is tokenized once, and each transform runs once: it
    changes the style under every theme with {!Token.map_style}.

    Returns {!Error.Duplicate_theme_label} when two labels are equal after each
    byte outside [A-Za-z0-9_-] becomes ['_']. The default theme takes part with
    [~label], or its name. Returns {!Error.Foreign_token} when a transform
    returns a token whose number of styles differs from the number of themes,
    such as a token taken from another {!Themed} value.

    {@ocaml[
    match
      Ochre.highlight_themes ~label:"light" ~theme:light_theme
        ~extra_themes:[ ("dark", dark_theme) ]
        ~lang code
    with
    | Ok themed ->
        Ochre.to_html themed
    | Error e ->
        failwith (Ochre.Error.to_string e)
    ]} *)

(** {1 Backends}

    Ochre renders {!Themed} code to several output formats. Render functions
    never fail.

    - {b HTML} — Self-contained [<pre><code>] blocks with inline styles or CSS
      classes. Shows every theme through CSS custom properties.
    - {b ANSI} — 24-bit color escape sequences for terminal display.
    - {b LaTeX} — [\textcolor] commands inside an [ochrehighlight] environment.
      Requires the [xcolor] and [ulem] packages.
    - {b SVG} — Standalone [<svg>] elements with monospace [<text>] and
      per-token [<tspan>] styling.
    - {b Debug tokens} — Raw token text for debugging grammar and scope
      matching.

    ANSI, LaTeX and SVG show the default theme. Use {!Themed.select} to show
    another one. *)

(** {2 HTML options} *)

module Html_options : sig
  (** {2 style_mode} *)

  (** How token colors are expressed in the output. *)
  type style_mode = Html_options.style_mode =
    | Inline_styles  (** Emit [style="color:..."] on each [<span>]. Default. *)
    | Css_classes of { class_prefix : string }
        (** Replace inline styles with deterministic CSS class names. *)

  (** {2 default_color} *)

  (** Whether the primary theme's colors are emitted inline. *)
  type default_color = Html_options.default_color =
    | Default_color
        (** Emit inline [color:] and [background-color:]. Default. *)
    | No_default_color
        (** Suppress inline colors. Every theme, the primary one included, is
            emitted as CSS custom properties, and the page supplies [color:] and
            [background-color:]. Font styles are still applied. *)

  (** {2 t} *)

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

  (** {2 default} *)

  val default : t
  (** Inline styles, default colors, no extra classes, no line numbers, the
      [--ochre-] variable prefix and no scope attributes. *)

  (** {2 make} *)

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
  (** Construct options with defaults for any unspecified fields.

      {@ocaml[
      let opts =
        Ochre.Html_options.make ~line_numbers:true
          ~default_color:No_default_color ()
      ]} *)
end

(** {2 to_html} *)

val to_html : ?options:Html_options.t -> Themed.t -> string
(** Render highlighted code to HTML.

    {3 Single theme}

    {@ocaml[
    Ochre.to_html (Ochre.highlight ~theme ~lang "let x = 42")
    ]}

    {3 Multiple themes}

    Each extra theme label becomes a CSS custom property prefix
    ([--ochre-<label>]). The default theme is emitted as base fallback variables
    ([var(--ochre-bg,<bg>)], [var(--ochre,<fg>)]), while extra themes are
    emitted as label-scoped variables. With {!Html_options.No_default_color},
    the default theme is emitted as [--ochre-<label>] like an extra theme, with
    its label.

    A token follows every theme for its colour, background, [font-weight],
    [font-style] and [text-decoration]. When any theme gives a token a value for
    one of them, the token reads a variable for it, and every extra theme
    defines that variable, with the neutral value ([normal], [none],
    [transparent], the theme colour) where the theme has none. So bold, italic,
    underline, strikethrough and token backgrounds of one theme neither leak
    into nor vanish from another. The token background uses [--ochre-token-bg],
    not the page background [--ochre-bg]. Underline and strikethrough together
    give [underline line-through].

    Pair with {!val-html_theme_css} to activate alternate themes via CSS. *)

(** {2 html_theme_css} *)

val html_theme_css : ?css_variable_prefix:string -> string -> string
(** [html_theme_css label] returns a CSS rule that maps base variables
    ([--ochre-*]) to the label-scoped variables ([--ochre-<label>-*]).
    [~css_variable_prefix] replaces ["--ochre-"]; give the prefix of the
    {!Html_options.type-t} that rendered the code.

    Wrap this in your own selector (a media query, a [.dark] class, a
    [data-theme] attribute selector, etc.) to control when the theme activates.

    {@ocaml[
    Printf.sprintf ".dark {\n  %s\n}" (Ochre.html_theme_css "dark")
    ]} *)

(** {2 html_render_theme_css} *)

val html_render_theme_css :
  ?css_variable_prefix:string -> class_prefix:string -> Themed.t -> string
(** [html_render_theme_css ~class_prefix themed] generates a complete CSS
    stylesheet for the default theme of [themed] when using
    {!Html_options.Css_classes} mode. Walks all tokens to discover unique styles
    and maps each to a deterministic class name prefixed with [class_prefix].
    Pass the [css_variable_prefix] of the {!Html_options.type-t} used to render
    the HTML as [~css_variable_prefix]; the class names depend on it. *)

(** {2 html_render_whole_theme_css} *)

val html_render_whole_theme_css :
  ?css_variable_prefix:string -> class_prefix:string -> Theme.theme -> string
(** [html_render_whole_theme_css ~class_prefix theme] generates a CSS stylesheet
    for every style that [theme] can give a token, with no code to highlight:
    the [.ochre] rule with the theme background and foreground, then one class
    for each style. The class names are the ones that
    {!Html_options.Css_classes} rendering with [class_prefix] uses, so the
    stylesheet covers any code highlighted with [theme]. A style that a
    transform makes, such as a line highlight, is not in the stylesheet; the
    HTML keeps it inline. Pass the [css_variable_prefix] of the
    {!Html_options.type-t} used to render the HTML as [~css_variable_prefix];
    the class names depend on it.

    {@ocaml[
    let css = Ochre.html_render_whole_theme_css ~class_prefix:"hl-" theme
    ]} *)

(** {2 to_ansi} *)

val to_ansi : Themed.t -> string
(** Render highlighted code to ANSI terminal escape sequences.

    Produces text with embedded 24-bit ANSI color codes for terminal display. A
    terminal has no alpha channel: a translucent background, such as the one of
    the line-highlight transforms, is blended over the theme background, and a
    translucent foreground over the background behind it.

    {@ocaml[
    print_string (Ochre.to_ansi (Ochre.highlight ~theme ~lang code))
    ]} *)

(** {2 to_latex} *)

val to_latex : Themed.t -> string
(** Render highlighted code to LaTeX with [\textcolor] commands.

    Produces a block wrapped in an [ochrehighlight] environment. Requires the
    [xcolor] and [ulem] LaTeX packages ([\usepackage[normalem]{ulem}] provides
    [\sout] for strikethrough).

    A token background, such as the one of the line-highlight transforms, is
    drawn with [\colorbox] in a group that sets [\fboxsep] to [0pt]. LaTeX has
    no alpha channel, so a translucent background is blended over the theme
    background, and a background equal to the theme background is not drawn. A
    tab becomes spaces up to the next multiple of 8 columns, a carriage return
    is dropped, and every other C0 control character and DEL is written in caret
    notation, like [cat -v]. The output was not compiled with TeX. *)

(** {2 to_svg} *)

val to_svg : Themed.t -> string
(** Render highlighted code to a self-contained SVG element.

    Produces an [<svg>] with monospace [<text>] elements and per-token [<tspan>]
    styling. Suitable for embedding in documents or rendering as an image. The
    [<text>] has the theme foreground as [fill]. A token background, such as the
    one of the line-highlight transforms, is drawn as a [<rect>] behind the
    text; a background equal to the theme background is not drawn.

    The width counts display cells: a Unicode scalar value is one cell, an East
    Asian wide or fullwidth character two, a combining mark none, and a carriage
    return none. A tab becomes spaces up to the next multiple of 8 cells, so the
    indentation survives [xml:space="preserve"]. *)

(** {2 to_debug_tokens} *)

val to_debug_tokens : Themed.t -> string
(** Render each token as [{text}[scope1,scope2,...]].

    Useful for debugging grammar and scope matching. Styles are not part of this
    format, so it is the same under every theme. *)

(** {2 output_format} *)

type output_format =
  | Html
  | Ansi
  | Latex
  | Svg
  | Tokens
      (** Supported output formats. Use with {!val-to_string} to select a
          backend at runtime. *)

(** {2 output_formats} *)

val output_formats : (string * output_format) list
(** Mapping of format names to typed variants. *)

(** {2 string_of_output_format} *)

val string_of_output_format : output_format -> string
(** Convert a format variant to its canonical lowercase name. *)

(** {2 output_format_of_string} *)

val output_format_of_string : string -> output_format option
(** Parse a format name into a variant. Returns [None] for unrecognised names.
*)

(** {2 to_string} *)

val to_string :
  ?options:Html_options.t -> format:output_format -> Themed.t -> string
(** Render highlighted code to one of the supported output formats. [~options]
    applies only to {!Html}.

    {@ocaml[
    let output = Ochre.to_string ~format:Html themed
    ]} *)
