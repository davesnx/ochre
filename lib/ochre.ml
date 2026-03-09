type t = { grammar_loader : Grammar_loader.t }
type output_format = Html | Ansi | Latex | Svg | Tokens

let string_of_output_format = function
  | Html -> "html"
  | Ansi -> "ansi"
  | Latex -> "latex"
  | Svg -> "svg"
  | Tokens -> "tokens"

let output_format_of_string value =
  match String.lowercase_ascii value with
  | "html" -> Some Html
  | "ansi" -> Some Ansi
  | "latex" -> Some Latex
  | "svg" -> Some Svg
  | "tokens" -> Some Tokens
  | _ -> None

let output_formats =
  List.map
    (fun f -> (string_of_output_format f, f))
    [ Html; Ansi; Latex; Svg; Tokens ]

let create ~grammars () =
  { grammar_loader = Grammar_loader.create ~grammars () }

let create_from_json ~grammars () =
  { grammar_loader = Grammar_loader.create_from_json ~grammars () }

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
          | [] -> []
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
            | Some s -> s.Theme.foreground
            | None -> Some theme.fg
          in
          let background =
            match settings with Some s -> s.Theme.background | None -> None
          in
          let font_style =
            match settings with Some s -> s.Theme.font_style | None -> []
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

let to_tokens t ~theme ~lang source =
  let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
  let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
  let tokens = tokenize_with_grammar tm_collection grammar source in
  apply_theme theme tokens

let to_tokens_with t ?(decorations = []) ~transforms ~theme ~lang source =
  let tokens = to_tokens t ~theme ~lang source in
  let tokens = Decoration.apply ~source decorations tokens in
  Transform.run transforms tokens

let render_to_string t ~theme ~lang render source =
  let tokens = to_tokens t ~theme ~lang source in
  render theme tokens

let render_to_string_with t ?(decorations = []) ~transforms ~theme ~lang render
    source =
  let tokens = to_tokens_with t ~decorations ~transforms ~theme ~lang source in
  render theme tokens

(** Resolve the default theme and extra themes from the optional arguments.
    - [~theme] alone: single-theme render.
    - [~theme ~themes]: theme is default, themes are extras.
    - [~themes] alone: first entry becomes the default, rest are extras.
    - Neither: falls back to [Theme.dark]. *)
let resolve_themes ?theme ?(themes = []) () =
  match (theme, themes) with
  | Some t, _ -> (t, themes)
  | None, (_, first_theme) :: rest -> (first_theme, rest)
  | None, [] -> (Theme.dark, [])

let to_html t ?options ?theme ?themes ~lang source =
  let default_theme, extras = resolve_themes ?theme ?themes () in
  match extras with
  | [] ->
      let tokens = to_tokens t ~theme:default_theme ~lang source in
      Render_html.render ?options default_theme tokens
  | _ ->
      let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
      let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
      let raw_tokens = tokenize_with_grammar tm_collection grammar source in
      let default_code = apply_theme default_theme raw_tokens in
      let themed_extras =
        List.map
          (fun (label, theme) -> (label, theme, apply_theme theme raw_tokens))
          extras
      in
      Render_html.render ?options default_theme ~themes:themed_extras
        default_code

let to_html_with t ?(decorations = []) ~transforms ?options ?theme ?themes ~lang
    source =
  let default_theme, extras = resolve_themes ?theme ?themes () in
  match extras with
  | [] ->
      let tokens =
        to_tokens_with t ~decorations ~transforms ~theme:default_theme ~lang
          source
      in
      Render_html.render ?options default_theme tokens
  | _ ->
      let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
      let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
      let raw_tokens = tokenize_with_grammar tm_collection grammar source in
      let default_code = apply_theme default_theme raw_tokens in
      let default_code = Decoration.apply ~source decorations default_code in
      let default_code = Transform.run transforms default_code in
      let themed_extras =
        List.map
          (fun (label, theme) ->
            let code = apply_theme theme raw_tokens in
            let code = Decoration.apply ~source decorations code in
            let code = Transform.run transforms code in
            (label, theme, code)
          )
          extras
      in
      Render_html.render ?options default_theme ~themes:themed_extras
        default_code

let html_theme_prefers_dark_css = Render_html.theme_prefers_dark_css ()
let html_theme_css = Render_html.theme_css
let to_ansi t = render_to_string t Render_ansi.render
let to_latex t = render_to_string t Render_latex.render
let to_svg t = render_to_string t Render_svg.render
let to_debug_tokens t = render_to_string t Render_tokens.render

let to_ansi_with t ?decorations =
  render_to_string_with t ?decorations Render_ansi.render

let to_latex_with t ?decorations =
  render_to_string_with t ?decorations Render_latex.render

let to_svg_with t ?decorations =
  render_to_string_with t ?decorations Render_svg.render

let to_debug_tokens_with t ?decorations =
  render_to_string_with t ?decorations Render_tokens.render

let to_string t ~format ~theme ~lang source =
  match format with
  | Html -> to_html t ~theme ~lang source
  | Ansi -> to_ansi t ~theme ~lang source
  | Latex -> to_latex t ~theme ~lang source
  | Svg -> to_svg t ~theme ~lang source
  | Tokens -> to_debug_tokens t ~theme ~lang source

let to_string_with t ?decorations ~transforms ~format ~theme ~lang source =
  match format with
  | Html -> to_html_with t ?decorations ~transforms ~theme ~lang source
  | Ansi -> to_ansi_with t ?decorations ~transforms ~theme ~lang source
  | Latex -> to_latex_with t ?decorations ~transforms ~theme ~lang source
  | Svg -> to_svg_with t ?decorations ~transforms ~theme ~lang source
  | Tokens ->
      to_debug_tokens_with t ?decorations ~transforms ~theme ~lang source

module Token = Token
module Theme = Theme
module Transform = Transform
module Transform_builtin = Transform_builtin
module Decoration = Decoration
module Html_options = Html_options
