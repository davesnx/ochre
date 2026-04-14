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

let configure_oniguruma_limits () =
  Oniguruma.set_retry_limit_in_match 1_000_000;
  Oniguruma.set_match_stack_limit_size 100_000

let load_exn grammars =
  configure_oniguruma_limits ();
  { grammar_loader = Grammar_loader.load_exn grammars }

let load grammars =
  configure_oniguruma_limits ();
  match Grammar_loader.load grammars with
  | Ok loader ->
      Ok { grammar_loader = loader }
  | Error _ as err ->
      err

let load_from_files_exn grammars =
  configure_oniguruma_limits ();
  { grammar_loader = Grammar_loader.load_from_files_exn grammars }

let load_from_files grammars =
  configure_oniguruma_limits ();
  match Grammar_loader.load_from_files grammars with
  | Ok loader ->
      Ok { grammar_loader = loader }
  | Error _ as err ->
      err

let tokenize_with_grammar tm_collection grammar source =
  let lines = String.split_on_char '\n' source in
  let stack = ref TmLanguage.empty in
  let tokenized_lines =
    List.map
      (fun line ->
        let line_with_newline = line ^ "\n" in
        let tokens, new_stack =
          TmLanguage.tokenize_exn tm_collection grammar !stack line_with_newline
        in
        stack := new_stack;
        let rec extract_tokens prev_end = function
          | [] ->
              []
          | tok :: rest ->
              let start = prev_end in
              let ending = TmLanguage.ending tok in
              let text = String.sub line_with_newline start (ending - start) in
              let scopes = TmLanguage.scopes tok in
              (text, scopes) :: extract_tokens ending rest
        in
        extract_tokens 0 tokens
      )
      lines
  in
  tokenized_lines

let apply_theme theme tokens_per_line =
  let theme_rules = theme.Theme.token_colors in
  List.map
    (fun line_tokens ->
      List.map
        (fun (text, scopes) ->
          let settings = Scope.find_best_match scopes theme_rules in
          let foreground =
            match settings with
            | Some s ->
                s.Theme.foreground
            | None ->
                Some theme.fg
          in
          let background =
            match settings with Some s -> s.Theme.background | None -> None
          in
          let font_style =
            match settings with
            | Some s ->
                Option.value s.Theme.font_style ~default:[]
            | None ->
                []
          in
          {
            Token.text;
            foreground;
            background;
            font_style;
            scopes;
            decoration = None;
          }
        )
        line_tokens
    )
    tokens_per_line

let tokenize t ~theme ~lang source =
  let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
  let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
  let tokens = tokenize_with_grammar tm_collection grammar source in
  apply_theme theme tokens

let to_tokens t ?(decorations = []) ?(transforms = []) ~theme ~lang source =
  let tokens = tokenize t ~theme ~lang source in
  let tokens = Decoration.apply ~source decorations tokens in
  Transform.run transforms tokens

let resolve_themes ?theme ?(extra_themes = []) () =
  match (theme, extra_themes) with
  | Some t, _ ->
      (t, extra_themes)
  | None, (_, first_theme) :: rest ->
      (first_theme, rest)
  | None, [] ->
      (Theme.dark, [])

let to_html t ?(decorations = []) ?(transforms = []) ?options ?theme
    ?extra_themes ~lang source =
  let default_theme, extras = resolve_themes ?theme ?extra_themes () in
  match extras with
  | [] ->
      let tokens =
        to_tokens t ~decorations ~transforms ~theme:default_theme ~lang source
      in
      Render_html.render ?options default_theme tokens
  | _ ->
      let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
      let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
      let raw_tokens = tokenize_with_grammar tm_collection grammar source in
      let apply_pipeline theme_val =
        let code = apply_theme theme_val raw_tokens in
        let code = Decoration.apply ~source decorations code in
        Transform.run transforms code
      in
      let default_code = apply_pipeline default_theme in
      let themed_extras =
        List.map
          (fun (label, theme) -> (label, theme, apply_pipeline theme))
          extras
      in
      Render_html.render ?options default_theme ~extra_themes:themed_extras
        default_code

let html_theme_css = Render_html.theme_css
let html_render_theme_css = Render_html.render_theme_css

let render_backend t ?(decorations = []) ?(transforms = []) ~theme ~lang render
    source =
  let tokens = to_tokens t ~decorations ~transforms ~theme ~lang source in
  render theme tokens

let to_ansi t ?decorations ?transforms =
  render_backend t ?decorations ?transforms Render_ansi.render

let to_latex t ?decorations ?transforms =
  render_backend t ?decorations ?transforms Render_latex.render

let to_svg t ?decorations ?transforms =
  render_backend t ?decorations ?transforms Render_svg.render

let to_debug_tokens t ?decorations ?transforms =
  render_backend t ?decorations ?transforms Render_tokens.render

let to_string t ?(decorations = []) ?(transforms = []) ~format ~theme ~lang
    source =
  match format with
  | Html ->
      to_html t ~decorations ~transforms ~theme ~lang source
  | Ansi ->
      to_ansi t ~decorations ~transforms ~theme ~lang source
  | Latex ->
      to_latex t ~decorations ~transforms ~theme ~lang source
  | Svg ->
      to_svg t ~decorations ~transforms ~theme ~lang source
  | Tokens ->
      to_debug_tokens t ~decorations ~transforms ~theme ~lang source

module Token = Token
module Theme = Theme
module Transform = Transform
module Transform_builtin = Transform_builtin
module Decoration = Decoration
module Html_options = Html_options
