
# ochre CLI

Command-line interface for the ochre syntax highlighter.


## Synopsis

```
ochre LANG [FILE] [OPTION]...
```

## Arguments

- `LANG` — Language identifier (e.g. `ocaml`, `javascript`, `python`). Required.
- `FILE` — Input file path. Optional when piping/redirection stdin is used.

## Options

- `--theme NAME_OR_PATH`, `-t NAME_OR_PATH` — Optional. Theme name from [tm-themes](https://github.com/davesnx/tm-grammars) (for example `dark-plus`, `light-plus`, or `tokyo-night`) or path to a VS Code / TextMate theme JSON file. A theme color that is not `#rgb`, `#rgba`, `#rrggbb` or `#rrggbbaa` is dropped, with a warning on standard error (`ochre: warning: <message>`).
- `--theme-dark NAME_OR_PATH` — Theme used when terminal mode is detected as dark (same name-or-path resolution as `--theme`). With `--format html`, when both `--theme-dark` and `--theme-light` are given (and no `--theme`), produces dual-theme output: the light theme is the default and the dark theme is emitted as CSS custom properties (`--ochre-dark-*`) for automatic dark-mode switching.
- `--theme-light NAME_OR_PATH` — Theme used when terminal mode is detected as light (same name-or-path resolution as `--theme`). See `--theme-dark` for dual-theme HTML output.
- `--grammar FILE`, `-g FILE` — Path to a `.tmLanguage.json` grammar file. Can be specified multiple times. Optional: when omitted, the bundled grammar for `LANG` is used.
- `--include LANG_OR_PATH`, `-i LANG_OR_PATH` — Additional grammar to load, by bundled name or file path. Use to enable cross-grammar features like HTML embedding CSS/JS. Can be specified multiple times.
- `--format FORMAT`, `-f FORMAT` — Output format: `html` (default), `ansi`, `latex`, `svg`, or `tokens`.
- `--html-css-classes` — Use CSS class names instead of inline styles for HTML output. Each unique style gets a deterministic class like `ochre-<hash>`.
- `--line-numbers` — Add `data-line` attributes to line spans in HTML output (1-indexed).
- `--no-default-color` — Suppress inline color/background-color on the primary theme; all colors come from CSS custom properties only. Useful with multi-theme output when you control theme switching entirely via CSS.
- `--css-var-prefix PREFIX` — CSS custom property prefix for multi-theme output (default: `--ochre-`).
- `--scopes-data` — Add `data-scope` attributes to token spans in HTML output with TextMate scope names.

## Exit codes

- `0` — success.
- `1` — a user/input error: an invalid command line (unknown option, too many arguments, a missing required argument), an unresolvable language/theme/grammar, a malformed theme/grammar file, a missing input file, or any other error this CLI can name. Reported on standard error as `ochre: <message>`.
- `3` — the output cannot be written to standard output (for example the disk is full, or standard output is closed). Reported on standard error as `ochre: cannot write output: <reason>`. When the reader of a pipe closes it early (EPIPE), ochre exits with this code and no message.
- `124` — an option given a malformed value (wrong type, e.g. `--format`) or missing its required value (e.g. `--theme` with no argument).
- `125` — an unexpected internal error (a bug — please report it).

## Examples


### Highlight an OCaml file to HTML

Using the bundled OCaml grammar and the default theme:

```
ochre ocaml file.ml
```
Highlight from stdin with ANSI terminal colors:

```
cat file.js | ochre javascript --format ansi
```

### Dual-theme HTML output

```
ochre ocaml file.ml --theme-light light-plus --theme-dark tokyo-night
```

### Load multiple grammars (e.g. for embedded languages)

Bundled grammars can be added by name with `--include`:

```
ochre html index.html --include css --include javascript
```
Custom grammar files are loaded with `--grammar`:

```
ochre html index.html \
  --grammar ./grammars/html.tmLanguage.json \
  --grammar ./grammars/css.tmLanguage.json \
  --grammar ./grammars/javascript.tmLanguage.json \
  --theme theme.json
```
or using the short flags:

```
ochre html index.html -g ./grammars/html.tmLanguage.json -i css -i javascript
```

## Grammars

ochre bundles the grammars from the [tm-grammars](https://github.com/davesnx/tm-grammars) package, covering 200+ languages. When no `--grammar` flag is given, the bundled grammar matching `LANG` is used; if there is none, the CLI lists the available names.

The language identifiers `plaintext`, `text`, and `txt` need no grammar: they render the input as unstyled tokens with the theme's default colors.

To use a custom grammar, pass `--grammar` with a path to a `.tmLanguage.json` file. The language identifier is derived from the filename (e.g. `ocaml.tmLanguage.json` registers as `ocaml`). Common sources for grammar files:

- VS Code extensions: `~/.vscode/extensions/`
- [shikijs/textmate-grammars-themes](https://github.com/shikijs/textmate-grammars-themes) on GitHub

## Themes

Themes use the VS Code / TextMate JSON format with `colors` and `tokenColors` fields. See [VS Code Theme Gallery](https://vscodethemes.com/) for available themes.

For the CLI, `--theme` is optional. ochre uses `dark-plus` or `light-plus` and auto-picks dark/light from your terminal (using `OCHRE_THEME_MODE`, `TERM_THEME`, or `COLORFGBG`).

You can also pass a theme name directly, for example `--theme nord`, instead of a file path. The names are the [Shiki theme](https://shiki.style/themes) names: `andromeeda`, `aurora-x`, `ayu-dark`, `ayu-light`, `ayu-mirage`, `catppuccin-frappe`, `catppuccin-latte`, `catppuccin-macchiato`, `catppuccin-mocha`, `dark-plus`, `dracula`, `dracula-soft`, `everforest-dark`, `everforest-light`, `github-dark`, `github-dark-default`, `github-dark-dimmed`, `github-dark-high-contrast`, `github-light`, `github-light-default`, `github-light-high-contrast`, `gruvbox-dark-hard`, `gruvbox-dark-medium`, `gruvbox-dark-soft`, `gruvbox-light-hard`, `gruvbox-light-medium`, `gruvbox-light-soft`, `horizon`, `horizon-bright`, `houston`, `kanagawa-dragon`, `kanagawa-lotus`, `kanagawa-wave`, `laserwave`, `light-plus`, `material-theme`, `material-theme-darker`, `material-theme-lighter`, `material-theme-ocean`, `material-theme-palenight`, `min-dark`, `min-light`, `monokai`, `night-owl`, `night-owl-light`, `nord`, `one-dark-pro`, `one-light`, `plastic`, `poimandres`, `red`, `rose-pine`, `rose-pine-dawn`, `rose-pine-moon`, `slack-dark`, `slack-ochin`, `snazzy-light`, `solarized-dark`, `solarized-light`, `synthwave-84`, `tokyo-night`, `vesper`, `vitesse-black`, `vitesse-dark`, `vitesse-light`.
