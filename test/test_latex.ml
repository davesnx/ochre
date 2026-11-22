let grammar_json =
  {|{
  "scopeName": "source.ocaml",
  "name": "ocaml",
  "patterns": [
    { "match": "\\(\\*[^\\n]*\\*\\)", "name": "comment.block.ocaml" },
    { "match": "\\b(let|in|fun|match|with|type|module)\\b", "name": "keyword.control.ocaml" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.ocaml" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.ocaml" }
  ]
}|}

let preview_themes =
  [
    ("tokyo-night", Tm_themes.tokyo_night);
    ("everforest-dark", Tm_themes.everforest_dark);
    ("ayu-dark", Tm_themes.ayu_dark);
    ("catppuccin-mocha", Tm_themes.catppuccin_mocha);
    ("catppuccin-macchiato", Tm_themes.catppuccin_macchiato);
    ("gruvbox-dark-medium", Tm_themes.gruvbox_dark_medium);
    ("kanagawa-wave", Tm_themes.kanagawa_wave);
    ("nord", Tm_themes.nord);
    ("one-dark-pro", Tm_themes.one_dark_pro);
  ]

let preamble =
  String.concat "\n"
    [
      "\\documentclass[11pt]{article}";
      "\\usepackage[margin=1in]{geometry}";
      "\\usepackage[T1]{fontenc}";
      "\\usepackage[utf8]{inputenc}";
      "\\usepackage{xcolor}";
      "\\usepackage[normalem]{ulem}";
      "\\usepackage{tcolorbox}";
      "\\setlength{\\parindent}{0pt}";
      "\\newenvironment{ochrehighlight}[2]{%";
      "  \\par\\smallskip\\noindent";
      "  \\begingroup";
      "  \\definecolor{ochrebg}{HTML}{#1}";
      "  \\definecolor{ochrefg}{HTML}{#2}";
      "  \
       \\begin{tcolorbox}[colback=ochrebg,coltext=ochrefg,boxrule=0pt,arc=0pt,left=2mm,right=2mm,top=1mm,bottom=1mm]";
      "  \\ttfamily\\small\\obeylines\\obeyspaces";
      "}{%";
      "  \\end{tcolorbox}";
      "  \\endgroup\\smallskip";
      "}";
      "\\begin{document}";
      "\\section*{ochre LaTeX Theme Preview}";
    ]

let trailer = "\\end{document}\n"

let lang_of grammar =
  match
    Result.bind
      (Ochre.load [ ("ocaml", grammar) ])
      (fun hl -> Ochre.lang hl "ocaml")
  with
  | Ok lang ->
      lang
  | Error error ->
      failwith (Ochre.Error.to_string error)

let theme_of json =
  match Ochre.Theme.load json with
  | Ok (theme, _warnings) ->
      theme
  | Error error ->
      failwith (Ochre.Error.to_string error)

let () =
  let lang = lang_of grammar_json in
  let source =
    "let answer = 42\n(* LaTeX preview *)\nlet greet = \"hello from ochre\""
  in
  print_endline preamble;
  List.iter
    (fun (name, json) ->
      let theme = theme_of json in
      Printf.printf "\\subsection*{%s}\n" name;
      print_endline (Ochre.to_latex (Ochre.highlight ~theme ~lang source))
    )
    preview_themes;
  print_string trailer
