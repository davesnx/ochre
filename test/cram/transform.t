No transforms (passthrough)
  $ ./test_transform.exe no-transforms
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

Line highlight (line 0 only)
  $ ./test_transform.exe line-highlight
  text: "let"
    fg: #ff0000
    bg: #ffffff22
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #ffffff22
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #ffffff22
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Word highlight ("let")
  $ ./test_transform.exe word-highlight
  text: "let"
    fg: #ffff00
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Diff markers (+/-)
  $ ./test_transform.exe diff-markers
  text: "let"
    fg: #ff0000
    bg: #22883322
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #22883322
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #22883322
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    bg: #88222222
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    bg: #88222222
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    bg: #88222222
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "z ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "0"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Scope marker (keyword prefix)
  $ ./test_transform.exe scope-marker
  text: "let"
    fg: #ff0000
    bg: #ffff0033
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

HTML output with line highlight transform
  $ ./test_transform.exe html-with-transform
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);background-color:var(--ochre-bg,#ffffff22);color:var(--ochre,#ff0000)">let</span><span style="background-color:var(--ochre-bg,#ffffff22);color:var(--ochre,#d4d4d4)"> x = </span><span style="background-color:var(--ochre-bg,#ffffff22);color:var(--ochre,#0000ff)">42</span><span style="background-color:var(--ochre-bg,#ffffff22);color:var(--ochre,#d4d4d4)">
  </span></span>
  <span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> y = </span><span style="color:var(--ochre,#0000ff)">10</span><span style="color:var(--ochre,#d4d4d4)">
  </span></span></code></pre>

Combined transforms (line-highlight + word-highlight)
  $ ./test_transform.exe combined
  text: "let"
    fg: #ffff00
    bg: #ffffff22
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #ffffff22
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #ffffff22
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ffff00
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Notation highlight (// [!code highlight])
  $ ./test_transform.exe notation-highlight
  text: "let"
    fg: #ff0000
    bg: #ffffff22
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #ffffff22
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #ffffff22
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Notation diff (// [!code ++] and // [!code --])
  $ ./test_transform.exe notation-diff
  text: "let"
    fg: #ff0000
    bg: #22883322
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #22883322
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #22883322
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    bg: #88222222
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    bg: #88222222
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    bg: #88222222
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "z ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "0"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Notation word highlight (// [!code word:xxx])
  $ ./test_transform.exe notation-word-highlight
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x"
    fg: #ffff00
    styles: [bold]
    scopes: [source.test]
  text: "="
    fg: #d4d4d4
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Notation highlight with no matches (passthrough)
  $ ./test_transform.exe notation-highlight-no-match
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
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]

Notation diff with mixed lines (some marked, some not)
  $ ./test_transform.exe notation-diff-mixed
  text: "let"
    fg: #ff0000
    bg: #22883322
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "x ="
    fg: #d4d4d4
    bg: #22883322
    scopes: [source.test]
  text: "42"
    fg: #0000ff
    bg: #22883322
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "y ="
    fg: #d4d4d4
    scopes: [source.test]
  text: "10"
    fg: #0000ff
    scopes: [constant.numeric.test, source.test]
  text: "let"
    fg: #ff0000
    bg: #88222222
    styles: [bold]
    scopes: [keyword.control.test, source.test]
  text: "z ="
    fg: #d4d4d4
    bg: #88222222
    scopes: [source.test]
  text: "0"
    fg: #0000ff
    bg: #88222222
    scopes: [constant.numeric.test, source.test]
