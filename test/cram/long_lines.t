A line over the length cap is one token with the scopes in force at its start, and the next line starts from the state the long line received

  $ awk 'BEGIN { s = sprintf("%12000s", ""); gsub(/ /, "a", s); print "var s = \"" s "\"; var t = 1;"; print "var u = 2;" }' > long.js
  $ ochre javascript long.js --format tokens | sed 's/aaa*/a../' | grep -c 'invalid.illegal'
  0
  [1]
  $ ochre javascript long.js --format tokens | sed 's/aaa*/a../' | sed -n 1,5p
  line 1:
    "var s = \"a..\"; var t = 1;\n"  source.js
  line 2:
    "var"  storage.type.js, meta.var.expr.js, source.js
    " "  meta.var.expr.js, source.js
