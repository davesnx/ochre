## Unreleased

- Add composable transform pipeline (`Transform`, `Transform_builtin`) that runs after tokenization and before rendering
- Add `*_with` entry points (`to_html_with`, `to_tokens_with`, etc.) accepting a `~transforms` list
- Ship built-in transforms: `line_highlight`, `word_highlight`, `diff_markers`, `scope_marker`
- Initial release
