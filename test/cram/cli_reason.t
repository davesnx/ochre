Reason bundled grammar works through the CLI
  $ printf 'let x = 1;\n' | ochre reason --stdin --format tokens
  {let}[storage.type,source.reason]{ }[source.reason]{x}[entity.name.function,source.reason]{ }[source.reason]{=}[keyword.control.less,source.reason]{ }[source.reason]{1}[constant.numeric,source.reason]{;}[variable.other.class.js variable.interpolation keyword.operator keyword.control message.error,source.reason]{
  }[source.reason]
