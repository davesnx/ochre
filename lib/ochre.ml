type t = { grammar_loader : Grammar_loader.t }
type output_format = Html | Ansi | Latex | Svg | Tokens

let string_of_output_format = function
  | Html ->
      "html"
  | Ansi ->
      "ansi"
  | Latex ->
      "latex"
  | Svg ->
      "svg"
  | Tokens ->
      "tokens"

let output_format_of_string value =
  match String.lowercase_ascii value with
  | "html" ->
      Some Html
  | "ansi" ->
      Some Ansi
  | "latex" ->
      Some Latex
  | "svg" ->
      Some Svg
  | "tokens" ->
      Some Tokens
  | _ ->
      None

let output_formats =
  List.map
    (fun f -> (string_of_output_format f, f))
    [ Html; Ansi; Latex; Svg; Tokens ]

let oniguruma_limits =
  lazy
    ( Oniguruma.set_retry_limit_in_match 1_000_000;
      Oniguruma.set_match_stack_limit_size 100_000
    )

let configure_oniguruma_limits () = Lazy.force oniguruma_limits

let load grammars =
  configure_oniguruma_limits ();
  Result.map
    (fun grammar_loader -> { grammar_loader })
    (Grammar_loader.load grammars)

let load_from_files paths =
  configure_oniguruma_limits ();
  Result.map
    (fun grammar_loader -> { grammar_loader })
    (Grammar_loader.load_from_files paths)

let lang t name = Lang.find t.grammar_loader name

let split_lines source =
  let parts = String.split_on_char '\n' source in
  let ends_with_newline = String.ends_with ~suffix:"\n" source in
  let parts =
    if ends_with_newline then
      List.rev parts |> List.tl |> List.rev
    else
      parts
  in
  match parts with
  | [ "" ] when source = "" ->
      []
  | _ ->
      let last_index = List.length parts - 1 in
      List.mapi
        (fun index line ->
          if index < last_index || ends_with_newline then
            line ^ "\n"
          else
            line
        )
        parts

let position ~line_offset ~line ~column ~length =
  { Token.offset = line_offset + column; line; column; length }

let raw_tokenize (lang : Lang.t) source =
  let lines = split_lines source in
  let stack = ref TmLanguage.empty in
  let line_offset = ref 0 in
  List.mapi
    (fun line_index line ->
      let line_offset_value = !line_offset in
      line_offset := line_offset_value + String.length line;
      let position = position ~line_offset:line_offset_value ~line:line_index in
      match lang.kind with
      | Plaintext ->
          [ (line, [], position ~column:0 ~length:(String.length line)) ]
      | Grammar { collection; grammar } ->
          let tokens, new_stack =
            TmLanguage.tokenize_exn collection grammar !stack
              (Utf8.mask_invalid line)
          in
          stack := new_stack;
          let rec extract start = function
            | [] ->
                []
            | tok :: rest ->
                let ending = TmLanguage.ending tok in
                let length = ending - start in
                ( String.sub line start length,
                  TmLanguage.scopes tok,
                  position ~column:start ~length
                )
                :: extract ending rest
          in
          extract 0 tokens
    )
    lines

let style_of (theme : Theme.theme) resolver scopes : Style.t =
  let settings = Scope.resolve resolver scopes in
  let field get = Option.bind settings get in
  {
    foreground =
      Option.value
        (field (fun (s : Theme.token_color_settings) -> s.foreground))
        ~default:theme.fg;
    background =
      ( match field (fun (s : Theme.token_color_settings) -> s.background) with
      | Some color when not (Color.equal color theme.bg) ->
          Some color
      | _ ->
          None
      );
    font_style =
      Option.value
        (field (fun (s : Theme.token_color_settings) -> s.font_style))
        ~default:Style.plain;
  }

let apply_themes ~scopes themes raw =
  let resolvers =
    Array.map
      (fun (theme : Theme.theme) -> Scope.resolver theme.token_colors)
      themes
  in
  let make (text, scopes, position) =
    let values =
      Array.mapi (fun i theme -> style_of theme resolvers.(i) scopes) themes
    in
    {
      Token.text;
      position;
      scopes;
      styles = Token.make_styles themes values;
      decoration = None;
    }
  in
  Scope_spans.apply ~make scopes raw

let decorated ?(scopes = []) ?(decorations = []) ~themes ~lang source =
  Decoration.apply ~source decorations
    (apply_themes ~scopes (Array.of_list themes) (raw_tokenize lang source))

let highlight ?scopes ?decorations ?(transforms = []) ?label
    ~(theme : Theme.theme) ~lang source =
  let lines = decorated ?scopes ?decorations ~themes:[ theme ] ~lang source in
  {
    Themed.themes = ((Option.value label ~default:theme.name, theme), []);
    lines = Transform.run transforms lines;
  }

let first_duplicate labels =
  let rec go seen = function
    | [] ->
        None
    | label :: rest ->
        if List.mem label seen then
          Some label
        else
          go (label :: seen) rest
  in
  go [] labels

let highlight_themes ?scopes ?decorations ?(transforms = []) ?label
    ~(theme : Theme.theme) ~extra_themes ~lang source =
  let label = Option.value label ~default:theme.name in
  match
    first_duplicate
      (List.map Escape.css_ident (label :: List.map fst extra_themes))
  with
  | Some label ->
      Error (Error.Duplicate_theme_label label)
  | None ->
      let themes = theme :: List.map snd extra_themes in
      let lines = decorated ?scopes ?decorations ~themes ~lang source in
      let count = List.length themes in
      let check (transform : Transform.t) token =
        if Token.style_count token = count then
          None
        else
          Some (Error.Foreign_token { transform = transform.name })
      in
      Result.map
        (fun lines -> { Themed.themes = ((label, theme), extra_themes); lines })
        (Transform.run_checked ~check transforms lines)

let to_html ?options themed = Render_html.render ?options themed

let html_theme_css = Render_html.theme_css
let html_render_theme_css = Render_html.render_theme_css

let render_default render (themed : Themed.t) =
  let (_, theme), _ = themed.themes in
  render theme themed.lines

let to_ansi = render_default Render_ansi.render
let to_latex = render_default Render_latex.render
let to_svg = render_default Render_svg.render
let to_debug_tokens (themed : Themed.t) = Render_tokens.render themed.lines

let to_string ?options ~format themed =
  match format with
  | Html ->
      to_html ?options themed
  | Ansi ->
      to_ansi themed
  | Latex ->
      to_latex themed
  | Svg ->
      to_svg themed
  | Tokens ->
      to_debug_tokens themed

module Error = Error
module Color = Color
module Style = Style
module Lang = Lang
module Token = Token
module Themed = Themed
module Theme = Theme
module Transform = Transform
module Transform_builtin = Transform_builtin
module Decoration = Decoration
module Scope_spans = Scope_spans
module Html_options = Html_options
