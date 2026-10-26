Array-form captures are indexed from 0, as in vscode-textmate

  $ cat > arr.tmLanguage.json <<'EOF'
  > { "scopeName": "source.arr", "name": "arr", "patterns": [
  >   { "match": "(a)(b)", "captures": [ { "name": "zero" }, { "name": "one" } ] },
  >   { "begin": "(\\{)", "end": "(\\})",
  >     "beginCaptures": [ { "name": "open" } ],
  >     "endCaptures": [ { "name": "close" } ] }
  > ] }
  > EOF
  $ printf 'ab {}\n' | ochre arr --grammar arr.tmLanguage.json --format tokens
  line 1:
    "a"  one, zero, source.arr
    "b"  zero, source.arr
    " "  source.arr
    "{"  open, source.arr
    "}"  close, source.arr
    "\n"  source.arr
