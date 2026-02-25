
# ochre CLI

Command-line interface for the ochre syntax highlighter.


## Synopsis

```
ochre LANG [FILE] [--theme PATH] [--grammar-dir DIR]... [--format FORMAT] [--stdin]
```

## Arguments

- `LANG` — Language identifier (e.g. `ocaml`, `javascript`, `python`). Required.
- `FILE` — Input file path. Optional when using `--stdin`.

## Options

- `--theme PATH`, `-t PATH` — Path to a VS Code / TextMate theme JSON file.
- `--grammar-dir DIR`, `-g DIR` — Directory containing `.tmLanguage.json` grammar files. Can be specified multiple times.
- `--format FORMAT`, `-f FORMAT` — Output format: `html` (default), `ansi`, or `tokens`.
- `--stdin`, `-s` — Read source code from standard input instead of a file.

## Examples

Highlight an OCaml file to HTML:

```
ochre ocaml file.ml --grammar-dir ./grammars --theme theme.json
```
Highlight from stdin with ANSI terminal colors:

```
cat file.js | ochre javascript --stdin --grammar-dir ./grammars --format ansi
```
Dump raw token information for debugging:

```
ochre python script.py --grammar-dir ./grammars --format tokens
```

## Grammars

Ochre looks for TextMate grammar files in each `--grammar-dir` directory, trying `{<lang>}.tmLanguage.json`, `{<lang>}.json`, and `{<lang>}` in order.

Common sources for grammars:

- VS Code extensions: `~/.vscode/extensions/`
- [shikijs/textmate-grammars-themes](https://github.com/shikijs/textmate-grammars-themes) on GitHub

## Themes

Themes use the VS Code / TextMate JSON format with `colors` and `tokenColors` fields. See [VS Code Theme Gallery](https://vscodethemes.com/) for available themes.
