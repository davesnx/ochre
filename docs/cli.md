
# ochre CLI

Command-line interface for the ochre syntax highlighter.


## Synopsis

```
ochre LANG [FILE] [--theme PATH] [--grammar FILE]... [--format FORMAT] [--stdin]
```

## Arguments

- `LANG` — Language identifier (e.g. `ocaml`, `javascript`, `python`). Required.
- `FILE` — Input file path. Optional when using `--stdin`.

## Options

- `--theme PATH`, `-t PATH` — Path to a VS Code / TextMate theme JSON file.
- `--grammar FILE`, `-g FILE` — Path to a `.tmLanguage.json` grammar file. Can be specified multiple times.
- `--format FORMAT`, `-f FORMAT` — Output format: `html` (default), `ansi`, or `tokens`.
- `--stdin`, `-s` — Read source code from standard input instead of a file.

## Examples

Highlight an OCaml file to HTML:

```
ochre ocaml file.ml --grammar ./grammars/ocaml.tmLanguage.json --theme theme.json
```
Highlight from stdin with ANSI terminal colors:

```
cat file.js | ochre javascript --stdin --grammar ./grammars/javascript.tmLanguage.json --format ansi
```
Dump raw token information for debugging:

```
ochre python script.py --grammar ./grammars/python.tmLanguage.json --format tokens
```
Load multiple grammars (e.g. for embedded languages):

```
ochre html index.html \
  --grammar ./grammars/html.tmLanguage.json \
  --grammar ./grammars/css.tmLanguage.json \
  --grammar ./grammars/javascript.tmLanguage.json \
  --theme theme.json
```
Or using the short flag:

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
