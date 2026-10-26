CLI safety: untrusted theme data stays inert, output errors and unreadable
inputs give a clear message and a documented exit code.

  $ printf 'let x = 1\n' > ok.ml

A theme name is escaped in the class attribute

  $ cat > evil-name.json <<'JSON'
  > {"name":"\"><img src=x onerror=alert(1)>","tokenColors":[]}
  > JSON
  $ ochre ocaml ok.ml --theme-light evil-name.json --theme-dark nord | grep -o '<pre[^>]*>'
  <pre class="ochre ochre-themes &quot;&gt;&lt;img src=x onerror=alert(1)&gt; nord" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#000000);--ochre-dark-bg:#2e3440;--ochre-dark:#d8dee9" tabindex="0">
  $ ochre ocaml ok.ml --theme-light evil-name.json --theme-dark nord | grep -c '<img'
  0
  [1]

A theme colour that is not a plain CSS colour is left out, in HTML and in SVG

  $ cat > evil-color.json <<'JSON'
  > {"name":"evil","colors":{"editor.foreground":"\"><b>","editor.background":"red;}</style>"},"tokenColors":[{"scope":"keyword","settings":{"foreground":"\"><i>"}}]}
  > JSON
  $ ochre ocaml ok.ml --theme evil-color.json | grep -o '<pre[^>]*>'
  <pre class="ochre" tabindex="0">
  $ ochre ocaml ok.ml --theme evil-color.json | grep -c '<[bi]>'
  0
  [1]
  $ ochre ocaml ok.ml --theme evil-color.json --format svg | grep -c '<[bi]>'
  0
  [1]
  $ ochre ocaml ok.ml --theme evil-color.json --format svg | grep -o '<rect[^>]*>'
  <rect width="100%" height="100%" fill="none"/>

An option value is made safe for CSS names

  $ ochre ocaml ok.ml --theme nord '--css-var-prefix=--x;}</style>' | grep -o '<pre[^>]*>'
  <pre class="ochre" style="background-color:var(--x____style_-bg,#2e3440);color:var(--x____style_,#d8dee9)" tabindex="0">

Control characters in the source never reach SVG or the terminal raw

  $ printf 'a\001b\033[2Jc\n' | ochre plaintext --theme nord --format svg | grep -o 'preserve">.*</text>'
  preserve"><tspan fill="#d8dee9ff">a�b�[2Jc</tspan></text>
  $ printf 'a\001b\033[2Jc\n' | ochre plaintext --theme nord --format ansi | od -An -c
   033   [   4   8   ;   2   ;   4   6   ;   5   2   ;   6   4   m
   033   [   3   8   ;   2   ;   2   1   6   ;   2   2   2   ;   2
     3   3   m   a   ^   A   b   ^   [   [   2   J   c  \n 033   [
     0   m
  $ ochre ocaml ok.ml --theme nord --format tokens > /dev/null

Output errors: a full disk gives a message and exit code 3

  $ ochre ocaml ok.ml --theme nord > /dev/full
  ochre: cannot write output: No space left on device
  [3]
  $ ochre ocaml ok.ml --theme nord --format ansi > /dev/full
  ochre: cannot write output: No space left on device
  [3]

A closed standard error does not turn into a fatal error

  $ ochre ocaml ok.ml --theme nord > /dev/full 2>&-
  [3]
  $ ochre nosuch ok.ml 2>&-
  [1]
  $ ochre ocaml nosuch.ml 2>&-
  [1]

A closed standard output is an output error

  $ ochre ocaml ok.ml --theme nord >&-
  ochre: cannot write output: Bad file descriptor
  [3]

A reader that closes the pipe early ends ochre quietly with exit code 3

  $ yes hello | head -n 200000 > big.txt
  $ (ochre plaintext big.txt --theme nord --format ansi; echo "ochre exit: $?" >&2) | head -c 1 > /dev/null
  ochre exit: 3

Directory paths are named in the error

  $ mkdir dir
  $ ochre ocaml dir
  ochre: dir: Is a directory
  [1]
  $ ochre ocaml ok.ml --theme dir
  ochre: dir: Is a directory
  [1]
  $ ochre ocaml ok.ml --grammar dir
  ochre: dir: Is a directory
  [1]
  $ ochre ocaml ok.ml --include dir
  ochre: dir: Is a directory
  [1]
  $ ochre ocaml < dir
  ochre: <stdin>: Is a directory
  [1]

A non-blocking standard output that fills up is waited on, not an error

  $ ochre plaintext big.txt --theme nord --format ansi | wc -c > expected.count
  $ (./nonblock_exec.exe ochre plaintext big.txt --theme nord --format ansi; echo "ochre exit: $?" >&2) | (sleep 1; wc -c) > actual.count
  ochre exit: 0
  $ cmp expected.count actual.count
