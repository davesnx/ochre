(lang dune 3.17)

(name ochre)

(version 0.1.0)

(generate_opam_files true)

(source
 (github yourusername/ochre))

(authors "Your Name")

(maintainers "Your Name")

(license MIT)

(package
 (name ochre)
 (synopsis "Syntax highlighter using TextMate grammars and themes")
 (description
  "ochre is a syntax highlighter inspired by Shiki, using TextMate grammars and themes to produce accurate, beautiful syntax highlighting. It supports HTML output with inline styles, ANSI terminal colors, and raw token output.")
 (depends
  (ocaml
   (>= 5.4.0))
  dune
   (textmate-language
    (>= 0.5.0))
  (yojson
   (>= 2.0.0))
  (melange-json-native
   (>= 2.0.0))
  (odoc
   (>= 3.1.0))
  (alcotest :with-test)
  (ocaml-lsp-server :with-dev-setup)
  (ocamlformat :with-dev-setup)))

(package
 (name ochre-cli)
 (synopsis "Command-line interface for ochre syntax highlighter")
 (description
  "CLI tool for highlighting source code using TextMate grammars and themes.")
 (depends
  (ocaml
   (>= 5.4.0))
  dune
  ochre
   tm-grammars
  (cmdliner
   (>= 1.1.0))))
