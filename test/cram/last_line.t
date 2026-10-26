The last line is tokenized with a newline, as in vscode-textmate, and the added newline is not part of any token

  $ cat > eol.tmLanguage.json <<'EOF2'
  > { "scopeName": "source.eol", "name": "eol", "patterns": [
  >   { "match": "b\\n", "name": "b-at-eol" } ] }
  > EOF2
  $ printf 'a b' | ochre eol --grammar eol.tmLanguage.json --format tokens
  line 1:
    "a "  source.eol
    "b"  b-at-eol, source.eol
  $ printf 'a b\n' | ochre eol --grammar eol.tmLanguage.json --format tokens
  line 1:
    "a "  source.eol
    "b\n"  b-at-eol, source.eol
  $ printf 'a b\nc' | ochre eol --grammar eol.tmLanguage.json --format tokens
  line 1:
    "a "  source.eol
    "b\n"  b-at-eol, source.eol
  line 2:
    "c"  source.eol
