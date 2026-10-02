## Unreleased

- Escape decoration-supplied `class_`, `style`, and `data` values (and grammar scope names) before writing them into HTML/SVG attributes, closing an HTML/SVG injection hole for decorations built from untrusted strings.
- Reject `Decoration.make ~data` keys that are not valid `data-*` attribute-name characters, instead of writing them unescaped into the attribute name.
- Normalize `Html_options.make ~css_variable_prefix` to always end with `-`.
- Stop counting a line's trailing newline towards SVG output width.
- Document that decorations are applied by the HTML and SVG renderers only; ANSI and LaTeX output ignore them.

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
