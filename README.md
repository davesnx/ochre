# Ochre

A syntax highlighter for OCaml using TextMate grammars and themes, inspired by [Shiki](https://shiki.style/).


## Installation

```
opam pin add . -y
```

## Quick start

```ocaml
let theme = Ochre.Theme.load_from_file "path/to/theme.json" in
let hl = Ochre.create ~grammars:["path/to/ocaml.tmLanguage.json"] () in
let html = Ochre.to_html hl ~theme ~lang:"ocaml" source_code
```

## Documentation

- [Library API](docs/Ochre.md) — `Ochre` module reference
- [CLI reference](docs/cli.md) — command-line usage
- Regenerate docs with `make docs`.

## License

MIT — see [LICENSE](LICENSE).


## Credits

- Inspired by [Shiki](https://shiki.style/) by Pine Wu and Anthony Fu
- Uses [textmate-language](https://github.com/alan-j-hu/ocaml-textmate-language) by Alan Hu