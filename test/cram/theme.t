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
  fg: #D4D4D4
  bg: #1E1E1E
  rules: 65

Load built-in light theme
  $ ./test_theme.exe builtin-light
  name: light
  fg: #000000
  bg: #FFFFFF
  rules: 64

Load by alias with name-or-path API
  $ ./test_theme.exe load-dark-alias
  name: dark
  fg: #D4D4D4
  bg: #1E1E1E
  rules: 65

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
  fg: #a9b1d6
  bg: #1a1b26
  rules: 114
