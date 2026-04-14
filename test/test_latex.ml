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
    "tokyonight";
    "everforest";
    "ayu";
    "catppuccin";
    "catppuccin-macchiato";
    "gruvbox";
    "kanagawa";
    "nord";
    "matrix";
    "one-dark";
  ]

let preamble =
  String.concat "\n"
    [
      "\\documentclass[11pt]{article}";
      "\\usepackage[margin=1in]{geometry}";
      "\\usepackage[T1]{fontenc}";
      "\\usepackage[utf8]{inputenc}";
      "\\usepackage{xcolor}";
      "\\usepackage{soul}";
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

let () =
  let highlighter = Ochre.load_exn [ ("ocaml", grammar_json) ] in
  let source =
    "let answer = 42\n(* LaTeX preview *)\nlet greet = \"hello from ochre\""
  in
  print_endline preamble;
  List.iter
    (fun name ->
      match Ochre.Theme.find name with
      | Some theme ->
          Printf.printf "\\subsection*{%s}\n" name;
          print_endline (Ochre.to_latex highlighter ~theme ~lang:"ocaml" source)
      | None ->
          Printf.printf "\\textbf{Missing built-in theme: %s}\\par\n" name
    )
    preview_themes;
  print_string trailer
