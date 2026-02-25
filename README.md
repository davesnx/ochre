# Ochre

A syntax highlighter for OCaml using TextMate grammars and themes, inspired by [Shiki](https://shiki.style/).

## Installation

```bash
opam pin add . -y
```

## Quick start

```ocaml
let hl = Ochre.create ~grammar_paths:["/path/to/grammars"] () in
Ochre.load_theme_from_file hl "path/to/theme.json";
let html = Ochre.highlight_to_html hl ~lang:"ocaml" {|let x = 42|}
```

## Documentation

- [Library API](docs/Ochre.md) — `Ochre` module reference
- [CLI reference](docs/cli.md) — command-line usage

Regenerate docs with `make docs`.

## License

MIT — see [LICENSE](LICENSE).

## Credits

- Inspired by [Shiki](https://shiki.style/) by Pine Wu and Anthony Fu
- Uses [textmate-language](https://github.com/alan-j-hu/ocaml-textmate-language) by Alan Hu
