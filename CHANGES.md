## Unreleased

- Fix 9 bundled grammars (`blade`, `codeql`, `d`, `move`, `racket`, `stata`, `wikitext`, `xml`, `swift`) that failed to load via `Ochre.load`/`Ochre.load_exn`. Each has a rule shape vscode-textmate tolerates but the vendored TextMate parser rejected outright: a `begin` rule with neither `end` nor `while`, a rule with both `match` and `begin`, a `patterns`-less repository entry, a `patterns`-less grammar, a non-dict capture/repository-entry value (bare string, array, or `null`), and a non-string `name`/`contentName`. The parser now degrades the same way vscode-textmate does instead of failing to load. `swift` additionally needed the vendored Oniguruma binding to compile regexes with `ONIG_OPTION_CAPTURE_GROUP`, matching vscode-oniguruma, so that a numbered regex subroutine call next to a named group doesn't reject compilation.

## 1.1.0

- Add built-in `plaintext`/`text`/`txt` languages that produce unstyled tokens without a grammar, in both the library and the CLI.
- Add `?options` and `?extra_themes` to `Ochre.to_string`, giving the runtime-format API the same HTML capabilities as `Ochre.to_html`.
- Report the real package version from `ochre --version` instead of a hardcoded string.
- Preserve source line endings across tokenization, CLI input, and rendered output.
- Reject multi-theme transforms that produce incompatible token structures.
- Count decoration positions as Unicode scalar values instead of UTF-8 bytes.
- Report CLI input and theme loading failures without uncaught exceptions.
- Document all CLI flags, bundled grammars, and dual-theme HTML output in the CLI reference.
- Deploy API documentation and dual-theme/ANSI/tokens previews to GitHub Pages.

## 1.0.0

- Initial release of ochre, a syntax highlighter inspired by Shiki, using TextMate grammars and themes to produce accurate, beautiful syntax highlighting. It supports HTML output with inline styles, ANSI terminal colors, and raw token output
- Initial release of ochre-cli, a CLI tool for highlighting source code using TextMate grammars and themes
