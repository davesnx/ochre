(* Auto-generated from lib/themes/*.json. *)

let dark_plus =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#1E1E1E\",\n\
  \      \"editor.foreground\": \"#D4D4D4\"\n\
  \    },\n\
  \    \"name\": \"dark-plus\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.embedded\",\n\
  \          \"source.groovy.embedded\",\n\
  \          \"string meta.image.inline.markdown\",\n\
  \          \"variable.legacy.builtin.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D4D4D4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"emphasis\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"strong\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"header\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#6A9955\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\",\n\
  \          \"variable.other.enummember\",\n\
  \          \"keyword.operator.plus.exponent\",\n\
  \          \"keyword.operator.minus.exponent\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b5cea8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#646695\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag.css\",\n\
  \          \"entity.name.tag.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d7ba7d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9cdcfe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.class.css\",\n\
  \          \"source.css entity.other.attribute-name.class\",\n\
  \          \"entity.other.attribute-name.id.css\",\n\
  \          \"entity.other.attribute-name.parent-selector.css\",\n\
  \          \"entity.other.attribute-name.parent.less\",\n\
  \          \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \          \"entity.other.attribute-name.pseudo-element.css\",\n\
  \          \"source.css.less entity.other.attribute-name.id\",\n\
  \          \"entity.other.attribute-name.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d7ba7d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f44747\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.strikethrough\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"strikethrough\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b5cea8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.quote.begin.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#6A9955\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#6796e6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inline.raw\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#808080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.preprocessor\",\n\
  \          \"entity.name.function.preprocessor\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b5cea8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.structure.dictionary.key.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9cdcfe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.diff.header\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier\",\n\
  \          \"keyword.operator.noexcept\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"meta.embedded.assembly\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ce9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d16969\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.template-expression.begin\",\n\
  \          \"punctuation.definition.template-expression.end\",\n\
  \          \"punctuation.section.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.template.expression\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d4d4d4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.vendored.property-name\",\n\
  \          \"support.type.property-name\",\n\
  \          \"source.css variable\",\n\
  \          \"source.coffee.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9cdcfe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d4d4d4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.new\",\n\
  \          \"keyword.operator.expression\",\n\
  \          \"keyword.operator.cast\",\n\
  \          \"keyword.operator.sizeof\",\n\
  \          \"keyword.operator.alignof\",\n\
  \          \"keyword.operator.typeid\",\n\
  \          \"keyword.operator.alignas\",\n\
  \          \"keyword.operator.instanceof\",\n\
  \          \"keyword.operator.logical.python\",\n\
  \          \"keyword.operator.wordlike\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b5cea8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section.embedded.begin.php\",\n\
  \          \"punctuation.section.embedded.end.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9cdcfe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.sha.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b5cea8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.import.java\",\n\
  \          \"variable.language.wildcard.java\",\n\
  \          \"storage.modifier.package.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d4d4d4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"support.function\",\n\
  \          \"support.constant.handlebars\",\n\
  \          \"source.powershell variable.other.member\",\n\
  \          \"entity.name.operator.custom-literal\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCDCAA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class\",\n\
  \          \"support.type\",\n\
  \          \"entity.name.type\",\n\
  \          \"entity.name.namespace\",\n\
  \          \"entity.other.attribute\",\n\
  \          \"entity.name.scope-resolution\",\n\
  \          \"entity.name.class\",\n\
  \          \"storage.type.numeric.go\",\n\
  \          \"storage.type.byte.go\",\n\
  \          \"storage.type.boolean.go\",\n\
  \          \"storage.type.string.go\",\n\
  \          \"storage.type.uintptr.go\",\n\
  \          \"storage.type.error.go\",\n\
  \          \"storage.type.rune.go\",\n\
  \          \"storage.type.cs\",\n\
  \          \"storage.type.generic.cs\",\n\
  \          \"storage.type.modifier.cs\",\n\
  \          \"storage.type.variable.cs\",\n\
  \          \"storage.type.annotation.java\",\n\
  \          \"storage.type.generic.java\",\n\
  \          \"storage.type.java\",\n\
  \          \"storage.type.object.array.java\",\n\
  \          \"storage.type.primitive.array.java\",\n\
  \          \"storage.type.primitive.java\",\n\
  \          \"storage.type.token.java\",\n\
  \          \"storage.type.groovy\",\n\
  \          \"storage.type.annotation.groovy\",\n\
  \          \"storage.type.parameters.groovy\",\n\
  \          \"storage.type.generic.groovy\",\n\
  \          \"storage.type.object.array.groovy\",\n\
  \          \"storage.type.primitive.array.groovy\",\n\
  \          \"storage.type.primitive.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#4EC9B0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.type.cast.expr\",\n\
  \          \"meta.type.new.expr\",\n\
  \          \"support.constant.math\",\n\
  \          \"support.constant.dom\",\n\
  \          \"support.constant.json\",\n\
  \          \"entity.other.inherited-class\",\n\
  \          \"punctuation.separator.namespace.ruby\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#4EC9B0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control\",\n\
  \          \"source.cpp keyword.operator.new\",\n\
  \          \"keyword.operator.delete\",\n\
  \          \"keyword.other.using\",\n\
  \          \"keyword.other.directive.using\",\n\
  \          \"keyword.other.operator\",\n\
  \          \"entity.name.operator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#C586C0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable\",\n\
  \          \"meta.definition.variable.name\",\n\
  \          \"support.variable\",\n\
  \          \"entity.name.variable\",\n\
  \          \"constant.other.placeholder\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9CDCFE\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant\",\n\
  \          \"variable.other.enummember\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#4FC1FF\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.object-literal.key\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9CDCFE\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.property-value\",\n\
  \          \"support.constant.font-name\",\n\
  \          \"support.constant.media-type\",\n\
  \          \"support.constant.media\",\n\
  \          \"constant.other.color.rgb-value\",\n\
  \          \"constant.other.rgb-value\",\n\
  \          \"support.constant.color\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#CE9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.regexp\",\n\
  \          \"punctuation.definition.group.assertion.regexp\",\n\
  \          \"punctuation.definition.character-class.regexp\",\n\
  \          \"punctuation.character.set.begin.regexp\",\n\
  \          \"punctuation.character.set.end.regexp\",\n\
  \          \"keyword.operator.negation.regexp\",\n\
  \          \"support.other.parenthesis.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#CE9178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.character-class.regexp\",\n\
  \          \"constant.other.character-class.set.regexp\",\n\
  \          \"constant.other.character-class.regexp\",\n\
  \          \"constant.character.set.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d16969\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.or.regexp\",\n\
  \          \"keyword.control.anchor.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCDCAA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d7ba7d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character\",\n\
  \          \"constant.other.option\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#569cd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d7ba7d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.label\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#C8C8C8\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let light_plus =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#FFFFFF\",\n\
  \      \"editor.foreground\": \"#000000\"\n\
  \    },\n\
  \    \"name\": \"light-plus\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.embedded\",\n\
  \          \"source.groovy.embedded\",\n\
  \          \"string meta.image.inline.markdown\",\n\
  \          \"variable.legacy.builtin.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"emphasis\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"strong\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.diff.header\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#008000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\",\n\
  \          \"variable.other.enummember\",\n\
  \          \"keyword.operator.plus.exponent\",\n\
  \          \"keyword.operator.minus.exponent\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#098658\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#811f3f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e50000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.class.css\",\n\
  \          \"source.css entity.other.attribute-name.class\",\n\
  \          \"entity.other.attribute-name.id.css\",\n\
  \          \"entity.other.attribute-name.parent-selector.css\",\n\
  \          \"entity.other.attribute-name.parent.less\",\n\
  \          \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \          \"entity.other.attribute-name.pseudo-element.css\",\n\
  \          \"source.css.less entity.other.attribute-name.id\",\n\
  \          \"entity.other.attribute-name.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cd3131\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#000080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.strikethrough\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"strikethrough\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#098658\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a31515\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.quote.begin.markdown\",\n\
  \          \"punctuation.definition.list.begin.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inline.raw\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.preprocessor\",\n\
  \          \"entity.name.function.preprocessor\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a31515\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#098658\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.structure.dictionary.key.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier\",\n\
  \          \"keyword.operator.noexcept\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"meta.embedded.assembly\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a31515\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.comment.buffered.block.pug\",\n\
  \          \"string.quoted.pug\",\n\
  \          \"string.interpolated.pug\",\n\
  \          \"string.unquoted.plain.in.yaml\",\n\
  \          \"string.unquoted.plain.out.yaml\",\n\
  \          \"string.unquoted.block.yaml\",\n\
  \          \"string.quoted.single.yaml\",\n\
  \          \"string.quoted.double.xml\",\n\
  \          \"string.quoted.single.xml\",\n\
  \          \"string.unquoted.cdata.xml\",\n\
  \          \"string.quoted.double.html\",\n\
  \          \"string.quoted.single.html\",\n\
  \          \"string.unquoted.html\",\n\
  \          \"string.quoted.single.handlebars\",\n\
  \          \"string.quoted.double.handlebars\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#811f3f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.template-expression.begin\",\n\
  \          \"punctuation.definition.template-expression.end\",\n\
  \          \"punctuation.section.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.template.expression\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.property-value\",\n\
  \          \"support.constant.font-name\",\n\
  \          \"support.constant.media-type\",\n\
  \          \"support.constant.media\",\n\
  \          \"constant.other.color.rgb-value\",\n\
  \          \"constant.other.rgb-value\",\n\
  \          \"support.constant.color\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.vendored.property-name\",\n\
  \          \"support.type.property-name\",\n\
  \          \"source.css variable\",\n\
  \          \"source.coffee.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e50000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.new\",\n\
  \          \"keyword.operator.expression\",\n\
  \          \"keyword.operator.cast\",\n\
  \          \"keyword.operator.sizeof\",\n\
  \          \"keyword.operator.alignof\",\n\
  \          \"keyword.operator.typeid\",\n\
  \          \"keyword.operator.alignas\",\n\
  \          \"keyword.operator.instanceof\",\n\
  \          \"keyword.operator.logical.python\",\n\
  \          \"keyword.operator.wordlike\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#098658\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section.embedded.begin.php\",\n\
  \          \"punctuation.section.embedded.end.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#800000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.sha.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#098658\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.import.java\",\n\
  \          \"variable.language.wildcard.java\",\n\
  \          \"storage.modifier.package.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"support.function\",\n\
  \          \"support.constant.handlebars\",\n\
  \          \"source.powershell variable.other.member\",\n\
  \          \"entity.name.operator.custom-literal\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#795E26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class\",\n\
  \          \"support.type\",\n\
  \          \"entity.name.type\",\n\
  \          \"entity.name.namespace\",\n\
  \          \"entity.other.attribute\",\n\
  \          \"entity.name.scope-resolution\",\n\
  \          \"entity.name.class\",\n\
  \          \"storage.type.numeric.go\",\n\
  \          \"storage.type.byte.go\",\n\
  \          \"storage.type.boolean.go\",\n\
  \          \"storage.type.string.go\",\n\
  \          \"storage.type.uintptr.go\",\n\
  \          \"storage.type.error.go\",\n\
  \          \"storage.type.rune.go\",\n\
  \          \"storage.type.cs\",\n\
  \          \"storage.type.generic.cs\",\n\
  \          \"storage.type.modifier.cs\",\n\
  \          \"storage.type.variable.cs\",\n\
  \          \"storage.type.annotation.java\",\n\
  \          \"storage.type.generic.java\",\n\
  \          \"storage.type.java\",\n\
  \          \"storage.type.object.array.java\",\n\
  \          \"storage.type.primitive.array.java\",\n\
  \          \"storage.type.primitive.java\",\n\
  \          \"storage.type.token.java\",\n\
  \          \"storage.type.groovy\",\n\
  \          \"storage.type.annotation.groovy\",\n\
  \          \"storage.type.parameters.groovy\",\n\
  \          \"storage.type.generic.groovy\",\n\
  \          \"storage.type.object.array.groovy\",\n\
  \          \"storage.type.primitive.array.groovy\",\n\
  \          \"storage.type.primitive.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#267f99\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.type.cast.expr\",\n\
  \          \"meta.type.new.expr\",\n\
  \          \"support.constant.math\",\n\
  \          \"support.constant.dom\",\n\
  \          \"support.constant.json\",\n\
  \          \"entity.other.inherited-class\",\n\
  \          \"punctuation.separator.namespace.ruby\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#267f99\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control\",\n\
  \          \"source.cpp keyword.operator.new\",\n\
  \          \"source.cpp keyword.operator.delete\",\n\
  \          \"keyword.other.using\",\n\
  \          \"keyword.other.directive.using\",\n\
  \          \"keyword.other.operator\",\n\
  \          \"entity.name.operator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#AF00DB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable\",\n\
  \          \"meta.definition.variable.name\",\n\
  \          \"support.variable\",\n\
  \          \"entity.name.variable\",\n\
  \          \"constant.other.placeholder\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#001080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant\",\n\
  \          \"variable.other.enummember\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0070C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.object-literal.key\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#001080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.property-value\",\n\
  \          \"support.constant.font-name\",\n\
  \          \"support.constant.media-type\",\n\
  \          \"support.constant.media\",\n\
  \          \"constant.other.color.rgb-value\",\n\
  \          \"constant.other.rgb-value\",\n\
  \          \"support.constant.color\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0451a5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.regexp\",\n\
  \          \"punctuation.definition.group.assertion.regexp\",\n\
  \          \"punctuation.definition.character-class.regexp\",\n\
  \          \"punctuation.character.set.begin.regexp\",\n\
  \          \"punctuation.character.set.end.regexp\",\n\
  \          \"keyword.operator.negation.regexp\",\n\
  \          \"support.other.parenthesis.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d16969\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.character-class.regexp\",\n\
  \          \"constant.other.character-class.set.regexp\",\n\
  \          \"constant.other.character-class.regexp\",\n\
  \          \"constant.character.set.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#811f3f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.or.regexp\",\n\
  \          \"keyword.control.anchor.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EE0000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character\",\n\
  \          \"constant.other.option\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0000ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EE0000\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.label\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#000000\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"light\"\n\
  \  }\n"

let tokyo_night =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#1a1b26\",\n\
  \      \"editor.foreground\": \"#a9b1d6\"\n\
  \    },\n\
  \    \"name\": \"tokyo-night\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"meta.var.expr storage.type\",\n\
  \          \"keyword.control.flow\",\n\
  \          \"keyword.control.return\",\n\
  \          \"meta.directive.vue punctuation.separator.key-value.html\",\n\
  \          \"meta.directive.vue entity.other.attribute-name.html\",\n\
  \          \"tag.decorator.js entity.name.tag.js\",\n\
  \          \"tag.decorator.js punctuation.definition.tag.js\",\n\
  \          \"storage.modifier\",\n\
  \          \"string.quoted.docstring.multi\",\n\
  \          \"string.quoted.docstring.multi.python \
   punctuation.definition.string.begin\",\n\
  \          \"string.quoted.docstring.multi.python \
   punctuation.definition.string.end\",\n\
  \          \"string.quoted.docstring.multi.python constant.character.escape\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.flow.block-scalar.literal\",\n\
  \          \"keyword.control.flow.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"comment.block.documentation\",\n\
  \          \"punctuation.definition.comment\",\n\
  \          \"comment.block.documentation punctuation\",\n\
  \          \"string.quoted.docstring.multi\",\n\
  \          \"string.quoted.docstring.multi.python \
   punctuation.definition.string.begin\",\n\
  \          \"string.quoted.docstring.multi.python \
   punctuation.definition.string.end\",\n\
  \          \"string.quoted.docstring.multi.python constant.character.escape\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#51597d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.assignment.jsdoc\",\n\
  \          \"comment.block.documentation variable\",\n\
  \          \"comment.block.documentation storage\",\n\
  \          \"comment.block.documentation keyword\",\n\
  \          \"comment.block.documentation support\",\n\
  \          \"comment.block.documentation markup\",\n\
  \          \"comment.block.documentation markup.inline.raw.string.markdown\",\n\
  \          \"meta.other.type.phpdoc.php keyword.other.type.php\",\n\
  \          \"meta.other.type.phpdoc.php support.other.namespace.php\",\n\
  \          \"meta.other.type.phpdoc.php \
   punctuation.separator.inheritance.php\",\n\
  \          \"meta.other.type.phpdoc.php support.class\",\n\
  \          \"keyword.other.phpdoc.php\",\n\
  \          \"log.date\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5a638c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.other.type.phpdoc.php support.class\",\n\
  \          \"comment.block.documentation storage.type\",\n\
  \          \"comment.block.documentation punctuation.definition.block.tag\",\n\
  \          \"comment.block.documentation entity.name.type.instance\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#646e9c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant\",\n\
  \          \"punctuation.definition.constant\",\n\
  \          \"constant.language\",\n\
  \          \"constant.numeric\",\n\
  \          \"support.constant\",\n\
  \          \"constant.other.caps\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff9e64\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"constant.other.symbol\",\n\
  \          \"constant.other.key\",\n\
  \          \"meta.attribute-selector\",\n\
  \          \"string constant.character\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#9ece6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.color\",\n\
  \          \"constant.other.color.rgb-value.hex \
   punctuation.definition.constant\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9aa5ce\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"invalid\",\n\
  \          \"invalid.illegal\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff5370\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.deprecated\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.var.expr storage.type\",\n\
  \          \"storage.modifier\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9d7cd8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.template-expression\",\n\
  \          \"punctuation.section.embedded\",\n\
  \          \"meta.embedded.line.tag.smarty\",\n\
  \          \"support.constant.handlebars\",\n\
  \          \"punctuation.section.tag.twig\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.smarty\",\n\
  \          \"keyword.control.twig\",\n\
  \          \"support.constant.handlebars keyword.control\",\n\
  \          \"keyword.operator.comparison.twig\",\n\
  \          \"keyword.blade\",\n\
  \          \"entity.name.function.blade\",\n\
  \          \"meta.tag.blade keyword.other.type.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.spread\",\n\
  \          \"keyword.operator.rest\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator\",\n\
  \          \"keyword.control.as\",\n\
  \          \"keyword.other\",\n\
  \          \"keyword.operator.bitwise.shift\",\n\
  \          \"punctuation\",\n\
  \          \"expression.embbeded.vue punctuation.definition.tag\",\n\
  \          \"text.html.twig meta.tag.inline.any.html\",\n\
  \          \"meta.tag.template.value.twig meta.function.arguments.twig\",\n\
  \          \"meta.directive.vue punctuation.separator.key-value.html\",\n\
  \          \"punctuation.definition.constant.markdown\",\n\
  \          \"punctuation.definition.string\",\n\
  \          \"punctuation.support.type.property-name\",\n\
  \          \"text.html.vue-html meta.tag\",\n\
  \          \"meta.attribute.directive\",\n\
  \          \"punctuation.definition.keyword\",\n\
  \          \"punctuation.terminator.rule\",\n\
  \          \"punctuation.definition.entity\",\n\
  \          \"punctuation.separator.inheritance.php\",\n\
  \          \"keyword.other.template\",\n\
  \          \"keyword.other.substitution\",\n\
  \          \"entity.name.operator\",\n\
  \          \"meta.property-list punctuation.separator.key-value\",\n\
  \          \"meta.at-rule.mixin punctuation.separator.key-value\",\n\
  \          \"meta.at-rule.function variable.parameter.url\",\n\
  \          \"meta.embedded.inline.phpx \
   punctuation.definition.tag.begin.html\",\n\
  \          \"meta.embedded.inline.phpx punctuation.definition.tag.end.html\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89ddff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.module.js\",\n\
  \          \"keyword.control.import\",\n\
  \          \"keyword.control.export\",\n\
  \          \"keyword.control.from\",\n\
  \          \"keyword.control.default\",\n\
  \          \"meta.import keyword.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword\",\n\
  \          \"keyword.control\",\n\
  \          \"keyword.other.important\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.DML\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.logical\",\n\
  \          \"storage.type.function\",\n\
  \          \"keyword.operator.bitwise\",\n\
  \          \"keyword.operator.ternary\",\n\
  \          \"keyword.operator.comparison\",\n\
  \          \"keyword.operator.relational\",\n\
  \          \"keyword.operator.or.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag support.class.component\",\n\
  \          \"meta.tag.custom entity.name.tag\",\n\
  \          \"meta.tag.other.unrecognized.html.derivative entity.name.tag\",\n\
  \          \"meta.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#de5971\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.tag\",\n\
  \          \"text.html.php meta.embedded.block.html \
   meta.tag.metadata.script.end.html punctuation.definition.tag.begin.html \
   text.html.basic\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ba3c97\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.php\",\n\
  \          \"variable.other.global.safer\",\n\
  \          \"variable.other.global.safer punctuation.definition.variable\",\n\
  \          \"variable.other.global\",\n\
  \          \"variable.other.global punctuation.definition.variable\",\n\
  \          \"constant.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e0af68\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable\",\n\
  \          \"support.variable\",\n\
  \          \"string constant.other.placeholder\",\n\
  \          \"variable.parameter.handlebars\",\n\
  \          \"variable.other.object\",\n\
  \          \"meta.fstring\",\n\
  \          \"meta.function-call meta.function-call.arguments\",\n\
  \          \"meta.embedded.inline.phpx constant.other.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.array.literal variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.object-literal.key\",\n\
  \          \"entity.name.type.hcl\",\n\
  \          \"string.alias.graphql\",\n\
  \          \"string.unquoted.graphql\",\n\
  \          \"string.unquoted.alias.graphql\",\n\
  \          \"meta.group.braces.curly constant.other.object.key.js \
   string.unquoted.label.js\",\n\
  \          \"meta.field.declaration.ts variable.object.property\",\n\
  \          \"meta.block entity.name.label\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73daca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.property\",\n\
  \          \"support.variable.property\",\n\
  \          \"support.variable.property.dom\",\n\
  \          \"meta.function-call variable.other.object.property\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.object.property\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.objectliteral meta.object.member \
   meta.objectliteral meta.object.member meta.objectliteral meta.object.member \
   meta.object-literal.key\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#41a6b5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.cpp meta.block variable.other\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.other.variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.class-method.js entity.name.function.js\",\n\
  \          \"entity.name.method.js\",\n\
  \          \"variable.function.constructor\",\n\
  \          \"keyword.other.special-method\",\n\
  \          \"storage.type.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"variable.other.enummember\",\n\
  \          \"meta.function-call\",\n\
  \          \"meta.function-call entity.name.function\",\n\
  \          \"variable.function\",\n\
  \          \"meta.definition.method entity.name.function\",\n\
  \          \"meta.object-literal entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter.function.language.special\",\n\
  \          \"variable.parameter\",\n\
  \          \"meta.function.parameters punctuation.definition.variable\",\n\
  \          \"meta.function.parameter variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e0af68\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.type.php\",\n\
  \          \"storage.type.php\",\n\
  \          \"constant.character\",\n\
  \          \"constant.escape\",\n\
  \          \"keyword.other.unit\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.definition.variable variable.other.constant\",\n\
  \          \"meta.definition.variable variable.other.readwrite\",\n\
  \          \"variable.declaration.hcl variable.other.readwrite.hcl\",\n\
  \          \"meta.mapping.key.hcl variable.other.readwrite.hcl\",\n\
  \          \"variable.other.declaration\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.inherited-class\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class\",\n\
  \          \"support.type\",\n\
  \          \"variable.other.readwrite.alias\",\n\
  \          \"support.orther.namespace.use.php\",\n\
  \          \"meta.use.php\",\n\
  \          \"support.other.namespace.php\",\n\
  \          \"support.type.sys-types\",\n\
  \          \"support.variable.dom\",\n\
  \          \"support.constant.math\",\n\
  \          \"support.type.object.module\",\n\
  \          \"support.constant.json\",\n\
  \          \"entity.name.namespace\",\n\
  \          \"meta.import.qualifier\",\n\
  \          \"variable.other.constant.object\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css support.type.property-name\",\n\
  \          \"source.sass support.type.property-name\",\n\
  \          \"source.scss support.type.property-name\",\n\
  \          \"source.less support.type.property-name\",\n\
  \          \"source.stylus support.type.property-name\",\n\
  \          \"source.postcss support.type.property-name\",\n\
  \          \"support.type.property-name.css\",\n\
  \          \"support.type.vendored.property-name\",\n\
  \          \"support.type.map.key\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.font-name\",\n\
  \          \"meta.definition.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9ece6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.class\",\n\
  \          \"meta.at-rule.mixin.scss entity.name.function.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9ece6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.id\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fc7b7b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.pseudo-class \
   punctuation.definition.entity\",\n\
  \          \"entity.other.attribute-name.pseudo-element \
   punctuation.definition.entity\",\n\
  \          \"entity.other.attribute-name.class \
   punctuation.definition.entity\",\n\
  \          \"entity.name.tag.reference\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e0af68\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.property-list\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9abdf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.property-list meta.at-rule.if\",\n\
  \          \"meta.at-rule.return variable.parameter.url\",\n\
  \          \"meta.property-list meta.at-rule.else\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff9e64\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.parent-selector-suffix \
   punctuation.definition.entity.css\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73daca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.property-list meta.property-list\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9abdf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.at-rule.mixin keyword.control.at-rule.mixin\",\n\
  \          \"meta.at-rule.include entity.name.function.scss\",\n\
  \          \"meta.at-rule.include keyword.control.at-rule.include\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.at-rule.include punctuation.definition.keyword\",\n\
  \          \"keyword.control.at-rule.mixin punctuation.definition.keyword\",\n\
  \          \"meta.at-rule.include keyword.control.at-rule.include\",\n\
  \          \"keyword.control.at-rule.extend punctuation.definition.keyword\",\n\
  \          \"meta.at-rule.extend keyword.control.at-rule.extend\",\n\
  \          \"entity.other.attribute-name.placeholder.css \
   punctuation.definition.entity.css\",\n\
  \          \"meta.at-rule.media keyword.control.at-rule.media\",\n\
  \          \"meta.at-rule.mixin keyword.control.at-rule.mixin\",\n\
  \          \"meta.at-rule.function keyword.control.at-rule.function\",\n\
  \          \"keyword.control punctuation.definition.keyword\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9d7cd8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.property-list meta.at-rule.include\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.property-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff9e64\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.module.js\",\n\
  \          \"variable.import.parameter.js\",\n\
  \          \"variable.other.class.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other punctuation.definition.variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js constant.other.object.key.js \
   string.unquoted.label.js\",\n\
  \          \"variable.language.this punctuation.definition.variable\",\n\
  \          \"keyword.other.this\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name\",\n\
  \          \"text.html.basic entity.other.attribute-name.html\",\n\
  \          \"text.html.basic entity.other.attribute-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html constant.character.entity\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0DB9D7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.id.html\",\n\
  \          \"meta.directive.vue entity.other.attribute-name.html\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.sass keyword.control\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.pseudo-class\",\n\
  \          \"entity.other.attribute-name.pseudo-element\",\n\
  \          \"entity.other.attribute-name.placeholder\",\n\
  \          \"meta.property-list meta.property-value\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#449dab\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#914c54\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#6183bb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b4f9f8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.group\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.character-class.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.character-class.set.regexp\",\n\
  \          \"punctuation.definition.character-class.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e0af68\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89ddff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape.backslash\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89ddff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"tag.decorator.js entity.name.tag.js\",\n\
  \          \"tag.decorator.js punctuation.definition.tag.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dcfff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e0af68\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73daca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9ece6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.list_item.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9abdf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.block\",\n\
  \          \"meta.brace\",\n\
  \          \"punctuation.definition.block\",\n\
  \          \"punctuation.definition.use\",\n\
  \          \"punctuation.definition.class\",\n\
  \          \"punctuation.definition.begin.bracket\",\n\
  \          \"punctuation.definition.end.bracket\",\n\
  \          \"punctuation.definition.switch-expression.begin.bracket\",\n\
  \          \"punctuation.definition.switch-expression.end.bracket\",\n\
  \          \"punctuation.definition.section.switch-block.begin.bracket\",\n\
  \          \"punctuation.definition.section.switch-block.end.bracket\",\n\
  \          \"punctuation.definition.group.shell\",\n\
  \          \"punctuation.definition.parameters\",\n\
  \          \"punctuation.definition.arguments\",\n\
  \          \"punctuation.definition.dictionary\",\n\
  \          \"punctuation.definition.array\",\n\
  \          \"punctuation.section\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9abdf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.embedded.block\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.tag JSXNested\",\n\
  \          \"meta.jsx.children\",\n\
  \          \"text.html\",\n\
  \          \"text.log\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9aa5ce\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown markup.inline.raw.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bb9af7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown markup.inline.raw.markdown \
   punctuation.definition.raw.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#4E5579\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.1.markdown entity.name\",\n\
  \          \"heading.1.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#89ddff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.2.markdown entity.name\",\n\
  \          \"heading.2.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#61bdf2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.3.markdown entity.name\",\n\
  \          \"heading.3.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.4.markdown entity.name\",\n\
  \          \"heading.4.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#6d91de\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.5.markdown entity.name\",\n\
  \          \"heading.5.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#9aa5ce\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.6.markdown entity.name\",\n\
  \          \"heading.6.markdown punctuation.definition.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#747ca1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.italic\",\n\
  \          \"markup.italic punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.bold\",\n\
  \          \"markup.bold punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.bold markup.italic\",\n\
  \          \"markup.bold markup.italic punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold italic\",\n\
  \          \"foreground\": \"#c0caf5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.underline\",\n\
  \          \"markup.underline punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.quote \
   punctuation.definition.blockquote.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#4e5579\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.quote\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.other.link\",\n\
  \          \"markup.underline.link\",\n\
  \          \"constant.other.reference.link.markdown\",\n\
  \          \"string.other.link.description.title.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73daca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.fenced_code.block.markdown\",\n\
  \          \"markup.inline.raw.string.markdown\",\n\
  \          \"variable.language.fenced.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89ddff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.separator\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#51597d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.table\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c0cefc\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.info-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#0db9d7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.warn-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffdb69\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.error-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#db4b4b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.debug-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b267e6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.tag.apacheconf\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f7768e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.preprocessor\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73daca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.env\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7aa2f7\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let everforest_dark =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#2d353b\",\n\
  \      \"editor.foreground\": \"#d3c6aa\"\n\
  \    },\n\
  \    \"name\": \"everforest-dark\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": \"keyword, storage.type.function, storage.type.class, \
   storage.type.enum, storage.type.interface, storage.type.property, \
   keyword.operator.new, keyword.operator.expression, keyword.operator.new, \
   keyword.operator.delete, storage.type.extends\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.debugger\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage, modifier, keyword.var, entity.name.tag, \
   keyword.control.case, keyword.control.switch\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string, punctuation.definition.string.end, \
   punctuation.definition.string.begin, \
   punctuation.definition.string.template.begin, \
   punctuation.definition.string.template.end\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape, punctuation.quasi.element, \
   punctuation.definition.template-expression, punctuation.section.embedded, \
   storage.type.format, constant.other.placeholder, \
   constant.other.placeholder, variable.interpolation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function, support.function, meta.function, \
   meta.function-call, meta.definition.method\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.at-rule, keyword.control.import, \
   keyword.control.export, storage.type.namespace, punctuation.decorator, \
   keyword.control.directive, keyword.preprocessor, \
   punctuation.definition.preprocessor, punctuation.definition.directive, \
   keyword.other.import, keyword.other.package, entity.name.type.namespace, \
   entity.name.scope-resolution, keyword.other.using, keyword.package, \
   keyword.import, keyword.map\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.annotation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.label, constant.other.label\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.module, support.node, support.other.module, \
   support.type.object.module, entity.name.type.module, \
   entity.name.type.class.module, keyword.control.module\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type, support.type, entity.name.type, \
   keyword.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.class, support.class, \
   entity.name.class, entity.other.inherited-class, storage.class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.boolean\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.preprocessor\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.this, variable.language.self, \
   variable.language.super, keyword.other.this, variable.language.special, \
   constant.language.null, constant.language.undefined, \
   constant.language.nan\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language, support.constant\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable, support.variable, meta.definition.variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.object.property, support.variable.property, \
   variable.other.property, variable.other.object.property, \
   variable.other.enummember, variable.other.member, meta.object-literal.key\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation, meta.brace, meta.delimiter, meta.bracket\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.1.markdown, markup.heading.setext.1.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.2.markdown, markup.heading.setext.2.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.3.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.4.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.5.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.6.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.heading.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"regular\",\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.other.link.title.markdown, \
   constant.other.reference.link.markdown, \
   string.other.link.description.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"regular\",\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline.link.image.markdown, \
   markup.underline.link.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\",\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.string.begin.markdown, \
   punctuation.definition.string.end.markdown, \
   punctuation.definition.italic.markdown, \
   punctuation.definition.quote.begin.markdown, \
   punctuation.definition.metadata.markdown, \
   punctuation.separator.key-value.markdown, \
   punctuation.definition.constant.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.bold.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"regular\",\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.separator.markdown, \
   punctuation.definition.constant.begin.markdown, \
   punctuation.definition.constant.end.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold markup.italic, markup.italic markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.markdown, \
   punctuation.definition.raw.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"fenced_code.block.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.fenced_code.block.markdown, \
   markup.inline.raw.string.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.heading.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.field.restructuredtext, \
   punctuation.separator.key-value.restructuredtext, \
   punctuation.definition.directive.restructuredtext, \
   punctuation.definition.constant.restructuredtext, \
   punctuation.definition.italic.restructuredtext, \
   punctuation.definition.table.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.bold.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"regular\",\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.restructuredtext, \
   punctuation.definition.link.restructuredtext, \
   punctuation.definition.raw.restructuredtext, \
   punctuation.section.raw.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.footnote.link.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.directive.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.directive.restructuredtext, \
   markup.raw.restructuredtext, markup.raw.inner.restructuredtext, \
   string.other.link.title.restructuredtext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.function.latex, \
   punctuation.definition.function.tex, punctuation.definition.keyword.latex, \
   constant.character.newline.tex, punctuation.definition.keyword.tex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.be.latex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.section.latex, \
   keyword.control.table.cell.latex, keyword.control.table.newline.latex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.class.latex, variable.parameter.latex, \
   variable.parameter.function.latex, \
   variable.parameter.definition.label.latex, \
   constant.other.reference.label.latex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.preamble.latex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.namespace.xml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.html, entity.name.tag.xml, \
   entity.name.tag.localname.xml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.html, \
   entity.other.attribute-name.xml, \
   entity.other.attribute-name.localname.xml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.html, string.quoted.single.html, \
   punctuation.definition.string.begin.html, \
   punctuation.definition.string.end.html, \
   punctuation.separator.key-value.html, \
   punctuation.definition.string.begin.xml, \
   punctuation.definition.string.end.xml, string.quoted.double.xml, \
   string.quoted.single.xml, punctuation.definition.tag.begin.html, \
   punctuation.definition.tag.end.html, punctuation.definition.tag.xml, \
   meta.tag.xml, meta.tag.preprocessor.xml, meta.tag.other.html, \
   meta.tag.block.any.html, meta.tag.inline.any.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.documentroot.xml, \
   meta.tag.sgml.doctype.xml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.proto\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.proto.syntax, \
   string.quoted.single.proto.syntax, string.quoted.double.proto, \
   string.quoted.single.proto\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.class.proto, \
   entity.name.class.message.proto\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.entity.css, \
   punctuation.separator.key-value.css, punctuation.terminator.rule.css, \
   punctuation.separator.list.comma.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.class.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.pseudo-class.css, \
   entity.other.attribute-name.pseudo-element.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.single.css, string.quoted.double.css, \
   support.constant.property-value.css, meta.property-value.css, \
   punctuation.definition.string.begin.css, \
   punctuation.definition.string.end.css, constant.numeric.css, \
   support.constant.font-name.css, variable.parameter.keyframe-list.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.vendored.property-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.css, entity.other.keyframe-offset.css, \
   punctuation.definition.keyword.css, keyword.control.at-rule.keyframes.css, \
   meta.selector.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.entity.scss, \
   punctuation.separator.key-value.scss, punctuation.terminator.rule.scss, \
   punctuation.separator.list.comma.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.at-rule.keyframes.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.definition.interpolation.begin.bracket.curly.scss, \
   punctuation.definition.interpolation.end.bracket.curly.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.string.begin.scss, \
   punctuation.definition.string.end.scss, string.quoted.double.scss, \
   string.quoted.single.scss, constant.character.css.sass, \
   meta.property-value.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.at-rule.include.scss, \
   keyword.control.at-rule.use.scss, keyword.control.at-rule.mixin.scss, \
   keyword.control.at-rule.extend.scss, keyword.control.at-rule.import.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.stylus\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.stylus\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.accessor.js, \
   punctuation.separator.key-value.js, punctuation.separator.label.js, \
   keyword.operator.accessor.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.block.tag.jsdoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.js, storage.type.function.arrow.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"JSXNested\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag.jsx, \
   entity.other.attribute-name.jsx, punctuation.definition.tag.begin.js.jsx, \
   punctuation.definition.tag.end.js.jsx, entity.other.attribute-name.js.jsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.type.annotation.ts, \
   punctuation.accessor.ts, punctuation.separator.key-value.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag.directive.ts, \
   entity.other.attribute-name.directive.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.ts, entity.name.type.interface.ts, \
   entity.other.inherited-class.ts, entity.name.type.alias.ts, \
   entity.name.type.class.ts, entity.name.type.enum.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.ts, storage.type.function.arrow.ts, \
   storage.type.type.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.import.ts, keyword.control.export.ts, \
   storage.type.namespace.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.type.annotation.tsx, \
   punctuation.accessor.tsx, punctuation.separator.key-value.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag.directive.tsx, \
   entity.other.attribute-name.directive.tsx, \
   punctuation.definition.tag.begin.tsx, punctuation.definition.tag.end.tsx, \
   entity.other.attribute-name.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.tsx, entity.name.type.interface.tsx, \
   entity.other.inherited-class.tsx, entity.name.type.alias.tsx, \
   entity.name.type.class.tsx, entity.name.type.enum.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.import.tsx, \
   keyword.control.export.tsx, storage.type.namespace.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.tsx, storage.type.function.arrow.tsx, \
   storage.type.type.tsx, support.class.component.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function.coffee\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.type-signature.purescript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.double-colon.purescript, \
   keyword.other.arrow.purescript, keyword.other.big-arrow.purescript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.purescript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.single.purescript, \
   string.quoted.double.purescript, \
   punctuation.definition.string.begin.purescript, \
   punctuation.definition.string.end.purescript, \
   string.quoted.triple.purescript, entity.name.type.purescript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.other.module.purescript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.dot.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.primitive.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.class.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.dart, \
   string.interpolated.single.dart, string.interpolated.double.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.import.dart, \
   storage.type.annotation.dart\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.class.pug\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function.pug\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.tag.pug\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.pug, storage.type.import.include.pug\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.c, \
   storage.modifier.array.bracket.square.c, \
   meta.function.definition.parameters.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.dot-access.c, \
   constant.character.escape.line-continuation.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.directive.include.c, \
   punctuation.definition.directive.c, keyword.control.directive.pragma.c, \
   keyword.control.directive.line.c, keyword.control.directive.define.c, \
   keyword.control.directive.conditional.c, \
   keyword.control.directive.diagnostic.error.c, \
   keyword.control.directive.undef.c, \
   keyword.control.directive.conditional.ifdef.c, \
   keyword.control.directive.endif.c, \
   keyword.control.directive.conditional.ifndef.c, \
   keyword.control.directive.conditional.if.c, \
   keyword.control.directive.else.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.pointer-access.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.member.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.cpp, \
   storage.modifier.array.bracket.square.cpp, \
   meta.function.definition.parameters.cpp, \
   meta.body.function.definition.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.dot-access.cpp, \
   constant.character.escape.line-continuation.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.directive.include.cpp, \
   punctuation.definition.directive.cpp, keyword.control.directive.pragma.cpp, \
   keyword.control.directive.line.cpp, keyword.control.directive.define.cpp, \
   keyword.control.directive.conditional.cpp, \
   keyword.control.directive.diagnostic.error.cpp, \
   keyword.control.directive.undef.cpp, \
   keyword.control.directive.conditional.ifdef.cpp, \
   keyword.control.directive.endif.cpp, \
   keyword.control.directive.conditional.ifndef.cpp, \
   keyword.control.directive.conditional.if.cpp, \
   keyword.control.directive.else.cpp, storage.type.namespace.definition.cpp, \
   keyword.other.using.directive.cpp, storage.type.struct.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.pointer-access.cpp, \
   punctuation.section.angle-brackets.begin.template.call.cpp, \
   punctuation.section.angle-brackets.end.template.call.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.member.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.using.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.type.cs, constant.character.escape.cs, \
   punctuation.definition.interpolation.begin.cs, \
   punctuation.definition.interpolation.end.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.cs, string.quoted.single.cs, \
   punctuation.definition.string.begin.cs, \
   punctuation.definition.string.end.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.object.property.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.namespace.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.symbol.fsharp, constant.language.unit.fsharp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.format.specifier.fsharp, \
   entity.name.type.fsharp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.fsharp, \
   string.quoted.single.fsharp, punctuation.definition.string.begin.fsharp, \
   punctuation.definition.string.end.fsharp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.section.fsharp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.attribute.fsharp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.java, \
   punctuation.separator.period.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.import.java, keyword.other.package.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function.arrow.java, \
   keyword.control.ternary.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.property.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.wildcard.java, \
   storage.modifier.import.java, storage.type.annotation.java, \
   punctuation.definition.annotation.java, storage.modifier.package.java, \
   entity.name.type.module.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.import.kotlin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.kotlin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.kotlin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.package.kotlin, \
   storage.type.annotation.kotlin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.package.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.import.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.scala, \
   string.quoted.single.scala, punctuation.definition.string.begin.scala, \
   punctuation.definition.string.end.scala, \
   string.quoted.double.interpolated.scala, \
   string.quoted.single.interpolated.scala, string.quoted.triple.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.class, entity.other.inherited-class.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.declaration.stable.scala, \
   keyword.other.arrow.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.import.scala\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.navigation.groovy, \
   meta.method.body.java, meta.definition.method.groovy, \
   meta.definition.method.signature.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.import.groovy, \
   keyword.other.package.groovy, keyword.other.import.static.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.def.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.interpolated.groovy, \
   meta.method.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.import.groovy, \
   storage.modifier.package.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.annotation.groovy\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.type.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.package.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.import.go, keyword.package.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.mod.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.path.rust, \
   keyword.operator.member-access.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.core.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.attribute.rust, variable.language.rust, \
   storage.type.module.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.swift, \
   support.function.any-method.swift\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.variable.swift\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.class.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.trait.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.php, support.other.namespace.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.modifier.access.control.public.cpp, \
   storage.type.modifier.access.control.private.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.import.include.php, storage.type.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.arguments.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.decorator.python, \
   punctuation.separator.period.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.import.python, \
   keyword.control.import.from.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.lua\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.class.lua\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.method.with-arguments.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.method.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.pseudo-method.ruby, \
   storage.type.variable.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.special-method.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.module.ruby, \
   punctuation.definition.constant.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"string.regexp.character-class.ruby,string.regexp.interpolated.ruby,punctuation.definition.character-class.ruby,string.regexp.group.ruby, \
   punctuation.section.regexp.ruby, punctuation.definition.group.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.constant.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.arrow.haskell, \
   keyword.other.big-arrow.haskell, keyword.other.double-colon.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.haskell, string.quoted.double.haskell, \
   string.quoted.single.haskell, punctuation.definition.string.begin.haskell, \
   punctuation.definition.string.end.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.namespace, meta.preprocessor.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.import.julia, \
   keyword.control.export.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.storage.modifier.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.macro.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.period.elm\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.elm\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.r, variable.function.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.namespace.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.module-function.erlang, \
   punctuation.section.directive.begin.erlang\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.directive.erlang, \
   keyword.control.directive.define.erlang\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.class.module.erlang\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.erlang, \
   string.quoted.single.erlang, punctuation.definition.string.begin.erlang, \
   punctuation.definition.string.end.erlang\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.directive.export.erlang, \
   keyword.control.directive.module.erlang, \
   keyword.control.directive.import.erlang, \
   keyword.control.directive.behaviour.erlang\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.readwrite.module.elixir, \
   punctuation.definition.variable.elixir\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.elixir\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.module.elixir\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.value-signature.ocaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.ocaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.variant.ocaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.sub.perl, \
   storage.type.declare.routine.perl\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.lisp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function-type.lisp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.constant.lisp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.lisp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.keyword.clojure, support.variable.clojure, \
   meta.definition.variable.clojure\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.global.clojure\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.clojure\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.scope.if-block.shell, meta.scope.group.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.builtin.shell, \
   entity.name.function.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.shell, \
   string.quoted.single.shell, punctuation.definition.string.begin.shell, \
   punctuation.definition.string.end.shell, string.unquoted.heredoc.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.heredoc-token.shell, \
   variable.other.normal.shell, punctuation.definition.variable.shell, \
   variable.other.special.shell, variable.other.positional.shell, \
   variable.other.bracket.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.builtin.fish\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.unix.fish\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.normal.fish, \
   punctuation.definition.variable.fish, variable.other.fixed.fish, \
   variable.other.special.fish\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.fish, \
   punctuation.definition.string.end.fish, \
   punctuation.definition.string.begin.fish, string.quoted.single.fish\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape.single.fish\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.variable.powershell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.powershell, \
   support.function.attribute.powershell, support.function.powershell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.single.powershell, \
   string.quoted.double.powershell, \
   punctuation.definition.string.begin.powershell, \
   punctuation.definition.string.end.powershell, \
   string.quoted.double.heredoc.powershell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.member.powershell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.alias.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3c6aa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.type.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.fragment.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.target.makefile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.makefile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.scope.prerequisites.makefile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.source.cmake\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.source.cmake\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.source.cmake\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.map.viml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.map.viml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.map.viml, \
   constant.character.map.key.viml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.map.special.viml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.tmux, constant.numeric.tmux\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.package-manager.dockerfile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.flag.dockerfile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.dockerfile, \
   string.quoted.single.dockerfile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape.dockerfile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.base-image.dockerfile, \
   entity.name.image.dockerfile\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.separator.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted.diff, \
   punctuation.definition.deleted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.diff.range.context, \
   punctuation.definition.range.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.diff.header.from-file\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted.diff, \
   punctuation.definition.inserted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed.diff, \
   punctuation.definition.changed.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.from-file.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.section.group-title.ini, \
   punctuation.definition.entity.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e67e80\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.key-value.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.ini, string.quoted.single.ini, \
   punctuation.definition.string.begin.ini, \
   punctuation.definition.string.end.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.definition.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.aggregate.sql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.single.sql, \
   punctuation.definition.string.end.sql, \
   punctuation.definition.string.begin.sql, string.quoted.double.sql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#dbbc7f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.enum.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.support.type.property-name.begin.json, \
   punctuation.support.type.property-name.end.json, \
   punctuation.separator.dictionary.key-value.json, \
   punctuation.definition.string.begin.json, \
   punctuation.definition.string.end.json, \
   punctuation.separator.dictionary.pair.json, \
   punctuation.separator.array.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.key-value.mapping.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.plain.out.yaml, \
   string.quoted.single.yaml, string.quoted.double.yaml, \
   punctuation.definition.string.begin.yaml, \
   punctuation.definition.string.end.yaml, string.unquoted.plain.in.yaml, \
   string.unquoted.block.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.anchor.yaml, \
   punctuation.definition.block.sequence.item.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83c092\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.key.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e69875\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.single.basic.line.toml, \
   string.quoted.single.literal.line.toml, \
   punctuation.definition.keyValuePair.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a7c080\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.boolean.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7fbbb3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.table.toml, \
   punctuation.definition.table.toml, \
   entity.other.attribute-name.table.array.toml, \
   punctuation.definition.table.array.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d699b6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment, string.comment, \
   punctuation.definition.comment\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#859289\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let ayu_dark =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#10141c\",\n\
  \      \"editor.foreground\": \"#bfbdb6\"\n\
  \    },\n\
  \    \"name\": \"ayu-dark\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"settings\": {\n\
  \          \"background\": \"#0d1017\",\n\
  \          \"foreground\": \"#bfbdb6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"constant.other.symbol\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#aad94c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.regexp\",\n\
  \          \"constant.character\",\n\
  \          \"constant.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#95e6cb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d2a6ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d2a6ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable\",\n\
  \          \"variable.parameter.function-call\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bfbdb6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.member\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f07178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f29668\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.separator\",\n\
  \          \"punctuation.terminator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bfbdb6b3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bfbdb6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.accessor\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f29668\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.template-expression\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bfbdb6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java storage.type\",\n\
  \          \"source.haskell storage.type\",\n\
  \          \"source.c storage.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#59c2ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.inherited-class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java storage.type.primitive\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffb454\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter\",\n\
  \          \"meta.parameter\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d2a6ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.function\",\n\
  \          \"variable.annotation\",\n\
  \          \"meta.function-call.generic\",\n\
  \          \"support.function.go\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffb454\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.function\",\n\
  \          \"support.macro\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f07178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.import\",\n\
  \          \"entity.name.package\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#aad94c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#59c2ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag\",\n\
  \          \"meta.tag.sgml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.component\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#59c2ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.tag.end\",\n\
  \          \"punctuation.definition.tag.begin\",\n\
  \          \"punctuation.definition.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae680\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffb454\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.pseudo-class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#95e6cb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f29668\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type\",\n\
  \          \"support.class\",\n\
  \          \"source.go storage.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.decorator variable.other\",\n\
  \          \"meta.decorator punctuation.decorator\",\n\
  \          \"storage.type.annotation\",\n\
  \          \"entity.name.function.decorator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e6c08a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"invalid\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d95757\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.diff\",\n\
  \          \"meta.diff.header\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c594c5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ruby variable.other.readwrite\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffb454\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css entity.name.tag\",\n\
  \          \"source.sass entity.name.tag\",\n\
  \          \"source.scss entity.name.tag\",\n\
  \          \"source.less entity.name.tag\",\n\
  \          \"source.stylus entity.name.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#59c2ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css support.type\",\n\
  \          \"source.sass support.type\",\n\
  \          \"source.scss support.type\",\n\
  \          \"source.less support.type\",\n\
  \          \"source.stylus support.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"normal\",\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric.line-number.find-in-files - match\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric.line-number.match\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ff8f40\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.filename.find-in-files\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#aad94c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"message.error\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d95757\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.heading\",\n\
  \          \"markup.heading entity.name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#aad94c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.underline.link\",\n\
  \          \"string.other.link\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.italic\",\n\
  \          \"emphasis\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f07178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.bold\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#f07178\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.underline\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.italic markup.bold\",\n\
  \          \"markup.bold markup.italic\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.raw\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#bfbdb605\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.raw.inline\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#bfbdb60f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.separator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#bfbdb60f\",\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.quote\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#95e6cb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.list punctuation.definition.list.begin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffb454\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.inserted\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#70bf56\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.changed\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#73b8ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.deleted\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f26d78\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.strike\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e6c08a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.strong\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.table\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#bfbdb60f\",\n\
  \          \"foreground\": \"#39bae6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown markup.inline.raw\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f29668\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown meta.dummy.line-break\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#5a6673\",\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"background\": \"#bfbdb6\",\n\
  \          \"foreground\": \"#5a6673\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let catppuccin_mocha =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#1e1e2e\",\n\
  \      \"editor.foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"name\": \"catppuccin-mocha\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text\",\n\
  \          \"source\",\n\
  \          \"variable.other.readwrite\",\n\
  \          \"punctuation.definition.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#9399b2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"punctuation.definition.comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#9399b2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"punctuation.definition.string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\",\n\
  \          \"variable.other.constant\",\n\
  \          \"entity.name.constant\",\n\
  \          \"constant.language.boolean\",\n\
  \          \"constant.language.false\",\n\
  \          \"constant.language.true\",\n\
  \          \"keyword.other.unit.user-defined\",\n\
  \          \"keyword.other.unit.suffix.floating-point\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword\",\n\
  \          \"keyword.operator.word\",\n\
  \          \"keyword.operator.new\",\n\
  \          \"variable.language.super\",\n\
  \          \"support.type.primitive\",\n\
  \          \"storage.type\",\n\
  \          \"storage.modifier\",\n\
  \          \"punctuation.definition.keyword\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.documentation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator\",\n\
  \          \"punctuation.accessor\",\n\
  \          \"punctuation.definition.generic\",\n\
  \          \"meta.function.closure punctuation.section.parameters\",\n\
  \          \"punctuation.definition.tag\",\n\
  \          \"punctuation.separator.key-value\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"meta.function-call.method\",\n\
  \          \"support.function\",\n\
  \          \"support.function.misc\",\n\
  \          \"variable.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.class\",\n\
  \          \"entity.other.inherited-class\",\n\
  \          \"support.class\",\n\
  \          \"meta.function-call.constructor\",\n\
  \          \"entity.name.struct\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.enum\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.enum variable.other.readwrite\",\n\
  \          \"variable.other.enummember\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.property.object\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.type\",\n\
  \          \"meta.type-alias\",\n\
  \          \"support.type\",\n\
  \          \"entity.name.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.annotation variable.function\",\n\
  \          \"meta.annotation variable.annotation.function\",\n\
  \          \"meta.annotation punctuation.definition.annotation\",\n\
  \          \"meta.decorator\",\n\
  \          \"punctuation.decorator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter\",\n\
  \          \"meta.function.parameters\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language\",\n\
  \          \"support.function.builtin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.documentation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.directive\",\n\
  \          \"punctuation.definition.directive\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.typeparameters\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.namespace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name.css\",\n\
  \          \"support.type.property-name.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.language.this\",\n\
  \          \"variable.language.this punctuation.definition.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.object.property\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.template variable\",\n\
  \          \"string variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.new\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.specifier.extern.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.scope-resolution.template.call.cpp\",\n\
  \          \"entity.name.scope-resolution.parameter.cpp\",\n\
  \          \"entity.name.scope-resolution.cpp\",\n\
  \          \"entity.name.scope-resolution.function.definition.cpp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.class.doxygen\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.reference.cpp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.interpolation.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.block.documentation.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css entity.other.attribute-name.class.css\",\n\
  \          \"entity.other.attribute-name.parent-selector.css \
   punctuation.definition.entity.css\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.operator.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css constant.other.unicode-range\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css variable.parameter.url\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.vendored.property-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css meta.property-value variable\",\n\
  \          \"source.css meta.property-value variable.other.less\",\n\
  \          \"source.css meta.property-value variable.other.less \
   punctuation.definition.variable.less\",\n\
  \          \"meta.definition.variable.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css meta.property-list variable\",\n\
  \          \"meta.property-list variable.other.less\",\n\
  \          \"meta.property-list variable.other.less \
   punctuation.definition.variable.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit.percentage.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css meta.attribute-selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.definition.ini\",\n\
  \          \"punctuation.support.type.property-name.json\",\n\
  \          \"support.type.property-name.json\",\n\
  \          \"punctuation.support.type.property-name.toml\",\n\
  \          \"support.type.property-name.toml\",\n\
  \          \"entity.name.tag.yaml\",\n\
  \          \"punctuation.support.type.property-name.yaml\",\n\
  \          \"support.type.property-name.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.json\",\n\
  \          \"constant.language.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.type.anchor.yaml\",\n\
  \          \"variable.other.alias.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name.table\",\n\
  \          \"entity.name.section.group-title.ini\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.time.datetime.offset.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.anchor.yaml\",\n\
  \          \"punctuation.definition.alias.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.document.begin.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.diff.header.from-file\",\n\
  \          \"meta.diff.header.to-file\",\n\
  \          \"punctuation.definition.from-file.diff\",\n\
  \          \"punctuation.definition.to-file.diff\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.env\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.quoted variable.other.env\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.builtin.gdscript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.gdscript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment meta.annotation.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment meta.annotation.parameters.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.alias.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f2cdcd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.enum.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.objectvalues.graphql constant.object.key.graphql \
   string.unquoted.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f2cdcd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.doctype\",\n\
  \          \"meta.tag.sgml.doctype punctuation.definition.tag\",\n\
  \          \"meta.tag.metadata.doctype entity.name.tag\",\n\
  \          \"meta.tag.metadata.doctype punctuation.definition.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html constant.character.entity\",\n\
  \          \"text.html constant.character.entity punctuation\",\n\
  \          \"constant.character.entity.xml\",\n\
  \          \"constant.character.entity.xml punctuation\",\n\
  \          \"constant.character.entity.js.jsx\",\n\
  \          \"constant.charactger.entity.js.jsx punctuation\",\n\
  \          \"constant.character.entity.tsx\",\n\
  \          \"constant.character.entity.tsx punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.component\",\n\
  \          \"support.class.component.jsx\",\n\
  \          \"support.class.component.tsx\",\n\
  \          \"support.class.component.vue\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.annotation\",\n\
  \          \"storage.type.annotation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.enum.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.import.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.block.javadoc.java \
   keyword.other.documentation.javadoc.java\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.export variable.other.readwrite.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant.js\",\n\
  \          \"variable.other.constant.ts\",\n\
  \          \"variable.other.property.js\",\n\
  \          \"variable.other.property.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.jsdoc\",\n\
  \          \"comment.block.documentation variable.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.class.jsdoc\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.object.console.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.node\",\n\
  \          \"support.type.object.module.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.implements\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.null.js\",\n\
  \          \"constant.language.null.ts\",\n\
  \          \"constant.language.undefined.js\",\n\
  \          \"constant.language.undefined.ts\",\n\
  \          \"support.type.builtin.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.generic\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.declaration.function.arrow.js\",\n\
  \          \"storage.type.function.arrow.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.decorator.ts\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.expression.in.js\",\n\
  \          \"keyword.operator.expression.in.ts\",\n\
  \          \"keyword.operator.expression.infer.ts\",\n\
  \          \"keyword.operator.expression.instanceof.js\",\n\
  \          \"keyword.operator.expression.instanceof.ts\",\n\
  \          \"keyword.operator.expression.is\",\n\
  \          \"keyword.operator.expression.keyof.ts\",\n\
  \          \"keyword.operator.expression.of.js\",\n\
  \          \"keyword.operator.expression.of.ts\",\n\
  \          \"keyword.operator.expression.typeof.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.macro.julia\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.symbol.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.tex keyword.control.preamble\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.tex support.function.be\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.general.math.tex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f2cdcd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.liquid\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.line.double-dash.documentation.lua \
   storage.type.annotation.lua\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment.line.double-dash.documentation.lua \
   entity.name.variable.lua\",\n\
  \          \"comment.line.double-dash.documentation.lua variable.lua\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.1.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.1.markdown\",\n\
  \          \"heading.1.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.1.quarto\",\n\
  \          \"markup.heading.atx.1.mdx\",\n\
  \          \"markup.heading.atx.1.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.setext.1.markdown\",\n\
  \          \"markup.heading.heading-0.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.2.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.2.markdown\",\n\
  \          \"heading.2.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.2.quarto\",\n\
  \          \"markup.heading.atx.2.mdx\",\n\
  \          \"markup.heading.atx.2.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.setext.2.markdown\",\n\
  \          \"markup.heading.heading-1.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.3.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.3.markdown\",\n\
  \          \"heading.3.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.3.quarto\",\n\
  \          \"markup.heading.atx.3.mdx\",\n\
  \          \"markup.heading.atx.3.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-2.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.4.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.4.markdown\",\n\
  \          \"heading.4.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.4.quarto\",\n\
  \          \"markup.heading.atx.4.mdx\",\n\
  \          \"markup.heading.atx.4.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-3.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.5.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.5.markdown\",\n\
  \          \"heading.5.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.5.quarto\",\n\
  \          \"markup.heading.atx.5.mdx\",\n\
  \          \"markup.heading.atx.5.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-4.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#74c7ec\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.6.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.6.markdown\",\n\
  \          \"heading.6.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.6.quarto\",\n\
  \          \"markup.heading.atx.6.mdx\",\n\
  \          \"markup.heading.atx.6.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-5.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b4befe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.strikethrough\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"strikethrough\",\n\
  \          \"foreground\": \"#a6adc8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.link\",\n\
  \          \"markup.underline.link\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown punctuation.definition.link.title\",\n\
  \          \"text.html.quarto punctuation.definition.link.title\",\n\
  \          \"string.other.link.title.markdown\",\n\
  \          \"string.other.link.title.quarto\",\n\
  \          \"markup.link\",\n\
  \          \"punctuation.definition.constant.markdown\",\n\
  \          \"punctuation.definition.constant.quarto\",\n\
  \          \"constant.other.reference.link.markdown\",\n\
  \          \"constant.other.reference.link.quarto\",\n\
  \          \"markup.substitution.attribute-reference\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b4befe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.raw.markdown\",\n\
  \          \"punctuation.definition.raw.quarto\",\n\
  \          \"markup.inline.raw.string.markdown\",\n\
  \          \"markup.inline.raw.string.quarto\",\n\
  \          \"markup.raw.block.markdown\",\n\
  \          \"markup.raw.block.quarto\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"fenced_code.block.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.fenced_code.block punctuation.definition\",\n\
  \          \"markup.raw support.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9399b2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.quote\",\n\
  \          \"punctuation.definition.quote.begin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.separator.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.list.begin.markdown\",\n\
  \          \"punctuation.definition.list.begin.quarto\",\n\
  \          \"markup.list.bullet\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading.quarto\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.multipart.nix\",\n\
  \          \"entity.other.attribute-name.single.nix\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.name.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.embedded variable.parameter.name.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#b4befe\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.path.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.attribute.builtin\",\n\
  \          \"meta.attribute.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.parameters.php \
   punctuation.definition.variable.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.php support.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.phpdoc.php\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.variable.magic.python\",\n\
  \          \"meta.function-call.arguments.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.function.magic.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter.function.language.special.self.python\",\n\
  \          \"variable.language.special.self.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.flow.python\",\n\
  \          \"keyword.operator.logical.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.token.decorator.python\",\n\
  \          \"meta.function.decorator.identifier.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function-call.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.decorator.python\",\n\
  \          \"punctuation.definition.decorator.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.exception.python\",\n\
  \          \"support.function.builtin.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.indexed-name.python\",\n\
  \          \"meta.item-access.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.string.python\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.parameters.python\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.arguments.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.regexp punctuation.definition.string.begin\",\n\
  \          \"string.regexp punctuation.definition.string.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.anchor.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.regexp\",\n\
  \          \"keyword.other.back-reference.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6e3a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.character-class.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.character-class.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.character-class.range.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5e0dc\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.numeric.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.no-capture.regexp\",\n\
  \          \"meta.assertion.look-ahead.regexp\",\n\
  \          \"meta.assertion.negative-look-ahead.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.annotation.rust\",\n\
  \          \"meta.annotation.rust punctuation\",\n\
  \          \"meta.attribute.rust\",\n\
  \          \"punctuation.definition.attribute.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.attribute.rust string.quoted.double.rust\",\n\
  \          \"meta.attribute.rust string.quoted.single.char.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.macro.rules.rust\",\n\
  \          \"storage.type.module.rust\",\n\
  \          \"storage.modifier.rust\",\n\
  \          \"storage.type.struct.rust\",\n\
  \          \"storage.type.enum.rust\",\n\
  \          \"storage.type.trait.rust\",\n\
  \          \"storage.type.union.rust\",\n\
  \          \"storage.type.impl.rust\",\n\
  \          \"storage.type.rust\",\n\
  \          \"storage.type.function.rust\",\n\
  \          \"storage.type.type.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.numeric.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.generic.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.impl.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.module.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.trait.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.source.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.union.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f9e2af\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.enum.rust storage.type.source.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.macro.rust\",\n\
  \          \"meta.macro.rust support.function.rust\",\n\
  \          \"entity.name.function.macro.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.lifetime.rust\",\n\
  \          \"entity.name.type.lifetime\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.rust \
   constant.other.placeholder.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.return-type.rust meta.generic.rust \
   storage.type.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.call.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89b4fa\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.brackets.angle.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#89dceb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.caps.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function.definition.rust variable.other.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eba0ac\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.call.rust variable.other.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.self.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.metavariable.name.rust\",\n\
  \          \"meta.macro.metavariable.rust keyword.operator.macro.dollar.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment.line.shebang\",\n\
  \          \"comment.line.shebang punctuation.definition.comment\",\n\
  \          \"comment.line.shebang\",\n\
  \          \"punctuation.definition.comment.shebang.shell\",\n\
  \          \"meta.shebang.shell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f5c2e7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.line.shebang constant.language\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.string meta.interpolation.parameter.shell \
   variable.other.readwrite\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#fab387\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.shell punctuation.section.interpolation\",\n\
  \          \"punctuation.definition.evaluation.backticks.shell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#94e2d5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.heredoc.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cba6f7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.shell \
   variable.other.normal.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cdd6f4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.heading.typst\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f38ba8\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let catppuccin_macchiato =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#24273a\",\n\
  \      \"editor.foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"name\": \"catppuccin-macchiato\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text\",\n\
  \          \"source\",\n\
  \          \"variable.other.readwrite\",\n\
  \          \"punctuation.definition.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#939ab7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"punctuation.definition.comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#939ab7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"punctuation.definition.string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\",\n\
  \          \"variable.other.constant\",\n\
  \          \"entity.name.constant\",\n\
  \          \"constant.language.boolean\",\n\
  \          \"constant.language.false\",\n\
  \          \"constant.language.true\",\n\
  \          \"keyword.other.unit.user-defined\",\n\
  \          \"keyword.other.unit.suffix.floating-point\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword\",\n\
  \          \"keyword.operator.word\",\n\
  \          \"keyword.operator.new\",\n\
  \          \"variable.language.super\",\n\
  \          \"support.type.primitive\",\n\
  \          \"storage.type\",\n\
  \          \"storage.modifier\",\n\
  \          \"punctuation.definition.keyword\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.documentation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator\",\n\
  \          \"punctuation.accessor\",\n\
  \          \"punctuation.definition.generic\",\n\
  \          \"meta.function.closure punctuation.section.parameters\",\n\
  \          \"punctuation.definition.tag\",\n\
  \          \"punctuation.separator.key-value\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"meta.function-call.method\",\n\
  \          \"support.function\",\n\
  \          \"support.function.misc\",\n\
  \          \"variable.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.class\",\n\
  \          \"entity.other.inherited-class\",\n\
  \          \"support.class\",\n\
  \          \"meta.function-call.constructor\",\n\
  \          \"entity.name.struct\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.enum\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.enum variable.other.readwrite\",\n\
  \          \"variable.other.enummember\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.property.object\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.type\",\n\
  \          \"meta.type-alias\",\n\
  \          \"support.type\",\n\
  \          \"entity.name.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.annotation variable.function\",\n\
  \          \"meta.annotation variable.annotation.function\",\n\
  \          \"meta.annotation punctuation.definition.annotation\",\n\
  \          \"meta.decorator\",\n\
  \          \"punctuation.decorator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter\",\n\
  \          \"meta.function.parameters\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language\",\n\
  \          \"support.function.builtin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.documentation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.directive\",\n\
  \          \"punctuation.definition.directive\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.typeparameters\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.namespace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name.css\",\n\
  \          \"support.type.property-name.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.language.this\",\n\
  \          \"variable.language.this punctuation.definition.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.object.property\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.template variable\",\n\
  \          \"string variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.new\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.specifier.extern.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.scope-resolution.template.call.cpp\",\n\
  \          \"entity.name.scope-resolution.parameter.cpp\",\n\
  \          \"entity.name.scope-resolution.cpp\",\n\
  \          \"entity.name.scope-resolution.function.definition.cpp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.class.doxygen\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.reference.cpp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.interpolation.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.block.documentation.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css entity.other.attribute-name.class.css\",\n\
  \          \"entity.other.attribute-name.parent-selector.css \
   punctuation.definition.entity.css\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.operator.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css constant.other.unicode-range\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css variable.parameter.url\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.vendored.property-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css meta.property-value variable\",\n\
  \          \"source.css meta.property-value variable.other.less\",\n\
  \          \"source.css meta.property-value variable.other.less \
   punctuation.definition.variable.less\",\n\
  \          \"meta.definition.variable.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css meta.property-list variable\",\n\
  \          \"meta.property-list variable.other.less\",\n\
  \          \"meta.property-list variable.other.less \
   punctuation.definition.variable.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit.percentage.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css meta.attribute-selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.definition.ini\",\n\
  \          \"punctuation.support.type.property-name.json\",\n\
  \          \"support.type.property-name.json\",\n\
  \          \"punctuation.support.type.property-name.toml\",\n\
  \          \"support.type.property-name.toml\",\n\
  \          \"entity.name.tag.yaml\",\n\
  \          \"punctuation.support.type.property-name.yaml\",\n\
  \          \"support.type.property-name.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.json\",\n\
  \          \"constant.language.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.type.anchor.yaml\",\n\
  \          \"variable.other.alias.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.property-name.table\",\n\
  \          \"entity.name.section.group-title.ini\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.time.datetime.offset.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.anchor.yaml\",\n\
  \          \"punctuation.definition.alias.yaml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.document.begin.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.diff.header.from-file\",\n\
  \          \"meta.diff.header.to-file\",\n\
  \          \"punctuation.definition.from-file.diff\",\n\
  \          \"punctuation.definition.to-file.diff\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.env\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.quoted variable.other.env\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.builtin.gdscript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.gdscript\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment meta.annotation.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment meta.annotation.parameters.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.alias.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f0c6c6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.enum.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.objectvalues.graphql constant.object.key.graphql \
   string.unquoted.graphql\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f0c6c6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.doctype\",\n\
  \          \"meta.tag.sgml.doctype punctuation.definition.tag\",\n\
  \          \"meta.tag.metadata.doctype entity.name.tag\",\n\
  \          \"meta.tag.metadata.doctype punctuation.definition.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html constant.character.entity\",\n\
  \          \"text.html constant.character.entity punctuation\",\n\
  \          \"constant.character.entity.xml\",\n\
  \          \"constant.character.entity.xml punctuation\",\n\
  \          \"constant.character.entity.js.jsx\",\n\
  \          \"constant.charactger.entity.js.jsx punctuation\",\n\
  \          \"constant.character.entity.tsx\",\n\
  \          \"constant.character.entity.tsx punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.component\",\n\
  \          \"support.class.component.jsx\",\n\
  \          \"support.class.component.tsx\",\n\
  \          \"support.class.component.vue\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.annotation\",\n\
  \          \"storage.type.annotation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.enum.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.import.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.block.javadoc.java \
   keyword.other.documentation.javadoc.java\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.export variable.other.readwrite.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant.js\",\n\
  \          \"variable.other.constant.ts\",\n\
  \          \"variable.other.property.js\",\n\
  \          \"variable.other.property.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.jsdoc\",\n\
  \          \"comment.block.documentation variable.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.class.jsdoc\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.object.console.js\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.node\",\n\
  \          \"support.type.object.module.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.implements\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.null.js\",\n\
  \          \"constant.language.null.ts\",\n\
  \          \"constant.language.undefined.js\",\n\
  \          \"constant.language.undefined.ts\",\n\
  \          \"support.type.builtin.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.generic\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.declaration.function.arrow.js\",\n\
  \          \"storage.type.function.arrow.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.decorator.ts\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.expression.in.js\",\n\
  \          \"keyword.operator.expression.in.ts\",\n\
  \          \"keyword.operator.expression.infer.ts\",\n\
  \          \"keyword.operator.expression.instanceof.js\",\n\
  \          \"keyword.operator.expression.instanceof.ts\",\n\
  \          \"keyword.operator.expression.is\",\n\
  \          \"keyword.operator.expression.keyof.ts\",\n\
  \          \"keyword.operator.expression.of.js\",\n\
  \          \"keyword.operator.expression.of.ts\",\n\
  \          \"keyword.operator.expression.typeof.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.macro.julia\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.symbol.julia\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.tex keyword.control.preamble\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.tex support.function.be\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.general.math.tex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f0c6c6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.liquid\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.line.double-dash.documentation.lua \
   storage.type.annotation.lua\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment.line.double-dash.documentation.lua \
   entity.name.variable.lua\",\n\
  \          \"comment.line.double-dash.documentation.lua variable.lua\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.1.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.1.markdown\",\n\
  \          \"heading.1.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.1.quarto\",\n\
  \          \"markup.heading.atx.1.mdx\",\n\
  \          \"markup.heading.atx.1.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.setext.1.markdown\",\n\
  \          \"markup.heading.heading-0.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.2.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.2.markdown\",\n\
  \          \"heading.2.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.2.quarto\",\n\
  \          \"markup.heading.atx.2.mdx\",\n\
  \          \"markup.heading.atx.2.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.setext.2.markdown\",\n\
  \          \"markup.heading.heading-1.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.3.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.3.markdown\",\n\
  \          \"heading.3.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.3.quarto\",\n\
  \          \"markup.heading.atx.3.mdx\",\n\
  \          \"markup.heading.atx.3.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-2.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.4.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.4.markdown\",\n\
  \          \"heading.4.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.4.quarto\",\n\
  \          \"markup.heading.atx.4.mdx\",\n\
  \          \"markup.heading.atx.4.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-3.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.5.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.5.markdown\",\n\
  \          \"heading.5.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.5.quarto\",\n\
  \          \"markup.heading.atx.5.mdx\",\n\
  \          \"markup.heading.atx.5.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-4.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7dc4e4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"heading.6.markdown punctuation.definition.heading.markdown\",\n\
  \          \"heading.6.markdown\",\n\
  \          \"heading.6.quarto punctuation.definition.heading.quarto\",\n\
  \          \"heading.6.quarto\",\n\
  \          \"markup.heading.atx.6.mdx\",\n\
  \          \"markup.heading.atx.6.mdx punctuation.definition.heading.mdx\",\n\
  \          \"markup.heading.heading-5.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b7bdf8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.strikethrough\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"strikethrough\",\n\
  \          \"foreground\": \"#a5adcb\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.link\",\n\
  \          \"markup.underline.link\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown punctuation.definition.link.title\",\n\
  \          \"text.html.quarto punctuation.definition.link.title\",\n\
  \          \"string.other.link.title.markdown\",\n\
  \          \"string.other.link.title.quarto\",\n\
  \          \"markup.link\",\n\
  \          \"punctuation.definition.constant.markdown\",\n\
  \          \"punctuation.definition.constant.quarto\",\n\
  \          \"constant.other.reference.link.markdown\",\n\
  \          \"constant.other.reference.link.quarto\",\n\
  \          \"markup.substitution.attribute-reference\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b7bdf8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.raw.markdown\",\n\
  \          \"punctuation.definition.raw.quarto\",\n\
  \          \"markup.inline.raw.string.markdown\",\n\
  \          \"markup.inline.raw.string.quarto\",\n\
  \          \"markup.raw.block.markdown\",\n\
  \          \"markup.raw.block.quarto\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"fenced_code.block.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.fenced_code.block punctuation.definition\",\n\
  \          \"markup.raw support.asciidoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#939ab7\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.quote\",\n\
  \          \"punctuation.definition.quote.begin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.separator.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.list.begin.markdown\",\n\
  \          \"punctuation.definition.list.begin.quarto\",\n\
  \          \"markup.list.bullet\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading.quarto\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.multipart.nix\",\n\
  \          \"entity.other.attribute-name.single.nix\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.name.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.embedded variable.parameter.name.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#b7bdf8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.path.nix\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.attribute.builtin\",\n\
  \          \"meta.attribute.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.parameters.php \
   punctuation.definition.variable.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.php support.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.phpdoc.php\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.variable.magic.python\",\n\
  \          \"meta.function-call.arguments.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.function.magic.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter.function.language.special.self.python\",\n\
  \          \"variable.language.special.self.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.flow.python\",\n\
  \          \"keyword.operator.logical.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.function.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.token.decorator.python\",\n\
  \          \"meta.function.decorator.identifier.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function-call.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.decorator.python\",\n\
  \          \"punctuation.definition.decorator.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.exception.python\",\n\
  \          \"support.function.builtin.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.indexed-name.python\",\n\
  \          \"meta.item-access.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.string.python\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.parameters.python\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.arguments.r\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.regexp punctuation.definition.string.begin\",\n\
  \          \"string.regexp punctuation.definition.string.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.anchor.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.regexp\",\n\
  \          \"keyword.other.back-reference.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a6da95\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.character-class.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.character-class.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.character-class.range.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f4dbd6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.numeric.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.group.no-capture.regexp\",\n\
  \          \"meta.assertion.look-ahead.regexp\",\n\
  \          \"meta.assertion.negative-look-ahead.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.annotation.rust\",\n\
  \          \"meta.annotation.rust punctuation\",\n\
  \          \"meta.attribute.rust\",\n\
  \          \"punctuation.definition.attribute.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.attribute.rust string.quoted.double.rust\",\n\
  \          \"meta.attribute.rust string.quoted.single.char.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.macro.rules.rust\",\n\
  \          \"storage.type.module.rust\",\n\
  \          \"storage.modifier.rust\",\n\
  \          \"storage.type.struct.rust\",\n\
  \          \"storage.type.enum.rust\",\n\
  \          \"storage.type.trait.rust\",\n\
  \          \"storage.type.union.rust\",\n\
  \          \"storage.type.impl.rust\",\n\
  \          \"storage.type.rust\",\n\
  \          \"storage.type.function.rust\",\n\
  \          \"storage.type.type.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.numeric.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\",\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.generic.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.impl.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.module.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.trait.rust\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.source.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.union.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#eed49f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.enum.rust storage.type.source.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.macro.rust\",\n\
  \          \"meta.macro.rust support.function.rust\",\n\
  \          \"entity.name.function.macro.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.lifetime.rust\",\n\
  \          \"entity.name.type.lifetime\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.rust \
   constant.other.placeholder.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.return-type.rust meta.generic.rust \
   storage.type.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.call.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8aadf4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.brackets.angle.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#91d7e3\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.caps.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function.definition.rust variable.other.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ee99a0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.call.rust variable.other.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.self.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.metavariable.name.rust\",\n\
  \          \"meta.macro.metavariable.rust keyword.operator.macro.dollar.rust\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment.line.shebang\",\n\
  \          \"comment.line.shebang punctuation.definition.comment\",\n\
  \          \"comment.line.shebang\",\n\
  \          \"punctuation.definition.comment.shebang.shell\",\n\
  \          \"meta.shebang.shell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f5bde6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.line.shebang constant.language\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \          \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.string meta.interpolation.parameter.shell \
   variable.other.readwrite\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#f5a97f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.shell punctuation.section.interpolation\",\n\
  \          \"punctuation.definition.evaluation.backticks.shell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8bd5ca\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag.heredoc.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c6a0f6\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.shell \
   variable.other.normal.shell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cad3f5\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.heading.typst\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ed8796\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let gruvbox_dark_medium =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#282828\",\n\
  \      \"editor.foreground\": \"#ebdbb2\"\n\
  \    },\n\
  \    \"name\": \"gruvbox-dark-medium\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"emphasis\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"strong\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"header\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#458588\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"punctuation.definition.comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#928374\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant\",\n\
  \          \"support.constant\",\n\
  \          \"variable.arguments\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.rgb-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag\",\n\
  \          \"punctuation.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"invalid\",\n\
  \          \"invalid.illegal\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#cc241d\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.deprecated\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b16286\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.header.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type\",\n\
  \          \"storage.modifier\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quasi\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.entity\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"object\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"module.node\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#689d6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.module\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.less\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d79921\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.new\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"metatag.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#689d6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.sha.git-rebase\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.type.name\",\n\
  \          \"meta.return.type\",\n\
  \          \"meta.return-type\",\n\
  \          \"meta.cast\",\n\
  \          \"meta.type.annotation\",\n\
  \          \"support.type\",\n\
  \          \"storage.type.cs\",\n\
  \          \"variable.class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.this\",\n\
  \          \"support.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name\",\n\
  \          \"entity.static\",\n\
  \          \"entity.name.class.static.function\",\n\
  \          \"entity.name.function\",\n\
  \          \"entity.name.class\",\n\
  \          \"entity.name.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.function\",\n\
  \          \"entity.name.function.static\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.function-call\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.builtin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.method\",\n\
  \          \"entity.name.method.function-call\",\n\
  \          \"entity.name.static.function-call\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#689d6a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"brace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d5c4a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.parameter.type.variable\",\n\
  \          \"variable.parameter\",\n\
  \          \"variable.name\",\n\
  \          \"variable.other\",\n\
  \          \"variable\",\n\
  \          \"string.constant.other.placeholder\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"prototype\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#a89984\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.quoted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.quasi\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"*url*\",\n\
  \          \"*link*\",\n\
  \          \"*uri*\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function.python\",\n\
  \          \"entity.name.function.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type.function.python\",\n\
  \          \"storage.modifier.declaration\",\n\
  \          \"storage.type.class.python\",\n\
  \          \"storage.type.string.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type.function.async.python\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.generic\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.arguments\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d5c4a1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.decorator\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.caps\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.logical\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.logical-expression\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.interpolated.dollar.shell\",\n\
  \          \"string.interpolated.backtick.shell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control.directive\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.C99\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.function.cs\",\n\
  \          \"entity.name.function.cs\",\n\
  \          \"entity.name.type.namespace.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.using.cs\",\n\
  \          \"entity.name.variable.field.cs\",\n\
  \          \"entity.name.variable.local.cs\",\n\
  \          \"variable.other.readwrite.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.this.cs\",\n\
  \          \"keyword.other.base.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.scope.prerequisites\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function.target\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.import.java\",\n\
  \          \"storage.modifier.package.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bdae93\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.import.java\",\n\
  \          \"keyword.other.package.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.annotation\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.documentation.javadoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.block.javadoc variable.parameter.java\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java variable.other.object\",\n\
  \          \"source.java variable.other.definition.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-parameters.lisp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.other.link.title.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\",\n\
  \          \"foreground\": \"#928374\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline.link\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.1.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.2.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.3.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.4.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.5.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"heading.6.markdown entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d65d0e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.punctuation.quote.beginning\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98971a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.punctuation.list.beginning\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.inline.raw\",\n\
  \          \"markup.fenced_code.block\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.quoted.double.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css meta.selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css support.function.transform\",\n\
  \          \"source.css support.function.timing-function\",\n\
  \          \"source.css support.function.misc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.property-value\",\n\
  \          \"constant.rgb-value\",\n\
  \          \"support.property-value.scss\",\n\
  \          \"constant.rgb-value.scss\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d65d0e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag.css\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html entity.name.tag\",\n\
  \          \"text.html punctuation.tag\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js variable.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts variable.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go storage.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go entity.name.import\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go keyword.package\",\n\
  \          \"source.go keyword.import\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go keyword.interface\",\n\
  \          \"source.go keyword.struct\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go entity.name.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebdbb2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.go entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.cucumber.table\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.reason string.double\",\n\
  \          \"source.reason string.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b8bb26\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.reason keyword.control.less\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.reason entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#83a598\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.reason support.property-value\",\n\
  \          \"source.reason entity.name.filename\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.powershell variable.other.member.powershell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.powershell support.function.powershell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fabd2f\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.powershell support.function.attribute.powershell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bdae93\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.powershell meta.hashtable.assignment.powershell \
   variable.other.readwrite.powershell\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.function.be.latex\",\n\
  \          \"support.function.general.tex\",\n\
  \          \"support.function.section.latex\",\n\
  \          \"support.function.textbf.latex\",\n\
  \          \"support.function.textit.latex\",\n\
  \          \"support.function.texttt.latex\",\n\
  \          \"support.function.emph.latex\",\n\
  \          \"support.function.url.latex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fb4934\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.math.block.tex\",\n\
  \          \"support.class.math.block.environment.latex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#fe8019\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.preamble.latex\",\n\
  \          \"keyword.control.include.latex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d3869b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.latex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8ec07c\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let kanagawa_wave =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#1F1F28\",\n\
  \      \"editor.foreground\": \"#DCD7BA\"\n\
  \    },\n\
  \    \"name\": \"kanagawa-wave\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"comment\",\n\
  \          \"punctuation.definition.comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#727169\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable\",\n\
  \          \"string constant.other.placeholder\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.color\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"invalid\",\n\
  \          \"invalid.illegal\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E82424\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.flow\",\n\
  \          \"keyword.control.conditional\",\n\
  \          \"keyword.control.loop\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control\",\n\
  \          \"constant.other.color\",\n\
  \          \"meta.tag\",\n\
  \          \"keyword.other.template\",\n\
  \          \"keyword.other.substitution\",\n\
  \          \"keyword.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.definition.ini\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.trycatch\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#FF5D62\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.unit\",\n\
  \          \"keyword.operator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation\",\n\
  \          \"punctuation.definition.tag\",\n\
  \          \"punctuation.separator.inheritance.php\",\n\
  \          \"punctuation.definition.tag.html\",\n\
  \          \"punctuation.definition.tag.begin.html\",\n\
  \          \"punctuation.definition.tag.end.html\",\n\
  \          \"punctuation.section.embedded\",\n\
  \          \"meta.brace\",\n\
  \          \"keyword.operator.type.annotation\",\n\
  \          \"keyword.operator.namespace\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#9CABCA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.tag\",\n\
  \          \"meta.tag.sgml\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"meta.function-call\",\n\
  \          \"variable.function\",\n\
  \          \"support.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7E9CD8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.special-method\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.macro\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E46876\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.block variable.other\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.enummember\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.other.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.other.link\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\",\n\
  \          \"constant.language\",\n\
  \          \"support.constant\",\n\
  \          \"constant.character\",\n\
  \          \"constant.escape\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.boolean\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D27E99\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string\",\n\
  \          \"punctuation.definition.string\",\n\
  \          \"constant.other.symbol\",\n\
  \          \"constant.other.key\",\n\
  \          \"entity.other.inherited-class\",\n\
  \          \"markup.heading\",\n\
  \          \"markup.inserted.git_gutter\",\n\
  \          \"meta.group.braces.curly constant.other.object.key.js \
   string.unquoted.label.js\",\n\
  \          \"markup.inline.raw.string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98BB6C\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name\",\n\
  \          \"support.type\",\n\
  \          \"support.class\",\n\
  \          \"support.other.namespace.use.php\",\n\
  \          \"meta.use.php\",\n\
  \          \"support.other.namespace.php\",\n\
  \          \"support.type.sys-types\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7AA89F\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.type.module\",\n\
  \          \"entity.name.namespace\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.import.go\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98BB6C\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.blade\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.property\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.import\",\n\
  \          \"keyword.import\",\n\
  \          \"meta.import\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css support.type.property-name\",\n\
  \          \"source.sass support.type.property-name\",\n\
  \          \"source.scss support.type.property-name\",\n\
  \          \"source.less support.type.property-name\",\n\
  \          \"source.stylus support.type.property-name\",\n\
  \          \"source.postcss support.type.property-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7AA89F\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.module.js\",\n\
  \          \"variable.import.parameter.js\",\n\
  \          \"variable.other.class.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FF5D62\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FF5D62\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.method.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.class-method.js entity.name.function.js\",\n\
  \          \"variable.function.constructor\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.sass keyword.control\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.inserted\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#76946A\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.deleted\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#C34043\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.changed\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCA561\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#C0A36E\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.escape\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"*url*\",\n\
  \          \"*link*\",\n\
  \          \"*uri*\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"tag.decorator.js entity.name.tag.js\",\n\
  \          \"tag.decorator.js punctuation.definition.tag.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js constant.other.object.key.js string.unquoted.label.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FF5D62\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D27E99\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FF5D62\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7E9CD8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D27E99\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98BB6C\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.tag JSXNested\",\n\
  \          \"meta.jsx.children\",\n\
  \          \"text.html\",\n\
  \          \"text.log\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown\",\n\
  \          \"punctuation.definition.list_item.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown markup.inline.raw.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown markup.inline.raw.markdown \
   punctuation.definition.raw.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markdown.heading\",\n\
  \          \"entity.name.section.markdown\",\n\
  \          \"markup.heading.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7E9CD8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.italic\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#E46876\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.bold\",\n\
  \          \"markup.bold string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.bold markup.italic\",\n\
  \          \"markup.italic markup.bold\",\n\
  \          \"markup.quote markup.bold\",\n\
  \          \"markup.bold markup.italic string\",\n\
  \          \"markup.italic markup.bold string\",\n\
  \          \"markup.quote markup.bold string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#E46876\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.underline\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\",\n\
  \          \"foreground\": \"#7FB4CA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.quote punctuation.definition.blockquote.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#727169\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.quote\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.other.link.title.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#FFA066\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.other.link.description.title.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.reference.link.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#E6C384\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.raw.block\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#957FB8\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.raw.block.fenced.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#727169\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.fenced.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#727169\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.raw.block.fenced.markdown\",\n\
  \          \"variable.language.fenced.markdown\",\n\
  \          \"punctuation.section.class.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.language.fenced.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#727169\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.separator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#9CABCA\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"markup.table\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#DCD7BA\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let nord =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#2e3440\",\n\
  \      \"editor.foreground\": \"#d8dee9\"\n\
  \    },\n\
  \    \"name\": \"nord\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"settings\": {\n\
  \          \"background\": \"#2e3440ff\",\n\
  \          \"foreground\": \"#d8dee9ff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"emphasis\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"strong\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#616E88\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.escape\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#B48EAD\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.class\",\n\
  \          \"entity.name.type.class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.inherited-class\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.deprecated\",\n\
  \        \"settings\": {\n\
  \          \"background\": \"#EBCB8B\",\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.illegal\",\n\
  \        \"settings\": {\n\
  \          \"background\": \"#BF616A\",\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.new\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#BF616A\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#A3BE8C\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.preprocessor\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.method-parameters\",\n\
  \          \"punctuation.definition.function-parameters\",\n\
  \          \"punctuation.definition.parameters\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.comment\",\n\
  \          \"punctuation.end.definition.comment\",\n\
  \          \"punctuation.start.definition.comment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#616E88\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.section\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section.embedded.begin\",\n\
  \          \"punctuation.section.embedded.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.terminator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#A3BE8C\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.construct\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.exception\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.debug-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#b48ead\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.error-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#bf616a\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.info-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88c0d0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.warn-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ebcb8b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.pointer-access.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.c meta.preprocessor.include\",\n\
  \          \"source.c string.quoted.other.lt-gt.include\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.cpp keyword.control.directive.conditional\",\n\
  \          \"source.cpp punctuation.definition.directive\",\n\
  \          \"source.c keyword.control.directive.conditional\",\n\
  \          \"source.c punctuation.definition.directive\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css constant.other.color.rgb-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#B48EAD\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css meta.property-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css keyword.control.at-rule.media\",\n\
  \          \"source.css keyword.control.at-rule.media \
   punctuation.definition.keyword\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css punctuation.definition.keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css support.type.property-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.diff meta.diff.range.context\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.diff meta.diff.header.from-file\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.diff punctuation.definition.from-file\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.diff punctuation.definition.range\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.diff punctuation.definition.separator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module.elixir\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.readwrite.module.elixir\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.symbol.elixir\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.constant.elixir\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.go constant.other.placeholder.go\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java comment.block.documentation.javadoc \
   punctuation.definition.entity.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java constant.other\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java keyword.other.documentation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java \
   keyword.other.documentation.author.javadoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java keyword.other.documentation.directive\",\n\
  \          \"source.java keyword.other.documentation.custom\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java keyword.other.documentation.see.javadoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java meta.method-call meta.method\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java meta.tag.template.link.javadoc\",\n\
  \          \"source.java string.other.link.title.javadoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java meta.tag.template.value.javadoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java punctuation.definition.keyword.javadoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.java punctuation.definition.tag.begin.javadoc\",\n\
  \          \"source.java punctuation.definition.tag.end.javadoc\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#616E88\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.modifier.import\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.modifier.package\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.type.annotation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.type.generic\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java storage.type.primitive\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js punctuation.decorator\",\n\
  \          \"source.js meta.decorator variable.other.readwrite\",\n\
  \          \"source.js meta.decorator entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js meta.object-literal.key\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js storage.type.class.jsdoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js string.quoted.template \
   punctuation.quasi.element.begin\",\n\
  \          \"source.js string.quoted.template punctuation.quasi.element.end\",\n\
  \          \"source.js string.template \
   punctuation.definition.template-expression\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js string.quoted.template \
   meta.method-call.with-arguments\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js string.template meta.template.expression \
   support.variable.property\",\n\
  \          \"source.js string.template meta.template.expression \
   variable.other.object\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js support.type.primitive\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js variable.other.object\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.js variable.other.readwrite.alias\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.js meta.embedded.line meta.brace.square\",\n\
  \          \"source.js meta.embedded.line meta.brace.round\",\n\
  \          \"source.js string.quoted.template meta.brace.square\",\n\
  \          \"source.js string.quoted.template meta.brace.round\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.basic constant.character.entity.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.basic constant.other.inline-data\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.basic meta.tag.sgml.doctype\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.basic punctuation.definition.entity\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.properties entity.name.section.group-title.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.properties punctuation.separator.key-value.ini\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown markup.fenced_code.block\",\n\
  \          \"text.html.markdown markup.fenced_code.block \
   punctuation.definition\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown markup.inline.raw\",\n\
  \          \"text.html.markdown markup.inline.raw punctuation.definition.raw\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown markup.italic\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown markup.underline.link\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown \
   beginning.punctuation.definition.list\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown \
   beginning.punctuation.definition.quote\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown markup.quote\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#616E88\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown constant.character.math.tex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown punctuation.definition.math.begin\",\n\
  \          \"text.html.markdown punctuation.definition.math.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown \
   punctuation.definition.function.math.tex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown punctuation.math.operator.latex\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.markdown punctuation.definition.heading\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown punctuation.definition.constant\",\n\
  \          \"text.html.markdown punctuation.definition.string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.html.markdown constant.other.reference.link\",\n\
  \          \"text.html.markdown string.other.link.description\",\n\
  \          \"text.html.markdown string.other.link.title\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.perl punctuation.definition.variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.php meta.function-call\",\n\
  \          \"source.php meta.function-call.object\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.python entity.name.function.decorator\",\n\
  \          \"source.python meta.function.decorator support.type\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.python meta.function-call.generic\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.python support.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.python variable.parameter.function.language\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.python meta.function.parameters \
   variable.parameter.function.language.special.self\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.rust entity.name.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.rust meta.macro entity.name.function\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\",\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.rust meta.attribute\",\n\
  \          \"source.rust meta.attribute punctuation\",\n\
  \          \"source.rust meta.attribute keyword.operator\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.rust entity.name.type.trait\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"bold\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.rust punctuation.definition.interpolation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#EBCB8B\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.css.scss \
   punctuation.definition.interpolation.begin.bracket.curly\",\n\
  \          \"source.css.scss \
   punctuation.definition.interpolation.end.bracket.curly\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#81A1C1\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.css.scss variable.interpolation\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts punctuation.decorator\",\n\
  \          \"source.ts meta.decorator variable.other.readwrite\",\n\
  \          \"source.ts meta.decorator entity.name.function\",\n\
  \          \"source.tsx punctuation.decorator\",\n\
  \          \"source.tsx meta.decorator variable.other.readwrite\",\n\
  \          \"source.tsx meta.decorator entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts meta.object-literal.key\",\n\
  \          \"source.tsx meta.object-literal.key\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts meta.object-literal.key entity.name.function\",\n\
  \          \"source.tsx meta.object-literal.key entity.name.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#88C0D0\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts support.class\",\n\
  \          \"source.ts support.type\",\n\
  \          \"source.ts entity.name.type\",\n\
  \          \"source.ts entity.name.class\",\n\
  \          \"source.tsx support.class\",\n\
  \          \"source.tsx support.type\",\n\
  \          \"source.tsx entity.name.type\",\n\
  \          \"source.tsx entity.name.class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts support.constant.math\",\n\
  \          \"source.ts support.constant.dom\",\n\
  \          \"source.ts support.constant.json\",\n\
  \          \"source.tsx support.constant.math\",\n\
  \          \"source.tsx support.constant.dom\",\n\
  \          \"source.tsx support.constant.json\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts support.variable\",\n\
  \          \"source.tsx support.variable\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#D8DEE9\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ts meta.embedded.line meta.brace.square\",\n\
  \          \"source.ts meta.embedded.line meta.brace.round\",\n\
  \          \"source.tsx meta.embedded.line meta.brace.square\",\n\
  \          \"source.tsx meta.embedded.line meta.brace.round\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ECEFF4\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.xml entity.name.tag.namespace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.xml keyword.other.doctype\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.xml meta.tag.preprocessor entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5E81AC\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.xml string.unquoted.cdata\",\n\
  \          \"text.xml string.unquoted.cdata punctuation.definition.string\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#D08770\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.yaml entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#8FBCBB\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"

let one_dark_pro =
  "{\n\
  \    \"colors\": {\n\
  \      \"editor.background\": \"#282c34\",\n\
  \      \"editor.foreground\": \"#abb2bf\"\n\
  \    },\n\
  \    \"name\": \"one-dark-pro\",\n\
  \    \"tokenColors\": [\n\
  \      {\n\
  \        \"scope\": \"meta.embedded\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.definition.delayed.unison,punctuation.definition.list.begin.unison,punctuation.definition.list.end.unison,punctuation.definition.ability.begin.unison,punctuation.definition.ability.end.unison,punctuation.operator.assignment.as.unison,punctuation.separator.pipe.unison,punctuation.separator.delimiter.unison,punctuation.definition.hash.unison\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.generic-type.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.haskell\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.variable.magic.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.separator.period.python,punctuation.separator.element.python,punctuation.parenthesis.begin.python,punctuation.parenthesis.end.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"variable.parameter.function.language.special.self.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"variable.parameter.function.language.special.cls.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.modifier.lifetime.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function.std.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.lifetime.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.edge\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.character-class.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.word\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment markup.link\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5c6370\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.changed.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"meta.diff.header.from-file,meta.diff.header.to-file,punctuation.definition.from-file.diff,punctuation.definition.to-file.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted.diff\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.c,meta.function.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.section.block.begin.bracket.curly.cpp,punctuation.section.block.end.bracket.curly.cpp,punctuation.terminator.statement.c,punctuation.section.block.begin.bracket.curly.c,punctuation.section.block.end.bracket.curly.c,punctuation.section.parens.begin.bracket.round.c,punctuation.section.parens.end.bracket.round.c,punctuation.section.parameters.begin.bracket.round.c,punctuation.section.parameters.end.bracket.round.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.key-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.expression.import\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.math\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.property.math\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.constant\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.type.annotation.java\",\n\
  \          \"storage.type.object.array.java\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.section.block.begin.java,punctuation.section.block.end.java,punctuation.definition.method-parameters.begin.java,punctuation.definition.method-parameters.end.java,meta.method.identifier.java,punctuation.section.method.begin.java,punctuation.section.method.end.java,punctuation.terminator.java,punctuation.section.class.begin.java,punctuation.section.class.end.java,punctuation.section.inner-class.begin.java,punctuation.section.inner-class.end.java,meta.method-call.java,punctuation.section.class.begin.bracket.curly.java,punctuation.section.class.end.bracket.curly.java,punctuation.section.method.begin.bracket.curly.java,punctuation.section.method.end.bracket.curly.java,punctuation.separator.period.java,punctuation.bracket.angle.java,punctuation.definition.annotation.java,meta.method.body.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.method.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"storage.modifier.import.java,storage.type.java,storage.type.generic.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.instanceof.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.definition.variable.name.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.logical\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.bitwise\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.channel\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.constant.property-value.scss,support.constant.property-value.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.css,keyword.operator.scss,keyword.operator.less\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.constant.color.w3c-standard-color-name.css,support.constant.color.w3c-standard-color-name.scss\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.list.comma.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.color.w3c-standard-color-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.vendored.property-name.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.module.node,support.type.object.module,support.module.node\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.module\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"variable.other.readwrite,meta.object-literal.key,support.variable.property,support.variable.object.process,support.variable.object.node\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.expression.instanceof\",\n\
  \          \"keyword.operator.new\",\n\
  \          \"keyword.operator.ternary\",\n\
  \          \"keyword.operator.optional\",\n\
  \          \"keyword.operator.expression.keyof\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.object.console\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.variable.property.process\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.function,support.function.console\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.misc.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.sigil.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.delete\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.object.dom\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.variable.dom,support.variable.property.dom\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.arithmetic,keyword.operator.comparison,keyword.operator.decrement,keyword.operator.increment,keyword.operator.relational\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.assignment.c,keyword.operator.comparison.c,keyword.operator.c,keyword.operator.increment.c,keyword.operator.decrement.c,keyword.operator.bitwise.shift.c,keyword.operator.assignment.cpp,keyword.operator.comparison.cpp,keyword.operator.cpp,keyword.operator.increment.cpp,keyword.operator.decrement.cpp,keyword.operator.bitwise.shift.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.delimiter\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.separator.c,punctuation.separator.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.type.posix-reserved.c,support.type.posix-reserved.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.sizeof.c,keyword.operator.sizeof.cpp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.function.language.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.logical.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.parameter.function.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.definition.arguments.begin.python,punctuation.definition.arguments.end.python,punctuation.separator.arguments.python,punctuation.definition.list.begin.python,punctuation.definition.list.end.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function-call.generic.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.assignment.compound\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.assignment.compound.js,keyword.operator.assignment.compound.ts\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.namespace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.language\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.variable.parameter.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"import.storage.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.package.keyword\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.package\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function\",\n\
  \          \"meta.require\",\n\
  \          \"support.function.any-method\",\n\
  \          \"variable.function\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type.namespace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.class, entity.name.type.class\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.class.identifier.namespace.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.class\",\n\
  \          \"variable.other.class.js\",\n\
  \          \"variable.other.class.ts\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.class.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.type\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.control\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"control.elements, keyword.operator.less\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.special-method\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.storage\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.expression.delete,keyword.operator.expression.in,keyword.operator.expression.of,keyword.operator.expression.instanceof,keyword.operator.new,keyword.operator.expression.typeof,keyword.operator.expression.void\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.storage.type.java\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.function\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.toml, \
   support.type.property-name.table.toml, \
   support.type.property-name.array.toml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.property-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.font-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.other.symbol\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.numeric\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.constant\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.tag\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.id\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.other.attribute-name.class.css\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.selector\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading punctuation.definition.heading, \
   entity.name.section\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.other.unit\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.bold,todo.bold\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.bold\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic, \
   punctuation.definition.italic,todo.emphasis\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"emphasis md\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.section.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.heading.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.heading.setext\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.bold.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inline.raw.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inline.raw.string.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.raw.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.list.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.string.begin.markdown\",\n\
  \          \"punctuation.definition.string.end.markdown\",\n\
  \          \"punctuation.definition.metadata.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"beginning.punctuation.definition.list.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.metadata.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"markup.underline.link.markdown,markup.underline.link.image.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"string.other.link.title.markdown,string.other.link.description.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.raw.monospace.asciidoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.asciidoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.list.asciidoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.link.asciidoc,markup.other.url.asciidoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.unquoted.asciidoc,markup.other.url.asciidoc\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"string.regexp\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.section.embedded, variable.interpolation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.section.embedded.begin,punctuation.section.embedded.end\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.illegal\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffffff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.illegal.bad-ampersand.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.illegal.unrecognized-tag.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.broken\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffffff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.deprecated\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffffff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.deprecated.entity.other.attribute-name.html\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.unimplemented\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffffff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.json meta.structure.dictionary.json > \
   string.quoted.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.json meta.structure.dictionary.json > \
   string.quoted.json > punctuation.string\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.json meta.structure.dictionary.json > \
   value.json > string.quoted.json,source.json meta.structure.array.json > \
   value.json > string.quoted.json,source.json meta.structure.dictionary.json \
   > value.json > string.quoted.json > punctuation,source.json \
   meta.structure.array.json > value.json > string.quoted.json > punctuation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"source.json meta.structure.dictionary.json > \
   constant.language.json,source.json meta.structure.array.json > \
   constant.language.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.json\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.type.property-name.json punctuation\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.laravel-blade source.php.embedded.line.html \
   entity.name.tag.laravel-blade\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"text.html.laravel-blade source.php.embedded.line.html \
   support.constant.laravel-blade\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.other.namespace.use.php,support.other.namespace.use-as.php,entity.other.alias.php,meta.interface.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.error-control.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.type.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.section.array.begin.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.section.array.end.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"invalid.illegal.non-null-typehinted.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f44747\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"storage.type.php,meta.other.type.phpdoc.php,keyword.other.type.php,keyword.other.array.phpdoc.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"meta.function-call.php,meta.function-call.object.php,meta.function-call.static.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"punctuation.definition.parameters.begin.bracket.round.php,punctuation.definition.parameters.end.bracket.round.php,punctuation.separator.delimiter.php,punctuation.section.scope.begin.php,punctuation.section.scope.end.php,punctuation.terminator.expression.php,punctuation.definition.arguments.begin.bracket.round.php,punctuation.definition.arguments.end.bracket.round.php,punctuation.definition.storage-type.begin.bracket.round.php,punctuation.definition.storage-type.end.bracket.round.php,punctuation.definition.array.begin.bracket.round.php,punctuation.definition.array.end.bracket.round.php,punctuation.definition.begin.bracket.round.php,punctuation.definition.end.bracket.round.php,punctuation.definition.begin.bracket.curly.php,punctuation.definition.end.bracket.curly.php,punctuation.definition.section.switch-block.end.bracket.curly.php,punctuation.definition.section.switch-block.start.bracket.curly.php,punctuation.definition.section.switch-block.begin.bracket.curly.php,punctuation.definition.section.switch-block.end.bracket.curly.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"support.constant.core.rust\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.constant.ext.php,support.constant.std.php,support.constant.core.php,support.constant.parser-token.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.goto-label.php,support.other.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.logical.php,keyword.operator.bitwise.php,keyword.operator.arithmetic.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.regexp.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.comparison.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"keyword.operator.heredoc.php,keyword.operator.nowdoc.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"meta.function.decorator.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.token.decorator.python,meta.function.decorator.identifier.python\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"function.parameter\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"function.brace\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"function.parameter.ruby, function.parameter.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.symbol.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"constant.language.symbol.hashkey.ruby\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"rgb-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"inline-color-decoration rgb-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"less rgb-value\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"selector.sass\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"support.type.primitive.ts,support.type.builtin.ts,support.type.primitive.tsx,support.type.builtin.tsx\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"block.scope.end,block.scope.begin\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"storage.type.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.variable.local.cs\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.info-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.warn-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.error-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#f44747\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"token.debug-token\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.template-expression.begin\",\n\
  \          \"punctuation.definition.template-expression.end\",\n\
  \          \"punctuation.section.embedded\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.template.expression\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.module\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.type.flowtype\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.primitive\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.property.object\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter.function.js\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.template.begin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.template.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.substitution.begin\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.other.substitution.end\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.assignment\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.assignment.go\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.arithmetic.go\",\n\
  \          \"keyword.operator.address.go\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.operator.arithmetic.c\",\n\
  \          \"keyword.operator.arithmetic.cpp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.package.go\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.prelude.elm\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.constant.elm\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.quasi.element\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.entity\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.attribute-name.pseudo-element\",\n\
  \          \"entity.other.attribute-name.pseudo-class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.global.clojure\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.symbol.clojure\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.keyword.clojure\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.arguments.coffee\",\n\
  \          \"variable.parameter.function.coffee\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.ini\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.scope.prerequisites.makefile\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"source.makefile\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"storage.modifier.import.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.method.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.definition.variable.name.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"meta.definition.class.inherited.classes.groovy\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.variable.semantic.hlsl\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.texture.hlsl\",\n\
  \          \"support.type.sampler.hlsl\",\n\
  \          \"support.type.object.hlsl\",\n\
  \          \"support.type.object.rw.hlsl\",\n\
  \          \"support.type.fx.hlsl\",\n\
  \          \"support.type.object.hlsl\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"text.variable\",\n\
  \          \"text.bracketed\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.type.swift\",\n\
  \          \"support.type.vb.asp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.function.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.class.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.character-class.regexp.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.regexp.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"keyword.control.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"invalid.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"beginning.punctuation.definition.quote.markdown.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"beginning.punctuation.definition.list.markdown.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#7f848e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"accent.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"wikiword.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.other.color.rgb-value.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#ffffff\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.definition.tag.xi\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5c6370\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.label.cs\",\n\
  \          \"entity.name.scope-resolution.function.call\",\n\
  \          \"entity.name.scope-resolution.function.definition\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.label.cs\",\n\
  \          \"markup.heading.setext.1.markdown\",\n\
  \          \"markup.heading.setext.2.markdown\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \" meta.brace.square\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment, punctuation.definition.comment\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\",\n\
  \          \"foreground\": \"#7f848e\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.quote.markdown\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#5c6370\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"punctuation.definition.block.sequence.item.yaml\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.language.symbol.elixir\",\n\
  \          \"constant.language.symbol.double-quoted.elixir\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.variable.parameter.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.name.variable.field.cs\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.deleted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.inserted\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.underline\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"underline\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"punctuation.section.embedded.begin.php\",\n\
  \          \"punctuation.section.embedded.end.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#BE5046\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.other.namespace.php\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.parameter.function.latex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.object\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"variable.other.constant.property\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"entity.other.inherited-class\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"variable.other.readwrite.c\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"entity.name.variable.parameter.php,punctuation.separator.colon.php,constant.other.php\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#abb2bf\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.numeric.decimal.asm.x86_64\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.other.parenthesis.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#d19a66\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.escape\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#56b6c2\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"string.regexp\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"log.info\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"log.warning\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e5c07b\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"log.error\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"keyword.operator.expression.is\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#c678dd\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"entity.name.label\",\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#e06c75\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"support.class.math.block.environment.latex\",\n\
  \          \"constant.other.general.math.tex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#61afef\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": [\n\
  \          \"constant.character.math.tex\"\n\
  \        ],\n\
  \        \"settings\": {\n\
  \          \"foreground\": \"#98c379\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \
   \"entity.other.attribute-name.js,entity.other.attribute-name.ts,entity.other.attribute-name.jsx,entity.other.attribute-name.tsx,variable.parameter,variable.language.super\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"comment.line.double-slash,comment.block.documentation\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      },\n\
  \      {\n\
  \        \"scope\": \"markup.italic.markdown\",\n\
  \        \"settings\": {\n\
  \          \"fontStyle\": \"italic\"\n\
  \        }\n\
  \      }\n\
  \    ],\n\
  \    \"type\": \"dark\"\n\
  \  }\n"
