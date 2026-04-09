Reason bundled grammar works through the CLI
  $ printf 'let x = 1;\n' | ochre reason --format tokens
  line 1:
    "let"  storage.type, source.reason
    " "  source.reason
    "x"  entity.name.function, source.reason
    " "  source.reason
    "="  keyword.control.less, source.reason
    " "  source.reason
    "1"  constant.numeric, source.reason
    ";"  message.error, keyword.control, keyword.operator, variable.interpolation, variable.other.class.js, source.reason
    "\n"  source.reason
