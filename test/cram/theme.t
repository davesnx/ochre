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
