(lang dune 3.22)

(name ochre)

(version 1.0.0)

(generate_opam_files true)

(source
 (github davesnx/ochre))

(authors "David Sancho")

(maintainers "David Sancho")

(license MIT)

(package
 (name ochre)
 (synopsis "Syntax highlighter using TextMate grammars and themes")
 (description
  "ochre is a syntax highlighter inspired by Shiki, using TextMate grammars and themes to produce accurate, beautiful syntax highlighting. It supports HTML output with inline styles, ANSI terminal colors, and raw token output.")
 (depends
  (ocaml
   (>= 4.14.0))
  (yojson
   (>= 2.0.0))
  (melange-json-native
   (>= 2.0.0))
  (conf-oniguruma
   (= 1))
  (dune-configurator
   (and
    (>= 2.9)
    :build))
  (plist-xml
   (>= 0.5.0))
  (ezjsonm :with-test)
  (html_of_jsx
   (and
    (>= 0.0.9)
    :with-test))
  (tiny_httpd :with-test)
  (odoc
   (and
    (>= 3.1.0)
    :with-doc))
  (tm-grammars
   (and
    (>= 2.0.0)
    :with-test))
  (alcotest :with-test)
  (mlx :with-test)
  (ocaml-lsp-server :with-dev-setup)
  (ocamlmerlin-mlx :with-dev-setup)
  (ocamlformat-mlx :with-dev-setup)
  (ocamlformat
   (and
    (= 0.29.0)
    :with-dev-setup))))

(package
 (name ochre-cli)
 (synopsis "Command-line interface for ochre syntax highlighter")
 (description
  "CLI tool for highlighting source code using TextMate grammars and themes.")
 (depends
  (ocaml
   (>= 4.14.0))
  ochre
  (tm-grammars
   (>= 2.0.0))
  (cmdliner
   (>= 1.1.0))
  (ezjsonm :with-test)
  (alcotest :with-test)
  (odoc
   (and
    (>= 3.1.0)
    :with-doc))))
