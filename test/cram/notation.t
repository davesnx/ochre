Notation highlight in real grammars: the whole comment goes, other text and the newline stay
  $ ./test_notation.exe highlight
  javascript
    hl "let x = 42;\n"
    .  "let y = 10;\n"
  typescript
    hl "const x: number = 1;\n"
    .  "const y = 2;\n"
  c
    hl "int x;\n"
    .  "next\n"
  python
    hl "x = 1\n"
    .  "y = 2\n"
  ruby
    hl "x = 1\n"
    .  "y = 2\n"
  yaml
    hl "a: 1\n"
    .  "b: 2\n"
  sql
    hl "select 1\n"
    .  "select 2;\n"
  lua
    hl "local x = 1\n"
    .  "local y = 2\n"
  rust
    hl "let x = 1;\n"
    .  "let y = 2;\n"
  go
    hl "x := 1\n"
    .  "y := 2\n"
  toml
    hl "a = 1\n"
    .  "b = 2\n"
  java
    hl "int x = 1;\n"
    .  "int y = 2;\n"
  ocaml
    hl "let x = 1\n"
    .  "let y = 2\n"
  css
    hl "a { color: red }\n"
    .  "b { }\n"
  html
    hl "<p>x</p>\n"
    .  "<p>y</p>\n"
  markdown
    hl "foo\n"
    .  "bar\n"
  plaintext
    hl "foo\n"
    .  "bar\n"

Notation diff
  $ ./test_notation.exe diff
  javascript
    ++ "let a = 1;\n"
    -- "let b = 2;\n"
    .  "let c = 3;\n"
  python
    ++ "a = 1\n"
    -- "b = 2\n"
    .  "c = 3\n"
  ocaml
    ++ "let a = 1\n"
    -- "let b = 2\n"
    .  "let c = 3\n"

Notation word highlight
  $ ./test_notation.exe word
  javascript
    .  "let [foo] = 1;\n"
    .  "[foo] + [foo];\n"
    .  "bar;\n"
  javascript (range)
    .  "let [foo] = 1;\n"
    .  "foo + foo;\n"
    .  "bar;\n"
  javascript (comment line)
    .  "[foo] + 1;\n"
    .  "foo;\n"
  c (across tokens)
    .  "int [xy];\n"
  javascript (escaped)
    .  "[a][:][b];\n"

Edge cases
  $ ./test_notation.exe edge
  javascript (text and newline stay)
    hl "let x = 1; // keep me\n"
    .  "let y = 2;\n"
  javascript (comment only line)
    hl "let y = 10;\n"
    .  "let z = 1;\n"
  python (indented comment only line)
    .  "if x:\n"
    hl "    y = 1\n"
  javascript (range)
    hl "let a = 1;\n"
    hl "let b = 2;\n"
    .  "let c = 3;\n"
  javascript (hl alias)
    hl "let a = 1;\n"
    .  "let b = 2;\n"
  javascript (no trailing newline)
    .  "let a = 1;\n"
    hl "let b = 2;"
  c (crlf)
    hl "int x;\r\n"
    .  "next\r\n"
  javascript (marker in string)
    .  "let s = \"// [!code highlight]\";\n"
  javascript (block comment not last)
    .  "f(/* [!code highlight] */ x);\n"
  css (marker in middle of block)
    hl "a { } /* note more */\n"
    .  "b { }\n"
  javascript (both transforms)
    ++ "let a = 1;\n"
    .  "let b = 2;\n"
  javascript (no marker)
    .  "let a = 1; // plain\n"
  javascript (empty source)

Only comments are removed, never code
  $ ./test_notation.exe code
  javascript (semicolon is code)
    .  "let x = 1; [!code highlight]\n"
    .  "let y = 2;\n"
  javascript (semicolon after string)
    .  "x = \"a\"; [!code hl]\n"
  c (preprocessor line)
    .  "#define X 1 [!code hl]\n"
  css (css declaration)
    .  "a { color: red;[!code highlight] }\n"
  typescript (typescript soup)
    .  "<!--(*%%[!code highlight]\n"
  javascript (comment after code)
    hl "x = 1; // note\n"

Random lines in many languages lose no code
  $ ./test_notation.exe property
  javascript: only comments change
  typescript: only comments change
  c: only comments change
  python: only comments change
  ruby: only comments change
  yaml: only comments change
  sql: only comments change
  lua: only comments change
  rust: only comments change
  go: only comments change
  toml: only comments change
  java: only comments change
  ocaml: only comments change
  css: only comments change
  html: only comments change

Many markers in a string take linear time
  $ ./test_notation.exe speed
  2500 markers in a string: under 2s: true
  5000 markers in a string: under 2s: true
  20000 markers in a string: under 2s: true
