# ochre

A syntax highlighter for OCaml using TextMate grammars and themes, inspired by [Shiki](https://shiki.style/).


## Installation

```
opam install ochre -y
```

## Use tm-grammars

Install bundled grammars:

```
opam install tm-grammars-all -y
```

Then load a grammar from OCaml and create a highlighter:

```ocaml
let theme = Ochre.Theme.load_from_file "path/to/theme.json" in
let grammar = Option.get (Tm_grammars_all.find "ocaml") in
let hl = Ochre.create_from_json ~grammars:[ ("ocaml", grammar) ] () in
let html = Ochre.to_html hl ~theme ~lang:"ocaml" "let x = 42"
```

## Quick start

```ocaml
let theme = Ochre.Theme.load_from_file "path/to/theme.json" in
let hl = Ochre.create ~grammars:["path/to/ocaml.tmLanguage.json"] () in
let html = Ochre.to_html hl ~theme ~lang:"ocaml" source_code
```

For the CLI, `--theme` is optional. Ochre uses a built-in theme and auto-picks dark/light from your terminal (using `OCHRE_THEME_MODE`, `TERM_THEME`, or `COLORFGBG`).
You can also pass a built-in name directly, e.g. `--theme opencode-dark` (or `dark`), instead of a file path.

Built-in themes:

| Name | Description |
| --- | --- |
| `opencode-dark` | Default dark Ochre theme |
| `opencode-light` | Default light Ochre theme |
| `tokyonight` | Based on the Tokyonight theme |
| `everforest` | Based on the Everforest theme |
| `ayu` | Based on the Ayu dark theme |
| `catppuccin` | Based on the Catppuccin theme |
| `catppuccin-macchiato` | Based on the Catppuccin theme |
| `gruvbox` | Based on the Gruvbox theme |
| `kanagawa` | Based on the Kanagawa theme |
| `nord` | Based on the Nord theme |
| `matrix` | Hacker-style green on black theme |
| `one-dark` | Based on the Atom One Dark theme |

Aliases: `dark` -> `opencode-dark`, `light` -> `opencode-light`.

## Documentation

- [Library API](docs/Ochre.md) — `Ochre` module reference
- [CLI reference](docs/cli.md) — command-line usage

## Browser preview test

Serve a highlighted sample on port 5000:

```
make test-browser
```

Then open `http://localhost:5000` (or use SSH port forwarding).
Stop it with Ctrl+C.

If port 5000 is busy, pick another one:

```
PORT=5001 make test-browser
```

## License

MIT — see [LICENSE](LICENSE).


## Credits

- Inspired by [Shiki](https://shiki.style/) by Pine Wu and Anthony Fu
- Uses [textmate-language](https://github.com/alan-j-hu/ocaml-textmate-language) by Alan Hu
