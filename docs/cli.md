
# ochre CLI

Command-line interface for the ochre syntax highlighter.


## Synopsis

```
ochre LANG [FILE] [--theme NAME_OR_PATH] [--theme-dark NAME_OR_PATH] [--theme-light NAME_OR_PATH] [--grammar FILE]... [--format FORMAT]
```

## Arguments

- `LANG` — Language identifier (e.g. `ocaml`, `javascript`, `python`). Required.
- `FILE` — Input file path. Optional when piping/redirection stdin is used.

## Options

- `--theme NAME_OR_PATH`, `-t NAME_OR_PATH` — Optional. Built-in theme name (for example `dark`, `light`, or `tokyonight`) or path to a VS Code / TextMate theme JSON file.
- `--theme-dark NAME_OR_PATH` — Theme used when terminal mode is detected as dark (same name-or-path resolution as `--theme`).
- `--theme-light NAME_OR_PATH` — Theme used when terminal mode is detected as light (same name-or-path resolution as `--theme`).
- `--grammar FILE`, `-g FILE` — Path to a `.tmLanguage.json` grammar file. Can be specified multiple times.
- `--format FORMAT`, `-f FORMAT` — Output format: `html` (default), `ansi`, or `tokens`.

## Examples


### Highlight an OCaml file to HTML

```
ochre ocaml file.ml --grammar ./grammars/ocaml.tmLanguage.json --theme theme.json
```
Highlight from stdin with ANSI terminal colors:

```
cat file.js | ochre javascript --grammar ./grammars/javascript.tmLanguage.json --format ansi
```

### Load multiple grammars (e.g. for embedded languages)

```
ochre html index.html \
  --grammar ./grammars/html.tmLanguage.json \
  --grammar ./grammars/css.tmLanguage.json \
  --grammar ./grammars/javascript.tmLanguage.json \
  --theme theme.json
```
or using the short flag:

```
ochre html index.html -g ./grammars/html.tmLanguage.json -g ./grammars/css.tmLanguage.json -g ./grammars/javascript.tmLanguage.json
```

## Grammars

Each `--grammar` flag takes a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `ocaml.tmLanguage.json` registers as `ocaml`).

Common sources for grammars:

- VS Code extensions: `~/.vscode/extensions/`
- [shikijs/textmate-grammars-themes](https://github.com/shikijs/textmate-grammars-themes) on GitHub

## Themes

Themes use the VS Code / TextMate JSON format with `colors` and `tokenColors` fields. See [VS Code Theme Gallery](https://vscodethemes.com/) for available themes.

For the CLI, `--theme` is optional. ochre uses a built-in theme and auto-picks dark/light from your terminal (using `OCHRE_THEME_MODE`, `TERM_THEME`, or `COLORFGBG`).

You can also pass a built-in name directly, for example `--theme dark`, instead of a file path.

Built-in themes:

- `dark` — Default dark ochre theme
- `light` — Default light ochre theme
- `tokyonight` — Based on the Tokyonight theme
- `everforest` — Based on the Everforest theme
- `ayu` — Based on the Ayu dark theme
- `catppuccin` — Based on the Catppuccin theme
- `catppuccin-macchiato` — Based on the Catppuccin theme
- `gruvbox` — Based on the Gruvbox theme
- `kanagawa` — Based on the Kanagawa theme
- `nord` — Based on the Nord theme
- `matrix` — Hacker-style green on black theme
- `one-dark` — Based on the Atom One Dark theme