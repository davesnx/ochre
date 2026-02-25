type t = { grammar_loader : Grammar_loader.t }

let create ~grammars () =
  { grammar_loader = Grammar_loader.create ~grammars () }

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
          { Token.text; foreground; background; font_style; scopes })
        line_tokens)
    tokens_per_line

let to_tokens t ~theme ~lang source =
  let grammar = Grammar_loader.find_grammar t.grammar_loader lang in
  let tm_collection = Grammar_loader.tm_collection t.grammar_loader in
  let tokens = tokenize_with_grammar tm_collection grammar source in
  apply_theme theme tokens

let to_html t ~theme ~lang source =
  let tokens = to_tokens t ~theme ~lang source in
  Render_html.render theme tokens

let to_ansi t ~theme ~lang source =
  let tokens = to_tokens t ~theme ~lang source in
  Render_ansi.render theme tokens

module Token = Token
module Theme = Theme
