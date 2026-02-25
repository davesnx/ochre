type t = {
  mutable theme : Theme.theme option;
  mutable grammar_loader : Grammar_loader.t;
}

let create ?theme ?(grammar_paths = []) () =
  {
    theme;
    grammar_loader = Grammar_loader.create ~grammar_paths ();
  }

let load_theme t theme = t.theme <- Some theme

let load_theme_from_file t path =
  let theme = Theme.load_from_file path in
  load_theme t theme

let add_grammar_path t path =
  t.grammar_loader <- Grammar_loader.add_grammar_path t.grammar_loader path

let get_theme t =
  match t.theme with
  | Some theme -> theme
  | None ->
      {
        Theme.name = "default";
        fg = "#000000";
        bg = "#ffffff";
        token_colors = [];
      }

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
        extract_tokens 0 tokens)
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
          })
        line_tokens)
    tokens_per_line

let highlight_to_tokens t ~lang source =
  let grammar = Grammar_loader.load_grammar t.grammar_loader lang in
  let theme = get_theme t in
  let tokens = tokenize_with_grammar t.grammar_loader.Grammar_loader.tm_collection grammar source in
  apply_theme theme tokens

let highlight_to_html t ~lang source =
  let tokens = highlight_to_tokens t ~lang source in
  let theme = get_theme t in
  Render_html.render theme tokens

let highlight_to_ansi t ~lang source =
  let tokens = highlight_to_tokens t ~lang source in
  let theme = get_theme t in
  Render_ansi.render theme tokens

module Token = Token
module Theme = Theme
module Scope = Scope
module Render_html = Render_html
module Render_ansi = Render_ansi
