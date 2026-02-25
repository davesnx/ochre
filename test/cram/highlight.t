Keyword token gets correct color and bold style
  $ ./test_highlight.exe keyword
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]

Number token gets correct color
  $ ./test_highlight.exe number
  text: "42"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Comment token gets correct color and italic style
  $ ./test_highlight.exe comment
  text: "# hello"
    fg: #888888
    styles: [italic]
    scopes: [comment.line.test, source.test]

More specific scope selector wins (string.quoted beats string)
  $ ./test_highlight.exe string-specificity
  text: "\"hello\""
    fg: #00ff00
    scopes: [string.quoted.double.test, source.test]

Mixed tokens on one line
  $ ./test_highlight.exe mixed
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Text with no matching scope gets theme default foreground
  $ ./test_highlight.exe default-text
  text: "hello"
    fg: #d4d4d4
    scopes: [source.test]
