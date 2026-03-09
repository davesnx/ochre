## Unreleased

- Add decoration system (`Decoration`) for attaching classes, styles, and data attributes to source ranges with token splitting and overlap merging
- Add notation-based transforms mirroring Shiki's transformer API:
  - `notation_highlight`: detect `[!code highlight]` in comments, strip the comment, highlight the line
  - `notation_diff`: detect `[!code ++]`/`[!code --]` in comments, strip the comment, apply diff backgrounds
  - `notation_word_highlight`: detect `[!code word:xxx]` in comments, strip the comment, highlight all occurrences of the word on that line
- Add multi-theme HTML output with CSS custom properties (`--ochre-<label>`), inspired by Shiki's dual-themes approach
- `to_html` and `to_html_with` now accept optional `?themes:(string * Theme.theme) list` for labelled extra themes
- When `~theme` is omitted, the first entry in `~themes` becomes the default
- Add `html_theme_prefers_dark_css` (ready-made `prefers-color-scheme` media query) and `html_theme_css` (CSS rule for any label)
- CLI: `--theme-light` + `--theme-dark` with `--format html` produces multi-theme output automatically
- Add composable transform pipeline (`Transform`, `Transform_builtin`) that runs after tokenization and before rendering
- Add `*_with` entry points (`to_html_with`, `to_tokens_with`, etc.) accepting a `~transforms` list
- Ship built-in transforms: `line_highlight`, `word_highlight`, `diff_markers`, `scope_marker`
- Initial release
