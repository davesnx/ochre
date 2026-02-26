Load a theme with standard VS Code format
  $ ./test_theme.exe load
  name: test-theme
  fg: #abcdef
  bg: #123456
  rules: 2
    scopes: [comment]
    fg: #888888
    styles: [italic]
    scopes: [keyword, storage.type]
    fg: #ff0000
    styles: [bold]

Load from empty JSON gets defaults
  $ ./test_theme.exe defaults
  name: unnamed
  fg: #000000
  bg: #ffffff
  rules: 0

Multiple font styles in a single rule
  $ ./test_theme.exe multiple-styles
  name: multi-style
  fg: #000000
  bg: #ffffff
  rules: 1
    scopes: [emphasis]
    fg: none
    styles: [bold, italic, underline]

Rule with missing settings
  $ ./test_theme.exe no-settings
  name: no-settings
  fg: #000000
  bg: #ffffff
  rules: 1
    scopes: [comment]
    fg: none

Scope specified as an array of strings
  $ ./test_theme.exe array-scope
  name: array-scope
  fg: #000000
  bg: #ffffff
  rules: 1
    scopes: [string, string.quoted, string.template]
    fg: #ce9178

Alternative fg/bg keys
  $ ./test_theme.exe alt-keys
  name: alt-keys
  fg: #aabbcc
  bg: #112233
  rules: 0

Load built-in dark theme
  $ ./test_theme.exe builtin-dark
  name: dark
  fg: #d4d4d4
  bg: #1e1e1e
  rules: 6
    scopes: [comment]
    fg: #6a9955
    scopes: [string]
    fg: #ce9178
    scopes: [constant.numeric]
    fg: #b5cea8
    scopes: [keyword]
    fg: #569cd6
    scopes: [entity.name.function]
    fg: #dcdcaa
    scopes: [entity.name.type]
    fg: #4ec9b0

Load built-in light theme
  $ ./test_theme.exe builtin-light
  name: light
  fg: #1f2328
  bg: #ffffff
  rules: 6
    scopes: [comment]
    fg: #6a737d
    scopes: [string]
    fg: #032f62
    scopes: [constant.numeric]
    fg: #005cc5
    scopes: [keyword]
    fg: #d73a49
    scopes: [entity.name.function]
    fg: #6f42c1
    scopes: [entity.name.type]
    fg: #22863a

Load by alias with name-or-path API
  $ ./test_theme.exe load-dark-alias
  name: dark
  fg: #d4d4d4
  bg: #1e1e1e
  rules: 6
    scopes: [comment]
    fg: #6a9955
    scopes: [string]
    fg: #ce9178
    scopes: [constant.numeric]
    fg: #b5cea8
    scopes: [keyword]
    fg: #569cd6
    scopes: [entity.name.function]
    fg: #dcdcaa
    scopes: [entity.name.type]
    fg: #4ec9b0

Built-in theme catalog includes all shipped themes
  $ ./test_theme.exe available
  dark
  light
  tokyonight
  everforest
  ayu
  catppuccin
  catppuccin-macchiato
  gruvbox
  kanagawa
  nord
  matrix
  one-dark

Load a newly added built-in theme by name
  $ ./test_theme.exe tokyonight
  name: tokyonight
  fg: #c0caf5
  bg: #1a1b26
  rules: 6
    scopes: [comment]
    fg: #565f89
    scopes: [string]
    fg: #9ece6a
    scopes: [constant.numeric]
    fg: #ff9e64
    scopes: [keyword]
    fg: #7aa2f7
    scopes: [entity.name.function]
    fg: #7dcfff
    scopes: [entity.name.type]
    fg: #2ac3de
