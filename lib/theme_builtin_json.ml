(* Auto-generated from lib/themes/*.json. *)
let dark_plus =
  "{\n\
  \  \"colors\": {\n\
  \    \"actionBar.toggledBackground\": \"#383a49\",\n\
  \    \"activityBarBadge.background\": \"#007ACC\",\n\
  \    \"checkbox.border\": \"#6B6B6B\",\n\
  \    \"editor.background\": \"#1E1E1E\",\n\
  \    \"editor.foreground\": \"#D4D4D4\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#3A3D41\",\n\
  \    \"editor.selectionHighlightBackground\": \"#ADD6FF26\",\n\
  \    \"editorIndentGuide.activeBackground1\": \"#707070\",\n\
  \    \"editorIndentGuide.background1\": \"#404040\",\n\
  \    \"input.placeholderForeground\": \"#A6A6A6\",\n\
  \    \"list.activeSelectionIconForeground\": \"#FFF\",\n\
  \    \"list.dropBackground\": \"#383B3D\",\n\
  \    \"menu.background\": \"#252526\",\n\
  \    \"menu.border\": \"#454545\",\n\
  \    \"menu.foreground\": \"#CCCCCC\",\n\
  \    \"menu.selectionBackground\": \"#0078d4\",\n\
  \    \"menu.separatorBackground\": \"#454545\",\n\
  \    \"ports.iconRunningProcessForeground\": \"#369432\",\n\
  \    \"sideBarSectionHeader.background\": \"#0000\",\n\
  \    \"sideBarSectionHeader.border\": \"#ccc3\",\n\
  \    \"sideBarTitle.foreground\": \"#BBBBBB\",\n\
  \    \"statusBarItem.remoteBackground\": \"#16825D\",\n\
  \    \"statusBarItem.remoteForeground\": \"#FFF\",\n\
  \    \"tab.lastPinnedBorder\": \"#ccc3\",\n\
  \    \"tab.selectedBackground\": \"#222222\",\n\
  \    \"tab.selectedForeground\": \"#ffffffa0\",\n\
  \    \"terminal.inactiveSelectionBackground\": \"#3A3D41\",\n\
  \    \"widget.border\": \"#303031\"\n\
  \  },\n\
  \  \"displayName\": \"Dark Plus\",\n\
  \  \"name\": \"dark-plus\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"customLiteral\": \"#DCDCAA\",\n\
  \    \"newOperator\": \"#C586C0\",\n\
  \    \"numberLiteral\": \"#b5cea8\",\n\
  \    \"stringLiteral\": \"#ce9178\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.embedded\",\n\
  \        \"source.groovy.embedded\",\n\
  \        \"string meta.image.inline.markdown\",\n\
  \        \"variable.legacy.builtin.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D4D4D4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"emphasis\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"strong\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"header\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#6A9955\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\",\n\
  \        \"variable.other.enummember\",\n\
  \        \"keyword.operator.plus.exponent\",\n\
  \        \"keyword.operator.minus.exponent\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b5cea8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#646695\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag.css\",\n\
  \        \"entity.name.tag.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d7ba7d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9cdcfe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.class.css\",\n\
  \        \"source.css entity.other.attribute-name.class\",\n\
  \        \"entity.other.attribute-name.id.css\",\n\
  \        \"entity.other.attribute-name.parent-selector.css\",\n\
  \        \"entity.other.attribute-name.parent.less\",\n\
  \        \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \        \"entity.other.attribute-name.pseudo-element.css\",\n\
  \        \"source.css.less entity.other.attribute-name.id\",\n\
  \        \"entity.other.attribute-name.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d7ba7d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f44747\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.strikethrough\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"strikethrough\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b5cea8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.quote.begin.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#6A9955\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#6796e6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inline.raw\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#808080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.preprocessor\",\n\
  \        \"entity.name.function.preprocessor\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b5cea8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.structure.dictionary.key.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9cdcfe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.diff.header\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier\",\n\
  \        \"keyword.operator.noexcept\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"meta.embedded.assembly\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ce9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d16969\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.template-expression.begin\",\n\
  \        \"punctuation.definition.template-expression.end\",\n\
  \        \"punctuation.section.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.template.expression\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d4d4d4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.vendored.property-name\",\n\
  \        \"support.type.property-name\",\n\
  \        \"source.css variable\",\n\
  \        \"source.coffee.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9cdcfe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d4d4d4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.new\",\n\
  \        \"keyword.operator.expression\",\n\
  \        \"keyword.operator.cast\",\n\
  \        \"keyword.operator.sizeof\",\n\
  \        \"keyword.operator.alignof\",\n\
  \        \"keyword.operator.typeid\",\n\
  \        \"keyword.operator.alignas\",\n\
  \        \"keyword.operator.instanceof\",\n\
  \        \"keyword.operator.logical.python\",\n\
  \        \"keyword.operator.wordlike\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b5cea8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section.embedded.begin.php\",\n\
  \        \"punctuation.section.embedded.end.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9cdcfe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.sha.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b5cea8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.import.java\",\n\
  \        \"variable.language.wildcard.java\",\n\
  \        \"storage.modifier.package.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d4d4d4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"support.function\",\n\
  \        \"support.constant.handlebars\",\n\
  \        \"source.powershell variable.other.member\",\n\
  \        \"entity.name.operator.custom-literal\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCDCAA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class\",\n\
  \        \"support.type\",\n\
  \        \"entity.name.type\",\n\
  \        \"entity.name.namespace\",\n\
  \        \"entity.other.attribute\",\n\
  \        \"entity.name.scope-resolution\",\n\
  \        \"entity.name.class\",\n\
  \        \"storage.type.numeric.go\",\n\
  \        \"storage.type.byte.go\",\n\
  \        \"storage.type.boolean.go\",\n\
  \        \"storage.type.string.go\",\n\
  \        \"storage.type.uintptr.go\",\n\
  \        \"storage.type.error.go\",\n\
  \        \"storage.type.rune.go\",\n\
  \        \"storage.type.cs\",\n\
  \        \"storage.type.generic.cs\",\n\
  \        \"storage.type.modifier.cs\",\n\
  \        \"storage.type.variable.cs\",\n\
  \        \"storage.type.annotation.java\",\n\
  \        \"storage.type.generic.java\",\n\
  \        \"storage.type.java\",\n\
  \        \"storage.type.object.array.java\",\n\
  \        \"storage.type.primitive.array.java\",\n\
  \        \"storage.type.primitive.java\",\n\
  \        \"storage.type.token.java\",\n\
  \        \"storage.type.groovy\",\n\
  \        \"storage.type.annotation.groovy\",\n\
  \        \"storage.type.parameters.groovy\",\n\
  \        \"storage.type.generic.groovy\",\n\
  \        \"storage.type.object.array.groovy\",\n\
  \        \"storage.type.primitive.array.groovy\",\n\
  \        \"storage.type.primitive.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#4EC9B0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.type.cast.expr\",\n\
  \        \"meta.type.new.expr\",\n\
  \        \"support.constant.math\",\n\
  \        \"support.constant.dom\",\n\
  \        \"support.constant.json\",\n\
  \        \"entity.other.inherited-class\",\n\
  \        \"punctuation.separator.namespace.ruby\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#4EC9B0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control\",\n\
  \        \"source.cpp keyword.operator.new\",\n\
  \        \"keyword.operator.delete\",\n\
  \        \"keyword.other.using\",\n\
  \        \"keyword.other.directive.using\",\n\
  \        \"keyword.other.operator\",\n\
  \        \"entity.name.operator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#C586C0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable\",\n\
  \        \"meta.definition.variable.name\",\n\
  \        \"support.variable\",\n\
  \        \"entity.name.variable\",\n\
  \        \"constant.other.placeholder\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9CDCFE\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant\",\n\
  \        \"variable.other.enummember\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#4FC1FF\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.object-literal.key\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9CDCFE\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.property-value\",\n\
  \        \"support.constant.font-name\",\n\
  \        \"support.constant.media-type\",\n\
  \        \"support.constant.media\",\n\
  \        \"constant.other.color.rgb-value\",\n\
  \        \"constant.other.rgb-value\",\n\
  \        \"support.constant.color\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#CE9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.regexp\",\n\
  \        \"punctuation.definition.group.assertion.regexp\",\n\
  \        \"punctuation.definition.character-class.regexp\",\n\
  \        \"punctuation.character.set.begin.regexp\",\n\
  \        \"punctuation.character.set.end.regexp\",\n\
  \        \"keyword.operator.negation.regexp\",\n\
  \        \"support.other.parenthesis.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#CE9178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.character-class.regexp\",\n\
  \        \"constant.other.character-class.set.regexp\",\n\
  \        \"constant.other.character-class.regexp\",\n\
  \        \"constant.character.set.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d16969\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.or.regexp\",\n\
  \        \"keyword.control.anchor.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCDCAA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d7ba7d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character\",\n\
  \        \"constant.other.option\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#569cd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d7ba7d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.label\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#C8C8C8\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let light_plus =
  "{\n\
  \  \"colors\": {\n\
  \    \"actionBar.toggledBackground\": \"#dddddd\",\n\
  \    \"activityBarBadge.background\": \"#007ACC\",\n\
  \    \"checkbox.border\": \"#919191\",\n\
  \    \"diffEditor.unchangedRegionBackground\": \"#f8f8f8\",\n\
  \    \"editor.background\": \"#FFFFFF\",\n\
  \    \"editor.foreground\": \"#000000\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#E5EBF1\",\n\
  \    \"editor.selectionHighlightBackground\": \"#ADD6FF80\",\n\
  \    \"editorIndentGuide.activeBackground1\": \"#939393\",\n\
  \    \"editorIndentGuide.background1\": \"#D3D3D3\",\n\
  \    \"editorSuggestWidget.background\": \"#F3F3F3\",\n\
  \    \"input.placeholderForeground\": \"#767676\",\n\
  \    \"list.activeSelectionIconForeground\": \"#FFF\",\n\
  \    \"list.focusAndSelectionOutline\": \"#90C2F9\",\n\
  \    \"list.hoverBackground\": \"#E8E8E8\",\n\
  \    \"menu.border\": \"#D4D4D4\",\n\
  \    \"notebook.cellBorderColor\": \"#E8E8E8\",\n\
  \    \"notebook.selectedCellBackground\": \"#c8ddf150\",\n\
  \    \"ports.iconRunningProcessForeground\": \"#369432\",\n\
  \    \"searchEditor.textInputBorder\": \"#CECECE\",\n\
  \    \"settings.numberInputBorder\": \"#CECECE\",\n\
  \    \"settings.textInputBorder\": \"#CECECE\",\n\
  \    \"sideBarSectionHeader.background\": \"#0000\",\n\
  \    \"sideBarSectionHeader.border\": \"#61616130\",\n\
  \    \"sideBarTitle.foreground\": \"#6F6F6F\",\n\
  \    \"statusBarItem.errorBackground\": \"#c72e0f\",\n\
  \    \"statusBarItem.remoteBackground\": \"#16825D\",\n\
  \    \"statusBarItem.remoteForeground\": \"#FFF\",\n\
  \    \"tab.lastPinnedBorder\": \"#61616130\",\n\
  \    \"tab.selectedBackground\": \"#ffffffa5\",\n\
  \    \"tab.selectedForeground\": \"#333333b3\",\n\
  \    \"terminal.inactiveSelectionBackground\": \"#E5EBF1\",\n\
  \    \"widget.border\": \"#d4d4d4\"\n\
  \  },\n\
  \  \"displayName\": \"Light Plus\",\n\
  \  \"name\": \"light-plus\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"customLiteral\": \"#795E26\",\n\
  \    \"newOperator\": \"#AF00DB\",\n\
  \    \"numberLiteral\": \"#098658\",\n\
  \    \"stringLiteral\": \"#a31515\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.embedded\",\n\
  \        \"source.groovy.embedded\",\n\
  \        \"string meta.image.inline.markdown\",\n\
  \        \"variable.legacy.builtin.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"emphasis\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"strong\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.diff.header\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#008000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\",\n\
  \        \"variable.other.enummember\",\n\
  \        \"keyword.operator.plus.exponent\",\n\
  \        \"keyword.operator.minus.exponent\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#098658\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#811f3f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e50000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.class.css\",\n\
  \        \"source.css entity.other.attribute-name.class\",\n\
  \        \"entity.other.attribute-name.id.css\",\n\
  \        \"entity.other.attribute-name.parent-selector.css\",\n\
  \        \"entity.other.attribute-name.parent.less\",\n\
  \        \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \        \"entity.other.attribute-name.pseudo-element.css\",\n\
  \        \"source.css.less entity.other.attribute-name.id\",\n\
  \        \"entity.other.attribute-name.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cd3131\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#000080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.strikethrough\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"strikethrough\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#098658\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a31515\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.quote.begin.markdown\",\n\
  \        \"punctuation.definition.list.begin.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inline.raw\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.preprocessor\",\n\
  \        \"entity.name.function.preprocessor\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a31515\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#098658\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.structure.dictionary.key.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier\",\n\
  \        \"keyword.operator.noexcept\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"meta.embedded.assembly\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a31515\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.comment.buffered.block.pug\",\n\
  \        \"string.quoted.pug\",\n\
  \        \"string.interpolated.pug\",\n\
  \        \"string.unquoted.plain.in.yaml\",\n\
  \        \"string.unquoted.plain.out.yaml\",\n\
  \        \"string.unquoted.block.yaml\",\n\
  \        \"string.quoted.single.yaml\",\n\
  \        \"string.quoted.double.xml\",\n\
  \        \"string.quoted.single.xml\",\n\
  \        \"string.unquoted.cdata.xml\",\n\
  \        \"string.quoted.double.html\",\n\
  \        \"string.quoted.single.html\",\n\
  \        \"string.unquoted.html\",\n\
  \        \"string.quoted.single.handlebars\",\n\
  \        \"string.quoted.double.handlebars\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#811f3f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.template-expression.begin\",\n\
  \        \"punctuation.definition.template-expression.end\",\n\
  \        \"punctuation.section.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.template.expression\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.property-value\",\n\
  \        \"support.constant.font-name\",\n\
  \        \"support.constant.media-type\",\n\
  \        \"support.constant.media\",\n\
  \        \"constant.other.color.rgb-value\",\n\
  \        \"constant.other.rgb-value\",\n\
  \        \"support.constant.color\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.vendored.property-name\",\n\
  \        \"support.type.property-name\",\n\
  \        \"source.css variable\",\n\
  \        \"source.coffee.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e50000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.new\",\n\
  \        \"keyword.operator.expression\",\n\
  \        \"keyword.operator.cast\",\n\
  \        \"keyword.operator.sizeof\",\n\
  \        \"keyword.operator.alignof\",\n\
  \        \"keyword.operator.typeid\",\n\
  \        \"keyword.operator.alignas\",\n\
  \        \"keyword.operator.instanceof\",\n\
  \        \"keyword.operator.logical.python\",\n\
  \        \"keyword.operator.wordlike\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#098658\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section.embedded.begin.php\",\n\
  \        \"punctuation.section.embedded.end.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#800000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.sha.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#098658\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.import.java\",\n\
  \        \"variable.language.wildcard.java\",\n\
  \        \"storage.modifier.package.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"support.function\",\n\
  \        \"support.constant.handlebars\",\n\
  \        \"source.powershell variable.other.member\",\n\
  \        \"entity.name.operator.custom-literal\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#795E26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class\",\n\
  \        \"support.type\",\n\
  \        \"entity.name.type\",\n\
  \        \"entity.name.namespace\",\n\
  \        \"entity.other.attribute\",\n\
  \        \"entity.name.scope-resolution\",\n\
  \        \"entity.name.class\",\n\
  \        \"storage.type.numeric.go\",\n\
  \        \"storage.type.byte.go\",\n\
  \        \"storage.type.boolean.go\",\n\
  \        \"storage.type.string.go\",\n\
  \        \"storage.type.uintptr.go\",\n\
  \        \"storage.type.error.go\",\n\
  \        \"storage.type.rune.go\",\n\
  \        \"storage.type.cs\",\n\
  \        \"storage.type.generic.cs\",\n\
  \        \"storage.type.modifier.cs\",\n\
  \        \"storage.type.variable.cs\",\n\
  \        \"storage.type.annotation.java\",\n\
  \        \"storage.type.generic.java\",\n\
  \        \"storage.type.java\",\n\
  \        \"storage.type.object.array.java\",\n\
  \        \"storage.type.primitive.array.java\",\n\
  \        \"storage.type.primitive.java\",\n\
  \        \"storage.type.token.java\",\n\
  \        \"storage.type.groovy\",\n\
  \        \"storage.type.annotation.groovy\",\n\
  \        \"storage.type.parameters.groovy\",\n\
  \        \"storage.type.generic.groovy\",\n\
  \        \"storage.type.object.array.groovy\",\n\
  \        \"storage.type.primitive.array.groovy\",\n\
  \        \"storage.type.primitive.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#267f99\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.type.cast.expr\",\n\
  \        \"meta.type.new.expr\",\n\
  \        \"support.constant.math\",\n\
  \        \"support.constant.dom\",\n\
  \        \"support.constant.json\",\n\
  \        \"entity.other.inherited-class\",\n\
  \        \"punctuation.separator.namespace.ruby\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#267f99\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control\",\n\
  \        \"source.cpp keyword.operator.new\",\n\
  \        \"source.cpp keyword.operator.delete\",\n\
  \        \"keyword.other.using\",\n\
  \        \"keyword.other.directive.using\",\n\
  \        \"keyword.other.operator\",\n\
  \        \"entity.name.operator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#AF00DB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable\",\n\
  \        \"meta.definition.variable.name\",\n\
  \        \"support.variable\",\n\
  \        \"entity.name.variable\",\n\
  \        \"constant.other.placeholder\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#001080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant\",\n\
  \        \"variable.other.enummember\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0070C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.object-literal.key\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#001080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.property-value\",\n\
  \        \"support.constant.font-name\",\n\
  \        \"support.constant.media-type\",\n\
  \        \"support.constant.media\",\n\
  \        \"constant.other.color.rgb-value\",\n\
  \        \"constant.other.rgb-value\",\n\
  \        \"support.constant.color\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0451a5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.regexp\",\n\
  \        \"punctuation.definition.group.assertion.regexp\",\n\
  \        \"punctuation.definition.character-class.regexp\",\n\
  \        \"punctuation.character.set.begin.regexp\",\n\
  \        \"punctuation.character.set.end.regexp\",\n\
  \        \"keyword.operator.negation.regexp\",\n\
  \        \"support.other.parenthesis.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d16969\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.character-class.regexp\",\n\
  \        \"constant.other.character-class.set.regexp\",\n\
  \        \"constant.other.character-class.regexp\",\n\
  \        \"constant.character.set.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#811f3f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.or.regexp\",\n\
  \        \"keyword.control.anchor.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EE0000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character\",\n\
  \        \"constant.other.option\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0000ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EE0000\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.label\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#000000\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"light\"\n\
   }\n"
let tokyo_night =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.background\": \"#16161e\",\n\
  \    \"activityBar.border\": \"#16161e\",\n\
  \    \"activityBar.foreground\": \"#787c99\",\n\
  \    \"activityBar.inactiveForeground\": \"#3b3e52\",\n\
  \    \"activityBarBadge.background\": \"#3d59a1\",\n\
  \    \"activityBarBadge.foreground\": \"#fff\",\n\
  \    \"activityBarTop.foreground\": \"#787c99\",\n\
  \    \"activityBarTop.inactiveForeground\": \"#3b3e52\",\n\
  \    \"badge.background\": \"#7e83b230\",\n\
  \    \"badge.foreground\": \"#acb0d0\",\n\
  \    \"breadcrumb.activeSelectionForeground\": \"#a9b1d6\",\n\
  \    \"breadcrumb.background\": \"#16161e\",\n\
  \    \"breadcrumb.focusForeground\": \"#a9b1d6\",\n\
  \    \"breadcrumb.foreground\": \"#515670\",\n\
  \    \"breadcrumbPicker.background\": \"#16161e\",\n\
  \    \"button.background\": \"#3d59a1dd\",\n\
  \    \"button.foreground\": \"#ffffff\",\n\
  \    \"button.hoverBackground\": \"#3d59a1AA\",\n\
  \    \"button.secondaryBackground\": \"#3b3e52\",\n\
  \    \"charts.blue\": \"#7aa2f7\",\n\
  \    \"charts.foreground\": \"#9AA5CE\",\n\
  \    \"charts.green\": \"#41a6b5\",\n\
  \    \"charts.lines\": \"#16161e\",\n\
  \    \"charts.orange\": \"#ff9e64\",\n\
  \    \"charts.purple\": \"#9d7cd8\",\n\
  \    \"charts.red\": \"#f7768e\",\n\
  \    \"charts.yellow\": \"#e0af68\",\n\
  \    \"chat.avatarBackground\": \"#3d59a1\",\n\
  \    \"chat.avatarForeground\": \"#a9b1d6\",\n\
  \    \"chat.requestBorder\": \"#0f0f14\",\n\
  \    \"chat.slashCommandBackground\": \"#14141b\",\n\
  \    \"chat.slashCommandForeground\": \"#7aa2f7\",\n\
  \    \"debugConsole.errorForeground\": \"#bb616b\",\n\
  \    \"debugConsole.infoForeground\": \"#787c99\",\n\
  \    \"debugConsole.sourceForeground\": \"#787c99\",\n\
  \    \"debugConsole.warningForeground\": \"#c49a5a\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#73daca\",\n\
  \    \"debugExceptionWidget.background\": \"#101014\",\n\
  \    \"debugExceptionWidget.border\": \"#963c47\",\n\
  \    \"debugIcon.breakpointDisabledForeground\": \"#414761\",\n\
  \    \"debugIcon.breakpointForeground\": \"#db4b4b\",\n\
  \    \"debugIcon.breakpointUnverifiedForeground\": \"#c24242\",\n\
  \    \"debugTokenExpression.boolean\": \"#ff9e64\",\n\
  \    \"debugTokenExpression.error\": \"#bb616b\",\n\
  \    \"debugTokenExpression.name\": \"#7dcfff\",\n\
  \    \"debugTokenExpression.number\": \"#ff9e64\",\n\
  \    \"debugTokenExpression.string\": \"#9ece6a\",\n\
  \    \"debugTokenExpression.value\": \"#9aa5ce\",\n\
  \    \"debugToolBar.background\": \"#101014\",\n\
  \    \"debugView.stateLabelBackground\": \"#14141b\",\n\
  \    \"debugView.stateLabelForeground\": \"#787c99\",\n\
  \    \"debugView.valueChangedHighlight\": \"#3d59a1aa\",\n\
  \    \"descriptionForeground\": \"#515670\",\n\
  \    \"diffEditor.diagonalFill\": \"#292e42\",\n\
  \    \"diffEditor.insertedLineBackground\": \"#41a6b520\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#41a6b520\",\n\
  \    \"diffEditor.removedLineBackground\": \"#db4b4b22\",\n\
  \    \"diffEditor.removedTextBackground\": \"#db4b4b22\",\n\
  \    \"diffEditor.unchangedCodeBackground\": \"#282a3b66\",\n\
  \    \"diffEditorGutter.insertedLineBackground\": \"#41a6b525\",\n\
  \    \"diffEditorGutter.removedLineBackground\": \"#db4b4b22\",\n\
  \    \"diffEditorOverview.insertedForeground\": \"#41a6b525\",\n\
  \    \"diffEditorOverview.removedForeground\": \"#db4b4b22\",\n\
  \    \"disabledForeground\": \"#545c7e\",\n\
  \    \"dropdown.background\": \"#14141b\",\n\
  \    \"dropdown.foreground\": \"#787c99\",\n\
  \    \"dropdown.listBackground\": \"#14141b\",\n\
  \    \"editor.background\": \"#1a1b26\",\n\
  \    \"editor.findMatchBackground\": \"#3d59a166\",\n\
  \    \"editor.findMatchBorder\": \"#e0af68\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#3d59a166\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#515c7e33\",\n\
  \    \"editor.focusedStackFrameHighlightBackground\": \"#73daca20\",\n\
  \    \"editor.foldBackground\": \"#1111174a\",\n\
  \    \"editor.foreground\": \"#a9b1d6\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#515c7e25\",\n\
  \    \"editor.lineHighlightBackground\": \"#1e202e\",\n\
  \    \"editor.rangeHighlightBackground\": \"#515c7e20\",\n\
  \    \"editor.selectionBackground\": \"#515c7e4d\",\n\
  \    \"editor.selectionHighlightBackground\": \"#515c7e44\",\n\
  \    \"editor.stackFrameHighlightBackground\": \"#E2BD3A20\",\n\
  \    \"editor.wordHighlightBackground\": \"#515c7e44\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#515c7e55\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#698cd6\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#68b3de\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#9a7ecc\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#25aac2\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#80a856\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#c49a5a\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#db4b4b\",\n\
  \    \"editorBracketMatch.background\": \"#16161e\",\n\
  \    \"editorBracketMatch.border\": \"#42465d\",\n\
  \    \"editorBracketPairGuide.activeBackground1\": \"#698cd6\",\n\
  \    \"editorBracketPairGuide.activeBackground2\": \"#68b3de\",\n\
  \    \"editorBracketPairGuide.activeBackground3\": \"#9a7ecc\",\n\
  \    \"editorBracketPairGuide.activeBackground4\": \"#25aac2\",\n\
  \    \"editorBracketPairGuide.activeBackground5\": \"#80a856\",\n\
  \    \"editorBracketPairGuide.activeBackground6\": \"#c49a5a\",\n\
  \    \"editorCodeLens.foreground\": \"#51597d\",\n\
  \    \"editorCursor.foreground\": \"#c0caf5\",\n\
  \    \"editorError.foreground\": \"#db4b4b\",\n\
  \    \"editorGhostText.foreground\": \"#646e9c\",\n\
  \    \"editorGroup.border\": \"#101014\",\n\
  \    \"editorGroup.dropBackground\": \"#1e202e\",\n\
  \    \"editorGroupHeader.border\": \"#101014\",\n\
  \    \"editorGroupHeader.noTabsBackground\": \"#16161e\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#16161e\",\n\
  \    \"editorGroupHeader.tabsBorder\": \"#101014\",\n\
  \    \"editorGutter.addedBackground\": \"#164846\",\n\
  \    \"editorGutter.deletedBackground\": \"#823c41\",\n\
  \    \"editorGutter.modifiedBackground\": \"#394b70\",\n\
  \    \"editorHint.foreground\": \"#0da0ba\",\n\
  \    \"editorHoverWidget.background\": \"#16161e\",\n\
  \    \"editorHoverWidget.border\": \"#101014\",\n\
  \    \"editorIndentGuide.activeBackground1\": \"#363b54\",\n\
  \    \"editorIndentGuide.background1\": \"#232433\",\n\
  \    \"editorInfo.foreground\": \"#0da0ba\",\n\
  \    \"editorInlayHint.foreground\": \"#646e9c\",\n\
  \    \"editorLightBulb.foreground\": \"#e0af68\",\n\
  \    \"editorLightBulbAutoFix.foreground\": \"#e0af68\",\n\
  \    \"editorLineNumber.activeForeground\": \"#787c99\",\n\
  \    \"editorLineNumber.foreground\": \"#363b54\",\n\
  \    \"editorLink.activeForeground\": \"#acb0d0\",\n\
  \    \"editorMarkerNavigation.background\": \"#16161e\",\n\
  \    \"editorOverviewRuler.addedForeground\": \"#164846\",\n\
  \    \"editorOverviewRuler.border\": \"#101014\",\n\
  \    \"editorOverviewRuler.bracketMatchForeground\": \"#101014\",\n\
  \    \"editorOverviewRuler.deletedForeground\": \"#703438\",\n\
  \    \"editorOverviewRuler.errorForeground\": \"#db4b4b\",\n\
  \    \"editorOverviewRuler.findMatchForeground\": \"#a9b1d644\",\n\
  \    \"editorOverviewRuler.infoForeground\": \"#1abc9c\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#394b70\",\n\
  \    \"editorOverviewRuler.rangeHighlightForeground\": \"#a9b1d644\",\n\
  \    \"editorOverviewRuler.selectionHighlightForeground\": \"#a9b1d622\",\n\
  \    \"editorOverviewRuler.warningForeground\": \"#e0af68\",\n\
  \    \"editorOverviewRuler.wordHighlightForeground\": \"#bb9af755\",\n\
  \    \"editorOverviewRuler.wordHighlightStrongForeground\": \"#bb9af766\",\n\
  \    \"editorPane.background\": \"#1a1b26\",\n\
  \    \"editorRuler.foreground\": \"#101014\",\n\
  \    \"editorSuggestWidget.background\": \"#16161e\",\n\
  \    \"editorSuggestWidget.border\": \"#101014\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#6183bb\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#20222c\",\n\
  \    \"editorWarning.foreground\": \"#e0af68\",\n\
  \    \"editorWhitespace.foreground\": \"#363b54\",\n\
  \    \"editorWidget.background\": \"#16161e\",\n\
  \    \"editorWidget.border\": \"#101014\",\n\
  \    \"editorWidget.foreground\": \"#787c99\",\n\
  \    \"editorWidget.resizeBorder\": \"#545c7e33\",\n\
  \    \"errorForeground\": \"#515670\",\n\
  \    \"extensionBadge.remoteBackground\": \"#3d59a1\",\n\
  \    \"extensionBadge.remoteForeground\": \"#ffffff\",\n\
  \    \"extensionButton.prominentBackground\": \"#3d59a1DD\",\n\
  \    \"extensionButton.prominentForeground\": \"#ffffff\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#3d59a1AA\",\n\
  \    \"focusBorder\": \"#545c7e33\",\n\
  \    \"foreground\": \"#787c99\",\n\
  \    \"gitDecoration.addedResourceForeground\": \"#449dab\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#e0af68cc\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#914c54\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#515670\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#6183bb\",\n\
  \    \"gitDecoration.renamedResourceForeground\": \"#449dab\",\n\
  \    \"gitDecoration.stageDeletedResourceForeground\": \"#914c54\",\n\
  \    \"gitDecoration.stageModifiedResourceForeground\": \"#6183bb\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#449dab\",\n\
  \    \"gitlens.gutterBackgroundColor\": \"#16161e\",\n\
  \    \"gitlens.gutterForegroundColor\": \"#787c99\",\n\
  \    \"gitlens.gutterUncommittedForegroundColor\": \"#7aa2f7\",\n\
  \    \"gitlens.trailingLineForegroundColor\": \"#646e9c\",\n\
  \    \"icon.foreground\": \"#787c99\",\n\
  \    \"inlineChat.foreground\": \"#a9b1d6\",\n\
  \    \"inlineChatDiff.inserted\": \"#41a6b540\",\n\
  \    \"inlineChatDiff.removed\": \"#db4b4b42\",\n\
  \    \"inlineChatInput.background\": \"#14141b\",\n\
  \    \"input.background\": \"#14141b\",\n\
  \    \"input.border\": \"#0f0f14\",\n\
  \    \"input.foreground\": \"#a9b1d6\",\n\
  \    \"input.placeholderForeground\": \"#787c998A\",\n\
  \    \"inputOption.activeBackground\": \"#3d59a144\",\n\
  \    \"inputOption.activeForeground\": \"#c0caf5\",\n\
  \    \"inputValidation.errorBackground\": \"#85353e\",\n\
  \    \"inputValidation.errorBorder\": \"#963c47\",\n\
  \    \"inputValidation.errorForeground\": \"#bbc2e0\",\n\
  \    \"inputValidation.infoBackground\": \"#3d59a15c\",\n\
  \    \"inputValidation.infoBorder\": \"#3d59a1\",\n\
  \    \"inputValidation.infoForeground\": \"#bbc2e0\",\n\
  \    \"inputValidation.warningBackground\": \"#c2985b\",\n\
  \    \"inputValidation.warningBorder\": \"#e0af68\",\n\
  \    \"inputValidation.warningForeground\": \"#000000\",\n\
  \    \"list.activeSelectionBackground\": \"#202330\",\n\
  \    \"list.activeSelectionForeground\": \"#a9b1d6\",\n\
  \    \"list.deemphasizedForeground\": \"#787c99\",\n\
  \    \"list.dropBackground\": \"#1e202e\",\n\
  \    \"list.errorForeground\": \"#bb616b\",\n\
  \    \"list.focusBackground\": \"#1c1d29\",\n\
  \    \"list.focusForeground\": \"#a9b1d6\",\n\
  \    \"list.highlightForeground\": \"#668ac4\",\n\
  \    \"list.hoverBackground\": \"#13131a\",\n\
  \    \"list.hoverForeground\": \"#a9b1d6\",\n\
  \    \"list.inactiveSelectionBackground\": \"#1c1d29\",\n\
  \    \"list.inactiveSelectionForeground\": \"#a9b1d6\",\n\
  \    \"list.invalidItemForeground\": \"#c97018\",\n\
  \    \"list.warningForeground\": \"#c49a5a\",\n\
  \    \"listFilterWidget.background\": \"#101014\",\n\
  \    \"listFilterWidget.noMatchesOutline\": \"#a6333f\",\n\
  \    \"listFilterWidget.outline\": \"#3d59a1\",\n\
  \    \"menu.background\": \"#16161e\",\n\
  \    \"menu.border\": \"#101014\",\n\
  \    \"menu.foreground\": \"#787c99\",\n\
  \    \"menu.selectionBackground\": \"#1e202e\",\n\
  \    \"menu.selectionForeground\": \"#a9b1d6\",\n\
  \    \"menu.separatorBackground\": \"#101014\",\n\
  \    \"menubar.selectionBackground\": \"#1e202e\",\n\
  \    \"menubar.selectionBorder\": \"#1b1e2e\",\n\
  \    \"menubar.selectionForeground\": \"#a9b1d6\",\n\
  \    \"merge.currentContentBackground\": \"#007a7544\",\n\
  \    \"merge.currentHeaderBackground\": \"#41a6b525\",\n\
  \    \"merge.incomingContentBackground\": \"#3d59a144\",\n\
  \    \"merge.incomingHeaderBackground\": \"#3d59a1aa\",\n\
  \    \"mergeEditor.change.background\": \"#41a6b525\",\n\
  \    \"mergeEditor.change.word.background\": \"#41a6b540\",\n\
  \    \"mergeEditor.conflict.handled.minimapOverViewRuler\": \"#449dab\",\n\
  \    \"mergeEditor.conflict.handledFocused.border\": \"#41a6b565\",\n\
  \    \"mergeEditor.conflict.handledUnfocused.border\": \"#41a6b525\",\n\
  \    \"mergeEditor.conflict.unhandled.minimapOverViewRuler\": \"#e0af68\",\n\
  \    \"mergeEditor.conflict.unhandledFocused.border\": \"#e0af68b0\",\n\
  \    \"mergeEditor.conflict.unhandledUnfocused.border\": \"#e0af6888\",\n\
  \    \"minimapGutter.addedBackground\": \"#1C5957\",\n\
  \    \"minimapGutter.deletedBackground\": \"#944449\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#425882\",\n\
  \    \"multiDiffEditor.border\": \"#1a1b26\",\n\
  \    \"multiDiffEditor.headerBackground\": \"#1a1b26\",\n\
  \    \"notebook.cellBorderColor\": \"#101014\",\n\
  \    \"notebook.cellEditorBackground\": \"#16161e\",\n\
  \    \"notebook.cellStatusBarItemHoverBackground\": \"#1c1d29\",\n\
  \    \"notebook.editorBackground\": \"#1a1b26\",\n\
  \    \"notebook.focusedCellBorder\": \"#29355a\",\n\
  \    \"notificationCenterHeader.background\": \"#101014\",\n\
  \    \"notificationLink.foreground\": \"#6183bb\",\n\
  \    \"notifications.background\": \"#101014\",\n\
  \    \"notificationsErrorIcon.foreground\": \"#bb616b\",\n\
  \    \"notificationsInfoIcon.foreground\": \"#0da0ba\",\n\
  \    \"notificationsWarningIcon.foreground\": \"#bba461\",\n\
  \    \"panel.background\": \"#16161e\",\n\
  \    \"panel.border\": \"#101014\",\n\
  \    \"panelInput.border\": \"#16161e\",\n\
  \    \"panelTitle.activeBorder\": \"#16161e\",\n\
  \    \"panelTitle.activeForeground\": \"#787c99\",\n\
  \    \"panelTitle.inactiveForeground\": \"#42465d\",\n\
  \    \"peekView.border\": \"#101014\",\n\
  \    \"peekViewEditor.background\": \"#16161e\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#3d59a166\",\n\
  \    \"peekViewResult.background\": \"#101014\",\n\
  \    \"peekViewResult.fileForeground\": \"#787c99\",\n\
  \    \"peekViewResult.lineForeground\": \"#a9b1d6\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#3d59a166\",\n\
  \    \"peekViewResult.selectionBackground\": \"#3d59a133\",\n\
  \    \"peekViewResult.selectionForeground\": \"#a9b1d6\",\n\
  \    \"peekViewTitle.background\": \"#101014\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#787c99\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#a9b1d6\",\n\
  \    \"pickerGroup.border\": \"#101014\",\n\
  \    \"pickerGroup.foreground\": \"#a9b1d6\",\n\
  \    \"progressBar.background\": \"#3d59a1\",\n\
  \    \"sash.hoverBorder\": \"#29355a\",\n\
  \    \"scmGraph.foreground1\": \"#ff9e64\",\n\
  \    \"scmGraph.foreground2\": \"#e0af68\",\n\
  \    \"scmGraph.foreground3\": \"#41a6b5\",\n\
  \    \"scmGraph.foreground4\": \"#7aa2f7\",\n\
  \    \"scmGraph.foreground5\": \"#bb9af7\",\n\
  \    \"scmGraph.historyItemBaseRefColor\": \"#9d7cd8\",\n\
  \    \"scmGraph.historyItemHoverAdditionsForeground\": \"#41a6b5\",\n\
  \    \"scmGraph.historyItemHoverDefaultLabelForeground\": \"#a9b1d6\",\n\
  \    \"scmGraph.historyItemHoverDeletionsForeground\": \"#f7768e\",\n\
  \    \"scmGraph.historyItemHoverLabelForeground\": \"#1b1e2e\",\n\
  \    \"scmGraph.historyItemRefColor\": \"#506FCA\",\n\
  \    \"scmGraph.historyItemRemoteRefColor\": \"#41a6b5\",\n\
  \    \"scrollbar.shadow\": \"#00000033\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#868bc422\",\n\
  \    \"scrollbarSlider.background\": \"#868bc415\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#868bc410\",\n\
  \    \"selection.background\": \"#515c7e40\",\n\
  \    \"settings.headerForeground\": \"#6183bb\",\n\
  \    \"sideBar.background\": \"#16161e\",\n\
  \    \"sideBar.border\": \"#101014\",\n\
  \    \"sideBar.dropBackground\": \"#1e202e\",\n\
  \    \"sideBar.foreground\": \"#787c99\",\n\
  \    \"sideBarSectionHeader.background\": \"#16161e\",\n\
  \    \"sideBarSectionHeader.border\": \"#101014\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#a9b1d6\",\n\
  \    \"sideBarTitle.foreground\": \"#787c99\",\n\
  \    \"statusBar.background\": \"#16161e\",\n\
  \    \"statusBar.border\": \"#101014\",\n\
  \    \"statusBar.debuggingBackground\": \"#16161e\",\n\
  \    \"statusBar.debuggingForeground\": \"#787c99\",\n\
  \    \"statusBar.foreground\": \"#787c99\",\n\
  \    \"statusBar.noFolderBackground\": \"#16161e\",\n\
  \    \"statusBarItem.activeBackground\": \"#101014\",\n\
  \    \"statusBarItem.hoverBackground\": \"#20222c\",\n\
  \    \"statusBarItem.prominentBackground\": \"#101014\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#20222c\",\n\
  \    \"tab.activeBackground\": \"#16161e\",\n\
  \    \"tab.activeBorder\": \"#3d59a1\",\n\
  \    \"tab.activeForeground\": \"#a9b1d6\",\n\
  \    \"tab.activeModifiedBorder\": \"#1a1b26\",\n\
  \    \"tab.border\": \"#101014\",\n\
  \    \"tab.hoverForeground\": \"#a9b1d6\",\n\
  \    \"tab.inactiveBackground\": \"#16161e\",\n\
  \    \"tab.inactiveForeground\": \"#787c99\",\n\
  \    \"tab.inactiveModifiedBorder\": \"#1f202e\",\n\
  \    \"tab.lastPinnedBorder\": \"#222333\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#1f202e\",\n\
  \    \"tab.unfocusedActiveForeground\": \"#a9b1d6\",\n\
  \    \"tab.unfocusedHoverForeground\": \"#a9b1d6\",\n\
  \    \"tab.unfocusedInactiveForeground\": \"#787c99\",\n\
  \    \"terminal.ansiBlack\": \"#363b54\",\n\
  \    \"terminal.ansiBlue\": \"#7aa2f7\",\n\
  \    \"terminal.ansiBrightBlack\": \"#363b54\",\n\
  \    \"terminal.ansiBrightBlue\": \"#7aa2f7\",\n\
  \    \"terminal.ansiBrightCyan\": \"#7dcfff\",\n\
  \    \"terminal.ansiBrightGreen\": \"#73daca\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#bb9af7\",\n\
  \    \"terminal.ansiBrightRed\": \"#f7768e\",\n\
  \    \"terminal.ansiBrightWhite\": \"#acb0d0\",\n\
  \    \"terminal.ansiBrightYellow\": \"#e0af68\",\n\
  \    \"terminal.ansiCyan\": \"#7dcfff\",\n\
  \    \"terminal.ansiGreen\": \"#73daca\",\n\
  \    \"terminal.ansiMagenta\": \"#bb9af7\",\n\
  \    \"terminal.ansiRed\": \"#f7768e\",\n\
  \    \"terminal.ansiWhite\": \"#787c99\",\n\
  \    \"terminal.ansiYellow\": \"#e0af68\",\n\
  \    \"terminal.background\": \"#16161e\",\n\
  \    \"terminal.foreground\": \"#787c99\",\n\
  \    \"terminal.selectionBackground\": \"#515c7e4d\",\n\
  \    \"textBlockQuote.background\": \"#16161e\",\n\
  \    \"textCodeBlock.background\": \"#16161e\",\n\
  \    \"textLink.activeForeground\": \"#7dcfff\",\n\
  \    \"textLink.foreground\": \"#6183bb\",\n\
  \    \"textPreformat.foreground\": \"#9699a8\",\n\
  \    \"textSeparator.foreground\": \"#363b54\",\n\
  \    \"titleBar.activeBackground\": \"#16161e\",\n\
  \    \"titleBar.activeForeground\": \"#787c99\",\n\
  \    \"titleBar.border\": \"#101014\",\n\
  \    \"titleBar.inactiveBackground\": \"#16161e\",\n\
  \    \"titleBar.inactiveForeground\": \"#787c99\",\n\
  \    \"toolbar.activeBackground\": \"#202330\",\n\
  \    \"toolbar.hoverBackground\": \"#202330\",\n\
  \    \"tree.indentGuidesStroke\": \"#2b2b3b\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#16161e\",\n\
  \    \"widget.shadow\": \"#ffffff00\",\n\
  \    \"window.activeBorder\": \"#0d0f17\",\n\
  \    \"window.inactiveBorder\": \"#0d0f17\"\n\
  \  },\n\
  \  \"displayName\": \"Tokyo Night\",\n\
  \  \"name\": \"tokyo-night\",\n\
  \  \"semanticTokenColors\": {\n\
  \    \"*.defaultLibrary\": {\n\
  \      \"foreground\": \"#2ac3de\"\n\
  \    },\n\
  \    \"parameter\": {\n\
  \      \"foreground\": \"#d9d4cd\"\n\
  \    },\n\
  \    \"parameter.declaration\": {\n\
  \      \"foreground\": \"#e0af68\"\n\
  \    },\n\
  \    \"property.declaration\": {\n\
  \      \"foreground\": \"#73daca\"\n\
  \    },\n\
  \    \"property.defaultLibrary\": {\n\
  \      \"foreground\": \"#2ac3de\"\n\
  \    },\n\
  \    \"variable\": {\n\
  \      \"foreground\": \"#c0caf5\"\n\
  \    },\n\
  \    \"variable.declaration\": {\n\
  \      \"foreground\": \"#bb9af7\"\n\
  \    },\n\
  \    \"variable.defaultLibrary\": {\n\
  \      \"foreground\": \"#2ac3de\"\n\
  \    }\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"meta.var.expr storage.type\",\n\
  \        \"keyword.control.flow\",\n\
  \        \"keyword.control.return\",\n\
  \        \"meta.directive.vue punctuation.separator.key-value.html\",\n\
  \        \"meta.directive.vue entity.other.attribute-name.html\",\n\
  \        \"tag.decorator.js entity.name.tag.js\",\n\
  \        \"tag.decorator.js punctuation.definition.tag.js\",\n\
  \        \"storage.modifier\",\n\
  \        \"string.quoted.docstring.multi\",\n\
  \        \"string.quoted.docstring.multi.python \
   punctuation.definition.string.begin\",\n\
  \        \"string.quoted.docstring.multi.python \
   punctuation.definition.string.end\",\n\
  \        \"string.quoted.docstring.multi.python constant.character.escape\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.flow.block-scalar.literal\",\n\
  \        \"keyword.control.flow.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"comment.block.documentation\",\n\
  \        \"punctuation.definition.comment\",\n\
  \        \"comment.block.documentation punctuation\",\n\
  \        \"string.quoted.docstring.multi\",\n\
  \        \"string.quoted.docstring.multi.python \
   punctuation.definition.string.begin\",\n\
  \        \"string.quoted.docstring.multi.python \
   punctuation.definition.string.end\",\n\
  \        \"string.quoted.docstring.multi.python constant.character.escape\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#51597d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.assignment.jsdoc\",\n\
  \        \"comment.block.documentation variable\",\n\
  \        \"comment.block.documentation storage\",\n\
  \        \"comment.block.documentation keyword\",\n\
  \        \"comment.block.documentation support\",\n\
  \        \"comment.block.documentation markup\",\n\
  \        \"comment.block.documentation markup.inline.raw.string.markdown\",\n\
  \        \"meta.other.type.phpdoc.php keyword.other.type.php\",\n\
  \        \"meta.other.type.phpdoc.php support.other.namespace.php\",\n\
  \        \"meta.other.type.phpdoc.php punctuation.separator.inheritance.php\",\n\
  \        \"meta.other.type.phpdoc.php support.class\",\n\
  \        \"keyword.other.phpdoc.php\",\n\
  \        \"log.date\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5a638c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.other.type.phpdoc.php support.class\",\n\
  \        \"comment.block.documentation storage.type\",\n\
  \        \"comment.block.documentation punctuation.definition.block.tag\",\n\
  \        \"comment.block.documentation entity.name.type.instance\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#646e9c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant\",\n\
  \        \"punctuation.definition.constant\",\n\
  \        \"constant.language\",\n\
  \        \"constant.numeric\",\n\
  \        \"support.constant\",\n\
  \        \"constant.other.caps\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff9e64\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"constant.other.symbol\",\n\
  \        \"constant.other.key\",\n\
  \        \"meta.attribute-selector\",\n\
  \        \"string constant.character\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#9ece6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.color\",\n\
  \        \"constant.other.color.rgb-value.hex \
   punctuation.definition.constant\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9aa5ce\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"invalid\",\n\
  \        \"invalid.illegal\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff5370\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.deprecated\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.var.expr storage.type\",\n\
  \        \"storage.modifier\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9d7cd8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.template-expression\",\n\
  \        \"punctuation.section.embedded\",\n\
  \        \"meta.embedded.line.tag.smarty\",\n\
  \        \"support.constant.handlebars\",\n\
  \        \"punctuation.section.tag.twig\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.smarty\",\n\
  \        \"keyword.control.twig\",\n\
  \        \"support.constant.handlebars keyword.control\",\n\
  \        \"keyword.operator.comparison.twig\",\n\
  \        \"keyword.blade\",\n\
  \        \"entity.name.function.blade\",\n\
  \        \"meta.tag.blade keyword.other.type.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.spread\",\n\
  \        \"keyword.operator.rest\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator\",\n\
  \        \"keyword.control.as\",\n\
  \        \"keyword.other\",\n\
  \        \"keyword.operator.bitwise.shift\",\n\
  \        \"punctuation\",\n\
  \        \"expression.embbeded.vue punctuation.definition.tag\",\n\
  \        \"text.html.twig meta.tag.inline.any.html\",\n\
  \        \"meta.tag.template.value.twig meta.function.arguments.twig\",\n\
  \        \"meta.directive.vue punctuation.separator.key-value.html\",\n\
  \        \"punctuation.definition.constant.markdown\",\n\
  \        \"punctuation.definition.string\",\n\
  \        \"punctuation.support.type.property-name\",\n\
  \        \"text.html.vue-html meta.tag\",\n\
  \        \"meta.attribute.directive\",\n\
  \        \"punctuation.definition.keyword\",\n\
  \        \"punctuation.terminator.rule\",\n\
  \        \"punctuation.definition.entity\",\n\
  \        \"punctuation.separator.inheritance.php\",\n\
  \        \"keyword.other.template\",\n\
  \        \"keyword.other.substitution\",\n\
  \        \"entity.name.operator\",\n\
  \        \"meta.property-list punctuation.separator.key-value\",\n\
  \        \"meta.at-rule.mixin punctuation.separator.key-value\",\n\
  \        \"meta.at-rule.function variable.parameter.url\",\n\
  \        \"meta.embedded.inline.phpx punctuation.definition.tag.begin.html\",\n\
  \        \"meta.embedded.inline.phpx punctuation.definition.tag.end.html\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89ddff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.module.js\",\n\
  \        \"keyword.control.import\",\n\
  \        \"keyword.control.export\",\n\
  \        \"keyword.control.from\",\n\
  \        \"keyword.control.default\",\n\
  \        \"meta.import keyword.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword\",\n\
  \        \"keyword.control\",\n\
  \        \"keyword.other.important\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.DML\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.logical\",\n\
  \        \"storage.type.function\",\n\
  \        \"keyword.operator.bitwise\",\n\
  \        \"keyword.operator.ternary\",\n\
  \        \"keyword.operator.comparison\",\n\
  \        \"keyword.operator.relational\",\n\
  \        \"keyword.operator.or.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag support.class.component\",\n\
  \        \"meta.tag.custom entity.name.tag\",\n\
  \        \"meta.tag.other.unrecognized.html.derivative entity.name.tag\",\n\
  \        \"meta.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#de5971\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.tag\",\n\
  \        \"text.html.php meta.embedded.block.html \
   meta.tag.metadata.script.end.html punctuation.definition.tag.begin.html \
   text.html.basic\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ba3c97\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.php\",\n\
  \        \"variable.other.global.safer\",\n\
  \        \"variable.other.global.safer punctuation.definition.variable\",\n\
  \        \"variable.other.global\",\n\
  \        \"variable.other.global punctuation.definition.variable\",\n\
  \        \"constant.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e0af68\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable\",\n\
  \        \"support.variable\",\n\
  \        \"string constant.other.placeholder\",\n\
  \        \"variable.parameter.handlebars\",\n\
  \        \"variable.other.object\",\n\
  \        \"meta.fstring\",\n\
  \        \"meta.function-call meta.function-call.arguments\",\n\
  \        \"meta.embedded.inline.phpx constant.other.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.array.literal variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.object-literal.key\",\n\
  \        \"entity.name.type.hcl\",\n\
  \        \"string.alias.graphql\",\n\
  \        \"string.unquoted.graphql\",\n\
  \        \"string.unquoted.alias.graphql\",\n\
  \        \"meta.group.braces.curly constant.other.object.key.js \
   string.unquoted.label.js\",\n\
  \        \"meta.field.declaration.ts variable.object.property\",\n\
  \        \"meta.block entity.name.label\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73daca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.property\",\n\
  \        \"support.variable.property\",\n\
  \        \"support.variable.property.dom\",\n\
  \        \"meta.function-call variable.other.object.property\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.object.property\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.objectliteral meta.object.member meta.objectliteral \
   meta.object.member meta.objectliteral meta.object.member \
   meta.object-literal.key\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#41a6b5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.cpp meta.block variable.other\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.other.variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.class-method.js entity.name.function.js\",\n\
  \        \"entity.name.method.js\",\n\
  \        \"variable.function.constructor\",\n\
  \        \"keyword.other.special-method\",\n\
  \        \"storage.type.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"variable.other.enummember\",\n\
  \        \"meta.function-call\",\n\
  \        \"meta.function-call entity.name.function\",\n\
  \        \"variable.function\",\n\
  \        \"meta.definition.method entity.name.function\",\n\
  \        \"meta.object-literal entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter.function.language.special\",\n\
  \        \"variable.parameter\",\n\
  \        \"meta.function.parameters punctuation.definition.variable\",\n\
  \        \"meta.function.parameter variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e0af68\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.type.php\",\n\
  \        \"storage.type.php\",\n\
  \        \"constant.character\",\n\
  \        \"constant.escape\",\n\
  \        \"keyword.other.unit\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.definition.variable variable.other.constant\",\n\
  \        \"meta.definition.variable variable.other.readwrite\",\n\
  \        \"variable.declaration.hcl variable.other.readwrite.hcl\",\n\
  \        \"meta.mapping.key.hcl variable.other.readwrite.hcl\",\n\
  \        \"variable.other.declaration\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.inherited-class\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class\",\n\
  \        \"support.type\",\n\
  \        \"variable.other.readwrite.alias\",\n\
  \        \"support.orther.namespace.use.php\",\n\
  \        \"meta.use.php\",\n\
  \        \"support.other.namespace.php\",\n\
  \        \"support.type.sys-types\",\n\
  \        \"support.variable.dom\",\n\
  \        \"support.constant.math\",\n\
  \        \"support.type.object.module\",\n\
  \        \"support.constant.json\",\n\
  \        \"entity.name.namespace\",\n\
  \        \"meta.import.qualifier\",\n\
  \        \"variable.other.constant.object\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css support.type.property-name\",\n\
  \        \"source.sass support.type.property-name\",\n\
  \        \"source.scss support.type.property-name\",\n\
  \        \"source.less support.type.property-name\",\n\
  \        \"source.stylus support.type.property-name\",\n\
  \        \"source.postcss support.type.property-name\",\n\
  \        \"support.type.property-name.css\",\n\
  \        \"support.type.vendored.property-name\",\n\
  \        \"support.type.map.key\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.font-name\",\n\
  \        \"meta.definition.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9ece6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.class\",\n\
  \        \"meta.at-rule.mixin.scss entity.name.function.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9ece6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.id\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fc7b7b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.pseudo-class \
   punctuation.definition.entity\",\n\
  \        \"entity.other.attribute-name.pseudo-element \
   punctuation.definition.entity\",\n\
  \        \"entity.other.attribute-name.class punctuation.definition.entity\",\n\
  \        \"entity.name.tag.reference\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e0af68\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.property-list\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9abdf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.property-list meta.at-rule.if\",\n\
  \        \"meta.at-rule.return variable.parameter.url\",\n\
  \        \"meta.property-list meta.at-rule.else\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff9e64\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.parent-selector-suffix \
   punctuation.definition.entity.css\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73daca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.property-list meta.property-list\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9abdf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.at-rule.mixin keyword.control.at-rule.mixin\",\n\
  \        \"meta.at-rule.include entity.name.function.scss\",\n\
  \        \"meta.at-rule.include keyword.control.at-rule.include\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.at-rule.include punctuation.definition.keyword\",\n\
  \        \"keyword.control.at-rule.mixin punctuation.definition.keyword\",\n\
  \        \"meta.at-rule.include keyword.control.at-rule.include\",\n\
  \        \"keyword.control.at-rule.extend punctuation.definition.keyword\",\n\
  \        \"meta.at-rule.extend keyword.control.at-rule.extend\",\n\
  \        \"entity.other.attribute-name.placeholder.css \
   punctuation.definition.entity.css\",\n\
  \        \"meta.at-rule.media keyword.control.at-rule.media\",\n\
  \        \"meta.at-rule.mixin keyword.control.at-rule.mixin\",\n\
  \        \"meta.at-rule.function keyword.control.at-rule.function\",\n\
  \        \"keyword.control punctuation.definition.keyword\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9d7cd8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.property-list meta.at-rule.include\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.property-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff9e64\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.module.js\",\n\
  \        \"variable.import.parameter.js\",\n\
  \        \"variable.other.class.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other punctuation.definition.variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js constant.other.object.key.js string.unquoted.label.js\",\n\
  \        \"variable.language.this punctuation.definition.variable\",\n\
  \        \"keyword.other.this\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name\",\n\
  \        \"text.html.basic entity.other.attribute-name.html\",\n\
  \        \"text.html.basic entity.other.attribute-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html constant.character.entity\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0DB9D7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.id.html\",\n\
  \        \"meta.directive.vue entity.other.attribute-name.html\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.sass keyword.control\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.pseudo-class\",\n\
  \        \"entity.other.attribute-name.pseudo-element\",\n\
  \        \"entity.other.attribute-name.placeholder\",\n\
  \        \"meta.property-list meta.property-value\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#449dab\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#914c54\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#6183bb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b4f9f8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.group\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.character-class.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.character-class.set.regexp\",\n\
  \        \"punctuation.definition.character-class.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e0af68\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89ddff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape.backslash\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89ddff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"tag.decorator.js entity.name.tag.js\",\n\
  \        \"tag.decorator.js punctuation.definition.tag.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dcfff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e0af68\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73daca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9ece6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.list_item.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9abdf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.block\",\n\
  \        \"meta.brace\",\n\
  \        \"punctuation.definition.block\",\n\
  \        \"punctuation.definition.use\",\n\
  \        \"punctuation.definition.class\",\n\
  \        \"punctuation.definition.begin.bracket\",\n\
  \        \"punctuation.definition.end.bracket\",\n\
  \        \"punctuation.definition.switch-expression.begin.bracket\",\n\
  \        \"punctuation.definition.switch-expression.end.bracket\",\n\
  \        \"punctuation.definition.section.switch-block.begin.bracket\",\n\
  \        \"punctuation.definition.section.switch-block.end.bracket\",\n\
  \        \"punctuation.definition.group.shell\",\n\
  \        \"punctuation.definition.parameters\",\n\
  \        \"punctuation.definition.arguments\",\n\
  \        \"punctuation.definition.dictionary\",\n\
  \        \"punctuation.definition.array\",\n\
  \        \"punctuation.section\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9abdf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.embedded.block\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.tag JSXNested\",\n\
  \        \"meta.jsx.children\",\n\
  \        \"text.html\",\n\
  \        \"text.log\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9aa5ce\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown markup.inline.raw.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bb9af7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown markup.inline.raw.markdown \
   punctuation.definition.raw.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#4E5579\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.1.markdown entity.name\",\n\
  \        \"heading.1.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#89ddff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.2.markdown entity.name\",\n\
  \        \"heading.2.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#61bdf2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.3.markdown entity.name\",\n\
  \        \"heading.3.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.4.markdown entity.name\",\n\
  \        \"heading.4.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#6d91de\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.5.markdown entity.name\",\n\
  \        \"heading.5.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#9aa5ce\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.6.markdown entity.name\",\n\
  \        \"heading.6.markdown punctuation.definition.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#747ca1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.italic\",\n\
  \        \"markup.italic punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.bold\",\n\
  \        \"markup.bold punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.bold markup.italic\",\n\
  \        \"markup.bold markup.italic punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold italic\",\n\
  \        \"foreground\": \"#c0caf5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.underline\",\n\
  \        \"markup.underline punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.quote punctuation.definition.blockquote.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#4e5579\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.quote\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.other.link\",\n\
  \        \"markup.underline.link\",\n\
  \        \"constant.other.reference.link.markdown\",\n\
  \        \"string.other.link.description.title.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73daca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.fenced_code.block.markdown\",\n\
  \        \"markup.inline.raw.string.markdown\",\n\
  \        \"variable.language.fenced.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89ddff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.separator\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#51597d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.table\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c0cefc\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.info-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#0db9d7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.warn-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffdb69\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.error-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#db4b4b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.debug-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b267e6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.tag.apacheconf\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f7768e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.preprocessor\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73daca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.env\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7aa2f7\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let everforest_dark =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.activeBorder\": \"#a7c080d0\",\n\
  \    \"activityBar.activeFocusBorder\": \"#a7c080\",\n\
  \    \"activityBar.background\": \"#2d353b\",\n\
  \    \"activityBar.border\": \"#2d353b\",\n\
  \    \"activityBar.dropBackground\": \"#2d353b\",\n\
  \    \"activityBar.foreground\": \"#d3c6aa\",\n\
  \    \"activityBar.inactiveForeground\": \"#859289\",\n\
  \    \"activityBarBadge.background\": \"#a7c080\",\n\
  \    \"activityBarBadge.foreground\": \"#2d353b\",\n\
  \    \"badge.background\": \"#a7c080\",\n\
  \    \"badge.foreground\": \"#2d353b\",\n\
  \    \"breadcrumb.activeSelectionForeground\": \"#d3c6aa\",\n\
  \    \"breadcrumb.focusForeground\": \"#d3c6aa\",\n\
  \    \"breadcrumb.foreground\": \"#859289\",\n\
  \    \"button.background\": \"#a7c080\",\n\
  \    \"button.foreground\": \"#2d353b\",\n\
  \    \"button.hoverBackground\": \"#a7c080d0\",\n\
  \    \"button.secondaryBackground\": \"#3d484d\",\n\
  \    \"button.secondaryForeground\": \"#d3c6aa\",\n\
  \    \"button.secondaryHoverBackground\": \"#475258\",\n\
  \    \"charts.blue\": \"#7fbbb3\",\n\
  \    \"charts.foreground\": \"#d3c6aa\",\n\
  \    \"charts.green\": \"#a7c080\",\n\
  \    \"charts.orange\": \"#e69875\",\n\
  \    \"charts.purple\": \"#d699b6\",\n\
  \    \"charts.red\": \"#e67e80\",\n\
  \    \"charts.yellow\": \"#dbbc7f\",\n\
  \    \"checkbox.background\": \"#2d353b\",\n\
  \    \"checkbox.border\": \"#4f585e\",\n\
  \    \"checkbox.foreground\": \"#e69875\",\n\
  \    \"debugConsole.errorForeground\": \"#e67e80\",\n\
  \    \"debugConsole.infoForeground\": \"#a7c080\",\n\
  \    \"debugConsole.sourceForeground\": \"#d699b6\",\n\
  \    \"debugConsole.warningForeground\": \"#dbbc7f\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#83c092\",\n\
  \    \"debugIcon.breakpointCurrentStackframeForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.breakpointDisabledForeground\": \"#da6362\",\n\
  \    \"debugIcon.breakpointForeground\": \"#e67e80\",\n\
  \    \"debugIcon.breakpointStackframeForeground\": \"#e67e80\",\n\
  \    \"debugIcon.breakpointUnverifiedForeground\": \"#9aa79d\",\n\
  \    \"debugIcon.continueForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.disconnectForeground\": \"#d699b6\",\n\
  \    \"debugIcon.pauseForeground\": \"#dbbc7f\",\n\
  \    \"debugIcon.restartForeground\": \"#83c092\",\n\
  \    \"debugIcon.startForeground\": \"#83c092\",\n\
  \    \"debugIcon.stepBackForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.stepIntoForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.stepOutForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.stepOverForeground\": \"#7fbbb3\",\n\
  \    \"debugIcon.stopForeground\": \"#e67e80\",\n\
  \    \"debugTokenExpression.boolean\": \"#d699b6\",\n\
  \    \"debugTokenExpression.error\": \"#e67e80\",\n\
  \    \"debugTokenExpression.name\": \"#7fbbb3\",\n\
  \    \"debugTokenExpression.number\": \"#d699b6\",\n\
  \    \"debugTokenExpression.string\": \"#dbbc7f\",\n\
  \    \"debugTokenExpression.value\": \"#a7c080\",\n\
  \    \"debugToolBar.background\": \"#2d353b\",\n\
  \    \"descriptionForeground\": \"#859289\",\n\
  \    \"diffEditor.diagonalFill\": \"#4f585e\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#569d7930\",\n\
  \    \"diffEditor.removedTextBackground\": \"#da636230\",\n\
  \    \"dropdown.background\": \"#2d353b\",\n\
  \    \"dropdown.border\": \"#4f585e\",\n\
  \    \"dropdown.foreground\": \"#9aa79d\",\n\
  \    \"editor.background\": \"#2d353b\",\n\
  \    \"editor.findMatchBackground\": \"#d77f4840\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#899c4040\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#47525860\",\n\
  \    \"editor.foldBackground\": \"#4f585e80\",\n\
  \    \"editor.foreground\": \"#d3c6aa\",\n\
  \    \"editor.hoverHighlightBackground\": \"#475258b0\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#47525860\",\n\
  \    \"editor.lineHighlightBackground\": \"#3d484d90\",\n\
  \    \"editor.lineHighlightBorder\": \"#4f585e00\",\n\
  \    \"editor.rangeHighlightBackground\": \"#3d484d80\",\n\
  \    \"editor.selectionBackground\": \"#475258c0\",\n\
  \    \"editor.selectionHighlightBackground\": \"#47525860\",\n\
  \    \"editor.snippetFinalTabstopHighlightBackground\": \"#899c4040\",\n\
  \    \"editor.snippetFinalTabstopHighlightBorder\": \"#2d353b\",\n\
  \    \"editor.snippetTabstopHighlightBackground\": \"#3d484d\",\n\
  \    \"editor.symbolHighlightBackground\": \"#5a93a240\",\n\
  \    \"editor.wordHighlightBackground\": \"#47525858\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#475258b0\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#e67e80\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#dbbc7f\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#a7c080\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#7fbbb3\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#e69875\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#d699b6\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#859289\",\n\
  \    \"editorBracketMatch.background\": \"#4f585e\",\n\
  \    \"editorBracketMatch.border\": \"#2d353b00\",\n\
  \    \"editorCodeLens.foreground\": \"#7f897da0\",\n\
  \    \"editorCursor.foreground\": \"#d3c6aa\",\n\
  \    \"editorError.background\": \"#da636200\",\n\
  \    \"editorError.foreground\": \"#da6362\",\n\
  \    \"editorGhostText.background\": \"#2d353b00\",\n\
  \    \"editorGhostText.foreground\": \"#7f897da0\",\n\
  \    \"editorGroup.border\": \"#21272b\",\n\
  \    \"editorGroup.dropBackground\": \"#4f585e60\",\n\
  \    \"editorGroupHeader.noTabsBackground\": \"#2d353b\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#2d353b\",\n\
  \    \"editorGutter.addedBackground\": \"#899c40a0\",\n\
  \    \"editorGutter.background\": \"#2d353b00\",\n\
  \    \"editorGutter.commentRangeForeground\": \"#7f897d\",\n\
  \    \"editorGutter.deletedBackground\": \"#da6362a0\",\n\
  \    \"editorGutter.modifiedBackground\": \"#5a93a2a0\",\n\
  \    \"editorHint.foreground\": \"#b87b9d\",\n\
  \    \"editorHoverWidget.background\": \"#343f44\",\n\
  \    \"editorHoverWidget.border\": \"#475258\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#9aa79d50\",\n\
  \    \"editorIndentGuide.background\": \"#9aa79d20\",\n\
  \    \"editorInfo.background\": \"#5a93a200\",\n\
  \    \"editorInfo.foreground\": \"#5a93a2\",\n\
  \    \"editorInlayHint.background\": \"#2d353b00\",\n\
  \    \"editorInlayHint.foreground\": \"#7f897da0\",\n\
  \    \"editorInlayHint.parameterBackground\": \"#2d353b00\",\n\
  \    \"editorInlayHint.parameterForeground\": \"#7f897da0\",\n\
  \    \"editorInlayHint.typeBackground\": \"#2d353b00\",\n\
  \    \"editorInlayHint.typeForeground\": \"#7f897da0\",\n\
  \    \"editorLightBulb.foreground\": \"#dbbc7f\",\n\
  \    \"editorLightBulbAutoFix.foreground\": \"#83c092\",\n\
  \    \"editorLineNumber.activeForeground\": \"#9aa79de0\",\n\
  \    \"editorLineNumber.foreground\": \"#7f897da0\",\n\
  \    \"editorLink.activeForeground\": \"#a7c080\",\n\
  \    \"editorMarkerNavigation.background\": \"#343f44\",\n\
  \    \"editorMarkerNavigationError.background\": \"#da636280\",\n\
  \    \"editorMarkerNavigationInfo.background\": \"#5a93a280\",\n\
  \    \"editorMarkerNavigationWarning.background\": \"#bf983d80\",\n\
  \    \"editorOverviewRuler.addedForeground\": \"#899c40a0\",\n\
  \    \"editorOverviewRuler.border\": \"#2d353b00\",\n\
  \    \"editorOverviewRuler.commonContentForeground\": \"#859289\",\n\
  \    \"editorOverviewRuler.currentContentForeground\": \"#5a93a2\",\n\
  \    \"editorOverviewRuler.deletedForeground\": \"#da6362a0\",\n\
  \    \"editorOverviewRuler.errorForeground\": \"#e67e80\",\n\
  \    \"editorOverviewRuler.findMatchForeground\": \"#569d79\",\n\
  \    \"editorOverviewRuler.incomingContentForeground\": \"#569d79\",\n\
  \    \"editorOverviewRuler.infoForeground\": \"#d699b6\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#5a93a2a0\",\n\
  \    \"editorOverviewRuler.rangeHighlightForeground\": \"#569d79\",\n\
  \    \"editorOverviewRuler.selectionHighlightForeground\": \"#569d79\",\n\
  \    \"editorOverviewRuler.warningForeground\": \"#dbbc7f\",\n\
  \    \"editorOverviewRuler.wordHighlightForeground\": \"#4f585e\",\n\
  \    \"editorOverviewRuler.wordHighlightStrongForeground\": \"#4f585e\",\n\
  \    \"editorRuler.foreground\": \"#475258a0\",\n\
  \    \"editorSuggestWidget.background\": \"#3d484d\",\n\
  \    \"editorSuggestWidget.border\": \"#3d484d\",\n\
  \    \"editorSuggestWidget.foreground\": \"#d3c6aa\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#a7c080\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#475258\",\n\
  \    \"editorUnnecessaryCode.border\": \"#2d353b\",\n\
  \    \"editorUnnecessaryCode.opacity\": \"#00000080\",\n\
  \    \"editorWarning.background\": \"#bf983d00\",\n\
  \    \"editorWarning.foreground\": \"#bf983d\",\n\
  \    \"editorWhitespace.foreground\": \"#475258\",\n\
  \    \"editorWidget.background\": \"#2d353b\",\n\
  \    \"editorWidget.border\": \"#4f585e\",\n\
  \    \"editorWidget.foreground\": \"#d3c6aa\",\n\
  \    \"errorForeground\": \"#e67e80\",\n\
  \    \"extensionBadge.remoteBackground\": \"#a7c080\",\n\
  \    \"extensionBadge.remoteForeground\": \"#2d353b\",\n\
  \    \"extensionButton.prominentBackground\": \"#a7c080\",\n\
  \    \"extensionButton.prominentForeground\": \"#2d353b\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#a7c080d0\",\n\
  \    \"extensionIcon.preReleaseForeground\": \"#e69875\",\n\
  \    \"extensionIcon.starForeground\": \"#83c092\",\n\
  \    \"extensionIcon.verifiedForeground\": \"#a7c080\",\n\
  \    \"focusBorder\": \"#2d353b00\",\n\
  \    \"foreground\": \"#9aa79d\",\n\
  \    \"gitDecoration.addedResourceForeground\": \"#a7c080a0\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#d699b6a0\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#e67e80a0\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#4f585e\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#7fbbb3a0\",\n\
  \    \"gitDecoration.stageDeletedResourceForeground\": \"#83c092a0\",\n\
  \    \"gitDecoration.stageModifiedResourceForeground\": \"#83c092a0\",\n\
  \    \"gitDecoration.submoduleResourceForeground\": \"#e69875a0\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#dbbc7fa0\",\n\
  \    \"gitlens.closedPullRequestIconColor\": \"#e67e80\",\n\
  \    \"gitlens.decorations.addedForegroundColor\": \"#a7c080\",\n\
  \    \"gitlens.decorations.branchAheadForegroundColor\": \"#83c092\",\n\
  \    \"gitlens.decorations.branchBehindForegroundColor\": \"#e69875\",\n\
  \    \"gitlens.decorations.branchDivergedForegroundColor\": \"#dbbc7f\",\n\
  \    \"gitlens.decorations.branchMissingUpstreamForegroundColor\": \
   \"#e67e80\",\n\
  \    \"gitlens.decorations.branchUnpublishedForegroundColor\": \"#7fbbb3\",\n\
  \    \"gitlens.decorations.branchUpToDateForegroundColor\": \"#d3c6aa\",\n\
  \    \"gitlens.decorations.copiedForegroundColor\": \"#d699b6\",\n\
  \    \"gitlens.decorations.deletedForegroundColor\": \"#e67e80\",\n\
  \    \"gitlens.decorations.ignoredForegroundColor\": \"#9aa79d\",\n\
  \    \"gitlens.decorations.modifiedForegroundColor\": \"#7fbbb3\",\n\
  \    \"gitlens.decorations.renamedForegroundColor\": \"#d699b6\",\n\
  \    \"gitlens.decorations.untrackedForegroundColor\": \"#dbbc7f\",\n\
  \    \"gitlens.gutterBackgroundColor\": \"#2d353b\",\n\
  \    \"gitlens.gutterForegroundColor\": \"#d3c6aa\",\n\
  \    \"gitlens.gutterUncommittedForegroundColor\": \"#7fbbb3\",\n\
  \    \"gitlens.lineHighlightBackgroundColor\": \"#343f44\",\n\
  \    \"gitlens.lineHighlightOverviewRulerColor\": \"#a7c080\",\n\
  \    \"gitlens.mergedPullRequestIconColor\": \"#d699b6\",\n\
  \    \"gitlens.openPullRequestIconColor\": \"#83c092\",\n\
  \    \"gitlens.trailingLineForegroundColor\": \"#859289\",\n\
  \    \"gitlens.unpublishedCommitIconColor\": \"#dbbc7f\",\n\
  \    \"gitlens.unpulledChangesIconColor\": \"#e69875\",\n\
  \    \"gitlens.unpushlishedChangesIconColor\": \"#7fbbb3\",\n\
  \    \"icon.foreground\": \"#83c092\",\n\
  \    \"imagePreview.border\": \"#2d353b\",\n\
  \    \"input.background\": \"#2d353b00\",\n\
  \    \"input.border\": \"#4f585e\",\n\
  \    \"input.foreground\": \"#d3c6aa\",\n\
  \    \"input.placeholderForeground\": \"#7f897d\",\n\
  \    \"inputOption.activeBorder\": \"#83c092\",\n\
  \    \"inputValidation.errorBackground\": \"#da6362\",\n\
  \    \"inputValidation.errorBorder\": \"#e67e80\",\n\
  \    \"inputValidation.errorForeground\": \"#d3c6aa\",\n\
  \    \"inputValidation.infoBackground\": \"#5a93a2\",\n\
  \    \"inputValidation.infoBorder\": \"#7fbbb3\",\n\
  \    \"inputValidation.infoForeground\": \"#d3c6aa\",\n\
  \    \"inputValidation.warningBackground\": \"#bf983d\",\n\
  \    \"inputValidation.warningBorder\": \"#dbbc7f\",\n\
  \    \"inputValidation.warningForeground\": \"#d3c6aa\",\n\
  \    \"issues.closed\": \"#e67e80\",\n\
  \    \"issues.open\": \"#83c092\",\n\
  \    \"keybindingLabel.background\": \"#2d353b00\",\n\
  \    \"keybindingLabel.border\": \"#272e33\",\n\
  \    \"keybindingLabel.bottomBorder\": \"#21272b\",\n\
  \    \"keybindingLabel.foreground\": \"#d3c6aa\",\n\
  \    \"keybindingTable.headerBackground\": \"#3d484d\",\n\
  \    \"keybindingTable.rowsBackground\": \"#343f44\",\n\
  \    \"list.activeSelectionBackground\": \"#47525880\",\n\
  \    \"list.activeSelectionForeground\": \"#d3c6aa\",\n\
  \    \"list.dropBackground\": \"#343f4480\",\n\
  \    \"list.errorForeground\": \"#e67e80\",\n\
  \    \"list.focusBackground\": \"#47525880\",\n\
  \    \"list.focusForeground\": \"#d3c6aa\",\n\
  \    \"list.highlightForeground\": \"#a7c080\",\n\
  \    \"list.hoverBackground\": \"#2d353b00\",\n\
  \    \"list.hoverForeground\": \"#d3c6aa\",\n\
  \    \"list.inactiveFocusBackground\": \"#47525860\",\n\
  \    \"list.inactiveSelectionBackground\": \"#47525880\",\n\
  \    \"list.inactiveSelectionForeground\": \"#9aa79d\",\n\
  \    \"list.invalidItemForeground\": \"#da6362\",\n\
  \    \"list.warningForeground\": \"#dbbc7f\",\n\
  \    \"menu.background\": \"#2d353b\",\n\
  \    \"menu.foreground\": \"#9aa79d\",\n\
  \    \"menu.selectionBackground\": \"#343f44\",\n\
  \    \"menu.selectionForeground\": \"#d3c6aa\",\n\
  \    \"menubar.selectionBackground\": \"#2d353b\",\n\
  \    \"menubar.selectionBorder\": \"#2d353b\",\n\
  \    \"merge.border\": \"#2d353b00\",\n\
  \    \"merge.currentContentBackground\": \"#5a93a240\",\n\
  \    \"merge.currentHeaderBackground\": \"#5a93a280\",\n\
  \    \"merge.incomingContentBackground\": \"#569d7940\",\n\
  \    \"merge.incomingHeaderBackground\": \"#569d7980\",\n\
  \    \"minimap.errorHighlight\": \"#da636280\",\n\
  \    \"minimap.findMatchHighlight\": \"#569d7960\",\n\
  \    \"minimap.selectionHighlight\": \"#4f585ef0\",\n\
  \    \"minimap.warningHighlight\": \"#bf983d80\",\n\
  \    \"minimapGutter.addedBackground\": \"#899c40a0\",\n\
  \    \"minimapGutter.deletedBackground\": \"#da6362a0\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#5a93a2a0\",\n\
  \    \"notebook.cellBorderColor\": \"#4f585e\",\n\
  \    \"notebook.cellHoverBackground\": \"#2d353b\",\n\
  \    \"notebook.cellStatusBarItemHoverBackground\": \"#343f44\",\n\
  \    \"notebook.cellToolbarSeparator\": \"#4f585e\",\n\
  \    \"notebook.focusedCellBackground\": \"#2d353b\",\n\
  \    \"notebook.focusedCellBorder\": \"#4f585e\",\n\
  \    \"notebook.focusedEditorBorder\": \"#4f585e\",\n\
  \    \"notebook.focusedRowBorder\": \"#4f585e\",\n\
  \    \"notebook.inactiveFocusedCellBorder\": \"#4f585e\",\n\
  \    \"notebook.outputContainerBackgroundColor\": \"#272e33\",\n\
  \    \"notebook.selectedCellBorder\": \"#4f585e\",\n\
  \    \"notebookStatusErrorIcon.foreground\": \"#e67e80\",\n\
  \    \"notebookStatusRunningIcon.foreground\": \"#7fbbb3\",\n\
  \    \"notebookStatusSuccessIcon.foreground\": \"#a7c080\",\n\
  \    \"notificationCenterHeader.background\": \"#3d484d\",\n\
  \    \"notificationCenterHeader.foreground\": \"#d3c6aa\",\n\
  \    \"notificationLink.foreground\": \"#a7c080\",\n\
  \    \"notifications.background\": \"#2d353b\",\n\
  \    \"notifications.foreground\": \"#d3c6aa\",\n\
  \    \"notificationsErrorIcon.foreground\": \"#e67e80\",\n\
  \    \"notificationsInfoIcon.foreground\": \"#7fbbb3\",\n\
  \    \"notificationsWarningIcon.foreground\": \"#dbbc7f\",\n\
  \    \"panel.background\": \"#2d353b\",\n\
  \    \"panel.border\": \"#2d353b\",\n\
  \    \"panelInput.border\": \"#4f585e\",\n\
  \    \"panelSection.border\": \"#21272b\",\n\
  \    \"panelSectionHeader.background\": \"#2d353b\",\n\
  \    \"panelTitle.activeBorder\": \"#a7c080d0\",\n\
  \    \"panelTitle.activeForeground\": \"#d3c6aa\",\n\
  \    \"panelTitle.inactiveForeground\": \"#859289\",\n\
  \    \"peekView.border\": \"#475258\",\n\
  \    \"peekViewEditor.background\": \"#343f44\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#bf983d50\",\n\
  \    \"peekViewEditorGutter.background\": \"#343f44\",\n\
  \    \"peekViewResult.background\": \"#343f44\",\n\
  \    \"peekViewResult.fileForeground\": \"#d3c6aa\",\n\
  \    \"peekViewResult.lineForeground\": \"#9aa79d\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#bf983d50\",\n\
  \    \"peekViewResult.selectionBackground\": \"#569d7950\",\n\
  \    \"peekViewResult.selectionForeground\": \"#d3c6aa\",\n\
  \    \"peekViewTitle.background\": \"#475258\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#d3c6aa\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#a7c080\",\n\
  \    \"pickerGroup.border\": \"#a7c0801a\",\n\
  \    \"pickerGroup.foreground\": \"#d3c6aa\",\n\
  \    \"ports.iconRunningProcessForeground\": \"#e69875\",\n\
  \    \"problemsErrorIcon.foreground\": \"#e67e80\",\n\
  \    \"problemsInfoIcon.foreground\": \"#7fbbb3\",\n\
  \    \"problemsWarningIcon.foreground\": \"#dbbc7f\",\n\
  \    \"progressBar.background\": \"#a7c080\",\n\
  \    \"quickInputTitle.background\": \"#343f44\",\n\
  \    \"rust_analyzer.inlayHints.background\": \"#2d353b00\",\n\
  \    \"rust_analyzer.inlayHints.foreground\": \"#7f897da0\",\n\
  \    \"rust_analyzer.syntaxTreeBorder\": \"#e67e80\",\n\
  \    \"sash.hoverBorder\": \"#475258\",\n\
  \    \"scrollbar.shadow\": \"#00000070\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#9aa79d\",\n\
  \    \"scrollbarSlider.background\": \"#4f585e80\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#4f585e\",\n\
  \    \"selection.background\": \"#475258e0\",\n\
  \    \"settings.checkboxBackground\": \"#2d353b\",\n\
  \    \"settings.checkboxBorder\": \"#4f585e\",\n\
  \    \"settings.checkboxForeground\": \"#e69875\",\n\
  \    \"settings.dropdownBackground\": \"#2d353b\",\n\
  \    \"settings.dropdownBorder\": \"#4f585e\",\n\
  \    \"settings.dropdownForeground\": \"#83c092\",\n\
  \    \"settings.focusedRowBackground\": \"#343f44\",\n\
  \    \"settings.headerForeground\": \"#9aa79d\",\n\
  \    \"settings.modifiedItemIndicator\": \"#7f897d\",\n\
  \    \"settings.numberInputBackground\": \"#2d353b\",\n\
  \    \"settings.numberInputBorder\": \"#4f585e\",\n\
  \    \"settings.numberInputForeground\": \"#d699b6\",\n\
  \    \"settings.rowHoverBackground\": \"#343f44\",\n\
  \    \"settings.textInputBackground\": \"#2d353b\",\n\
  \    \"settings.textInputBorder\": \"#4f585e\",\n\
  \    \"settings.textInputForeground\": \"#7fbbb3\",\n\
  \    \"sideBar.background\": \"#2d353b\",\n\
  \    \"sideBar.foreground\": \"#859289\",\n\
  \    \"sideBarSectionHeader.background\": \"#2d353b00\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#9aa79d\",\n\
  \    \"sideBarTitle.foreground\": \"#9aa79d\",\n\
  \    \"statusBar.background\": \"#2d353b\",\n\
  \    \"statusBar.border\": \"#2d353b\",\n\
  \    \"statusBar.debuggingBackground\": \"#2d353b\",\n\
  \    \"statusBar.debuggingForeground\": \"#e69875\",\n\
  \    \"statusBar.foreground\": \"#9aa79d\",\n\
  \    \"statusBar.noFolderBackground\": \"#2d353b\",\n\
  \    \"statusBar.noFolderBorder\": \"#2d353b\",\n\
  \    \"statusBar.noFolderForeground\": \"#9aa79d\",\n\
  \    \"statusBarItem.activeBackground\": \"#47525870\",\n\
  \    \"statusBarItem.errorBackground\": \"#2d353b\",\n\
  \    \"statusBarItem.errorForeground\": \"#e67e80\",\n\
  \    \"statusBarItem.hoverBackground\": \"#475258a0\",\n\
  \    \"statusBarItem.prominentBackground\": \"#2d353b\",\n\
  \    \"statusBarItem.prominentForeground\": \"#d3c6aa\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#475258a0\",\n\
  \    \"statusBarItem.remoteBackground\": \"#2d353b\",\n\
  \    \"statusBarItem.remoteForeground\": \"#9aa79d\",\n\
  \    \"statusBarItem.warningBackground\": \"#2d353b\",\n\
  \    \"statusBarItem.warningForeground\": \"#dbbc7f\",\n\
  \    \"symbolIcon.arrayForeground\": \"#7fbbb3\",\n\
  \    \"symbolIcon.booleanForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.classForeground\": \"#dbbc7f\",\n\
  \    \"symbolIcon.colorForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.constantForeground\": \"#83c092\",\n\
  \    \"symbolIcon.constructorForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.enumeratorForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.enumeratorMemberForeground\": \"#83c092\",\n\
  \    \"symbolIcon.eventForeground\": \"#dbbc7f\",\n\
  \    \"symbolIcon.fieldForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.fileForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.folderForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.functionForeground\": \"#a7c080\",\n\
  \    \"symbolIcon.interfaceForeground\": \"#dbbc7f\",\n\
  \    \"symbolIcon.keyForeground\": \"#a7c080\",\n\
  \    \"symbolIcon.keywordForeground\": \"#e67e80\",\n\
  \    \"symbolIcon.methodForeground\": \"#a7c080\",\n\
  \    \"symbolIcon.moduleForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.namespaceForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.nullForeground\": \"#83c092\",\n\
  \    \"symbolIcon.numberForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.objectForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.operatorForeground\": \"#e69875\",\n\
  \    \"symbolIcon.packageForeground\": \"#d699b6\",\n\
  \    \"symbolIcon.propertyForeground\": \"#83c092\",\n\
  \    \"symbolIcon.referenceForeground\": \"#7fbbb3\",\n\
  \    \"symbolIcon.snippetForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.stringForeground\": \"#a7c080\",\n\
  \    \"symbolIcon.structForeground\": \"#dbbc7f\",\n\
  \    \"symbolIcon.textForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.typeParameterForeground\": \"#83c092\",\n\
  \    \"symbolIcon.unitForeground\": \"#d3c6aa\",\n\
  \    \"symbolIcon.variableForeground\": \"#7fbbb3\",\n\
  \    \"tab.activeBackground\": \"#2d353b\",\n\
  \    \"tab.activeBorder\": \"#a7c080d0\",\n\
  \    \"tab.activeForeground\": \"#d3c6aa\",\n\
  \    \"tab.border\": \"#2d353b\",\n\
  \    \"tab.hoverBackground\": \"#2d353b\",\n\
  \    \"tab.hoverForeground\": \"#d3c6aa\",\n\
  \    \"tab.inactiveBackground\": \"#2d353b\",\n\
  \    \"tab.inactiveForeground\": \"#7f897d\",\n\
  \    \"tab.lastPinnedBorder\": \"#a7c080d0\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#859289\",\n\
  \    \"tab.unfocusedActiveForeground\": \"#9aa79d\",\n\
  \    \"tab.unfocusedHoverForeground\": \"#d3c6aa\",\n\
  \    \"tab.unfocusedInactiveForeground\": \"#7f897d\",\n\
  \    \"terminal.ansiBlack\": \"#343f44\",\n\
  \    \"terminal.ansiBlue\": \"#7fbbb3\",\n\
  \    \"terminal.ansiBrightBlack\": \"#859289\",\n\
  \    \"terminal.ansiBrightBlue\": \"#7fbbb3\",\n\
  \    \"terminal.ansiBrightCyan\": \"#83c092\",\n\
  \    \"terminal.ansiBrightGreen\": \"#a7c080\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#d699b6\",\n\
  \    \"terminal.ansiBrightRed\": \"#e67e80\",\n\
  \    \"terminal.ansiBrightWhite\": \"#d3c6aa\",\n\
  \    \"terminal.ansiBrightYellow\": \"#dbbc7f\",\n\
  \    \"terminal.ansiCyan\": \"#83c092\",\n\
  \    \"terminal.ansiGreen\": \"#a7c080\",\n\
  \    \"terminal.ansiMagenta\": \"#d699b6\",\n\
  \    \"terminal.ansiRed\": \"#e67e80\",\n\
  \    \"terminal.ansiWhite\": \"#d3c6aa\",\n\
  \    \"terminal.ansiYellow\": \"#dbbc7f\",\n\
  \    \"terminal.foreground\": \"#d3c6aa\",\n\
  \    \"terminalCursor.foreground\": \"#d3c6aa\",\n\
  \    \"testing.iconErrored\": \"#e67e80\",\n\
  \    \"testing.iconFailed\": \"#e67e80\",\n\
  \    \"testing.iconPassed\": \"#83c092\",\n\
  \    \"testing.iconQueued\": \"#7fbbb3\",\n\
  \    \"testing.iconSkipped\": \"#d699b6\",\n\
  \    \"testing.iconUnset\": \"#dbbc7f\",\n\
  \    \"testing.runAction\": \"#83c092\",\n\
  \    \"textBlockQuote.background\": \"#272e33\",\n\
  \    \"textBlockQuote.border\": \"#475258\",\n\
  \    \"textCodeBlock.background\": \"#272e33\",\n\
  \    \"textLink.activeForeground\": \"#a7c080c0\",\n\
  \    \"textLink.foreground\": \"#a7c080\",\n\
  \    \"textPreformat.foreground\": \"#dbbc7f\",\n\
  \    \"titleBar.activeBackground\": \"#2d353b\",\n\
  \    \"titleBar.activeForeground\": \"#9aa79d\",\n\
  \    \"titleBar.border\": \"#2d353b\",\n\
  \    \"titleBar.inactiveBackground\": \"#2d353b\",\n\
  \    \"titleBar.inactiveForeground\": \"#7f897d\",\n\
  \    \"toolbar.hoverBackground\": \"#343f44\",\n\
  \    \"tree.indentGuidesStroke\": \"#7f897d\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#272e33\",\n\
  \    \"welcomePage.buttonBackground\": \"#343f44\",\n\
  \    \"welcomePage.buttonHoverBackground\": \"#343f44a0\",\n\
  \    \"welcomePage.progress.foreground\": \"#a7c080\",\n\
  \    \"welcomePage.tileHoverBackground\": \"#343f44\",\n\
  \    \"widget.shadow\": \"#00000070\"\n\
  \  },\n\
  \  \"displayName\": \"Everforest Dark\",\n\
  \  \"name\": \"everforest-dark\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"class:python\": \"#83c092\",\n\
  \    \"class:typescript\": \"#83c092\",\n\
  \    \"class:typescriptreact\": \"#83c092\",\n\
  \    \"enum:typescript\": \"#d699b6\",\n\
  \    \"enum:typescriptreact\": \"#d699b6\",\n\
  \    \"enumMember:typescript\": \"#7fbbb3\",\n\
  \    \"enumMember:typescriptreact\": \"#7fbbb3\",\n\
  \    \"interface:typescript\": \"#83c092\",\n\
  \    \"interface:typescriptreact\": \"#83c092\",\n\
  \    \"intrinsic:python\": \"#d699b6\",\n\
  \    \"macro:rust\": \"#83c092\",\n\
  \    \"memberOperatorOverload\": \"#e69875\",\n\
  \    \"module:python\": \"#7fbbb3\",\n\
  \    \"namespace:rust\": \"#d699b6\",\n\
  \    \"namespace:typescript\": \"#d699b6\",\n\
  \    \"namespace:typescriptreact\": \"#d699b6\",\n\
  \    \"operatorOverload\": \"#e69875\",\n\
  \    \"property.defaultLibrary:javascript\": \"#d699b6\",\n\
  \    \"property.defaultLibrary:javascriptreact\": \"#d699b6\",\n\
  \    \"property.defaultLibrary:typescript\": \"#d699b6\",\n\
  \    \"property.defaultLibrary:typescriptreact\": \"#d699b6\",\n\
  \    \"selfKeyword:rust\": \"#d699b6\",\n\
  \    \"variable.defaultLibrary:javascript\": \"#d699b6\",\n\
  \    \"variable.defaultLibrary:javascriptreact\": \"#d699b6\",\n\
  \    \"variable.defaultLibrary:typescript\": \"#d699b6\",\n\
  \    \"variable.defaultLibrary:typescriptreact\": \"#d699b6\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": \"keyword, storage.type.function, storage.type.class, \
   storage.type.enum, storage.type.interface, storage.type.property, \
   keyword.operator.new, keyword.operator.expression, keyword.operator.new, \
   keyword.operator.delete, storage.type.extends\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.debugger\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage, modifier, keyword.var, entity.name.tag, \
   keyword.control.case, keyword.control.switch\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string, punctuation.definition.string.end, \
   punctuation.definition.string.begin, \
   punctuation.definition.string.template.begin, \
   punctuation.definition.string.template.end\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape, punctuation.quasi.element, \
   punctuation.definition.template-expression, punctuation.section.embedded, \
   storage.type.format, constant.other.placeholder, \
   constant.other.placeholder, variable.interpolation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function, support.function, meta.function, \
   meta.function-call, meta.definition.method\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.at-rule, keyword.control.import, \
   keyword.control.export, storage.type.namespace, punctuation.decorator, \
   keyword.control.directive, keyword.preprocessor, \
   punctuation.definition.preprocessor, punctuation.definition.directive, \
   keyword.other.import, keyword.other.package, entity.name.type.namespace, \
   entity.name.scope-resolution, keyword.other.using, keyword.package, \
   keyword.import, keyword.map\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.annotation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.label, constant.other.label\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.module, support.node, support.other.module, \
   support.type.object.module, entity.name.type.module, \
   entity.name.type.class.module, keyword.control.module\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type, support.type, entity.name.type, \
   keyword.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.class, support.class, \
   entity.name.class, entity.other.inherited-class, storage.class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.boolean\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.preprocessor\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.this, variable.language.self, \
   variable.language.super, keyword.other.this, variable.language.special, \
   constant.language.null, constant.language.undefined, \
   constant.language.nan\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language, support.constant\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable, support.variable, meta.definition.variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.object.property, support.variable.property, \
   variable.other.property, variable.other.object.property, \
   variable.other.enummember, variable.other.member, meta.object-literal.key\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation, meta.brace, meta.delimiter, meta.bracket\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.1.markdown, markup.heading.setext.1.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.2.markdown, markup.heading.setext.2.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.3.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.4.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.5.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.6.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.heading.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"regular\",\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.other.link.title.markdown, \
   constant.other.reference.link.markdown, \
   string.other.link.description.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"regular\",\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline.link.image.markdown, \
   markup.underline.link.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\",\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.string.begin.markdown, \
   punctuation.definition.string.end.markdown, \
   punctuation.definition.italic.markdown, \
   punctuation.definition.quote.begin.markdown, \
   punctuation.definition.metadata.markdown, \
   punctuation.separator.key-value.markdown, \
   punctuation.definition.constant.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.bold.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"regular\",\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.separator.markdown, \
   punctuation.definition.constant.begin.markdown, \
   punctuation.definition.constant.end.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold markup.italic, markup.italic markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.markdown, \
   punctuation.definition.raw.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"fenced_code.block.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.fenced_code.block.markdown, \
   markup.inline.raw.string.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.heading.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.field.restructuredtext, \
   punctuation.separator.key-value.restructuredtext, \
   punctuation.definition.directive.restructuredtext, \
   punctuation.definition.constant.restructuredtext, \
   punctuation.definition.italic.restructuredtext, \
   punctuation.definition.table.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.bold.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"regular\",\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.restructuredtext, \
   punctuation.definition.link.restructuredtext, \
   punctuation.definition.raw.restructuredtext, \
   punctuation.section.raw.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.footnote.link.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.directive.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.directive.restructuredtext, \
   markup.raw.restructuredtext, markup.raw.inner.restructuredtext, \
   string.other.link.title.restructuredtext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.function.latex, \
   punctuation.definition.function.tex, punctuation.definition.keyword.latex, \
   constant.character.newline.tex, punctuation.definition.keyword.tex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.be.latex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.section.latex, \
   keyword.control.table.cell.latex, keyword.control.table.newline.latex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.class.latex, variable.parameter.latex, \
   variable.parameter.function.latex, \
   variable.parameter.definition.label.latex, \
   constant.other.reference.label.latex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.preamble.latex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.namespace.xml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.html, entity.name.tag.xml, \
   entity.name.tag.localname.xml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.html, \
   entity.other.attribute-name.xml, \
   entity.other.attribute-name.localname.xml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.html, string.quoted.single.html, \
   punctuation.definition.string.begin.html, \
   punctuation.definition.string.end.html, \
   punctuation.separator.key-value.html, \
   punctuation.definition.string.begin.xml, \
   punctuation.definition.string.end.xml, string.quoted.double.xml, \
   string.quoted.single.xml, punctuation.definition.tag.begin.html, \
   punctuation.definition.tag.end.html, punctuation.definition.tag.xml, \
   meta.tag.xml, meta.tag.preprocessor.xml, meta.tag.other.html, \
   meta.tag.block.any.html, meta.tag.inline.any.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.documentroot.xml, \
   meta.tag.sgml.doctype.xml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.proto\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.proto.syntax, \
   string.quoted.single.proto.syntax, string.quoted.double.proto, \
   string.quoted.single.proto\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.class.proto, \
   entity.name.class.message.proto\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.entity.css, \
   punctuation.separator.key-value.css, punctuation.terminator.rule.css, \
   punctuation.separator.list.comma.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.class.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.pseudo-class.css, \
   entity.other.attribute-name.pseudo-element.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.single.css, string.quoted.double.css, \
   support.constant.property-value.css, meta.property-value.css, \
   punctuation.definition.string.begin.css, \
   punctuation.definition.string.end.css, constant.numeric.css, \
   support.constant.font-name.css, variable.parameter.keyframe-list.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.vendored.property-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.css, entity.other.keyframe-offset.css, \
   punctuation.definition.keyword.css, keyword.control.at-rule.keyframes.css, \
   meta.selector.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.entity.scss, \
   punctuation.separator.key-value.scss, punctuation.terminator.rule.scss, \
   punctuation.separator.list.comma.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.at-rule.keyframes.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.definition.interpolation.begin.bracket.curly.scss, \
   punctuation.definition.interpolation.end.bracket.curly.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.string.begin.scss, \
   punctuation.definition.string.end.scss, string.quoted.double.scss, \
   string.quoted.single.scss, constant.character.css.sass, \
   meta.property-value.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.at-rule.include.scss, \
   keyword.control.at-rule.use.scss, keyword.control.at-rule.mixin.scss, \
   keyword.control.at-rule.extend.scss, keyword.control.at-rule.import.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.stylus\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.stylus\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.accessor.js, \
   punctuation.separator.key-value.js, punctuation.separator.label.js, \
   keyword.operator.accessor.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.block.tag.jsdoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.js, storage.type.function.arrow.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"JSXNested\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag.jsx, \
   entity.other.attribute-name.jsx, punctuation.definition.tag.begin.js.jsx, \
   punctuation.definition.tag.end.js.jsx, entity.other.attribute-name.js.jsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.type.annotation.ts, \
   punctuation.accessor.ts, punctuation.separator.key-value.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag.directive.ts, \
   entity.other.attribute-name.directive.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.ts, entity.name.type.interface.ts, \
   entity.other.inherited-class.ts, entity.name.type.alias.ts, \
   entity.name.type.class.ts, entity.name.type.enum.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.ts, storage.type.function.arrow.ts, \
   storage.type.type.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.import.ts, keyword.control.export.ts, \
   storage.type.namespace.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.type.annotation.tsx, \
   punctuation.accessor.tsx, punctuation.separator.key-value.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag.directive.tsx, \
   entity.other.attribute-name.directive.tsx, \
   punctuation.definition.tag.begin.tsx, punctuation.definition.tag.end.tsx, \
   entity.other.attribute-name.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.tsx, entity.name.type.interface.tsx, \
   entity.other.inherited-class.tsx, entity.name.type.alias.tsx, \
   entity.name.type.class.tsx, entity.name.type.enum.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.import.tsx, keyword.control.export.tsx, \
   storage.type.namespace.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.tsx, storage.type.function.arrow.tsx, \
   storage.type.type.tsx, support.class.component.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function.coffee\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.type-signature.purescript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.double-colon.purescript, \
   keyword.other.arrow.purescript, keyword.other.big-arrow.purescript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.purescript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.single.purescript, \
   string.quoted.double.purescript, \
   punctuation.definition.string.begin.purescript, \
   punctuation.definition.string.end.purescript, \
   string.quoted.triple.purescript, entity.name.type.purescript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.other.module.purescript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.dot.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.primitive.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.class.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.dart, \
   string.interpolated.single.dart, string.interpolated.double.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.import.dart, storage.type.annotation.dart\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.class.pug\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function.pug\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.tag.pug\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.pug, storage.type.import.include.pug\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.c, \
   storage.modifier.array.bracket.square.c, \
   meta.function.definition.parameters.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.dot-access.c, \
   constant.character.escape.line-continuation.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.directive.include.c, \
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
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.pointer-access.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.member.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.cpp, \
   storage.modifier.array.bracket.square.cpp, \
   meta.function.definition.parameters.cpp, \
   meta.body.function.definition.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.dot-access.cpp, \
   constant.character.escape.line-continuation.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.directive.include.cpp, \
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
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.pointer-access.cpp, \
   punctuation.section.angle-brackets.begin.template.call.cpp, \
   punctuation.section.angle-brackets.end.template.call.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.member.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.using.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.type.cs, constant.character.escape.cs, \
   punctuation.definition.interpolation.begin.cs, \
   punctuation.definition.interpolation.end.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.cs, string.quoted.single.cs, \
   punctuation.definition.string.begin.cs, \
   punctuation.definition.string.end.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.object.property.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.namespace.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.symbol.fsharp, constant.language.unit.fsharp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.format.specifier.fsharp, \
   entity.name.type.fsharp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.fsharp, \
   string.quoted.single.fsharp, punctuation.definition.string.begin.fsharp, \
   punctuation.definition.string.end.fsharp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.section.fsharp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.attribute.fsharp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.java, \
   punctuation.separator.period.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.import.java, keyword.other.package.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function.arrow.java, \
   keyword.control.ternary.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.property.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.wildcard.java, \
   storage.modifier.import.java, storage.type.annotation.java, \
   punctuation.definition.annotation.java, storage.modifier.package.java, \
   entity.name.type.module.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.import.kotlin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.kotlin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.kotlin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.package.kotlin, \
   storage.type.annotation.kotlin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.package.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.import.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.scala, string.quoted.single.scala, \
   punctuation.definition.string.begin.scala, \
   punctuation.definition.string.end.scala, \
   string.quoted.double.interpolated.scala, \
   string.quoted.single.interpolated.scala, string.quoted.triple.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.class, entity.other.inherited-class.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.declaration.stable.scala, \
   keyword.other.arrow.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.import.scala\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.navigation.groovy, \
   meta.method.body.java, meta.definition.method.groovy, \
   meta.definition.method.signature.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.import.groovy, \
   keyword.other.package.groovy, keyword.other.import.static.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.def.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.interpolated.groovy, meta.method.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.import.groovy, \
   storage.modifier.package.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.annotation.groovy\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.type.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.package.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.import.go, keyword.package.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.mod.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.path.rust, \
   keyword.operator.member-access.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.core.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.attribute.rust, variable.language.rust, \
   storage.type.module.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.swift, \
   support.function.any-method.swift\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.variable.swift\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.class.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.trait.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.php, support.other.namespace.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.modifier.access.control.public.cpp, \
   storage.type.modifier.access.control.private.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.import.include.php, storage.type.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.arguments.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.decorator.python, \
   punctuation.separator.period.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.import.python, \
   keyword.control.import.from.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.lua\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.class.lua\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.method.with-arguments.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.method.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.pseudo-method.ruby, \
   storage.type.variable.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.special-method.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.module.ruby, \
   punctuation.definition.constant.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"string.regexp.character-class.ruby,string.regexp.interpolated.ruby,punctuation.definition.character-class.ruby,string.regexp.group.ruby, \
   punctuation.section.regexp.ruby, punctuation.definition.group.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.constant.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.arrow.haskell, \
   keyword.other.big-arrow.haskell, keyword.other.double-colon.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.haskell, string.quoted.double.haskell, \
   string.quoted.single.haskell, punctuation.definition.string.begin.haskell, \
   punctuation.definition.string.end.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.namespace, meta.preprocessor.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.import.julia, \
   keyword.control.export.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.storage.modifier.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.macro.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.period.elm\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.elm\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.r, variable.function.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.namespace.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.module-function.erlang, \
   punctuation.section.directive.begin.erlang\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.directive.erlang, \
   keyword.control.directive.define.erlang\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.class.module.erlang\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.erlang, \
   string.quoted.single.erlang, punctuation.definition.string.begin.erlang, \
   punctuation.definition.string.end.erlang\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.directive.export.erlang, \
   keyword.control.directive.module.erlang, \
   keyword.control.directive.import.erlang, \
   keyword.control.directive.behaviour.erlang\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.readwrite.module.elixir, \
   punctuation.definition.variable.elixir\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.elixir\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.module.elixir\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.value-signature.ocaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.ocaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.variant.ocaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.sub.perl, \
   storage.type.declare.routine.perl\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.lisp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function-type.lisp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.constant.lisp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.lisp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.keyword.clojure, support.variable.clojure, \
   meta.definition.variable.clojure\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.global.clojure\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.clojure\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.scope.if-block.shell, meta.scope.group.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.builtin.shell, \
   entity.name.function.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.shell, string.quoted.single.shell, \
   punctuation.definition.string.begin.shell, \
   punctuation.definition.string.end.shell, string.unquoted.heredoc.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.heredoc-token.shell, \
   variable.other.normal.shell, punctuation.definition.variable.shell, \
   variable.other.special.shell, variable.other.positional.shell, \
   variable.other.bracket.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.builtin.fish\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.unix.fish\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.normal.fish, \
   punctuation.definition.variable.fish, variable.other.fixed.fish, \
   variable.other.special.fish\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.fish, \
   punctuation.definition.string.end.fish, \
   punctuation.definition.string.begin.fish, string.quoted.single.fish\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape.single.fish\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.variable.powershell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.powershell, \
   support.function.attribute.powershell, support.function.powershell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.single.powershell, \
   string.quoted.double.powershell, \
   punctuation.definition.string.begin.powershell, \
   punctuation.definition.string.end.powershell, \
   string.quoted.double.heredoc.powershell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.member.powershell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.alias.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3c6aa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.type.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.fragment.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.target.makefile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.makefile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.scope.prerequisites.makefile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.source.cmake\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.source.cmake\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.source.cmake\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.map.viml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.map.viml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.map.viml, \
   constant.character.map.key.viml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.map.special.viml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.tmux, constant.numeric.tmux\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.package-manager.dockerfile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.flag.dockerfile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.dockerfile, \
   string.quoted.single.dockerfile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape.dockerfile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.base-image.dockerfile, \
   entity.name.image.dockerfile\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.separator.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted.diff, \
   punctuation.definition.deleted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.diff.range.context, \
   punctuation.definition.range.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.diff.header.from-file\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted.diff, \
   punctuation.definition.inserted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed.diff, \
   punctuation.definition.changed.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.from-file.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.section.group-title.ini, \
   punctuation.definition.entity.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e67e80\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.key-value.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.ini, string.quoted.single.ini, \
   punctuation.definition.string.begin.ini, \
   punctuation.definition.string.end.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.definition.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.aggregate.sql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.single.sql, \
   punctuation.definition.string.end.sql, \
   punctuation.definition.string.begin.sql, string.quoted.double.sql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#dbbc7f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.enum.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.support.type.property-name.begin.json, \
   punctuation.support.type.property-name.end.json, \
   punctuation.separator.dictionary.key-value.json, \
   punctuation.definition.string.begin.json, \
   punctuation.definition.string.end.json, \
   punctuation.separator.dictionary.pair.json, \
   punctuation.separator.array.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.key-value.mapping.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.plain.out.yaml, \
   string.quoted.single.yaml, string.quoted.double.yaml, \
   punctuation.definition.string.begin.yaml, \
   punctuation.definition.string.end.yaml, string.unquoted.plain.in.yaml, \
   string.unquoted.block.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.anchor.yaml, \
   punctuation.definition.block.sequence.item.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83c092\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.key.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e69875\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.single.basic.line.toml, \
   string.quoted.single.literal.line.toml, \
   punctuation.definition.keyValuePair.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a7c080\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.boolean.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7fbbb3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.table.toml, \
   punctuation.definition.table.toml, \
   entity.other.attribute-name.table.array.toml, \
   punctuation.definition.table.array.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d699b6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment, string.comment, punctuation.definition.comment\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#859289\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let ayu_dark =
  "{\n\
  \  \"colors\": {\n\
  \    \"actionBar.toggledBackground\": \"#47526640\",\n\
  \    \"activityBar.activeBorder\": \"#e6b450\",\n\
  \    \"activityBar.background\": \"#0d1017\",\n\
  \    \"activityBar.border\": \"#1b1f29\",\n\
  \    \"activityBar.foreground\": \"#5a6378cc\",\n\
  \    \"activityBar.inactiveForeground\": \"#5a637899\",\n\
  \    \"activityBarBadge.background\": \"#e6b450\",\n\
  \    \"activityBarBadge.foreground\": \"#765b24\",\n\
  \    \"activityBarTop.activeBorder\": \"#e6b450\",\n\
  \    \"activityBarTop.foreground\": \"#697184\",\n\
  \    \"badge.background\": \"#e6b45033\",\n\
  \    \"badge.foreground\": \"#e6b450\",\n\
  \    \"button.background\": \"#e6b450\",\n\
  \    \"button.border\": \"#765b241a\",\n\
  \    \"button.foreground\": \"#765b24\",\n\
  \    \"button.hoverBackground\": \"#deae4d\",\n\
  \    \"button.secondaryBackground\": \"#5a637833\",\n\
  \    \"button.secondaryForeground\": \"#bfbdb6\",\n\
  \    \"button.secondaryHoverBackground\": \"#5a637880\",\n\
  \    \"button.separator\": \"#765b244d\",\n\
  \    \"chat.checkpointSeparator\": \"#5a6673\",\n\
  \    \"chat.editedFileForeground\": \"#73b8ff\",\n\
  \    \"chat.requestBackground\": \"#0d1017\",\n\
  \    \"chat.requestBorder\": \"#47526640\",\n\
  \    \"chat.requestBubbleBackground\": \"#47526633\",\n\
  \    \"chat.requestBubbleHoverBackground\": \"#47526640\",\n\
  \    \"chat.slashCommandBackground\": \"#39bae633\",\n\
  \    \"chat.slashCommandForeground\": \"#39bae6\",\n\
  \    \"commandCenter.activeBackground\": \"#47526640\",\n\
  \    \"commandCenter.activeBorder\": \"#47526600\",\n\
  \    \"commandCenter.activeForeground\": \"#5a6378\",\n\
  \    \"commandCenter.background\": \"#10141c\",\n\
  \    \"commandCenter.border\": \"#1b1f29\",\n\
  \    \"commandCenter.foreground\": \"#5a6378\",\n\
  \    \"commandCenter.inactiveBorder\": \"#1b1f29\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#e6b450\",\n\
  \    \"debugExceptionWidget.background\": \"#141821\",\n\
  \    \"debugExceptionWidget.border\": \"#1b1f29\",\n\
  \    \"debugIcon.breakpointDisabledForeground\": \"#f2966880\",\n\
  \    \"debugIcon.breakpointForeground\": \"#f29668\",\n\
  \    \"debugToolBar.background\": \"#141821\",\n\
  \    \"descriptionForeground\": \"#5a6378\",\n\
  \    \"diffEditor.diagonalFill\": \"#1b1f29\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#70bf561f\",\n\
  \    \"diffEditor.removedTextBackground\": \"#f26d781f\",\n\
  \    \"disabledForeground\": \"#5a637880\",\n\
  \    \"dropdown.background\": \"#141821\",\n\
  \    \"dropdown.border\": \"#1b1f29\",\n\
  \    \"dropdown.foreground\": \"#5a6378\",\n\
  \    \"editor.background\": \"#10141c\",\n\
  \    \"editor.findMatchBackground\": \"#4c4126\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#4c412680\",\n\
  \    \"editor.foreground\": \"#bfbdb6\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#80b5ff26\",\n\
  \    \"editor.lineHighlightBackground\": \"#161a24\",\n\
  \    \"editor.rangeHighlightBackground\": \"#4c412633\",\n\
  \    \"editor.selectionBackground\": \"#3388ff40\",\n\
  \    \"editor.selectionHighlightBackground\": \"#70bf5626\",\n\
  \    \"editor.selectionHighlightBorder\": \"#70bf5600\",\n\
  \    \"editor.snippetTabstopHighlightBackground\": \"#70bf5633\",\n\
  \    \"editor.wordHighlightBackground\": \"#73b8ff14\",\n\
  \    \"editor.wordHighlightBorder\": \"#73b8ff80\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#70bf5614\",\n\
  \    \"editor.wordHighlightStrongBorder\": \"#70bf5680\",\n\
  \    \"editorBracketMatch.background\": \"#5a63784d\",\n\
  \    \"editorBracketMatch.border\": \"#5a63784d\",\n\
  \    \"editorCodeLens.foreground\": \"#5a6673\",\n\
  \    \"editorCursor.foreground\": \"#e6b450\",\n\
  \    \"editorError.foreground\": \"#d95757\",\n\
  \    \"editorGroup.background\": \"#141821\",\n\
  \    \"editorGroup.border\": \"#1b1f29\",\n\
  \    \"editorGroupHeader.noTabsBackground\": \"#0d1017\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#0d1017\",\n\
  \    \"editorGroupHeader.tabsBorder\": \"#1b1f29\",\n\
  \    \"editorGutter.addedBackground\": \"#70bf56\",\n\
  \    \"editorGutter.deletedBackground\": \"#f26d78\",\n\
  \    \"editorGutter.modifiedBackground\": \"#73b8ff\",\n\
  \    \"editorHoverWidget.background\": \"#141821\",\n\
  \    \"editorHoverWidget.border\": \"#1b1f29\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#5a6378a1\",\n\
  \    \"editorIndentGuide.background\": \"#5a637842\",\n\
  \    \"editorInlayHint.foreground\": \"#bfbdb680\",\n\
  \    \"editorLineNumber.activeForeground\": \"#5a6378\",\n\
  \    \"editorLineNumber.foreground\": \"#5a6378a6\",\n\
  \    \"editorLink.activeForeground\": \"#e6b450\",\n\
  \    \"editorMarkerNavigation.background\": \"#141821\",\n\
  \    \"editorOverviewRuler.addedForeground\": \"#70bf56\",\n\
  \    \"editorOverviewRuler.border\": \"#1b1f29\",\n\
  \    \"editorOverviewRuler.bracketMatchForeground\": \"#5a6378b3\",\n\
  \    \"editorOverviewRuler.deletedForeground\": \"#f26d78\",\n\
  \    \"editorOverviewRuler.errorForeground\": \"#d95757\",\n\
  \    \"editorOverviewRuler.findMatchForeground\": \"#4c4126\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#73b8ff\",\n\
  \    \"editorOverviewRuler.warningForeground\": \"#e6b450\",\n\
  \    \"editorOverviewRuler.wordHighlightForeground\": \"#73b8ff66\",\n\
  \    \"editorOverviewRuler.wordHighlightStrongForeground\": \"#70bf5666\",\n\
  \    \"editorRuler.foreground\": \"#5a637842\",\n\
  \    \"editorStickyScroll.border\": \"#1b1f29\",\n\
  \    \"editorStickyScroll.shadow\": \"#00000080\",\n\
  \    \"editorStickyScrollHover.background\": \"#47526633\",\n\
  \    \"editorSuggestWidget.background\": \"#141821\",\n\
  \    \"editorSuggestWidget.border\": \"#1b1f29\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#e6b450\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#47526640\",\n\
  \    \"editorWarning.foreground\": \"#e6b450\",\n\
  \    \"editorWhitespace.foreground\": \"#5a6378a6\",\n\
  \    \"editorWidget.background\": \"#141821\",\n\
  \    \"editorWidget.border\": \"#1b1f29\",\n\
  \    \"editorWidget.resizeBorder\": \"#141821\",\n\
  \    \"errorForeground\": \"#d95757\",\n\
  \    \"extensionButton.prominentBackground\": \"#e6b450\",\n\
  \    \"extensionButton.prominentForeground\": \"#765b24\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#e2b14f\",\n\
  \    \"focusBorder\": \"#e6b450\",\n\
  \    \"foreground\": \"#5a6378\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#f26d78\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#5a637880\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#73b8ff\",\n\
  \    \"gitDecoration.submoduleResourceForeground\": \"#d2a6ff\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#70bf56\",\n\
  \    \"icon.foreground\": \"#5a6378\",\n\
  \    \"inlineChat.background\": \"#141821\",\n\
  \    \"inlineChat.border\": \"#1b1f29\",\n\
  \    \"inlineChat.foreground\": \"#bfbdb6\",\n\
  \    \"inlineChat.shadow\": \"#00000080\",\n\
  \    \"inlineChatDiff.inserted\": \"#70bf5633\",\n\
  \    \"inlineChatDiff.removed\": \"#f26d7833\",\n\
  \    \"inlineChatInput.background\": \"#10141c\",\n\
  \    \"inlineChatInput.border\": \"#1b1f29\",\n\
  \    \"inlineChatInput.focusBorder\": \"#e6b450b3\",\n\
  \    \"inlineChatInput.placeholderForeground\": \"#5a637880\",\n\
  \    \"inlineEdit.gutterIndicator.background\": \"#1b1f29\",\n\
  \    \"inlineEdit.gutterIndicator.primaryBackground\": \"#e6b4501a\",\n\
  \    \"inlineEdit.gutterIndicator.primaryBorder\": \"#e6b450\",\n\
  \    \"inlineEdit.gutterIndicator.primaryForeground\": \"#e6b450\",\n\
  \    \"inlineEdit.gutterIndicator.secondaryBackground\": \"#5a63781a\",\n\
  \    \"inlineEdit.gutterIndicator.secondaryBorder\": \"#5a637880\",\n\
  \    \"inlineEdit.gutterIndicator.secondaryForeground\": \"#5a6378\",\n\
  \    \"inlineEdit.gutterIndicator.successfulBackground\": \"#70bf561a\",\n\
  \    \"inlineEdit.gutterIndicator.successfulBorder\": \"#70bf56\",\n\
  \    \"inlineEdit.gutterIndicator.successfulForeground\": \"#70bf56\",\n\
  \    \"inlineEdit.modifiedBackground\": \"#70bf561a\",\n\
  \    \"inlineEdit.modifiedBorder\": \"#70bf5680\",\n\
  \    \"inlineEdit.modifiedChangedLineBackground\": \"#70bf5626\",\n\
  \    \"inlineEdit.modifiedChangedTextBackground\": \"#70bf5640\",\n\
  \    \"inlineEdit.originalBackground\": \"#f26d781a\",\n\
  \    \"inlineEdit.originalBorder\": \"#f26d7880\",\n\
  \    \"inlineEdit.originalChangedLineBackground\": \"#f26d7826\",\n\
  \    \"inlineEdit.originalChangedTextBackground\": \"#f26d7840\",\n\
  \    \"input.background\": \"#10141c\",\n\
  \    \"input.border\": \"#5a637833\",\n\
  \    \"input.foreground\": \"#bfbdb6\",\n\
  \    \"input.placeholderForeground\": \"#5a637880\",\n\
  \    \"inputOption.activeBackground\": \"#e6b4501a\",\n\
  \    \"inputOption.activeBorder\": \"#e6b45033\",\n\
  \    \"inputOption.activeForeground\": \"#e6b450\",\n\
  \    \"inputOption.hoverBackground\": \"#5a637833\",\n\
  \    \"inputValidation.errorBackground\": \"#10141c\",\n\
  \    \"inputValidation.errorBorder\": \"#d95757\",\n\
  \    \"inputValidation.infoBackground\": \"#0d1017\",\n\
  \    \"inputValidation.infoBorder\": \"#39bae6\",\n\
  \    \"inputValidation.warningBackground\": \"#0d1017\",\n\
  \    \"inputValidation.warningBorder\": \"#ffb454\",\n\
  \    \"keybindingLabel.background\": \"#5a63781a\",\n\
  \    \"keybindingLabel.border\": \"#bfbdb61a\",\n\
  \    \"keybindingLabel.bottomBorder\": \"#bfbdb61a\",\n\
  \    \"keybindingLabel.foreground\": \"#bfbdb6\",\n\
  \    \"list.activeSelectionBackground\": \"#47526640\",\n\
  \    \"list.activeSelectionForeground\": \"#bfbdb6\",\n\
  \    \"list.deemphasizedForeground\": \"#d95757\",\n\
  \    \"list.errorForeground\": \"#d95757\",\n\
  \    \"list.filterMatchBackground\": \"#43392180\",\n\
  \    \"list.filterMatchBorder\": \"#4c412680\",\n\
  \    \"list.focusBackground\": \"#47526640\",\n\
  \    \"list.focusForeground\": \"#bfbdb6\",\n\
  \    \"list.focusOutline\": \"#47526640\",\n\
  \    \"list.highlightForeground\": \"#e6b450\",\n\
  \    \"list.hoverBackground\": \"#47526640\",\n\
  \    \"list.inactiveSelectionBackground\": \"#47526633\",\n\
  \    \"list.inactiveSelectionForeground\": \"#5a6378\",\n\
  \    \"list.invalidItemForeground\": \"#5a63784d\",\n\
  \    \"listFilterWidget.background\": \"#141821\",\n\
  \    \"listFilterWidget.noMatchesOutline\": \"#d95757\",\n\
  \    \"listFilterWidget.outline\": \"#e6b450\",\n\
  \    \"menu.background\": \"#0f131a\",\n\
  \    \"menu.border\": \"#1b1f29\",\n\
  \    \"menu.foreground\": \"#5a6378\",\n\
  \    \"menu.selectionBackground\": \"#47526633\",\n\
  \    \"menu.selectionBorder\": \"#47526640\",\n\
  \    \"menu.separatorBackground\": \"#1b1f29\",\n\
  \    \"minimap.background\": \"#10141c\",\n\
  \    \"minimap.errorHighlight\": \"#d95757\",\n\
  \    \"minimap.findMatchHighlight\": \"#4c4126\",\n\
  \    \"minimap.selectionHighlight\": \"#3388ff40\",\n\
  \    \"minimapGutter.addedBackground\": \"#70bf56\",\n\
  \    \"minimapGutter.deletedBackground\": \"#f26d78\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#73b8ff\",\n\
  \    \"multiDiffEditor.background\": \"#0d1017\",\n\
  \    \"multiDiffEditor.border\": \"#1b1f29\",\n\
  \    \"multiDiffEditor.headerBackground\": \"#141821\",\n\
  \    \"panel.background\": \"#0d1017\",\n\
  \    \"panel.border\": \"#1b1f29\",\n\
  \    \"panelStickyScroll.border\": \"#1b1f29\",\n\
  \    \"panelStickyScroll.shadow\": \"#00000080\",\n\
  \    \"panelTitle.activeBorder\": \"#e6b450\",\n\
  \    \"panelTitle.activeForeground\": \"#bfbdb6\",\n\
  \    \"panelTitle.inactiveForeground\": \"#5a6378\",\n\
  \    \"peekView.border\": \"#47526640\",\n\
  \    \"peekViewEditor.background\": \"#141821\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#4c412680\",\n\
  \    \"peekViewEditor.matchHighlightBorder\": \"#43392180\",\n\
  \    \"peekViewResult.background\": \"#141821\",\n\
  \    \"peekViewResult.fileForeground\": \"#bfbdb6\",\n\
  \    \"peekViewResult.lineForeground\": \"#5a6378\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#4c412680\",\n\
  \    \"peekViewResult.selectionBackground\": \"#47526640\",\n\
  \    \"peekViewTitle.background\": \"#47526640\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#5a6378\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#bfbdb6\",\n\
  \    \"pickerGroup.border\": \"#1b1f29\",\n\
  \    \"pickerGroup.foreground\": \"#5a637880\",\n\
  \    \"profileBadge.background\": \"#e6b450\",\n\
  \    \"profileBadge.foreground\": \"#765b24\",\n\
  \    \"progressBar.background\": \"#e6b450\",\n\
  \    \"scrollbar.shadow\": \"#1b1f2900\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#5a6378b3\",\n\
  \    \"scrollbarSlider.background\": \"#5a637866\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#5a637899\",\n\
  \    \"selection.background\": \"#3388ff40\",\n\
  \    \"settings.headerForeground\": \"#bfbdb6\",\n\
  \    \"settings.modifiedItemIndicator\": \"#73b8ff\",\n\
  \    \"sideBar.background\": \"#0d1017\",\n\
  \    \"sideBar.border\": \"#1b1f29\",\n\
  \    \"sideBarSectionHeader.background\": \"#0d1017\",\n\
  \    \"sideBarSectionHeader.border\": \"#1b1f29\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#5a6378\",\n\
  \    \"sideBarStickyScroll.border\": \"#1b1f29\",\n\
  \    \"sideBarStickyScroll.shadow\": \"#00000080\",\n\
  \    \"sideBarTitle.foreground\": \"#5a6378\",\n\
  \    \"statusBar.background\": \"#0d1017\",\n\
  \    \"statusBar.border\": \"#1b1f29\",\n\
  \    \"statusBar.debuggingBackground\": \"#f29668\",\n\
  \    \"statusBar.debuggingForeground\": \"#10141c\",\n\
  \    \"statusBar.foreground\": \"#5a6378\",\n\
  \    \"statusBar.noFolderBackground\": \"#141821\",\n\
  \    \"statusBarItem.activeBackground\": \"#5a637833\",\n\
  \    \"statusBarItem.hoverBackground\": \"#5a637833\",\n\
  \    \"statusBarItem.prominentBackground\": \"#1b1f29\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#00000030\",\n\
  \    \"statusBarItem.remoteBackground\": \"#e6b450\",\n\
  \    \"statusBarItem.remoteForeground\": \"#765b24\",\n\
  \    \"symbolIcon.arrayForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.booleanForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.classForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.colorForeground\": \"#e6c08a\",\n\
  \    \"symbolIcon.constantForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.constructorForeground\": \"#ffb454\",\n\
  \    \"symbolIcon.enumeratorForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.enumeratorMemberForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.eventForeground\": \"#e6c08a\",\n\
  \    \"symbolIcon.fieldForeground\": \"#f07178\",\n\
  \    \"symbolIcon.fileForeground\": \"#5a6378\",\n\
  \    \"symbolIcon.folderForeground\": \"#5a6378\",\n\
  \    \"symbolIcon.functionForeground\": \"#ffb454\",\n\
  \    \"symbolIcon.interfaceForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.keyForeground\": \"#39bae6\",\n\
  \    \"symbolIcon.keywordForeground\": \"#ff8f40\",\n\
  \    \"symbolIcon.methodForeground\": \"#ffb454\",\n\
  \    \"symbolIcon.moduleForeground\": \"#aad94c\",\n\
  \    \"symbolIcon.namespaceForeground\": \"#aad94c\",\n\
  \    \"symbolIcon.nullForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.numberForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.objectForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.operatorForeground\": \"#f29668\",\n\
  \    \"symbolIcon.packageForeground\": \"#aad94c\",\n\
  \    \"symbolIcon.propertyForeground\": \"#f07178\",\n\
  \    \"symbolIcon.referenceForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.snippetForeground\": \"#e6c08a\",\n\
  \    \"symbolIcon.stringForeground\": \"#aad94c\",\n\
  \    \"symbolIcon.structForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.textForeground\": \"#bfbdb6\",\n\
  \    \"symbolIcon.typeParameterForeground\": \"#59c2ff\",\n\
  \    \"symbolIcon.unitForeground\": \"#d2a6ff\",\n\
  \    \"symbolIcon.variableForeground\": \"#bfbdb6\",\n\
  \    \"tab.activeBackground\": \"#10141c\",\n\
  \    \"tab.activeBorder\": \"#10141c\",\n\
  \    \"tab.activeBorderTop\": \"#e6b450\",\n\
  \    \"tab.activeForeground\": \"#bfbdb6\",\n\
  \    \"tab.border\": \"#1b1f29\",\n\
  \    \"tab.inactiveBackground\": \"#0d1017\",\n\
  \    \"tab.inactiveForeground\": \"#5a6378\",\n\
  \    \"tab.unfocusedActiveBorderTop\": \"#5a6378\",\n\
  \    \"tab.unfocusedActiveForeground\": \"#5a6378\",\n\
  \    \"tab.unfocusedInactiveForeground\": \"#5a6378\",\n\
  \    \"terminal.ansiBlack\": \"#1b1f29\",\n\
  \    \"terminal.ansiBlue\": \"#4fbfff\",\n\
  \    \"terminal.ansiBrightBlack\": \"#686868\",\n\
  \    \"terminal.ansiBrightBlue\": \"#59c2ff\",\n\
  \    \"terminal.ansiBrightCyan\": \"#95e6cb\",\n\
  \    \"terminal.ansiBrightGreen\": \"#aad94c\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#d2a6ff\",\n\
  \    \"terminal.ansiBrightRed\": \"#f07178\",\n\
  \    \"terminal.ansiBrightWhite\": \"#ffffff\",\n\
  \    \"terminal.ansiBrightYellow\": \"#ffb454\",\n\
  \    \"terminal.ansiCyan\": \"#93e2c8\",\n\
  \    \"terminal.ansiGreen\": \"#70bf56\",\n\
  \    \"terminal.ansiMagenta\": \"#d0a1ff\",\n\
  \    \"terminal.ansiRed\": \"#f06b73\",\n\
  \    \"terminal.ansiWhite\": \"#c7c7c7\",\n\
  \    \"terminal.ansiYellow\": \"#fdb04c\",\n\
  \    \"terminal.background\": \"#0d1017\",\n\
  \    \"terminal.foreground\": \"#bfbdb6\",\n\
  \    \"terminalCommandGuide.foreground\": \"#5a63784d\",\n\
  \    \"terminalStickyScroll.border\": \"#1b1f29\",\n\
  \    \"terminalStickyScroll.shadow\": \"#00000080\",\n\
  \    \"terminalStickyScrollHover.background\": \"#47526633\",\n\
  \    \"textBlockQuote.background\": \"#141821\",\n\
  \    \"textLink.activeForeground\": \"#e6b450\",\n\
  \    \"textLink.foreground\": \"#e6b450\",\n\
  \    \"textPreformat.foreground\": \"#bfbdb6\",\n\
  \    \"titleBar.activeBackground\": \"#0d1017\",\n\
  \    \"titleBar.activeForeground\": \"#5a6378\",\n\
  \    \"titleBar.border\": \"#1b1f29\",\n\
  \    \"titleBar.inactiveBackground\": \"#0d1017\",\n\
  \    \"titleBar.inactiveForeground\": \"#5a6378b3\",\n\
  \    \"toolbar.hoverBackground\": \"#47526640\",\n\
  \    \"tree.indentGuidesStroke\": \"#5a6378a1\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#141821\",\n\
  \    \"welcomePage.buttonBackground\": \"#e6b45066\",\n\
  \    \"welcomePage.progress.background\": \"#161a24\",\n\
  \    \"welcomePage.tileBackground\": \"#0d1017\",\n\
  \    \"welcomePage.tileShadow\": \"#00000080\",\n\
  \    \"widget.border\": \"#1b1f29\",\n\
  \    \"widget.shadow\": \"#00000080\"\n\
  \  },\n\
  \  \"displayName\": \"Ayu Dark\",\n\
  \  \"name\": \"ayu-dark\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"class\": \"#59c2ff\",\n\
  \    \"class.defaultLibrary\": \"#39bae6\",\n\
  \    \"comment\": \"#5a6673\",\n\
  \    \"enum\": \"#59c2ff\",\n\
  \    \"enum.defaultLibrary\": \"#39bae6\",\n\
  \    \"enumMember\": \"#95e6cb\",\n\
  \    \"event\": \"#f29668\",\n\
  \    \"function\": \"#ffb454\",\n\
  \    \"interface\": \"#39bae6\",\n\
  \    \"interface.defaultLibrary\": {\n\
  \      \"foreground\": \"#39bae6\",\n\
  \      \"italic\": true\n\
  \    },\n\
  \    \"keyword\": \"#ff8f40\",\n\
  \    \"macro\": \"#e6c08a\",\n\
  \    \"method\": \"#ffb454\",\n\
  \    \"number\": \"#d2a6ff\",\n\
  \    \"operator\": \"#f29668\",\n\
  \    \"regexp\": \"#95e6cb\",\n\
  \    \"string\": \"#aad94c\",\n\
  \    \"struct\": \"#59c2ff\",\n\
  \    \"struct.defaultLibrary\": \"#39bae6\",\n\
  \    \"type\": \"#59c2ff\",\n\
  \    \"type.defaultLibrary\": \"#39bae6\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"settings\": {\n\
  \        \"background\": \"#0d1017\",\n\
  \        \"foreground\": \"#bfbdb6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"constant.other.symbol\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#aad94c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.regexp\",\n\
  \        \"constant.character\",\n\
  \        \"constant.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#95e6cb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d2a6ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d2a6ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable\",\n\
  \        \"variable.parameter.function-call\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bfbdb6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.member\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f07178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f29668\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.separator\",\n\
  \        \"punctuation.terminator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bfbdb6b3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bfbdb6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.accessor\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f29668\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.template-expression\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bfbdb6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java storage.type\",\n\
  \        \"source.haskell storage.type\",\n\
  \        \"source.c storage.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#59c2ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.inherited-class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java storage.type.primitive\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffb454\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter\",\n\
  \        \"meta.parameter\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d2a6ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.function\",\n\
  \        \"variable.annotation\",\n\
  \        \"meta.function-call.generic\",\n\
  \        \"support.function.go\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffb454\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.function\",\n\
  \        \"support.macro\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f07178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.import\",\n\
  \        \"entity.name.package\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#aad94c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#59c2ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag\",\n\
  \        \"meta.tag.sgml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.component\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#59c2ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.tag.end\",\n\
  \        \"punctuation.definition.tag.begin\",\n\
  \        \"punctuation.definition.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae680\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffb454\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.pseudo-class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#95e6cb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f29668\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type\",\n\
  \        \"support.class\",\n\
  \        \"source.go storage.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.decorator variable.other\",\n\
  \        \"meta.decorator punctuation.decorator\",\n\
  \        \"storage.type.annotation\",\n\
  \        \"entity.name.function.decorator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e6c08a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"invalid\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d95757\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.diff\",\n\
  \        \"meta.diff.header\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c594c5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ruby variable.other.readwrite\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffb454\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css entity.name.tag\",\n\
  \        \"source.sass entity.name.tag\",\n\
  \        \"source.scss entity.name.tag\",\n\
  \        \"source.less entity.name.tag\",\n\
  \        \"source.stylus entity.name.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#59c2ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css support.type\",\n\
  \        \"source.sass support.type\",\n\
  \        \"source.scss support.type\",\n\
  \        \"source.less support.type\",\n\
  \        \"source.stylus support.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"normal\",\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric.line-number.find-in-files - match\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric.line-number.match\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ff8f40\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.filename.find-in-files\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#aad94c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"message.error\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d95757\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.heading\",\n\
  \        \"markup.heading entity.name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#aad94c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.underline.link\",\n\
  \        \"string.other.link\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.italic\",\n\
  \        \"emphasis\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f07178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.bold\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#f07178\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.underline\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.italic markup.bold\",\n\
  \        \"markup.bold markup.italic\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.raw\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#bfbdb605\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.raw.inline\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#bfbdb60f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.separator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#bfbdb60f\",\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.quote\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#95e6cb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.list punctuation.definition.list.begin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffb454\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.inserted\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#70bf56\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.changed\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#73b8ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.deleted\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f26d78\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.strike\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e6c08a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.strong\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.table\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#bfbdb60f\",\n\
  \        \"foreground\": \"#39bae6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown markup.inline.raw\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f29668\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown meta.dummy.line-break\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#5a6673\",\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"background\": \"#bfbdb6\",\n\
  \        \"foreground\": \"#5a6673\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let catppuccin_mocha =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.activeBackground\": \"#00000000\",\n\
  \    \"activityBar.activeBorder\": \"#00000000\",\n\
  \    \"activityBar.activeFocusBorder\": \"#00000000\",\n\
  \    \"activityBar.background\": \"#11111b\",\n\
  \    \"activityBar.border\": \"#00000000\",\n\
  \    \"activityBar.dropBorder\": \"#cba6f733\",\n\
  \    \"activityBar.foreground\": \"#cba6f7\",\n\
  \    \"activityBar.inactiveForeground\": \"#6c7086\",\n\
  \    \"activityBarBadge.background\": \"#cba6f7\",\n\
  \    \"activityBarBadge.foreground\": \"#11111b\",\n\
  \    \"activityBarTop.activeBorder\": \"#00000000\",\n\
  \    \"activityBarTop.dropBorder\": \"#cba6f733\",\n\
  \    \"activityBarTop.foreground\": \"#cba6f7\",\n\
  \    \"activityBarTop.inactiveForeground\": \"#6c7086\",\n\
  \    \"badge.background\": \"#45475a\",\n\
  \    \"badge.foreground\": \"#cdd6f4\",\n\
  \    \"banner.background\": \"#45475a\",\n\
  \    \"banner.foreground\": \"#cdd6f4\",\n\
  \    \"banner.iconForeground\": \"#cdd6f4\",\n\
  \    \"breadcrumb.activeSelectionForeground\": \"#cba6f7\",\n\
  \    \"breadcrumb.background\": \"#1e1e2e\",\n\
  \    \"breadcrumb.focusForeground\": \"#cba6f7\",\n\
  \    \"breadcrumb.foreground\": \"#cdd6f4cc\",\n\
  \    \"breadcrumbPicker.background\": \"#181825\",\n\
  \    \"button.background\": \"#cba6f7\",\n\
  \    \"button.border\": \"#00000000\",\n\
  \    \"button.foreground\": \"#11111b\",\n\
  \    \"button.hoverBackground\": \"#dec7fa\",\n\
  \    \"button.secondaryBackground\": \"#585b70\",\n\
  \    \"button.secondaryBorder\": \"#cba6f7\",\n\
  \    \"button.secondaryForeground\": \"#cdd6f4\",\n\
  \    \"button.secondaryHoverBackground\": \"#686b84\",\n\
  \    \"button.separator\": \"#00000000\",\n\
  \    \"charts.blue\": \"#89b4fa\",\n\
  \    \"charts.foreground\": \"#cdd6f4\",\n\
  \    \"charts.green\": \"#a6e3a1\",\n\
  \    \"charts.lines\": \"#bac2de\",\n\
  \    \"charts.orange\": \"#fab387\",\n\
  \    \"charts.purple\": \"#cba6f7\",\n\
  \    \"charts.red\": \"#f38ba8\",\n\
  \    \"charts.yellow\": \"#f9e2af\",\n\
  \    \"checkbox.background\": \"#45475a\",\n\
  \    \"checkbox.border\": \"#00000000\",\n\
  \    \"checkbox.foreground\": \"#cba6f7\",\n\
  \    \"commandCenter.activeBackground\": \"#585b7033\",\n\
  \    \"commandCenter.activeBorder\": \"#cba6f7\",\n\
  \    \"commandCenter.activeForeground\": \"#cba6f7\",\n\
  \    \"commandCenter.background\": \"#181825\",\n\
  \    \"commandCenter.border\": \"#00000000\",\n\
  \    \"commandCenter.foreground\": \"#bac2de\",\n\
  \    \"commandCenter.inactiveBorder\": \"#00000000\",\n\
  \    \"commandCenter.inactiveForeground\": \"#bac2de\",\n\
  \    \"debugConsole.errorForeground\": \"#f38ba8\",\n\
  \    \"debugConsole.infoForeground\": \"#89b4fa\",\n\
  \    \"debugConsole.sourceForeground\": \"#f5e0dc\",\n\
  \    \"debugConsole.warningForeground\": \"#fab387\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#cdd6f4\",\n\
  \    \"debugExceptionWidget.background\": \"#11111b\",\n\
  \    \"debugExceptionWidget.border\": \"#cba6f7\",\n\
  \    \"debugIcon.breakpointCurrentStackframeForeground\": \"#585b70\",\n\
  \    \"debugIcon.breakpointDisabledForeground\": \"#f38ba899\",\n\
  \    \"debugIcon.breakpointForeground\": \"#f38ba8\",\n\
  \    \"debugIcon.breakpointStackframeForeground\": \"#585b70\",\n\
  \    \"debugIcon.breakpointUnverifiedForeground\": \"#a6738c\",\n\
  \    \"debugIcon.continueForeground\": \"#a6e3a1\",\n\
  \    \"debugIcon.disconnectForeground\": \"#585b70\",\n\
  \    \"debugIcon.pauseForeground\": \"#89b4fa\",\n\
  \    \"debugIcon.restartForeground\": \"#94e2d5\",\n\
  \    \"debugIcon.startForeground\": \"#a6e3a1\",\n\
  \    \"debugIcon.stepBackForeground\": \"#585b70\",\n\
  \    \"debugIcon.stepIntoForeground\": \"#cdd6f4\",\n\
  \    \"debugIcon.stepOutForeground\": \"#cdd6f4\",\n\
  \    \"debugIcon.stepOverForeground\": \"#cba6f7\",\n\
  \    \"debugIcon.stopForeground\": \"#f38ba8\",\n\
  \    \"debugTokenExpression.boolean\": \"#cba6f7\",\n\
  \    \"debugTokenExpression.error\": \"#f38ba8\",\n\
  \    \"debugTokenExpression.number\": \"#fab387\",\n\
  \    \"debugTokenExpression.string\": \"#a6e3a1\",\n\
  \    \"debugToolBar.background\": \"#11111b\",\n\
  \    \"debugToolBar.border\": \"#00000000\",\n\
  \    \"descriptionForeground\": \"#cdd6f4\",\n\
  \    \"diffEditor.border\": \"#585b70\",\n\
  \    \"diffEditor.diagonalFill\": \"#585b7099\",\n\
  \    \"diffEditor.insertedLineBackground\": \"#a6e3a126\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#a6e3a133\",\n\
  \    \"diffEditor.removedLineBackground\": \"#f38ba826\",\n\
  \    \"diffEditor.removedTextBackground\": \"#f38ba833\",\n\
  \    \"diffEditorOverview.insertedForeground\": \"#a6e3a1cc\",\n\
  \    \"diffEditorOverview.removedForeground\": \"#f38ba8cc\",\n\
  \    \"disabledForeground\": \"#a6adc8\",\n\
  \    \"dropdown.background\": \"#181825\",\n\
  \    \"dropdown.border\": \"#cba6f7\",\n\
  \    \"dropdown.foreground\": \"#cdd6f4\",\n\
  \    \"dropdown.listBackground\": \"#585b70\",\n\
  \    \"editor.background\": \"#1e1e2e\",\n\
  \    \"editor.findMatchBackground\": \"#5e3f53\",\n\
  \    \"editor.findMatchBorder\": \"#f38ba833\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#3e5767\",\n\
  \    \"editor.findMatchHighlightBorder\": \"#89dceb33\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#3e5767\",\n\
  \    \"editor.findRangeHighlightBorder\": \"#89dceb33\",\n\
  \    \"editor.focusedStackFrameHighlightBackground\": \"#a6e3a126\",\n\
  \    \"editor.foldBackground\": \"#89dceb40\",\n\
  \    \"editor.foreground\": \"#cdd6f4\",\n\
  \    \"editor.hoverHighlightBackground\": \"#89dceb40\",\n\
  \    \"editor.lineHighlightBackground\": \"#cdd6f412\",\n\
  \    \"editor.lineHighlightBorder\": \"#00000000\",\n\
  \    \"editor.rangeHighlightBackground\": \"#89dceb40\",\n\
  \    \"editor.rangeHighlightBorder\": \"#00000000\",\n\
  \    \"editor.selectionBackground\": \"#9399b240\",\n\
  \    \"editor.selectionHighlightBackground\": \"#9399b233\",\n\
  \    \"editor.selectionHighlightBorder\": \"#9399b233\",\n\
  \    \"editor.stackFrameHighlightBackground\": \"#f9e2af26\",\n\
  \    \"editor.wordHighlightBackground\": \"#9399b233\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#89b4fa33\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#f38ba8\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#fab387\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#f9e2af\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#a6e3a1\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#74c7ec\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#cba6f7\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#eba0ac\",\n\
  \    \"editorBracketMatch.background\": \"#9399b21a\",\n\
  \    \"editorBracketMatch.border\": \"#9399b2\",\n\
  \    \"editorCodeLens.foreground\": \"#7f849c\",\n\
  \    \"editorCursor.background\": \"#1e1e2e\",\n\
  \    \"editorCursor.foreground\": \"#f5e0dc\",\n\
  \    \"editorError.background\": \"#00000000\",\n\
  \    \"editorError.border\": \"#00000000\",\n\
  \    \"editorError.foreground\": \"#f38ba8\",\n\
  \    \"editorGroup.border\": \"#585b70\",\n\
  \    \"editorGroup.dropBackground\": \"#cba6f733\",\n\
  \    \"editorGroup.emptyBackground\": \"#1e1e2e\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#11111b\",\n\
  \    \"editorGutter.addedBackground\": \"#a6e3a1\",\n\
  \    \"editorGutter.background\": \"#1e1e2e\",\n\
  \    \"editorGutter.commentGlyphForeground\": \"#cba6f7\",\n\
  \    \"editorGutter.commentRangeForeground\": \"#313244\",\n\
  \    \"editorGutter.deletedBackground\": \"#f38ba8\",\n\
  \    \"editorGutter.foldingControlForeground\": \"#9399b2\",\n\
  \    \"editorGutter.modifiedBackground\": \"#f9e2af\",\n\
  \    \"editorHoverWidget.background\": \"#181825\",\n\
  \    \"editorHoverWidget.border\": \"#585b70\",\n\
  \    \"editorHoverWidget.foreground\": \"#cdd6f4\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#585b70\",\n\
  \    \"editorIndentGuide.background\": \"#45475a\",\n\
  \    \"editorInfo.background\": \"#00000000\",\n\
  \    \"editorInfo.border\": \"#00000000\",\n\
  \    \"editorInfo.foreground\": \"#89b4fa\",\n\
  \    \"editorInlayHint.background\": \"#181825bf\",\n\
  \    \"editorInlayHint.foreground\": \"#585b70\",\n\
  \    \"editorInlayHint.parameterBackground\": \"#181825bf\",\n\
  \    \"editorInlayHint.parameterForeground\": \"#a6adc8\",\n\
  \    \"editorInlayHint.typeBackground\": \"#181825bf\",\n\
  \    \"editorInlayHint.typeForeground\": \"#bac2de\",\n\
  \    \"editorLightBulb.foreground\": \"#f9e2af\",\n\
  \    \"editorLineNumber.activeForeground\": \"#cba6f7\",\n\
  \    \"editorLineNumber.foreground\": \"#7f849c\",\n\
  \    \"editorLink.activeForeground\": \"#cba6f7\",\n\
  \    \"editorMarkerNavigation.background\": \"#181825\",\n\
  \    \"editorMarkerNavigationError.background\": \"#f38ba8\",\n\
  \    \"editorMarkerNavigationInfo.background\": \"#89b4fa\",\n\
  \    \"editorMarkerNavigationWarning.background\": \"#fab387\",\n\
  \    \"editorOverviewRuler.background\": \"#181825\",\n\
  \    \"editorOverviewRuler.border\": \"#cdd6f412\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#f9e2af\",\n\
  \    \"editorRuler.foreground\": \"#585b70\",\n\
  \    \"editorStickyScrollHover.background\": \"#313244\",\n\
  \    \"editorSuggestWidget.background\": \"#181825\",\n\
  \    \"editorSuggestWidget.border\": \"#585b70\",\n\
  \    \"editorSuggestWidget.foreground\": \"#cdd6f4\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#cba6f7\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#313244\",\n\
  \    \"editorWarning.background\": \"#00000000\",\n\
  \    \"editorWarning.border\": \"#00000000\",\n\
  \    \"editorWarning.foreground\": \"#fab387\",\n\
  \    \"editorWhitespace.foreground\": \"#9399b266\",\n\
  \    \"editorWidget.background\": \"#181825\",\n\
  \    \"editorWidget.foreground\": \"#cdd6f4\",\n\
  \    \"editorWidget.resizeBorder\": \"#585b70\",\n\
  \    \"errorForeground\": \"#f38ba8\",\n\
  \    \"errorLens.errorBackground\": \"#f38ba826\",\n\
  \    \"errorLens.errorBackgroundLight\": \"#f38ba826\",\n\
  \    \"errorLens.errorForeground\": \"#f38ba8\",\n\
  \    \"errorLens.errorForegroundLight\": \"#f38ba8\",\n\
  \    \"errorLens.errorMessageBackground\": \"#f38ba826\",\n\
  \    \"errorLens.hintBackground\": \"#a6e3a126\",\n\
  \    \"errorLens.hintBackgroundLight\": \"#a6e3a126\",\n\
  \    \"errorLens.hintForeground\": \"#a6e3a1\",\n\
  \    \"errorLens.hintForegroundLight\": \"#a6e3a1\",\n\
  \    \"errorLens.hintMessageBackground\": \"#a6e3a126\",\n\
  \    \"errorLens.infoBackground\": \"#89b4fa26\",\n\
  \    \"errorLens.infoBackgroundLight\": \"#89b4fa26\",\n\
  \    \"errorLens.infoForeground\": \"#89b4fa\",\n\
  \    \"errorLens.infoForegroundLight\": \"#89b4fa\",\n\
  \    \"errorLens.infoMessageBackground\": \"#89b4fa26\",\n\
  \    \"errorLens.statusBarErrorForeground\": \"#f38ba8\",\n\
  \    \"errorLens.statusBarHintForeground\": \"#a6e3a1\",\n\
  \    \"errorLens.statusBarIconErrorForeground\": \"#f38ba8\",\n\
  \    \"errorLens.statusBarIconWarningForeground\": \"#fab387\",\n\
  \    \"errorLens.statusBarInfoForeground\": \"#89b4fa\",\n\
  \    \"errorLens.statusBarWarningForeground\": \"#fab387\",\n\
  \    \"errorLens.warningBackground\": \"#fab38726\",\n\
  \    \"errorLens.warningBackgroundLight\": \"#fab38726\",\n\
  \    \"errorLens.warningForeground\": \"#fab387\",\n\
  \    \"errorLens.warningForegroundLight\": \"#fab387\",\n\
  \    \"errorLens.warningMessageBackground\": \"#fab38726\",\n\
  \    \"extensionBadge.remoteBackground\": \"#89b4fa\",\n\
  \    \"extensionBadge.remoteForeground\": \"#11111b\",\n\
  \    \"extensionButton.prominentBackground\": \"#cba6f7\",\n\
  \    \"extensionButton.prominentForeground\": \"#11111b\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#dec7fa\",\n\
  \    \"extensionButton.separator\": \"#1e1e2e\",\n\
  \    \"extensionIcon.preReleaseForeground\": \"#585b70\",\n\
  \    \"extensionIcon.sponsorForeground\": \"#f5c2e7\",\n\
  \    \"extensionIcon.starForeground\": \"#f9e2af\",\n\
  \    \"extensionIcon.verifiedForeground\": \"#a6e3a1\",\n\
  \    \"focusBorder\": \"#cba6f7\",\n\
  \    \"foreground\": \"#cdd6f4\",\n\
  \    \"gitDecoration.addedResourceForeground\": \"#a6e3a1\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#cba6f7\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#f38ba8\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#6c7086\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#f9e2af\",\n\
  \    \"gitDecoration.stageDeletedResourceForeground\": \"#f38ba8\",\n\
  \    \"gitDecoration.stageModifiedResourceForeground\": \"#f9e2af\",\n\
  \    \"gitDecoration.submoduleResourceForeground\": \"#89b4fa\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#a6e3a1\",\n\
  \    \"gitlens.closedAutolinkedIssueIconColor\": \"#cba6f7\",\n\
  \    \"gitlens.closedPullRequestIconColor\": \"#f38ba8\",\n\
  \    \"gitlens.decorations.branchAheadForegroundColor\": \"#a6e3a1\",\n\
  \    \"gitlens.decorations.branchBehindForegroundColor\": \"#fab387\",\n\
  \    \"gitlens.decorations.branchDivergedForegroundColor\": \"#f9e2af\",\n\
  \    \"gitlens.decorations.branchMissingUpstreamForegroundColor\": \
   \"#fab387\",\n\
  \    \"gitlens.decorations.branchUnpublishedForegroundColor\": \"#a6e3a1\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingConflictForegroundColor\": \
   \"#eba0ac\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingForegroundColor\": \
   \"#f9e2af\",\n\
  \    \"gitlens.decorations.workspaceCurrentForegroundColor\": \"#cba6f7\",\n\
  \    \"gitlens.decorations.workspaceRepoMissingForegroundColor\": \"#a6adc8\",\n\
  \    \"gitlens.decorations.workspaceRepoOpenForegroundColor\": \"#cba6f7\",\n\
  \    \"gitlens.decorations.worktreeHasUncommittedChangesForegroundColor\": \
   \"#fab387\",\n\
  \    \"gitlens.decorations.worktreeMissingForegroundColor\": \"#eba0ac\",\n\
  \    \"gitlens.graphChangesColumnAddedColor\": \"#a6e3a1\",\n\
  \    \"gitlens.graphChangesColumnDeletedColor\": \"#f38ba8\",\n\
  \    \"gitlens.graphLane10Color\": \"#f5c2e7\",\n\
  \    \"gitlens.graphLane1Color\": \"#cba6f7\",\n\
  \    \"gitlens.graphLane2Color\": \"#f9e2af\",\n\
  \    \"gitlens.graphLane3Color\": \"#89b4fa\",\n\
  \    \"gitlens.graphLane4Color\": \"#f2cdcd\",\n\
  \    \"gitlens.graphLane5Color\": \"#a6e3a1\",\n\
  \    \"gitlens.graphLane6Color\": \"#b4befe\",\n\
  \    \"gitlens.graphLane7Color\": \"#f5e0dc\",\n\
  \    \"gitlens.graphLane8Color\": \"#f38ba8\",\n\
  \    \"gitlens.graphLane9Color\": \"#94e2d5\",\n\
  \    \"gitlens.graphMinimapMarkerHeadColor\": \"#a6e3a1\",\n\
  \    \"gitlens.graphMinimapMarkerHighlightsColor\": \"#f9e2af\",\n\
  \    \"gitlens.graphMinimapMarkerLocalBranchesColor\": \"#89b4fa\",\n\
  \    \"gitlens.graphMinimapMarkerRemoteBranchesColor\": \"#71a4f9\",\n\
  \    \"gitlens.graphMinimapMarkerStashesColor\": \"#cba6f7\",\n\
  \    \"gitlens.graphMinimapMarkerTagsColor\": \"#f2cdcd\",\n\
  \    \"gitlens.graphMinimapMarkerUpstreamColor\": \"#93dd8d\",\n\
  \    \"gitlens.graphScrollMarkerHeadColor\": \"#a6e3a1\",\n\
  \    \"gitlens.graphScrollMarkerHighlightsColor\": \"#f9e2af\",\n\
  \    \"gitlens.graphScrollMarkerLocalBranchesColor\": \"#89b4fa\",\n\
  \    \"gitlens.graphScrollMarkerRemoteBranchesColor\": \"#71a4f9\",\n\
  \    \"gitlens.graphScrollMarkerStashesColor\": \"#cba6f7\",\n\
  \    \"gitlens.graphScrollMarkerTagsColor\": \"#f2cdcd\",\n\
  \    \"gitlens.graphScrollMarkerUpstreamColor\": \"#93dd8d\",\n\
  \    \"gitlens.gutterBackgroundColor\": \"#3132444d\",\n\
  \    \"gitlens.gutterForegroundColor\": \"#cdd6f4\",\n\
  \    \"gitlens.gutterUncommittedForegroundColor\": \"#cba6f7\",\n\
  \    \"gitlens.lineHighlightBackgroundColor\": \"#cba6f726\",\n\
  \    \"gitlens.lineHighlightOverviewRulerColor\": \"#cba6f7cc\",\n\
  \    \"gitlens.mergedPullRequestIconColor\": \"#cba6f7\",\n\
  \    \"gitlens.openAutolinkedIssueIconColor\": \"#a6e3a1\",\n\
  \    \"gitlens.openPullRequestIconColor\": \"#a6e3a1\",\n\
  \    \"gitlens.trailingLineBackgroundColor\": \"#00000000\",\n\
  \    \"gitlens.trailingLineForegroundColor\": \"#cdd6f44d\",\n\
  \    \"gitlens.unpublishedChangesIconColor\": \"#a6e3a1\",\n\
  \    \"gitlens.unpublishedCommitIconColor\": \"#a6e3a1\",\n\
  \    \"gitlens.unpulledChangesIconColor\": \"#fab387\",\n\
  \    \"icon.foreground\": \"#cba6f7\",\n\
  \    \"input.background\": \"#313244\",\n\
  \    \"input.border\": \"#00000000\",\n\
  \    \"input.foreground\": \"#cdd6f4\",\n\
  \    \"input.placeholderForeground\": \"#cdd6f473\",\n\
  \    \"inputOption.activeBackground\": \"#585b70\",\n\
  \    \"inputOption.activeBorder\": \"#cba6f7\",\n\
  \    \"inputOption.activeForeground\": \"#cdd6f4\",\n\
  \    \"inputValidation.errorBackground\": \"#f38ba8\",\n\
  \    \"inputValidation.errorBorder\": \"#11111b33\",\n\
  \    \"inputValidation.errorForeground\": \"#11111b\",\n\
  \    \"inputValidation.infoBackground\": \"#89b4fa\",\n\
  \    \"inputValidation.infoBorder\": \"#11111b33\",\n\
  \    \"inputValidation.infoForeground\": \"#11111b\",\n\
  \    \"inputValidation.warningBackground\": \"#fab387\",\n\
  \    \"inputValidation.warningBorder\": \"#11111b33\",\n\
  \    \"inputValidation.warningForeground\": \"#11111b\",\n\
  \    \"issues.closed\": \"#cba6f7\",\n\
  \    \"issues.newIssueDecoration\": \"#f5e0dc\",\n\
  \    \"issues.open\": \"#a6e3a1\",\n\
  \    \"list.activeSelectionBackground\": \"#313244\",\n\
  \    \"list.activeSelectionForeground\": \"#cdd6f4\",\n\
  \    \"list.dropBackground\": \"#cba6f733\",\n\
  \    \"list.focusAndSelectionBackground\": \"#45475a\",\n\
  \    \"list.focusBackground\": \"#313244\",\n\
  \    \"list.focusForeground\": \"#cdd6f4\",\n\
  \    \"list.focusOutline\": \"#00000000\",\n\
  \    \"list.highlightForeground\": \"#cba6f7\",\n\
  \    \"list.hoverBackground\": \"#31324480\",\n\
  \    \"list.hoverForeground\": \"#cdd6f4\",\n\
  \    \"list.inactiveSelectionBackground\": \"#313244\",\n\
  \    \"list.inactiveSelectionForeground\": \"#cdd6f4\",\n\
  \    \"list.warningForeground\": \"#fab387\",\n\
  \    \"listFilterWidget.background\": \"#45475a\",\n\
  \    \"listFilterWidget.noMatchesOutline\": \"#f38ba8\",\n\
  \    \"listFilterWidget.outline\": \"#00000000\",\n\
  \    \"menu.background\": \"#1e1e2e\",\n\
  \    \"menu.border\": \"#1e1e2e80\",\n\
  \    \"menu.foreground\": \"#cdd6f4\",\n\
  \    \"menu.selectionBackground\": \"#585b70\",\n\
  \    \"menu.selectionBorder\": \"#00000000\",\n\
  \    \"menu.selectionForeground\": \"#cdd6f4\",\n\
  \    \"menu.separatorBackground\": \"#585b70\",\n\
  \    \"menubar.selectionBackground\": \"#45475a\",\n\
  \    \"menubar.selectionForeground\": \"#cdd6f4\",\n\
  \    \"merge.commonContentBackground\": \"#45475a\",\n\
  \    \"merge.commonHeaderBackground\": \"#585b70\",\n\
  \    \"merge.currentContentBackground\": \"#a6e3a133\",\n\
  \    \"merge.currentHeaderBackground\": \"#a6e3a166\",\n\
  \    \"merge.incomingContentBackground\": \"#89b4fa33\",\n\
  \    \"merge.incomingHeaderBackground\": \"#89b4fa66\",\n\
  \    \"minimap.background\": \"#18182580\",\n\
  \    \"minimap.errorHighlight\": \"#f38ba8bf\",\n\
  \    \"minimap.findMatchHighlight\": \"#89dceb4d\",\n\
  \    \"minimap.selectionHighlight\": \"#585b70bf\",\n\
  \    \"minimap.selectionOccurrenceHighlight\": \"#585b70bf\",\n\
  \    \"minimap.warningHighlight\": \"#fab387bf\",\n\
  \    \"minimapGutter.addedBackground\": \"#a6e3a1bf\",\n\
  \    \"minimapGutter.deletedBackground\": \"#f38ba8bf\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#f9e2afbf\",\n\
  \    \"minimapSlider.activeBackground\": \"#cba6f799\",\n\
  \    \"minimapSlider.background\": \"#cba6f733\",\n\
  \    \"minimapSlider.hoverBackground\": \"#cba6f766\",\n\
  \    \"notificationCenter.border\": \"#cba6f7\",\n\
  \    \"notificationCenterHeader.background\": \"#181825\",\n\
  \    \"notificationCenterHeader.foreground\": \"#cdd6f4\",\n\
  \    \"notificationLink.foreground\": \"#89b4fa\",\n\
  \    \"notificationToast.border\": \"#cba6f7\",\n\
  \    \"notifications.background\": \"#181825\",\n\
  \    \"notifications.border\": \"#cba6f7\",\n\
  \    \"notifications.foreground\": \"#cdd6f4\",\n\
  \    \"notificationsErrorIcon.foreground\": \"#f38ba8\",\n\
  \    \"notificationsInfoIcon.foreground\": \"#89b4fa\",\n\
  \    \"notificationsWarningIcon.foreground\": \"#fab387\",\n\
  \    \"panel.background\": \"#1e1e2e\",\n\
  \    \"panel.border\": \"#585b70\",\n\
  \    \"panelSection.border\": \"#585b70\",\n\
  \    \"panelSection.dropBackground\": \"#cba6f733\",\n\
  \    \"panelTitle.activeBorder\": \"#cba6f7\",\n\
  \    \"panelTitle.activeForeground\": \"#cdd6f4\",\n\
  \    \"panelTitle.inactiveForeground\": \"#a6adc8\",\n\
  \    \"peekView.border\": \"#cba6f7\",\n\
  \    \"peekViewEditor.background\": \"#181825\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#89dceb4d\",\n\
  \    \"peekViewEditor.matchHighlightBorder\": \"#00000000\",\n\
  \    \"peekViewEditorGutter.background\": \"#181825\",\n\
  \    \"peekViewResult.background\": \"#181825\",\n\
  \    \"peekViewResult.fileForeground\": \"#cdd6f4\",\n\
  \    \"peekViewResult.lineForeground\": \"#cdd6f4\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#89dceb4d\",\n\
  \    \"peekViewResult.selectionBackground\": \"#313244\",\n\
  \    \"peekViewResult.selectionForeground\": \"#cdd6f4\",\n\
  \    \"peekViewTitle.background\": \"#1e1e2e\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#bac2deb3\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#cdd6f4\",\n\
  \    \"pickerGroup.border\": \"#cba6f7\",\n\
  \    \"pickerGroup.foreground\": \"#cba6f7\",\n\
  \    \"problemsErrorIcon.foreground\": \"#f38ba8\",\n\
  \    \"problemsInfoIcon.foreground\": \"#89b4fa\",\n\
  \    \"problemsWarningIcon.foreground\": \"#fab387\",\n\
  \    \"progressBar.background\": \"#cba6f7\",\n\
  \    \"pullRequests.closed\": \"#f38ba8\",\n\
  \    \"pullRequests.draft\": \"#9399b2\",\n\
  \    \"pullRequests.merged\": \"#cba6f7\",\n\
  \    \"pullRequests.notification\": \"#cdd6f4\",\n\
  \    \"pullRequests.open\": \"#a6e3a1\",\n\
  \    \"sash.hoverBorder\": \"#cba6f7\",\n\
  \    \"scmGraph.foreground1\": \"#f9e2af\",\n\
  \    \"scmGraph.foreground2\": \"#f38ba8\",\n\
  \    \"scmGraph.foreground3\": \"#a6e3a1\",\n\
  \    \"scmGraph.foreground4\": \"#cba6f7\",\n\
  \    \"scmGraph.foreground5\": \"#94e2d5\",\n\
  \    \"scmGraph.historyItemBaseRefColor\": \"#fab387\",\n\
  \    \"scmGraph.historyItemRefColor\": \"#89b4fa\",\n\
  \    \"scmGraph.historyItemRemoteRefColor\": \"#cba6f7\",\n\
  \    \"scrollbar.shadow\": \"#11111b\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#31324466\",\n\
  \    \"scrollbarSlider.background\": \"#585b7080\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#6c7086\",\n\
  \    \"selection.background\": \"#cba6f766\",\n\
  \    \"settings.dropdownBackground\": \"#45475a\",\n\
  \    \"settings.dropdownListBorder\": \"#00000000\",\n\
  \    \"settings.focusedRowBackground\": \"#585b7033\",\n\
  \    \"settings.headerForeground\": \"#cdd6f4\",\n\
  \    \"settings.modifiedItemIndicator\": \"#cba6f7\",\n\
  \    \"settings.numberInputBackground\": \"#45475a\",\n\
  \    \"settings.numberInputBorder\": \"#00000000\",\n\
  \    \"settings.textInputBackground\": \"#45475a\",\n\
  \    \"settings.textInputBorder\": \"#00000000\",\n\
  \    \"sideBar.background\": \"#181825\",\n\
  \    \"sideBar.border\": \"#00000000\",\n\
  \    \"sideBar.dropBackground\": \"#cba6f733\",\n\
  \    \"sideBar.foreground\": \"#cdd6f4\",\n\
  \    \"sideBarSectionHeader.background\": \"#181825\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#cdd6f4\",\n\
  \    \"sideBarTitle.foreground\": \"#cba6f7\",\n\
  \    \"statusBar.background\": \"#11111b\",\n\
  \    \"statusBar.border\": \"#00000000\",\n\
  \    \"statusBar.debuggingBackground\": \"#fab387\",\n\
  \    \"statusBar.debuggingBorder\": \"#00000000\",\n\
  \    \"statusBar.debuggingForeground\": \"#11111b\",\n\
  \    \"statusBar.foreground\": \"#cdd6f4\",\n\
  \    \"statusBar.noFolderBackground\": \"#11111b\",\n\
  \    \"statusBar.noFolderBorder\": \"#00000000\",\n\
  \    \"statusBar.noFolderForeground\": \"#cdd6f4\",\n\
  \    \"statusBarItem.activeBackground\": \"#585b7066\",\n\
  \    \"statusBarItem.errorBackground\": \"#00000000\",\n\
  \    \"statusBarItem.errorForeground\": \"#f38ba8\",\n\
  \    \"statusBarItem.hoverBackground\": \"#585b7033\",\n\
  \    \"statusBarItem.prominentBackground\": \"#00000000\",\n\
  \    \"statusBarItem.prominentForeground\": \"#cba6f7\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#585b7033\",\n\
  \    \"statusBarItem.remoteBackground\": \"#89b4fa\",\n\
  \    \"statusBarItem.remoteForeground\": \"#11111b\",\n\
  \    \"statusBarItem.warningBackground\": \"#00000000\",\n\
  \    \"statusBarItem.warningForeground\": \"#fab387\",\n\
  \    \"symbolIcon.arrayForeground\": \"#fab387\",\n\
  \    \"symbolIcon.booleanForeground\": \"#cba6f7\",\n\
  \    \"symbolIcon.classForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.colorForeground\": \"#f5c2e7\",\n\
  \    \"symbolIcon.constantForeground\": \"#fab387\",\n\
  \    \"symbolIcon.constructorForeground\": \"#b4befe\",\n\
  \    \"symbolIcon.enumeratorForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.enumeratorMemberForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.eventForeground\": \"#f5c2e7\",\n\
  \    \"symbolIcon.fieldForeground\": \"#cdd6f4\",\n\
  \    \"symbolIcon.fileForeground\": \"#cba6f7\",\n\
  \    \"symbolIcon.folderForeground\": \"#cba6f7\",\n\
  \    \"symbolIcon.functionForeground\": \"#89b4fa\",\n\
  \    \"symbolIcon.interfaceForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.keyForeground\": \"#94e2d5\",\n\
  \    \"symbolIcon.keywordForeground\": \"#cba6f7\",\n\
  \    \"symbolIcon.methodForeground\": \"#89b4fa\",\n\
  \    \"symbolIcon.moduleForeground\": \"#cdd6f4\",\n\
  \    \"symbolIcon.namespaceForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.nullForeground\": \"#eba0ac\",\n\
  \    \"symbolIcon.numberForeground\": \"#fab387\",\n\
  \    \"symbolIcon.objectForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.operatorForeground\": \"#94e2d5\",\n\
  \    \"symbolIcon.packageForeground\": \"#f2cdcd\",\n\
  \    \"symbolIcon.propertyForeground\": \"#eba0ac\",\n\
  \    \"symbolIcon.referenceForeground\": \"#f9e2af\",\n\
  \    \"symbolIcon.snippetForeground\": \"#f2cdcd\",\n\
  \    \"symbolIcon.stringForeground\": \"#a6e3a1\",\n\
  \    \"symbolIcon.structForeground\": \"#94e2d5\",\n\
  \    \"symbolIcon.textForeground\": \"#cdd6f4\",\n\
  \    \"symbolIcon.typeParameterForeground\": \"#eba0ac\",\n\
  \    \"symbolIcon.unitForeground\": \"#cdd6f4\",\n\
  \    \"symbolIcon.variableForeground\": \"#cdd6f4\",\n\
  \    \"tab.activeBackground\": \"#1e1e2e\",\n\
  \    \"tab.activeBorder\": \"#00000000\",\n\
  \    \"tab.activeBorderTop\": \"#cba6f7\",\n\
  \    \"tab.activeForeground\": \"#cba6f7\",\n\
  \    \"tab.activeModifiedBorder\": \"#f9e2af\",\n\
  \    \"tab.border\": \"#181825\",\n\
  \    \"tab.hoverBackground\": \"#28283d\",\n\
  \    \"tab.hoverBorder\": \"#00000000\",\n\
  \    \"tab.hoverForeground\": \"#cba6f7\",\n\
  \    \"tab.inactiveBackground\": \"#181825\",\n\
  \    \"tab.inactiveForeground\": \"#6c7086\",\n\
  \    \"tab.inactiveModifiedBorder\": \"#f9e2af4d\",\n\
  \    \"tab.lastPinnedBorder\": \"#cba6f7\",\n\
  \    \"tab.unfocusedActiveBackground\": \"#181825\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#00000000\",\n\
  \    \"tab.unfocusedActiveBorderTop\": \"#cba6f74d\",\n\
  \    \"tab.unfocusedInactiveBackground\": \"#0e0e16\",\n\
  \    \"table.headerBackground\": \"#313244\",\n\
  \    \"table.headerForeground\": \"#cdd6f4\",\n\
  \    \"terminal.ansiBlack\": \"#45475a\",\n\
  \    \"terminal.ansiBlue\": \"#89b4fa\",\n\
  \    \"terminal.ansiBrightBlack\": \"#585b70\",\n\
  \    \"terminal.ansiBrightBlue\": \"#74a8fc\",\n\
  \    \"terminal.ansiBrightCyan\": \"#6bd7ca\",\n\
  \    \"terminal.ansiBrightGreen\": \"#89d88b\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#f2aede\",\n\
  \    \"terminal.ansiBrightRed\": \"#f37799\",\n\
  \    \"terminal.ansiBrightWhite\": \"#bac2de\",\n\
  \    \"terminal.ansiBrightYellow\": \"#ebd391\",\n\
  \    \"terminal.ansiCyan\": \"#94e2d5\",\n\
  \    \"terminal.ansiGreen\": \"#a6e3a1\",\n\
  \    \"terminal.ansiMagenta\": \"#f5c2e7\",\n\
  \    \"terminal.ansiRed\": \"#f38ba8\",\n\
  \    \"terminal.ansiWhite\": \"#a6adc8\",\n\
  \    \"terminal.ansiYellow\": \"#f9e2af\",\n\
  \    \"terminal.border\": \"#585b70\",\n\
  \    \"terminal.dropBackground\": \"#cba6f733\",\n\
  \    \"terminal.foreground\": \"#cdd6f4\",\n\
  \    \"terminal.inactiveSelectionBackground\": \"#585b7080\",\n\
  \    \"terminal.selectionBackground\": \"#585b70\",\n\
  \    \"terminal.tab.activeBorder\": \"#cba6f7\",\n\
  \    \"terminalCommandDecoration.defaultBackground\": \"#585b70\",\n\
  \    \"terminalCommandDecoration.errorBackground\": \"#f38ba8\",\n\
  \    \"terminalCommandDecoration.successBackground\": \"#a6e3a1\",\n\
  \    \"terminalCursor.background\": \"#1e1e2e\",\n\
  \    \"terminalCursor.foreground\": \"#f5e0dc\",\n\
  \    \"testing.coverCountBadgeBackground\": \"#00000000\",\n\
  \    \"testing.coverCountBadgeForeground\": \"#cba6f7\",\n\
  \    \"testing.coveredBackground\": \"#a6e3a14d\",\n\
  \    \"testing.coveredBorder\": \"#00000000\",\n\
  \    \"testing.coveredGutterBackground\": \"#a6e3a14d\",\n\
  \    \"testing.iconErrored\": \"#f38ba8\",\n\
  \    \"testing.iconErrored.retired\": \"#f38ba8\",\n\
  \    \"testing.iconFailed\": \"#f38ba8\",\n\
  \    \"testing.iconFailed.retired\": \"#f38ba8\",\n\
  \    \"testing.iconPassed\": \"#a6e3a1\",\n\
  \    \"testing.iconPassed.retired\": \"#a6e3a1\",\n\
  \    \"testing.iconQueued\": \"#89b4fa\",\n\
  \    \"testing.iconQueued.retired\": \"#89b4fa\",\n\
  \    \"testing.iconSkipped\": \"#a6adc8\",\n\
  \    \"testing.iconSkipped.retired\": \"#a6adc8\",\n\
  \    \"testing.iconUnset\": \"#cdd6f4\",\n\
  \    \"testing.iconUnset.retired\": \"#cdd6f4\",\n\
  \    \"testing.message.error.lineBackground\": \"#f38ba826\",\n\
  \    \"testing.message.info.decorationForeground\": \"#a6e3a1cc\",\n\
  \    \"testing.message.info.lineBackground\": \"#a6e3a126\",\n\
  \    \"testing.messagePeekBorder\": \"#cba6f7\",\n\
  \    \"testing.messagePeekHeaderBackground\": \"#585b70\",\n\
  \    \"testing.peekBorder\": \"#cba6f7\",\n\
  \    \"testing.peekHeaderBackground\": \"#585b70\",\n\
  \    \"testing.runAction\": \"#cba6f7\",\n\
  \    \"testing.uncoveredBackground\": \"#f38ba833\",\n\
  \    \"testing.uncoveredBorder\": \"#00000000\",\n\
  \    \"testing.uncoveredBranchBackground\": \"#f38ba833\",\n\
  \    \"testing.uncoveredGutterBackground\": \"#f38ba840\",\n\
  \    \"textBlockQuote.background\": \"#181825\",\n\
  \    \"textBlockQuote.border\": \"#11111b\",\n\
  \    \"textCodeBlock.background\": \"#181825\",\n\
  \    \"textLink.activeForeground\": \"#89dceb\",\n\
  \    \"textLink.foreground\": \"#89b4fa\",\n\
  \    \"textPreformat.foreground\": \"#cdd6f4\",\n\
  \    \"textSeparator.foreground\": \"#cba6f7\",\n\
  \    \"titleBar.activeBackground\": \"#11111b\",\n\
  \    \"titleBar.activeForeground\": \"#cdd6f4\",\n\
  \    \"titleBar.border\": \"#00000000\",\n\
  \    \"titleBar.inactiveBackground\": \"#11111b\",\n\
  \    \"titleBar.inactiveForeground\": \"#cdd6f480\",\n\
  \    \"tree.inactiveIndentGuidesStroke\": \"#45475a\",\n\
  \    \"tree.indentGuidesStroke\": \"#9399b2\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#1e1e2e4d\",\n\
  \    \"welcomePage.progress.background\": \"#11111b\",\n\
  \    \"welcomePage.progress.foreground\": \"#cba6f7\",\n\
  \    \"welcomePage.tileBackground\": \"#181825\",\n\
  \    \"widget.shadow\": \"#18182580\"\n\
  \  },\n\
  \  \"displayName\": \"Catppuccin Mocha\",\n\
  \  \"name\": \"catppuccin-mocha\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"boolean\": {\n\
  \      \"foreground\": \"#fab387\"\n\
  \    },\n\
  \    \"builtinAttribute.attribute.library:rust\": {\n\
  \      \"foreground\": \"#89b4fa\"\n\
  \    },\n\
  \    \"class.builtin:python\": {\n\
  \      \"foreground\": \"#cba6f7\"\n\
  \    },\n\
  \    \"class:python\": {\n\
  \      \"foreground\": \"#f9e2af\"\n\
  \    },\n\
  \    \"constant.builtin.readonly:nix\": {\n\
  \      \"foreground\": \"#cba6f7\"\n\
  \    },\n\
  \    \"enumMember\": {\n\
  \      \"foreground\": \"#94e2d5\"\n\
  \    },\n\
  \    \"function.decorator:python\": {\n\
  \      \"foreground\": \"#fab387\"\n\
  \    },\n\
  \    \"generic.attribute:rust\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"heading\": {\n\
  \      \"foreground\": \"#f38ba8\"\n\
  \    },\n\
  \    \"number\": {\n\
  \      \"foreground\": \"#fab387\"\n\
  \    },\n\
  \    \"pol\": {\n\
  \      \"foreground\": \"#f2cdcd\"\n\
  \    },\n\
  \    \"property.readonly:javascript\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"property.readonly:javascriptreact\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"property.readonly:typescript\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"property.readonly:typescriptreact\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"selfKeyword\": {\n\
  \      \"foreground\": \"#f38ba8\"\n\
  \    },\n\
  \    \"text.emph\": {\n\
  \      \"fontStyle\": \"italic\",\n\
  \      \"foreground\": \"#f38ba8\"\n\
  \    },\n\
  \    \"text.math\": {\n\
  \      \"foreground\": \"#f2cdcd\"\n\
  \    },\n\
  \    \"text.strong\": {\n\
  \      \"fontStyle\": \"bold\",\n\
  \      \"foreground\": \"#f38ba8\"\n\
  \    },\n\
  \    \"tomlArrayKey\": {\n\
  \      \"fontStyle\": \"\",\n\
  \      \"foreground\": \"#89b4fa\"\n\
  \    },\n\
  \    \"tomlTableKey\": {\n\
  \      \"fontStyle\": \"\",\n\
  \      \"foreground\": \"#89b4fa\"\n\
  \    },\n\
  \    \"type.defaultLibrary:go\": {\n\
  \      \"foreground\": \"#cba6f7\"\n\
  \    },\n\
  \    \"variable.defaultLibrary\": {\n\
  \      \"foreground\": \"#eba0ac\"\n\
  \    },\n\
  \    \"variable.readonly.defaultLibrary:go\": {\n\
  \      \"foreground\": \"#cba6f7\"\n\
  \    },\n\
  \    \"variable.readonly:javascript\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"variable.readonly:javascriptreact\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"variable.readonly:scala\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"variable.readonly:typescript\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"variable.readonly:typescriptreact\": {\n\
  \      \"foreground\": \"#cdd6f4\"\n\
  \    },\n\
  \    \"variable.typeHint:python\": {\n\
  \      \"foreground\": \"#f9e2af\"\n\
  \    }\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text\",\n\
  \        \"source\",\n\
  \        \"variable.other.readwrite\",\n\
  \        \"punctuation.definition.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#9399b2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"punctuation.definition.comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#9399b2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"punctuation.definition.string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\",\n\
  \        \"variable.other.constant\",\n\
  \        \"entity.name.constant\",\n\
  \        \"constant.language.boolean\",\n\
  \        \"constant.language.false\",\n\
  \        \"constant.language.true\",\n\
  \        \"keyword.other.unit.user-defined\",\n\
  \        \"keyword.other.unit.suffix.floating-point\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword\",\n\
  \        \"keyword.operator.word\",\n\
  \        \"keyword.operator.new\",\n\
  \        \"variable.language.super\",\n\
  \        \"support.type.primitive\",\n\
  \        \"storage.type\",\n\
  \        \"storage.modifier\",\n\
  \        \"punctuation.definition.keyword\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.documentation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator\",\n\
  \        \"punctuation.accessor\",\n\
  \        \"punctuation.definition.generic\",\n\
  \        \"meta.function.closure punctuation.section.parameters\",\n\
  \        \"punctuation.definition.tag\",\n\
  \        \"punctuation.separator.key-value\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"meta.function-call.method\",\n\
  \        \"support.function\",\n\
  \        \"support.function.misc\",\n\
  \        \"variable.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.class\",\n\
  \        \"entity.other.inherited-class\",\n\
  \        \"support.class\",\n\
  \        \"meta.function-call.constructor\",\n\
  \        \"entity.name.struct\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.enum\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.enum variable.other.readwrite\",\n\
  \        \"variable.other.enummember\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.property.object\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.type\",\n\
  \        \"meta.type-alias\",\n\
  \        \"support.type\",\n\
  \        \"entity.name.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.annotation variable.function\",\n\
  \        \"meta.annotation variable.annotation.function\",\n\
  \        \"meta.annotation punctuation.definition.annotation\",\n\
  \        \"meta.decorator\",\n\
  \        \"punctuation.decorator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter\",\n\
  \        \"meta.function.parameters\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language\",\n\
  \        \"support.function.builtin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.documentation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.directive\",\n\
  \        \"punctuation.definition.directive\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.typeparameters\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.namespace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name.css\",\n\
  \        \"support.type.property-name.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.language.this\",\n\
  \        \"variable.language.this punctuation.definition.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.object.property\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.template variable\",\n\
  \        \"string variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.new\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.specifier.extern.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.scope-resolution.template.call.cpp\",\n\
  \        \"entity.name.scope-resolution.parameter.cpp\",\n\
  \        \"entity.name.scope-resolution.cpp\",\n\
  \        \"entity.name.scope-resolution.function.definition.cpp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.class.doxygen\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.reference.cpp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.interpolation.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.block.documentation.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css entity.other.attribute-name.class.css\",\n\
  \        \"entity.other.attribute-name.parent-selector.css \
   punctuation.definition.entity.css\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.operator.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css constant.other.unicode-range\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css variable.parameter.url\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.vendored.property-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css meta.property-value variable\",\n\
  \        \"source.css meta.property-value variable.other.less\",\n\
  \        \"source.css meta.property-value variable.other.less \
   punctuation.definition.variable.less\",\n\
  \        \"meta.definition.variable.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css meta.property-list variable\",\n\
  \        \"meta.property-list variable.other.less\",\n\
  \        \"meta.property-list variable.other.less \
   punctuation.definition.variable.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit.percentage.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css meta.attribute-selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.definition.ini\",\n\
  \        \"punctuation.support.type.property-name.json\",\n\
  \        \"support.type.property-name.json\",\n\
  \        \"punctuation.support.type.property-name.toml\",\n\
  \        \"support.type.property-name.toml\",\n\
  \        \"entity.name.tag.yaml\",\n\
  \        \"punctuation.support.type.property-name.yaml\",\n\
  \        \"support.type.property-name.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.json\",\n\
  \        \"constant.language.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.type.anchor.yaml\",\n\
  \        \"variable.other.alias.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name.table\",\n\
  \        \"entity.name.section.group-title.ini\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.time.datetime.offset.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.anchor.yaml\",\n\
  \        \"punctuation.definition.alias.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.document.begin.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.diff.header.from-file\",\n\
  \        \"meta.diff.header.to-file\",\n\
  \        \"punctuation.definition.from-file.diff\",\n\
  \        \"punctuation.definition.to-file.diff\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.env\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.quoted variable.other.env\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.builtin.gdscript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.gdscript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment meta.annotation.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment meta.annotation.parameters.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.alias.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f2cdcd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.enum.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.objectvalues.graphql constant.object.key.graphql \
   string.unquoted.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f2cdcd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.doctype\",\n\
  \        \"meta.tag.sgml.doctype punctuation.definition.tag\",\n\
  \        \"meta.tag.metadata.doctype entity.name.tag\",\n\
  \        \"meta.tag.metadata.doctype punctuation.definition.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html constant.character.entity\",\n\
  \        \"text.html constant.character.entity punctuation\",\n\
  \        \"constant.character.entity.xml\",\n\
  \        \"constant.character.entity.xml punctuation\",\n\
  \        \"constant.character.entity.js.jsx\",\n\
  \        \"constant.charactger.entity.js.jsx punctuation\",\n\
  \        \"constant.character.entity.tsx\",\n\
  \        \"constant.character.entity.tsx punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.component\",\n\
  \        \"support.class.component.jsx\",\n\
  \        \"support.class.component.tsx\",\n\
  \        \"support.class.component.vue\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.annotation\",\n\
  \        \"storage.type.annotation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.enum.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.import.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.block.javadoc.java \
   keyword.other.documentation.javadoc.java\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.export variable.other.readwrite.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant.js\",\n\
  \        \"variable.other.constant.ts\",\n\
  \        \"variable.other.property.js\",\n\
  \        \"variable.other.property.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.jsdoc\",\n\
  \        \"comment.block.documentation variable.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.class.jsdoc\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.object.console.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.node\",\n\
  \        \"support.type.object.module.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.implements\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.null.js\",\n\
  \        \"constant.language.null.ts\",\n\
  \        \"constant.language.undefined.js\",\n\
  \        \"constant.language.undefined.ts\",\n\
  \        \"support.type.builtin.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.generic\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.declaration.function.arrow.js\",\n\
  \        \"storage.type.function.arrow.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.decorator.ts\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.expression.in.js\",\n\
  \        \"keyword.operator.expression.in.ts\",\n\
  \        \"keyword.operator.expression.infer.ts\",\n\
  \        \"keyword.operator.expression.instanceof.js\",\n\
  \        \"keyword.operator.expression.instanceof.ts\",\n\
  \        \"keyword.operator.expression.is\",\n\
  \        \"keyword.operator.expression.keyof.ts\",\n\
  \        \"keyword.operator.expression.of.js\",\n\
  \        \"keyword.operator.expression.of.ts\",\n\
  \        \"keyword.operator.expression.typeof.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.macro.julia\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.symbol.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.tex keyword.control.preamble\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.tex support.function.be\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.general.math.tex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f2cdcd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.liquid\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.line.double-dash.documentation.lua \
   storage.type.annotation.lua\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment.line.double-dash.documentation.lua \
   entity.name.variable.lua\",\n\
  \        \"comment.line.double-dash.documentation.lua variable.lua\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.1.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.1.markdown\",\n\
  \        \"heading.1.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.1.quarto\",\n\
  \        \"markup.heading.atx.1.mdx\",\n\
  \        \"markup.heading.atx.1.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.setext.1.markdown\",\n\
  \        \"markup.heading.heading-0.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.2.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.2.markdown\",\n\
  \        \"heading.2.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.2.quarto\",\n\
  \        \"markup.heading.atx.2.mdx\",\n\
  \        \"markup.heading.atx.2.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.setext.2.markdown\",\n\
  \        \"markup.heading.heading-1.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.3.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.3.markdown\",\n\
  \        \"heading.3.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.3.quarto\",\n\
  \        \"markup.heading.atx.3.mdx\",\n\
  \        \"markup.heading.atx.3.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-2.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.4.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.4.markdown\",\n\
  \        \"heading.4.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.4.quarto\",\n\
  \        \"markup.heading.atx.4.mdx\",\n\
  \        \"markup.heading.atx.4.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-3.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.5.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.5.markdown\",\n\
  \        \"heading.5.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.5.quarto\",\n\
  \        \"markup.heading.atx.5.mdx\",\n\
  \        \"markup.heading.atx.5.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-4.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#74c7ec\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.6.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.6.markdown\",\n\
  \        \"heading.6.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.6.quarto\",\n\
  \        \"markup.heading.atx.6.mdx\",\n\
  \        \"markup.heading.atx.6.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-5.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b4befe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.strikethrough\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"strikethrough\",\n\
  \        \"foreground\": \"#a6adc8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.link\",\n\
  \        \"markup.underline.link\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown punctuation.definition.link.title\",\n\
  \        \"text.html.quarto punctuation.definition.link.title\",\n\
  \        \"string.other.link.title.markdown\",\n\
  \        \"string.other.link.title.quarto\",\n\
  \        \"markup.link\",\n\
  \        \"punctuation.definition.constant.markdown\",\n\
  \        \"punctuation.definition.constant.quarto\",\n\
  \        \"constant.other.reference.link.markdown\",\n\
  \        \"constant.other.reference.link.quarto\",\n\
  \        \"markup.substitution.attribute-reference\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b4befe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.raw.markdown\",\n\
  \        \"punctuation.definition.raw.quarto\",\n\
  \        \"markup.inline.raw.string.markdown\",\n\
  \        \"markup.inline.raw.string.quarto\",\n\
  \        \"markup.raw.block.markdown\",\n\
  \        \"markup.raw.block.quarto\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"fenced_code.block.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.fenced_code.block punctuation.definition\",\n\
  \        \"markup.raw support.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9399b2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.quote\",\n\
  \        \"punctuation.definition.quote.begin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.separator.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.list.begin.markdown\",\n\
  \        \"punctuation.definition.list.begin.quarto\",\n\
  \        \"markup.list.bullet\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading.quarto\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.multipart.nix\",\n\
  \        \"entity.other.attribute-name.single.nix\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.name.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.embedded variable.parameter.name.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#b4befe\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.path.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.attribute.builtin\",\n\
  \        \"meta.attribute.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.parameters.php \
   punctuation.definition.variable.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.php support.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.phpdoc.php\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.variable.magic.python\",\n\
  \        \"meta.function-call.arguments.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.function.magic.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter.function.language.special.self.python\",\n\
  \        \"variable.language.special.self.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.flow.python\",\n\
  \        \"keyword.operator.logical.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.token.decorator.python\",\n\
  \        \"meta.function.decorator.identifier.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function-call.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.decorator.python\",\n\
  \        \"punctuation.definition.decorator.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.exception.python\",\n\
  \        \"support.function.builtin.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.indexed-name.python\",\n\
  \        \"meta.item-access.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.string.python\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.parameters.python\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.arguments.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.regexp punctuation.definition.string.begin\",\n\
  \        \"string.regexp punctuation.definition.string.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.anchor.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.regexp\",\n\
  \        \"keyword.other.back-reference.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6e3a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.character-class.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.character-class.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.character-class.range.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5e0dc\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.numeric.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.no-capture.regexp\",\n\
  \        \"meta.assertion.look-ahead.regexp\",\n\
  \        \"meta.assertion.negative-look-ahead.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.annotation.rust\",\n\
  \        \"meta.annotation.rust punctuation\",\n\
  \        \"meta.attribute.rust\",\n\
  \        \"punctuation.definition.attribute.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.attribute.rust string.quoted.double.rust\",\n\
  \        \"meta.attribute.rust string.quoted.single.char.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.macro.rules.rust\",\n\
  \        \"storage.type.module.rust\",\n\
  \        \"storage.modifier.rust\",\n\
  \        \"storage.type.struct.rust\",\n\
  \        \"storage.type.enum.rust\",\n\
  \        \"storage.type.trait.rust\",\n\
  \        \"storage.type.union.rust\",\n\
  \        \"storage.type.impl.rust\",\n\
  \        \"storage.type.rust\",\n\
  \        \"storage.type.function.rust\",\n\
  \        \"storage.type.type.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.numeric.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.generic.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.impl.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.module.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.trait.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.source.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.union.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f9e2af\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.enum.rust storage.type.source.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.macro.rust\",\n\
  \        \"meta.macro.rust support.function.rust\",\n\
  \        \"entity.name.function.macro.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.lifetime.rust\",\n\
  \        \"entity.name.type.lifetime\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.rust \
   constant.other.placeholder.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.return-type.rust meta.generic.rust \
   storage.type.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.call.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89b4fa\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.brackets.angle.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#89dceb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.caps.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function.definition.rust variable.other.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eba0ac\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.call.rust variable.other.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.self.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.metavariable.name.rust\",\n\
  \        \"meta.macro.metavariable.rust keyword.operator.macro.dollar.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment.line.shebang\",\n\
  \        \"comment.line.shebang punctuation.definition.comment\",\n\
  \        \"comment.line.shebang\",\n\
  \        \"punctuation.definition.comment.shebang.shell\",\n\
  \        \"meta.shebang.shell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f5c2e7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.line.shebang constant.language\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.string meta.interpolation.parameter.shell \
   variable.other.readwrite\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#fab387\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.shell punctuation.section.interpolation\",\n\
  \        \"punctuation.definition.evaluation.backticks.shell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#94e2d5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.heredoc.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cba6f7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.shell variable.other.normal.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cdd6f4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.heading.typst\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f38ba8\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let catppuccin_macchiato =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.activeBackground\": \"#00000000\",\n\
  \    \"activityBar.activeBorder\": \"#00000000\",\n\
  \    \"activityBar.activeFocusBorder\": \"#00000000\",\n\
  \    \"activityBar.background\": \"#181926\",\n\
  \    \"activityBar.border\": \"#00000000\",\n\
  \    \"activityBar.dropBorder\": \"#c6a0f633\",\n\
  \    \"activityBar.foreground\": \"#c6a0f6\",\n\
  \    \"activityBar.inactiveForeground\": \"#6e738d\",\n\
  \    \"activityBarBadge.background\": \"#c6a0f6\",\n\
  \    \"activityBarBadge.foreground\": \"#181926\",\n\
  \    \"activityBarTop.activeBorder\": \"#00000000\",\n\
  \    \"activityBarTop.dropBorder\": \"#c6a0f633\",\n\
  \    \"activityBarTop.foreground\": \"#c6a0f6\",\n\
  \    \"activityBarTop.inactiveForeground\": \"#6e738d\",\n\
  \    \"badge.background\": \"#494d64\",\n\
  \    \"badge.foreground\": \"#cad3f5\",\n\
  \    \"banner.background\": \"#494d64\",\n\
  \    \"banner.foreground\": \"#cad3f5\",\n\
  \    \"banner.iconForeground\": \"#cad3f5\",\n\
  \    \"breadcrumb.activeSelectionForeground\": \"#c6a0f6\",\n\
  \    \"breadcrumb.background\": \"#24273a\",\n\
  \    \"breadcrumb.focusForeground\": \"#c6a0f6\",\n\
  \    \"breadcrumb.foreground\": \"#cad3f5cc\",\n\
  \    \"breadcrumbPicker.background\": \"#1e2030\",\n\
  \    \"button.background\": \"#c6a0f6\",\n\
  \    \"button.border\": \"#00000000\",\n\
  \    \"button.foreground\": \"#181926\",\n\
  \    \"button.hoverBackground\": \"#dac1f9\",\n\
  \    \"button.secondaryBackground\": \"#5b6078\",\n\
  \    \"button.secondaryBorder\": \"#c6a0f6\",\n\
  \    \"button.secondaryForeground\": \"#cad3f5\",\n\
  \    \"button.secondaryHoverBackground\": \"#6a708c\",\n\
  \    \"button.separator\": \"#00000000\",\n\
  \    \"charts.blue\": \"#8aadf4\",\n\
  \    \"charts.foreground\": \"#cad3f5\",\n\
  \    \"charts.green\": \"#a6da95\",\n\
  \    \"charts.lines\": \"#b8c0e0\",\n\
  \    \"charts.orange\": \"#f5a97f\",\n\
  \    \"charts.purple\": \"#c6a0f6\",\n\
  \    \"charts.red\": \"#ed8796\",\n\
  \    \"charts.yellow\": \"#eed49f\",\n\
  \    \"checkbox.background\": \"#494d64\",\n\
  \    \"checkbox.border\": \"#00000000\",\n\
  \    \"checkbox.foreground\": \"#c6a0f6\",\n\
  \    \"commandCenter.activeBackground\": \"#5b607833\",\n\
  \    \"commandCenter.activeBorder\": \"#c6a0f6\",\n\
  \    \"commandCenter.activeForeground\": \"#c6a0f6\",\n\
  \    \"commandCenter.background\": \"#1e2030\",\n\
  \    \"commandCenter.border\": \"#00000000\",\n\
  \    \"commandCenter.foreground\": \"#b8c0e0\",\n\
  \    \"commandCenter.inactiveBorder\": \"#00000000\",\n\
  \    \"commandCenter.inactiveForeground\": \"#b8c0e0\",\n\
  \    \"debugConsole.errorForeground\": \"#ed8796\",\n\
  \    \"debugConsole.infoForeground\": \"#8aadf4\",\n\
  \    \"debugConsole.sourceForeground\": \"#f4dbd6\",\n\
  \    \"debugConsole.warningForeground\": \"#f5a97f\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#cad3f5\",\n\
  \    \"debugExceptionWidget.background\": \"#181926\",\n\
  \    \"debugExceptionWidget.border\": \"#c6a0f6\",\n\
  \    \"debugIcon.breakpointCurrentStackframeForeground\": \"#5b6078\",\n\
  \    \"debugIcon.breakpointDisabledForeground\": \"#ed879699\",\n\
  \    \"debugIcon.breakpointForeground\": \"#ed8796\",\n\
  \    \"debugIcon.breakpointStackframeForeground\": \"#5b6078\",\n\
  \    \"debugIcon.breakpointUnverifiedForeground\": \"#a47487\",\n\
  \    \"debugIcon.continueForeground\": \"#a6da95\",\n\
  \    \"debugIcon.disconnectForeground\": \"#5b6078\",\n\
  \    \"debugIcon.pauseForeground\": \"#8aadf4\",\n\
  \    \"debugIcon.restartForeground\": \"#8bd5ca\",\n\
  \    \"debugIcon.startForeground\": \"#a6da95\",\n\
  \    \"debugIcon.stepBackForeground\": \"#5b6078\",\n\
  \    \"debugIcon.stepIntoForeground\": \"#cad3f5\",\n\
  \    \"debugIcon.stepOutForeground\": \"#cad3f5\",\n\
  \    \"debugIcon.stepOverForeground\": \"#c6a0f6\",\n\
  \    \"debugIcon.stopForeground\": \"#ed8796\",\n\
  \    \"debugTokenExpression.boolean\": \"#c6a0f6\",\n\
  \    \"debugTokenExpression.error\": \"#ed8796\",\n\
  \    \"debugTokenExpression.number\": \"#f5a97f\",\n\
  \    \"debugTokenExpression.string\": \"#a6da95\",\n\
  \    \"debugToolBar.background\": \"#181926\",\n\
  \    \"debugToolBar.border\": \"#00000000\",\n\
  \    \"descriptionForeground\": \"#cad3f5\",\n\
  \    \"diffEditor.border\": \"#5b6078\",\n\
  \    \"diffEditor.diagonalFill\": \"#5b607899\",\n\
  \    \"diffEditor.insertedLineBackground\": \"#a6da9526\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#a6da9533\",\n\
  \    \"diffEditor.removedLineBackground\": \"#ed879626\",\n\
  \    \"diffEditor.removedTextBackground\": \"#ed879633\",\n\
  \    \"diffEditorOverview.insertedForeground\": \"#a6da95cc\",\n\
  \    \"diffEditorOverview.removedForeground\": \"#ed8796cc\",\n\
  \    \"disabledForeground\": \"#a5adcb\",\n\
  \    \"dropdown.background\": \"#1e2030\",\n\
  \    \"dropdown.border\": \"#c6a0f6\",\n\
  \    \"dropdown.foreground\": \"#cad3f5\",\n\
  \    \"dropdown.listBackground\": \"#5b6078\",\n\
  \    \"editor.background\": \"#24273a\",\n\
  \    \"editor.findMatchBackground\": \"#604456\",\n\
  \    \"editor.findMatchBorder\": \"#ed879633\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#455c6d\",\n\
  \    \"editor.findMatchHighlightBorder\": \"#91d7e333\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#455c6d\",\n\
  \    \"editor.findRangeHighlightBorder\": \"#91d7e333\",\n\
  \    \"editor.focusedStackFrameHighlightBackground\": \"#a6da9526\",\n\
  \    \"editor.foldBackground\": \"#91d7e340\",\n\
  \    \"editor.foreground\": \"#cad3f5\",\n\
  \    \"editor.hoverHighlightBackground\": \"#91d7e340\",\n\
  \    \"editor.lineHighlightBackground\": \"#cad3f512\",\n\
  \    \"editor.lineHighlightBorder\": \"#00000000\",\n\
  \    \"editor.rangeHighlightBackground\": \"#91d7e340\",\n\
  \    \"editor.rangeHighlightBorder\": \"#00000000\",\n\
  \    \"editor.selectionBackground\": \"#939ab740\",\n\
  \    \"editor.selectionHighlightBackground\": \"#939ab733\",\n\
  \    \"editor.selectionHighlightBorder\": \"#939ab733\",\n\
  \    \"editor.stackFrameHighlightBackground\": \"#eed49f26\",\n\
  \    \"editor.wordHighlightBackground\": \"#939ab733\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#8aadf433\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#ed8796\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#f5a97f\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#eed49f\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#a6da95\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#7dc4e4\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#c6a0f6\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#ee99a0\",\n\
  \    \"editorBracketMatch.background\": \"#939ab71a\",\n\
  \    \"editorBracketMatch.border\": \"#939ab7\",\n\
  \    \"editorCodeLens.foreground\": \"#8087a2\",\n\
  \    \"editorCursor.background\": \"#24273a\",\n\
  \    \"editorCursor.foreground\": \"#f4dbd6\",\n\
  \    \"editorError.background\": \"#00000000\",\n\
  \    \"editorError.border\": \"#00000000\",\n\
  \    \"editorError.foreground\": \"#ed8796\",\n\
  \    \"editorGroup.border\": \"#5b6078\",\n\
  \    \"editorGroup.dropBackground\": \"#c6a0f633\",\n\
  \    \"editorGroup.emptyBackground\": \"#24273a\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#181926\",\n\
  \    \"editorGutter.addedBackground\": \"#a6da95\",\n\
  \    \"editorGutter.background\": \"#24273a\",\n\
  \    \"editorGutter.commentGlyphForeground\": \"#c6a0f6\",\n\
  \    \"editorGutter.commentRangeForeground\": \"#363a4f\",\n\
  \    \"editorGutter.deletedBackground\": \"#ed8796\",\n\
  \    \"editorGutter.foldingControlForeground\": \"#939ab7\",\n\
  \    \"editorGutter.modifiedBackground\": \"#eed49f\",\n\
  \    \"editorHoverWidget.background\": \"#1e2030\",\n\
  \    \"editorHoverWidget.border\": \"#5b6078\",\n\
  \    \"editorHoverWidget.foreground\": \"#cad3f5\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#5b6078\",\n\
  \    \"editorIndentGuide.background\": \"#494d64\",\n\
  \    \"editorInfo.background\": \"#00000000\",\n\
  \    \"editorInfo.border\": \"#00000000\",\n\
  \    \"editorInfo.foreground\": \"#8aadf4\",\n\
  \    \"editorInlayHint.background\": \"#1e2030bf\",\n\
  \    \"editorInlayHint.foreground\": \"#5b6078\",\n\
  \    \"editorInlayHint.parameterBackground\": \"#1e2030bf\",\n\
  \    \"editorInlayHint.parameterForeground\": \"#a5adcb\",\n\
  \    \"editorInlayHint.typeBackground\": \"#1e2030bf\",\n\
  \    \"editorInlayHint.typeForeground\": \"#b8c0e0\",\n\
  \    \"editorLightBulb.foreground\": \"#eed49f\",\n\
  \    \"editorLineNumber.activeForeground\": \"#c6a0f6\",\n\
  \    \"editorLineNumber.foreground\": \"#8087a2\",\n\
  \    \"editorLink.activeForeground\": \"#c6a0f6\",\n\
  \    \"editorMarkerNavigation.background\": \"#1e2030\",\n\
  \    \"editorMarkerNavigationError.background\": \"#ed8796\",\n\
  \    \"editorMarkerNavigationInfo.background\": \"#8aadf4\",\n\
  \    \"editorMarkerNavigationWarning.background\": \"#f5a97f\",\n\
  \    \"editorOverviewRuler.background\": \"#1e2030\",\n\
  \    \"editorOverviewRuler.border\": \"#cad3f512\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#eed49f\",\n\
  \    \"editorRuler.foreground\": \"#5b6078\",\n\
  \    \"editorStickyScrollHover.background\": \"#363a4f\",\n\
  \    \"editorSuggestWidget.background\": \"#1e2030\",\n\
  \    \"editorSuggestWidget.border\": \"#5b6078\",\n\
  \    \"editorSuggestWidget.foreground\": \"#cad3f5\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#c6a0f6\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#363a4f\",\n\
  \    \"editorWarning.background\": \"#00000000\",\n\
  \    \"editorWarning.border\": \"#00000000\",\n\
  \    \"editorWarning.foreground\": \"#f5a97f\",\n\
  \    \"editorWhitespace.foreground\": \"#939ab766\",\n\
  \    \"editorWidget.background\": \"#1e2030\",\n\
  \    \"editorWidget.foreground\": \"#cad3f5\",\n\
  \    \"editorWidget.resizeBorder\": \"#5b6078\",\n\
  \    \"errorForeground\": \"#ed8796\",\n\
  \    \"errorLens.errorBackground\": \"#ed879626\",\n\
  \    \"errorLens.errorBackgroundLight\": \"#ed879626\",\n\
  \    \"errorLens.errorForeground\": \"#ed8796\",\n\
  \    \"errorLens.errorForegroundLight\": \"#ed8796\",\n\
  \    \"errorLens.errorMessageBackground\": \"#ed879626\",\n\
  \    \"errorLens.hintBackground\": \"#a6da9526\",\n\
  \    \"errorLens.hintBackgroundLight\": \"#a6da9526\",\n\
  \    \"errorLens.hintForeground\": \"#a6da95\",\n\
  \    \"errorLens.hintForegroundLight\": \"#a6da95\",\n\
  \    \"errorLens.hintMessageBackground\": \"#a6da9526\",\n\
  \    \"errorLens.infoBackground\": \"#8aadf426\",\n\
  \    \"errorLens.infoBackgroundLight\": \"#8aadf426\",\n\
  \    \"errorLens.infoForeground\": \"#8aadf4\",\n\
  \    \"errorLens.infoForegroundLight\": \"#8aadf4\",\n\
  \    \"errorLens.infoMessageBackground\": \"#8aadf426\",\n\
  \    \"errorLens.statusBarErrorForeground\": \"#ed8796\",\n\
  \    \"errorLens.statusBarHintForeground\": \"#a6da95\",\n\
  \    \"errorLens.statusBarIconErrorForeground\": \"#ed8796\",\n\
  \    \"errorLens.statusBarIconWarningForeground\": \"#f5a97f\",\n\
  \    \"errorLens.statusBarInfoForeground\": \"#8aadf4\",\n\
  \    \"errorLens.statusBarWarningForeground\": \"#f5a97f\",\n\
  \    \"errorLens.warningBackground\": \"#f5a97f26\",\n\
  \    \"errorLens.warningBackgroundLight\": \"#f5a97f26\",\n\
  \    \"errorLens.warningForeground\": \"#f5a97f\",\n\
  \    \"errorLens.warningForegroundLight\": \"#f5a97f\",\n\
  \    \"errorLens.warningMessageBackground\": \"#f5a97f26\",\n\
  \    \"extensionBadge.remoteBackground\": \"#8aadf4\",\n\
  \    \"extensionBadge.remoteForeground\": \"#181926\",\n\
  \    \"extensionButton.prominentBackground\": \"#c6a0f6\",\n\
  \    \"extensionButton.prominentForeground\": \"#181926\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#dac1f9\",\n\
  \    \"extensionButton.separator\": \"#24273a\",\n\
  \    \"extensionIcon.preReleaseForeground\": \"#5b6078\",\n\
  \    \"extensionIcon.sponsorForeground\": \"#f5bde6\",\n\
  \    \"extensionIcon.starForeground\": \"#eed49f\",\n\
  \    \"extensionIcon.verifiedForeground\": \"#a6da95\",\n\
  \    \"focusBorder\": \"#c6a0f6\",\n\
  \    \"foreground\": \"#cad3f5\",\n\
  \    \"gitDecoration.addedResourceForeground\": \"#a6da95\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#c6a0f6\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#ed8796\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#6e738d\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#eed49f\",\n\
  \    \"gitDecoration.stageDeletedResourceForeground\": \"#ed8796\",\n\
  \    \"gitDecoration.stageModifiedResourceForeground\": \"#eed49f\",\n\
  \    \"gitDecoration.submoduleResourceForeground\": \"#8aadf4\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#a6da95\",\n\
  \    \"gitlens.closedAutolinkedIssueIconColor\": \"#c6a0f6\",\n\
  \    \"gitlens.closedPullRequestIconColor\": \"#ed8796\",\n\
  \    \"gitlens.decorations.branchAheadForegroundColor\": \"#a6da95\",\n\
  \    \"gitlens.decorations.branchBehindForegroundColor\": \"#f5a97f\",\n\
  \    \"gitlens.decorations.branchDivergedForegroundColor\": \"#eed49f\",\n\
  \    \"gitlens.decorations.branchMissingUpstreamForegroundColor\": \
   \"#f5a97f\",\n\
  \    \"gitlens.decorations.branchUnpublishedForegroundColor\": \"#a6da95\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingConflictForegroundColor\": \
   \"#ee99a0\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingForegroundColor\": \
   \"#eed49f\",\n\
  \    \"gitlens.decorations.workspaceCurrentForegroundColor\": \"#c6a0f6\",\n\
  \    \"gitlens.decorations.workspaceRepoMissingForegroundColor\": \"#a5adcb\",\n\
  \    \"gitlens.decorations.workspaceRepoOpenForegroundColor\": \"#c6a0f6\",\n\
  \    \"gitlens.decorations.worktreeHasUncommittedChangesForegroundColor\": \
   \"#f5a97f\",\n\
  \    \"gitlens.decorations.worktreeMissingForegroundColor\": \"#ee99a0\",\n\
  \    \"gitlens.graphChangesColumnAddedColor\": \"#a6da95\",\n\
  \    \"gitlens.graphChangesColumnDeletedColor\": \"#ed8796\",\n\
  \    \"gitlens.graphLane10Color\": \"#f5bde6\",\n\
  \    \"gitlens.graphLane1Color\": \"#c6a0f6\",\n\
  \    \"gitlens.graphLane2Color\": \"#eed49f\",\n\
  \    \"gitlens.graphLane3Color\": \"#8aadf4\",\n\
  \    \"gitlens.graphLane4Color\": \"#f0c6c6\",\n\
  \    \"gitlens.graphLane5Color\": \"#a6da95\",\n\
  \    \"gitlens.graphLane6Color\": \"#b7bdf8\",\n\
  \    \"gitlens.graphLane7Color\": \"#f4dbd6\",\n\
  \    \"gitlens.graphLane8Color\": \"#ed8796\",\n\
  \    \"gitlens.graphLane9Color\": \"#8bd5ca\",\n\
  \    \"gitlens.graphMinimapMarkerHeadColor\": \"#a6da95\",\n\
  \    \"gitlens.graphMinimapMarkerHighlightsColor\": \"#eed49f\",\n\
  \    \"gitlens.graphMinimapMarkerLocalBranchesColor\": \"#8aadf4\",\n\
  \    \"gitlens.graphMinimapMarkerRemoteBranchesColor\": \"#739df2\",\n\
  \    \"gitlens.graphMinimapMarkerStashesColor\": \"#c6a0f6\",\n\
  \    \"gitlens.graphMinimapMarkerTagsColor\": \"#f0c6c6\",\n\
  \    \"gitlens.graphMinimapMarkerUpstreamColor\": \"#96d382\",\n\
  \    \"gitlens.graphScrollMarkerHeadColor\": \"#a6da95\",\n\
  \    \"gitlens.graphScrollMarkerHighlightsColor\": \"#eed49f\",\n\
  \    \"gitlens.graphScrollMarkerLocalBranchesColor\": \"#8aadf4\",\n\
  \    \"gitlens.graphScrollMarkerRemoteBranchesColor\": \"#739df2\",\n\
  \    \"gitlens.graphScrollMarkerStashesColor\": \"#c6a0f6\",\n\
  \    \"gitlens.graphScrollMarkerTagsColor\": \"#f0c6c6\",\n\
  \    \"gitlens.graphScrollMarkerUpstreamColor\": \"#96d382\",\n\
  \    \"gitlens.gutterBackgroundColor\": \"#363a4f4d\",\n\
  \    \"gitlens.gutterForegroundColor\": \"#cad3f5\",\n\
  \    \"gitlens.gutterUncommittedForegroundColor\": \"#c6a0f6\",\n\
  \    \"gitlens.lineHighlightBackgroundColor\": \"#c6a0f626\",\n\
  \    \"gitlens.lineHighlightOverviewRulerColor\": \"#c6a0f6cc\",\n\
  \    \"gitlens.mergedPullRequestIconColor\": \"#c6a0f6\",\n\
  \    \"gitlens.openAutolinkedIssueIconColor\": \"#a6da95\",\n\
  \    \"gitlens.openPullRequestIconColor\": \"#a6da95\",\n\
  \    \"gitlens.trailingLineBackgroundColor\": \"#00000000\",\n\
  \    \"gitlens.trailingLineForegroundColor\": \"#cad3f54d\",\n\
  \    \"gitlens.unpublishedChangesIconColor\": \"#a6da95\",\n\
  \    \"gitlens.unpublishedCommitIconColor\": \"#a6da95\",\n\
  \    \"gitlens.unpulledChangesIconColor\": \"#f5a97f\",\n\
  \    \"icon.foreground\": \"#c6a0f6\",\n\
  \    \"input.background\": \"#363a4f\",\n\
  \    \"input.border\": \"#00000000\",\n\
  \    \"input.foreground\": \"#cad3f5\",\n\
  \    \"input.placeholderForeground\": \"#cad3f573\",\n\
  \    \"inputOption.activeBackground\": \"#5b6078\",\n\
  \    \"inputOption.activeBorder\": \"#c6a0f6\",\n\
  \    \"inputOption.activeForeground\": \"#cad3f5\",\n\
  \    \"inputValidation.errorBackground\": \"#ed8796\",\n\
  \    \"inputValidation.errorBorder\": \"#18192633\",\n\
  \    \"inputValidation.errorForeground\": \"#181926\",\n\
  \    \"inputValidation.infoBackground\": \"#8aadf4\",\n\
  \    \"inputValidation.infoBorder\": \"#18192633\",\n\
  \    \"inputValidation.infoForeground\": \"#181926\",\n\
  \    \"inputValidation.warningBackground\": \"#f5a97f\",\n\
  \    \"inputValidation.warningBorder\": \"#18192633\",\n\
  \    \"inputValidation.warningForeground\": \"#181926\",\n\
  \    \"issues.closed\": \"#c6a0f6\",\n\
  \    \"issues.newIssueDecoration\": \"#f4dbd6\",\n\
  \    \"issues.open\": \"#a6da95\",\n\
  \    \"list.activeSelectionBackground\": \"#363a4f\",\n\
  \    \"list.activeSelectionForeground\": \"#cad3f5\",\n\
  \    \"list.dropBackground\": \"#c6a0f633\",\n\
  \    \"list.focusAndSelectionBackground\": \"#494d64\",\n\
  \    \"list.focusBackground\": \"#363a4f\",\n\
  \    \"list.focusForeground\": \"#cad3f5\",\n\
  \    \"list.focusOutline\": \"#00000000\",\n\
  \    \"list.highlightForeground\": \"#c6a0f6\",\n\
  \    \"list.hoverBackground\": \"#363a4f80\",\n\
  \    \"list.hoverForeground\": \"#cad3f5\",\n\
  \    \"list.inactiveSelectionBackground\": \"#363a4f\",\n\
  \    \"list.inactiveSelectionForeground\": \"#cad3f5\",\n\
  \    \"list.warningForeground\": \"#f5a97f\",\n\
  \    \"listFilterWidget.background\": \"#494d64\",\n\
  \    \"listFilterWidget.noMatchesOutline\": \"#ed8796\",\n\
  \    \"listFilterWidget.outline\": \"#00000000\",\n\
  \    \"menu.background\": \"#24273a\",\n\
  \    \"menu.border\": \"#24273a80\",\n\
  \    \"menu.foreground\": \"#cad3f5\",\n\
  \    \"menu.selectionBackground\": \"#5b6078\",\n\
  \    \"menu.selectionBorder\": \"#00000000\",\n\
  \    \"menu.selectionForeground\": \"#cad3f5\",\n\
  \    \"menu.separatorBackground\": \"#5b6078\",\n\
  \    \"menubar.selectionBackground\": \"#494d64\",\n\
  \    \"menubar.selectionForeground\": \"#cad3f5\",\n\
  \    \"merge.commonContentBackground\": \"#494d64\",\n\
  \    \"merge.commonHeaderBackground\": \"#5b6078\",\n\
  \    \"merge.currentContentBackground\": \"#a6da9533\",\n\
  \    \"merge.currentHeaderBackground\": \"#a6da9566\",\n\
  \    \"merge.incomingContentBackground\": \"#8aadf433\",\n\
  \    \"merge.incomingHeaderBackground\": \"#8aadf466\",\n\
  \    \"minimap.background\": \"#1e203080\",\n\
  \    \"minimap.errorHighlight\": \"#ed8796bf\",\n\
  \    \"minimap.findMatchHighlight\": \"#91d7e34d\",\n\
  \    \"minimap.selectionHighlight\": \"#5b6078bf\",\n\
  \    \"minimap.selectionOccurrenceHighlight\": \"#5b6078bf\",\n\
  \    \"minimap.warningHighlight\": \"#f5a97fbf\",\n\
  \    \"minimapGutter.addedBackground\": \"#a6da95bf\",\n\
  \    \"minimapGutter.deletedBackground\": \"#ed8796bf\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#eed49fbf\",\n\
  \    \"minimapSlider.activeBackground\": \"#c6a0f699\",\n\
  \    \"minimapSlider.background\": \"#c6a0f633\",\n\
  \    \"minimapSlider.hoverBackground\": \"#c6a0f666\",\n\
  \    \"notificationCenter.border\": \"#c6a0f6\",\n\
  \    \"notificationCenterHeader.background\": \"#1e2030\",\n\
  \    \"notificationCenterHeader.foreground\": \"#cad3f5\",\n\
  \    \"notificationLink.foreground\": \"#8aadf4\",\n\
  \    \"notificationToast.border\": \"#c6a0f6\",\n\
  \    \"notifications.background\": \"#1e2030\",\n\
  \    \"notifications.border\": \"#c6a0f6\",\n\
  \    \"notifications.foreground\": \"#cad3f5\",\n\
  \    \"notificationsErrorIcon.foreground\": \"#ed8796\",\n\
  \    \"notificationsInfoIcon.foreground\": \"#8aadf4\",\n\
  \    \"notificationsWarningIcon.foreground\": \"#f5a97f\",\n\
  \    \"panel.background\": \"#24273a\",\n\
  \    \"panel.border\": \"#5b6078\",\n\
  \    \"panelSection.border\": \"#5b6078\",\n\
  \    \"panelSection.dropBackground\": \"#c6a0f633\",\n\
  \    \"panelTitle.activeBorder\": \"#c6a0f6\",\n\
  \    \"panelTitle.activeForeground\": \"#cad3f5\",\n\
  \    \"panelTitle.inactiveForeground\": \"#a5adcb\",\n\
  \    \"peekView.border\": \"#c6a0f6\",\n\
  \    \"peekViewEditor.background\": \"#1e2030\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#91d7e34d\",\n\
  \    \"peekViewEditor.matchHighlightBorder\": \"#00000000\",\n\
  \    \"peekViewEditorGutter.background\": \"#1e2030\",\n\
  \    \"peekViewResult.background\": \"#1e2030\",\n\
  \    \"peekViewResult.fileForeground\": \"#cad3f5\",\n\
  \    \"peekViewResult.lineForeground\": \"#cad3f5\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#91d7e34d\",\n\
  \    \"peekViewResult.selectionBackground\": \"#363a4f\",\n\
  \    \"peekViewResult.selectionForeground\": \"#cad3f5\",\n\
  \    \"peekViewTitle.background\": \"#24273a\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#b8c0e0b3\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#cad3f5\",\n\
  \    \"pickerGroup.border\": \"#c6a0f6\",\n\
  \    \"pickerGroup.foreground\": \"#c6a0f6\",\n\
  \    \"problemsErrorIcon.foreground\": \"#ed8796\",\n\
  \    \"problemsInfoIcon.foreground\": \"#8aadf4\",\n\
  \    \"problemsWarningIcon.foreground\": \"#f5a97f\",\n\
  \    \"progressBar.background\": \"#c6a0f6\",\n\
  \    \"pullRequests.closed\": \"#ed8796\",\n\
  \    \"pullRequests.draft\": \"#939ab7\",\n\
  \    \"pullRequests.merged\": \"#c6a0f6\",\n\
  \    \"pullRequests.notification\": \"#cad3f5\",\n\
  \    \"pullRequests.open\": \"#a6da95\",\n\
  \    \"sash.hoverBorder\": \"#c6a0f6\",\n\
  \    \"scmGraph.foreground1\": \"#eed49f\",\n\
  \    \"scmGraph.foreground2\": \"#ed8796\",\n\
  \    \"scmGraph.foreground3\": \"#a6da95\",\n\
  \    \"scmGraph.foreground4\": \"#c6a0f6\",\n\
  \    \"scmGraph.foreground5\": \"#8bd5ca\",\n\
  \    \"scmGraph.historyItemBaseRefColor\": \"#f5a97f\",\n\
  \    \"scmGraph.historyItemRefColor\": \"#8aadf4\",\n\
  \    \"scmGraph.historyItemRemoteRefColor\": \"#c6a0f6\",\n\
  \    \"scrollbar.shadow\": \"#181926\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#363a4f66\",\n\
  \    \"scrollbarSlider.background\": \"#5b607880\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#6e738d\",\n\
  \    \"selection.background\": \"#c6a0f666\",\n\
  \    \"settings.dropdownBackground\": \"#494d64\",\n\
  \    \"settings.dropdownListBorder\": \"#00000000\",\n\
  \    \"settings.focusedRowBackground\": \"#5b607833\",\n\
  \    \"settings.headerForeground\": \"#cad3f5\",\n\
  \    \"settings.modifiedItemIndicator\": \"#c6a0f6\",\n\
  \    \"settings.numberInputBackground\": \"#494d64\",\n\
  \    \"settings.numberInputBorder\": \"#00000000\",\n\
  \    \"settings.textInputBackground\": \"#494d64\",\n\
  \    \"settings.textInputBorder\": \"#00000000\",\n\
  \    \"sideBar.background\": \"#1e2030\",\n\
  \    \"sideBar.border\": \"#00000000\",\n\
  \    \"sideBar.dropBackground\": \"#c6a0f633\",\n\
  \    \"sideBar.foreground\": \"#cad3f5\",\n\
  \    \"sideBarSectionHeader.background\": \"#1e2030\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#cad3f5\",\n\
  \    \"sideBarTitle.foreground\": \"#c6a0f6\",\n\
  \    \"statusBar.background\": \"#181926\",\n\
  \    \"statusBar.border\": \"#00000000\",\n\
  \    \"statusBar.debuggingBackground\": \"#f5a97f\",\n\
  \    \"statusBar.debuggingBorder\": \"#00000000\",\n\
  \    \"statusBar.debuggingForeground\": \"#181926\",\n\
  \    \"statusBar.foreground\": \"#cad3f5\",\n\
  \    \"statusBar.noFolderBackground\": \"#181926\",\n\
  \    \"statusBar.noFolderBorder\": \"#00000000\",\n\
  \    \"statusBar.noFolderForeground\": \"#cad3f5\",\n\
  \    \"statusBarItem.activeBackground\": \"#5b607866\",\n\
  \    \"statusBarItem.errorBackground\": \"#00000000\",\n\
  \    \"statusBarItem.errorForeground\": \"#ed8796\",\n\
  \    \"statusBarItem.hoverBackground\": \"#5b607833\",\n\
  \    \"statusBarItem.prominentBackground\": \"#00000000\",\n\
  \    \"statusBarItem.prominentForeground\": \"#c6a0f6\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#5b607833\",\n\
  \    \"statusBarItem.remoteBackground\": \"#8aadf4\",\n\
  \    \"statusBarItem.remoteForeground\": \"#181926\",\n\
  \    \"statusBarItem.warningBackground\": \"#00000000\",\n\
  \    \"statusBarItem.warningForeground\": \"#f5a97f\",\n\
  \    \"symbolIcon.arrayForeground\": \"#f5a97f\",\n\
  \    \"symbolIcon.booleanForeground\": \"#c6a0f6\",\n\
  \    \"symbolIcon.classForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.colorForeground\": \"#f5bde6\",\n\
  \    \"symbolIcon.constantForeground\": \"#f5a97f\",\n\
  \    \"symbolIcon.constructorForeground\": \"#b7bdf8\",\n\
  \    \"symbolIcon.enumeratorForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.enumeratorMemberForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.eventForeground\": \"#f5bde6\",\n\
  \    \"symbolIcon.fieldForeground\": \"#cad3f5\",\n\
  \    \"symbolIcon.fileForeground\": \"#c6a0f6\",\n\
  \    \"symbolIcon.folderForeground\": \"#c6a0f6\",\n\
  \    \"symbolIcon.functionForeground\": \"#8aadf4\",\n\
  \    \"symbolIcon.interfaceForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.keyForeground\": \"#8bd5ca\",\n\
  \    \"symbolIcon.keywordForeground\": \"#c6a0f6\",\n\
  \    \"symbolIcon.methodForeground\": \"#8aadf4\",\n\
  \    \"symbolIcon.moduleForeground\": \"#cad3f5\",\n\
  \    \"symbolIcon.namespaceForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.nullForeground\": \"#ee99a0\",\n\
  \    \"symbolIcon.numberForeground\": \"#f5a97f\",\n\
  \    \"symbolIcon.objectForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.operatorForeground\": \"#8bd5ca\",\n\
  \    \"symbolIcon.packageForeground\": \"#f0c6c6\",\n\
  \    \"symbolIcon.propertyForeground\": \"#ee99a0\",\n\
  \    \"symbolIcon.referenceForeground\": \"#eed49f\",\n\
  \    \"symbolIcon.snippetForeground\": \"#f0c6c6\",\n\
  \    \"symbolIcon.stringForeground\": \"#a6da95\",\n\
  \    \"symbolIcon.structForeground\": \"#8bd5ca\",\n\
  \    \"symbolIcon.textForeground\": \"#cad3f5\",\n\
  \    \"symbolIcon.typeParameterForeground\": \"#ee99a0\",\n\
  \    \"symbolIcon.unitForeground\": \"#cad3f5\",\n\
  \    \"symbolIcon.variableForeground\": \"#cad3f5\",\n\
  \    \"tab.activeBackground\": \"#24273a\",\n\
  \    \"tab.activeBorder\": \"#00000000\",\n\
  \    \"tab.activeBorderTop\": \"#c6a0f6\",\n\
  \    \"tab.activeForeground\": \"#c6a0f6\",\n\
  \    \"tab.activeModifiedBorder\": \"#eed49f\",\n\
  \    \"tab.border\": \"#1e2030\",\n\
  \    \"tab.hoverBackground\": \"#2e324a\",\n\
  \    \"tab.hoverBorder\": \"#00000000\",\n\
  \    \"tab.hoverForeground\": \"#c6a0f6\",\n\
  \    \"tab.inactiveBackground\": \"#1e2030\",\n\
  \    \"tab.inactiveForeground\": \"#6e738d\",\n\
  \    \"tab.inactiveModifiedBorder\": \"#eed49f4d\",\n\
  \    \"tab.lastPinnedBorder\": \"#c6a0f6\",\n\
  \    \"tab.unfocusedActiveBackground\": \"#1e2030\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#00000000\",\n\
  \    \"tab.unfocusedActiveBorderTop\": \"#c6a0f64d\",\n\
  \    \"tab.unfocusedInactiveBackground\": \"#141620\",\n\
  \    \"table.headerBackground\": \"#363a4f\",\n\
  \    \"table.headerForeground\": \"#cad3f5\",\n\
  \    \"terminal.ansiBlack\": \"#494d64\",\n\
  \    \"terminal.ansiBlue\": \"#8aadf4\",\n\
  \    \"terminal.ansiBrightBlack\": \"#5b6078\",\n\
  \    \"terminal.ansiBrightBlue\": \"#78a1f6\",\n\
  \    \"terminal.ansiBrightCyan\": \"#63cbc0\",\n\
  \    \"terminal.ansiBrightGreen\": \"#8ccf7f\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#f2a9dd\",\n\
  \    \"terminal.ansiBrightRed\": \"#ec7486\",\n\
  \    \"terminal.ansiBrightWhite\": \"#b8c0e0\",\n\
  \    \"terminal.ansiBrightYellow\": \"#e1c682\",\n\
  \    \"terminal.ansiCyan\": \"#8bd5ca\",\n\
  \    \"terminal.ansiGreen\": \"#a6da95\",\n\
  \    \"terminal.ansiMagenta\": \"#f5bde6\",\n\
  \    \"terminal.ansiRed\": \"#ed8796\",\n\
  \    \"terminal.ansiWhite\": \"#a5adcb\",\n\
  \    \"terminal.ansiYellow\": \"#eed49f\",\n\
  \    \"terminal.border\": \"#5b6078\",\n\
  \    \"terminal.dropBackground\": \"#c6a0f633\",\n\
  \    \"terminal.foreground\": \"#cad3f5\",\n\
  \    \"terminal.inactiveSelectionBackground\": \"#5b607880\",\n\
  \    \"terminal.selectionBackground\": \"#5b6078\",\n\
  \    \"terminal.tab.activeBorder\": \"#c6a0f6\",\n\
  \    \"terminalCommandDecoration.defaultBackground\": \"#5b6078\",\n\
  \    \"terminalCommandDecoration.errorBackground\": \"#ed8796\",\n\
  \    \"terminalCommandDecoration.successBackground\": \"#a6da95\",\n\
  \    \"terminalCursor.background\": \"#24273a\",\n\
  \    \"terminalCursor.foreground\": \"#f4dbd6\",\n\
  \    \"testing.coverCountBadgeBackground\": \"#00000000\",\n\
  \    \"testing.coverCountBadgeForeground\": \"#c6a0f6\",\n\
  \    \"testing.coveredBackground\": \"#a6da954d\",\n\
  \    \"testing.coveredBorder\": \"#00000000\",\n\
  \    \"testing.coveredGutterBackground\": \"#a6da954d\",\n\
  \    \"testing.iconErrored\": \"#ed8796\",\n\
  \    \"testing.iconErrored.retired\": \"#ed8796\",\n\
  \    \"testing.iconFailed\": \"#ed8796\",\n\
  \    \"testing.iconFailed.retired\": \"#ed8796\",\n\
  \    \"testing.iconPassed\": \"#a6da95\",\n\
  \    \"testing.iconPassed.retired\": \"#a6da95\",\n\
  \    \"testing.iconQueued\": \"#8aadf4\",\n\
  \    \"testing.iconQueued.retired\": \"#8aadf4\",\n\
  \    \"testing.iconSkipped\": \"#a5adcb\",\n\
  \    \"testing.iconSkipped.retired\": \"#a5adcb\",\n\
  \    \"testing.iconUnset\": \"#cad3f5\",\n\
  \    \"testing.iconUnset.retired\": \"#cad3f5\",\n\
  \    \"testing.message.error.lineBackground\": \"#ed879626\",\n\
  \    \"testing.message.info.decorationForeground\": \"#a6da95cc\",\n\
  \    \"testing.message.info.lineBackground\": \"#a6da9526\",\n\
  \    \"testing.messagePeekBorder\": \"#c6a0f6\",\n\
  \    \"testing.messagePeekHeaderBackground\": \"#5b6078\",\n\
  \    \"testing.peekBorder\": \"#c6a0f6\",\n\
  \    \"testing.peekHeaderBackground\": \"#5b6078\",\n\
  \    \"testing.runAction\": \"#c6a0f6\",\n\
  \    \"testing.uncoveredBackground\": \"#ed879633\",\n\
  \    \"testing.uncoveredBorder\": \"#00000000\",\n\
  \    \"testing.uncoveredBranchBackground\": \"#ed879633\",\n\
  \    \"testing.uncoveredGutterBackground\": \"#ed879640\",\n\
  \    \"textBlockQuote.background\": \"#1e2030\",\n\
  \    \"textBlockQuote.border\": \"#181926\",\n\
  \    \"textCodeBlock.background\": \"#1e2030\",\n\
  \    \"textLink.activeForeground\": \"#91d7e3\",\n\
  \    \"textLink.foreground\": \"#8aadf4\",\n\
  \    \"textPreformat.foreground\": \"#cad3f5\",\n\
  \    \"textSeparator.foreground\": \"#c6a0f6\",\n\
  \    \"titleBar.activeBackground\": \"#181926\",\n\
  \    \"titleBar.activeForeground\": \"#cad3f5\",\n\
  \    \"titleBar.border\": \"#00000000\",\n\
  \    \"titleBar.inactiveBackground\": \"#181926\",\n\
  \    \"titleBar.inactiveForeground\": \"#cad3f580\",\n\
  \    \"tree.inactiveIndentGuidesStroke\": \"#494d64\",\n\
  \    \"tree.indentGuidesStroke\": \"#939ab7\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#24273a4d\",\n\
  \    \"welcomePage.progress.background\": \"#181926\",\n\
  \    \"welcomePage.progress.foreground\": \"#c6a0f6\",\n\
  \    \"welcomePage.tileBackground\": \"#1e2030\",\n\
  \    \"widget.shadow\": \"#1e203080\"\n\
  \  },\n\
  \  \"displayName\": \"Catppuccin Macchiato\",\n\
  \  \"name\": \"catppuccin-macchiato\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"boolean\": {\n\
  \      \"foreground\": \"#f5a97f\"\n\
  \    },\n\
  \    \"builtinAttribute.attribute.library:rust\": {\n\
  \      \"foreground\": \"#8aadf4\"\n\
  \    },\n\
  \    \"class.builtin:python\": {\n\
  \      \"foreground\": \"#c6a0f6\"\n\
  \    },\n\
  \    \"class:python\": {\n\
  \      \"foreground\": \"#eed49f\"\n\
  \    },\n\
  \    \"constant.builtin.readonly:nix\": {\n\
  \      \"foreground\": \"#c6a0f6\"\n\
  \    },\n\
  \    \"enumMember\": {\n\
  \      \"foreground\": \"#8bd5ca\"\n\
  \    },\n\
  \    \"function.decorator:python\": {\n\
  \      \"foreground\": \"#f5a97f\"\n\
  \    },\n\
  \    \"generic.attribute:rust\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"heading\": {\n\
  \      \"foreground\": \"#ed8796\"\n\
  \    },\n\
  \    \"number\": {\n\
  \      \"foreground\": \"#f5a97f\"\n\
  \    },\n\
  \    \"pol\": {\n\
  \      \"foreground\": \"#f0c6c6\"\n\
  \    },\n\
  \    \"property.readonly:javascript\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"property.readonly:javascriptreact\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"property.readonly:typescript\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"property.readonly:typescriptreact\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"selfKeyword\": {\n\
  \      \"foreground\": \"#ed8796\"\n\
  \    },\n\
  \    \"text.emph\": {\n\
  \      \"fontStyle\": \"italic\",\n\
  \      \"foreground\": \"#ed8796\"\n\
  \    },\n\
  \    \"text.math\": {\n\
  \      \"foreground\": \"#f0c6c6\"\n\
  \    },\n\
  \    \"text.strong\": {\n\
  \      \"fontStyle\": \"bold\",\n\
  \      \"foreground\": \"#ed8796\"\n\
  \    },\n\
  \    \"tomlArrayKey\": {\n\
  \      \"fontStyle\": \"\",\n\
  \      \"foreground\": \"#8aadf4\"\n\
  \    },\n\
  \    \"tomlTableKey\": {\n\
  \      \"fontStyle\": \"\",\n\
  \      \"foreground\": \"#8aadf4\"\n\
  \    },\n\
  \    \"type.defaultLibrary:go\": {\n\
  \      \"foreground\": \"#c6a0f6\"\n\
  \    },\n\
  \    \"variable.defaultLibrary\": {\n\
  \      \"foreground\": \"#ee99a0\"\n\
  \    },\n\
  \    \"variable.readonly.defaultLibrary:go\": {\n\
  \      \"foreground\": \"#c6a0f6\"\n\
  \    },\n\
  \    \"variable.readonly:javascript\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"variable.readonly:javascriptreact\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"variable.readonly:scala\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"variable.readonly:typescript\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"variable.readonly:typescriptreact\": {\n\
  \      \"foreground\": \"#cad3f5\"\n\
  \    },\n\
  \    \"variable.typeHint:python\": {\n\
  \      \"foreground\": \"#eed49f\"\n\
  \    }\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text\",\n\
  \        \"source\",\n\
  \        \"variable.other.readwrite\",\n\
  \        \"punctuation.definition.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#939ab7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"punctuation.definition.comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#939ab7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"punctuation.definition.string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\",\n\
  \        \"variable.other.constant\",\n\
  \        \"entity.name.constant\",\n\
  \        \"constant.language.boolean\",\n\
  \        \"constant.language.false\",\n\
  \        \"constant.language.true\",\n\
  \        \"keyword.other.unit.user-defined\",\n\
  \        \"keyword.other.unit.suffix.floating-point\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword\",\n\
  \        \"keyword.operator.word\",\n\
  \        \"keyword.operator.new\",\n\
  \        \"variable.language.super\",\n\
  \        \"support.type.primitive\",\n\
  \        \"storage.type\",\n\
  \        \"storage.modifier\",\n\
  \        \"punctuation.definition.keyword\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.documentation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator\",\n\
  \        \"punctuation.accessor\",\n\
  \        \"punctuation.definition.generic\",\n\
  \        \"meta.function.closure punctuation.section.parameters\",\n\
  \        \"punctuation.definition.tag\",\n\
  \        \"punctuation.separator.key-value\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"meta.function-call.method\",\n\
  \        \"support.function\",\n\
  \        \"support.function.misc\",\n\
  \        \"variable.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.class\",\n\
  \        \"entity.other.inherited-class\",\n\
  \        \"support.class\",\n\
  \        \"meta.function-call.constructor\",\n\
  \        \"entity.name.struct\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.enum\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.enum variable.other.readwrite\",\n\
  \        \"variable.other.enummember\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.property.object\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.type\",\n\
  \        \"meta.type-alias\",\n\
  \        \"support.type\",\n\
  \        \"entity.name.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.annotation variable.function\",\n\
  \        \"meta.annotation variable.annotation.function\",\n\
  \        \"meta.annotation punctuation.definition.annotation\",\n\
  \        \"meta.decorator\",\n\
  \        \"punctuation.decorator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter\",\n\
  \        \"meta.function.parameters\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language\",\n\
  \        \"support.function.builtin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.documentation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.directive\",\n\
  \        \"punctuation.definition.directive\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.typeparameters\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.namespace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name.css\",\n\
  \        \"support.type.property-name.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.language.this\",\n\
  \        \"variable.language.this punctuation.definition.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.object.property\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.template variable\",\n\
  \        \"string variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.new\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.specifier.extern.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.scope-resolution.template.call.cpp\",\n\
  \        \"entity.name.scope-resolution.parameter.cpp\",\n\
  \        \"entity.name.scope-resolution.cpp\",\n\
  \        \"entity.name.scope-resolution.function.definition.cpp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.class.doxygen\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.reference.cpp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.interpolation.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.block.documentation.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css entity.other.attribute-name.class.css\",\n\
  \        \"entity.other.attribute-name.parent-selector.css \
   punctuation.definition.entity.css\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.operator.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css entity.other.attribute-name.pseudo-class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css constant.other.unicode-range\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css variable.parameter.url\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.vendored.property-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css meta.property-value variable\",\n\
  \        \"source.css meta.property-value variable.other.less\",\n\
  \        \"source.css meta.property-value variable.other.less \
   punctuation.definition.variable.less\",\n\
  \        \"meta.definition.variable.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css meta.property-list variable\",\n\
  \        \"meta.property-list variable.other.less\",\n\
  \        \"meta.property-list variable.other.less \
   punctuation.definition.variable.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit.percentage.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css meta.attribute-selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.definition.ini\",\n\
  \        \"punctuation.support.type.property-name.json\",\n\
  \        \"support.type.property-name.json\",\n\
  \        \"punctuation.support.type.property-name.toml\",\n\
  \        \"support.type.property-name.toml\",\n\
  \        \"entity.name.tag.yaml\",\n\
  \        \"punctuation.support.type.property-name.yaml\",\n\
  \        \"support.type.property-name.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.json\",\n\
  \        \"constant.language.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.type.anchor.yaml\",\n\
  \        \"variable.other.alias.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.property-name.table\",\n\
  \        \"entity.name.section.group-title.ini\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.time.datetime.offset.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.anchor.yaml\",\n\
  \        \"punctuation.definition.alias.yaml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.document.begin.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.diff.header.from-file\",\n\
  \        \"meta.diff.header.to-file\",\n\
  \        \"punctuation.definition.from-file.diff\",\n\
  \        \"punctuation.definition.to-file.diff\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.env\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.quoted variable.other.env\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.builtin.gdscript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.gdscript\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment meta.annotation.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment meta.annotation.parameters.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.alias.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f0c6c6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.enum.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.objectvalues.graphql constant.object.key.graphql \
   string.unquoted.graphql\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f0c6c6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.doctype\",\n\
  \        \"meta.tag.sgml.doctype punctuation.definition.tag\",\n\
  \        \"meta.tag.metadata.doctype entity.name.tag\",\n\
  \        \"meta.tag.metadata.doctype punctuation.definition.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html constant.character.entity\",\n\
  \        \"text.html constant.character.entity punctuation\",\n\
  \        \"constant.character.entity.xml\",\n\
  \        \"constant.character.entity.xml punctuation\",\n\
  \        \"constant.character.entity.js.jsx\",\n\
  \        \"constant.charactger.entity.js.jsx punctuation\",\n\
  \        \"constant.character.entity.tsx\",\n\
  \        \"constant.character.entity.tsx punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.component\",\n\
  \        \"support.class.component.jsx\",\n\
  \        \"support.class.component.tsx\",\n\
  \        \"support.class.component.vue\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.annotation\",\n\
  \        \"storage.type.annotation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.enum.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.import.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.block.javadoc.java \
   keyword.other.documentation.javadoc.java\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.export variable.other.readwrite.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant.js\",\n\
  \        \"variable.other.constant.ts\",\n\
  \        \"variable.other.property.js\",\n\
  \        \"variable.other.property.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.jsdoc\",\n\
  \        \"comment.block.documentation variable.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.class.jsdoc\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.object.console.js\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.node\",\n\
  \        \"support.type.object.module.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.implements\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.null.js\",\n\
  \        \"constant.language.null.ts\",\n\
  \        \"constant.language.undefined.js\",\n\
  \        \"constant.language.undefined.ts\",\n\
  \        \"support.type.builtin.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.generic\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.declaration.function.arrow.js\",\n\
  \        \"storage.type.function.arrow.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.decorator.ts\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.expression.in.js\",\n\
  \        \"keyword.operator.expression.in.ts\",\n\
  \        \"keyword.operator.expression.infer.ts\",\n\
  \        \"keyword.operator.expression.instanceof.js\",\n\
  \        \"keyword.operator.expression.instanceof.ts\",\n\
  \        \"keyword.operator.expression.is\",\n\
  \        \"keyword.operator.expression.keyof.ts\",\n\
  \        \"keyword.operator.expression.of.js\",\n\
  \        \"keyword.operator.expression.of.ts\",\n\
  \        \"keyword.operator.expression.typeof.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.macro.julia\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.symbol.julia\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.tex keyword.control.preamble\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.tex support.function.be\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.general.math.tex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f0c6c6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.liquid\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.line.double-dash.documentation.lua \
   storage.type.annotation.lua\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment.line.double-dash.documentation.lua \
   entity.name.variable.lua\",\n\
  \        \"comment.line.double-dash.documentation.lua variable.lua\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.1.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.1.markdown\",\n\
  \        \"heading.1.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.1.quarto\",\n\
  \        \"markup.heading.atx.1.mdx\",\n\
  \        \"markup.heading.atx.1.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.setext.1.markdown\",\n\
  \        \"markup.heading.heading-0.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.2.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.2.markdown\",\n\
  \        \"heading.2.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.2.quarto\",\n\
  \        \"markup.heading.atx.2.mdx\",\n\
  \        \"markup.heading.atx.2.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.setext.2.markdown\",\n\
  \        \"markup.heading.heading-1.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.3.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.3.markdown\",\n\
  \        \"heading.3.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.3.quarto\",\n\
  \        \"markup.heading.atx.3.mdx\",\n\
  \        \"markup.heading.atx.3.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-2.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.4.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.4.markdown\",\n\
  \        \"heading.4.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.4.quarto\",\n\
  \        \"markup.heading.atx.4.mdx\",\n\
  \        \"markup.heading.atx.4.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-3.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.5.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.5.markdown\",\n\
  \        \"heading.5.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.5.quarto\",\n\
  \        \"markup.heading.atx.5.mdx\",\n\
  \        \"markup.heading.atx.5.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-4.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7dc4e4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"heading.6.markdown punctuation.definition.heading.markdown\",\n\
  \        \"heading.6.markdown\",\n\
  \        \"heading.6.quarto punctuation.definition.heading.quarto\",\n\
  \        \"heading.6.quarto\",\n\
  \        \"markup.heading.atx.6.mdx\",\n\
  \        \"markup.heading.atx.6.mdx punctuation.definition.heading.mdx\",\n\
  \        \"markup.heading.heading-5.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b7bdf8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.strikethrough\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"strikethrough\",\n\
  \        \"foreground\": \"#a5adcb\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.link\",\n\
  \        \"markup.underline.link\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown punctuation.definition.link.title\",\n\
  \        \"text.html.quarto punctuation.definition.link.title\",\n\
  \        \"string.other.link.title.markdown\",\n\
  \        \"string.other.link.title.quarto\",\n\
  \        \"markup.link\",\n\
  \        \"punctuation.definition.constant.markdown\",\n\
  \        \"punctuation.definition.constant.quarto\",\n\
  \        \"constant.other.reference.link.markdown\",\n\
  \        \"constant.other.reference.link.quarto\",\n\
  \        \"markup.substitution.attribute-reference\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b7bdf8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.raw.markdown\",\n\
  \        \"punctuation.definition.raw.quarto\",\n\
  \        \"markup.inline.raw.string.markdown\",\n\
  \        \"markup.inline.raw.string.quarto\",\n\
  \        \"markup.raw.block.markdown\",\n\
  \        \"markup.raw.block.quarto\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"fenced_code.block.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.fenced_code.block punctuation.definition\",\n\
  \        \"markup.raw support.asciidoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#939ab7\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.quote\",\n\
  \        \"punctuation.definition.quote.begin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.separator.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.list.begin.markdown\",\n\
  \        \"punctuation.definition.list.begin.quarto\",\n\
  \        \"markup.list.bullet\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading.quarto\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.multipart.nix\",\n\
  \        \"entity.other.attribute-name.single.nix\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.name.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.embedded variable.parameter.name.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#b7bdf8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.path.nix\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.attribute.builtin\",\n\
  \        \"meta.attribute.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.parameters.php \
   punctuation.definition.variable.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.php support.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.phpdoc.php\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.variable.magic.python\",\n\
  \        \"meta.function-call.arguments.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.function.magic.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter.function.language.special.self.python\",\n\
  \        \"variable.language.special.self.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.flow.python\",\n\
  \        \"keyword.operator.logical.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.function.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.token.decorator.python\",\n\
  \        \"meta.function.decorator.identifier.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function-call.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.decorator.python\",\n\
  \        \"punctuation.definition.decorator.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.exception.python\",\n\
  \        \"support.function.builtin.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.indexed-name.python\",\n\
  \        \"meta.item-access.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.string.python\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.parameters.python\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.arguments.r\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.regexp punctuation.definition.string.begin\",\n\
  \        \"string.regexp punctuation.definition.string.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.anchor.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.regexp\",\n\
  \        \"keyword.other.back-reference.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a6da95\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.character-class.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.character-class.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.character-class.range.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f4dbd6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.numeric.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.group.no-capture.regexp\",\n\
  \        \"meta.assertion.look-ahead.regexp\",\n\
  \        \"meta.assertion.negative-look-ahead.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.annotation.rust\",\n\
  \        \"meta.annotation.rust punctuation\",\n\
  \        \"meta.attribute.rust\",\n\
  \        \"punctuation.definition.attribute.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.attribute.rust string.quoted.double.rust\",\n\
  \        \"meta.attribute.rust string.quoted.single.char.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.macro.rules.rust\",\n\
  \        \"storage.type.module.rust\",\n\
  \        \"storage.modifier.rust\",\n\
  \        \"storage.type.struct.rust\",\n\
  \        \"storage.type.enum.rust\",\n\
  \        \"storage.type.trait.rust\",\n\
  \        \"storage.type.union.rust\",\n\
  \        \"storage.type.impl.rust\",\n\
  \        \"storage.type.rust\",\n\
  \        \"storage.type.function.rust\",\n\
  \        \"storage.type.type.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.numeric.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\",\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.generic.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.impl.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.module.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.trait.rust\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.source.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.union.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#eed49f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.enum.rust storage.type.source.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.macro.rust\",\n\
  \        \"meta.macro.rust support.function.rust\",\n\
  \        \"entity.name.function.macro.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.lifetime.rust\",\n\
  \        \"entity.name.type.lifetime\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.rust \
   constant.other.placeholder.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.return-type.rust meta.generic.rust \
   storage.type.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.call.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8aadf4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.brackets.angle.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#91d7e3\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.caps.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function.definition.rust variable.other.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ee99a0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.call.rust variable.other.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.self.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.metavariable.name.rust\",\n\
  \        \"meta.macro.metavariable.rust keyword.operator.macro.dollar.rust\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment.line.shebang\",\n\
  \        \"comment.line.shebang punctuation.definition.comment\",\n\
  \        \"comment.line.shebang\",\n\
  \        \"punctuation.definition.comment.shebang.shell\",\n\
  \        \"meta.shebang.shell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f5bde6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.line.shebang constant.language\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.definition.variable.shell\",\n\
  \        \"meta.function-call.arguments.shell \
   punctuation.section.interpolation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.string meta.interpolation.parameter.shell \
   variable.other.readwrite\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#f5a97f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.shell punctuation.section.interpolation\",\n\
  \        \"punctuation.definition.evaluation.backticks.shell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8bd5ca\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag.heredoc.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c6a0f6\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.shell variable.other.normal.shell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cad3f5\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.heading.typst\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ed8796\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let gruvbox_dark_medium =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.background\": \"#282828\",\n\
  \    \"activityBar.border\": \"#3c3836\",\n\
  \    \"activityBar.foreground\": \"#ebdbb2\",\n\
  \    \"activityBarBadge.background\": \"#458588\",\n\
  \    \"activityBarBadge.foreground\": \"#ebdbb2\",\n\
  \    \"activityBarTop.background\": \"#282828\",\n\
  \    \"activityBarTop.foreground\": \"#ebdbb2\",\n\
  \    \"badge.background\": \"#b16286\",\n\
  \    \"badge.foreground\": \"#ebdbb2\",\n\
  \    \"button.background\": \"#45858880\",\n\
  \    \"button.foreground\": \"#ebdbb2\",\n\
  \    \"button.hoverBackground\": \"#45858860\",\n\
  \    \"debugToolBar.background\": \"#282828\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#b8bb2630\",\n\
  \    \"diffEditor.removedTextBackground\": \"#fb493430\",\n\
  \    \"dropdown.background\": \"#282828\",\n\
  \    \"dropdown.border\": \"#3c3836\",\n\
  \    \"dropdown.foreground\": \"#ebdbb2\",\n\
  \    \"editor.background\": \"#282828\",\n\
  \    \"editor.findMatchBackground\": \"#83a59870\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#fe801930\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#83a59870\",\n\
  \    \"editor.foreground\": \"#ebdbb2\",\n\
  \    \"editor.hoverHighlightBackground\": \"#689d6a50\",\n\
  \    \"editor.lineHighlightBackground\": \"#3c383660\",\n\
  \    \"editor.lineHighlightBorder\": \"#0000\",\n\
  \    \"editor.selectionBackground\": \"#689d6a40\",\n\
  \    \"editor.selectionHighlightBackground\": \"#fabd2f40\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#b16286\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#458588\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#689d6a\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#98971a\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#d79921\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#d65d0e\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#cc241d\",\n\
  \    \"editorBracketMatch.background\": \"#92837480\",\n\
  \    \"editorBracketMatch.border\": \"#0000\",\n\
  \    \"editorCodeLens.foreground\": \"#a8998490\",\n\
  \    \"editorCursor.foreground\": \"#ebdbb2\",\n\
  \    \"editorError.foreground\": \"#cc241d\",\n\
  \    \"editorGhostText.background\": \"#665c5460\",\n\
  \    \"editorGroup.border\": \"#3c3836\",\n\
  \    \"editorGroup.dropBackground\": \"#3c383660\",\n\
  \    \"editorGroupHeader.noTabsBackground\": \"#282828\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#282828\",\n\
  \    \"editorGroupHeader.tabsBorder\": \"#3c3836\",\n\
  \    \"editorGutter.addedBackground\": \"#b8bb26\",\n\
  \    \"editorGutter.background\": \"#0000\",\n\
  \    \"editorGutter.deletedBackground\": \"#fb4934\",\n\
  \    \"editorGutter.modifiedBackground\": \"#83a598\",\n\
  \    \"editorHoverWidget.background\": \"#282828\",\n\
  \    \"editorHoverWidget.border\": \"#3c3836\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#665c54\",\n\
  \    \"editorInfo.foreground\": \"#458588\",\n\
  \    \"editorLineNumber.foreground\": \"#665c54\",\n\
  \    \"editorLink.activeForeground\": \"#ebdbb2\",\n\
  \    \"editorOverviewRuler.addedForeground\": \"#83a598\",\n\
  \    \"editorOverviewRuler.border\": \"#0000\",\n\
  \    \"editorOverviewRuler.commonContentForeground\": \"#928374\",\n\
  \    \"editorOverviewRuler.currentContentForeground\": \"#458588\",\n\
  \    \"editorOverviewRuler.deletedForeground\": \"#83a598\",\n\
  \    \"editorOverviewRuler.errorForeground\": \"#fb4934\",\n\
  \    \"editorOverviewRuler.findMatchForeground\": \"#bdae93\",\n\
  \    \"editorOverviewRuler.incomingContentForeground\": \"#689d6a\",\n\
  \    \"editorOverviewRuler.infoForeground\": \"#d3869b\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#83a598\",\n\
  \    \"editorOverviewRuler.rangeHighlightForeground\": \"#bdae93\",\n\
  \    \"editorOverviewRuler.selectionHighlightForeground\": \"#665c54\",\n\
  \    \"editorOverviewRuler.warningForeground\": \"#d79921\",\n\
  \    \"editorOverviewRuler.wordHighlightForeground\": \"#665c54\",\n\
  \    \"editorOverviewRuler.wordHighlightStrongForeground\": \"#665c54\",\n\
  \    \"editorRuler.foreground\": \"#a8998440\",\n\
  \    \"editorStickyScroll.shadow\": \"#50494599\",\n\
  \    \"editorStickyScrollHover.background\": \"#3c383660\",\n\
  \    \"editorSuggestWidget.background\": \"#282828\",\n\
  \    \"editorSuggestWidget.border\": \"#3c3836\",\n\
  \    \"editorSuggestWidget.foreground\": \"#ebdbb2\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#689d6a\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#3c383660\",\n\
  \    \"editorWarning.foreground\": \"#d79921\",\n\
  \    \"editorWhitespace.foreground\": \"#a8998420\",\n\
  \    \"editorWidget.background\": \"#282828\",\n\
  \    \"editorWidget.border\": \"#3c3836\",\n\
  \    \"errorForeground\": \"#fb4934\",\n\
  \    \"extensionButton.prominentBackground\": \"#b8bb2680\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#b8bb2630\",\n\
  \    \"focusBorder\": \"#3c3836\",\n\
  \    \"foreground\": \"#ebdbb2\",\n\
  \    \"gitDecoration.addedResourceForeground\": \"#ebdbb2\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#b16286\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#cc241d\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#7c6f64\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#d79921\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#98971a\",\n\
  \    \"gitlens.closedAutolinkedIssueIconColor\": \"#b16286\",\n\
  \    \"gitlens.closedPullRequestIconColor\": \"#cc241d\",\n\
  \    \"gitlens.decorations.branchAheadForegroundColor\": \"#98971a\",\n\
  \    \"gitlens.decorations.branchBehindForegroundColor\": \"#d65d0e\",\n\
  \    \"gitlens.decorations.branchDivergedForegroundColor\": \"#d79921\",\n\
  \    \"gitlens.decorations.branchMissingUpstreamForegroundColor\": \
   \"#cc241d\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingConflictForegroundColor\": \
   \"#cc241d\",\n\
  \    \"gitlens.decorations.statusMergingOrRebasingForegroundColor\": \
   \"#d79921\",\n\
  \    \"gitlens.decorations.workspaceCurrentForegroundColor\": \"#98971a\",\n\
  \    \"gitlens.decorations.workspaceRepoMissingForegroundColor\": \"#7c6f64\",\n\
  \    \"gitlens.decorations.workspaceRepoOpenForegroundColor\": \"#98971a\",\n\
  \    \"gitlens.decorations.worktreeHasUncommittedChangesForegroundColor\": \
   \"#928374\",\n\
  \    \"gitlens.decorations.worktreeMissingForegroundColor\": \"#cc241d\",\n\
  \    \"gitlens.graphChangesColumnAddedColor\": \"#98971a\",\n\
  \    \"gitlens.graphChangesColumnDeletedColor\": \"#cc241d\",\n\
  \    \"gitlens.graphLane10Color\": \"#98971a\",\n\
  \    \"gitlens.graphLane1Color\": \"#83a598\",\n\
  \    \"gitlens.graphLane2Color\": \"#458588\",\n\
  \    \"gitlens.graphLane3Color\": \"#d3869b\",\n\
  \    \"gitlens.graphLane4Color\": \"#b16286\",\n\
  \    \"gitlens.graphLane5Color\": \"#8ec07c\",\n\
  \    \"gitlens.graphLane6Color\": \"#689d6a\",\n\
  \    \"gitlens.graphLane7Color\": \"#fabd2f\",\n\
  \    \"gitlens.graphLane8Color\": \"#d79921\",\n\
  \    \"gitlens.graphLane9Color\": \"#b8bb26\",\n\
  \    \"gitlens.graphMinimapMarkerHeadColor\": \"#98971a\",\n\
  \    \"gitlens.graphMinimapMarkerHighlightsColor\": \"#b8bb26\",\n\
  \    \"gitlens.graphMinimapMarkerLocalBranchesColor\": \"#83a598\",\n\
  \    \"gitlens.graphMinimapMarkerPullRequestsColor\": \"#fe8019\",\n\
  \    \"gitlens.graphMinimapMarkerRemoteBranchesColor\": \"#458588\",\n\
  \    \"gitlens.graphMinimapMarkerStashesColor\": \"#b16286\",\n\
  \    \"gitlens.graphMinimapMarkerTagsColor\": \"#7c6f64\",\n\
  \    \"gitlens.graphMinimapMarkerUpstreamColor\": \"#689d6a\",\n\
  \    \"gitlens.graphScrollMarkerHeadColor\": \"#b8bb26\",\n\
  \    \"gitlens.graphScrollMarkerHighlightsColor\": \"#d79921\",\n\
  \    \"gitlens.graphScrollMarkerLocalBranchesColor\": \"#83a598\",\n\
  \    \"gitlens.graphScrollMarkerPullRequestsColor\": \"#fe8019\",\n\
  \    \"gitlens.graphScrollMarkerRemoteBranchesColor\": \"#458588\",\n\
  \    \"gitlens.graphScrollMarkerStashesColor\": \"#b16286\",\n\
  \    \"gitlens.graphScrollMarkerTagsColor\": \"#7c6f64\",\n\
  \    \"gitlens.graphScrollMarkerUpstreamColor\": \"#8ec07c\",\n\
  \    \"gitlens.gutterBackgroundColor\": \"#3c3836\",\n\
  \    \"gitlens.gutterForegroundColor\": \"#ebdbb2\",\n\
  \    \"gitlens.gutterUncommittedForegroundColor\": \"#458588\",\n\
  \    \"gitlens.launchpadIndicatorAttentionColor\": \"#fabd2f\",\n\
  \    \"gitlens.launchpadIndicatorAttentionHoverColor\": \"#d79921\",\n\
  \    \"gitlens.launchpadIndicatorBlockedColor\": \"#fb4934\",\n\
  \    \"gitlens.launchpadIndicatorBlockedHoverColor\": \"#cc241d\",\n\
  \    \"gitlens.launchpadIndicatorMergeableColor\": \"#b8bb26\",\n\
  \    \"gitlens.launchpadIndicatorMergeableHoverColor\": \"#98971a\",\n\
  \    \"gitlens.lineHighlightBackgroundColor\": \"#3c3836\",\n\
  \    \"gitlens.lineHighlightOverviewRulerColor\": \"#458588\",\n\
  \    \"gitlens.mergedPullRequestIconColor\": \"#b16286\",\n\
  \    \"gitlens.openAutolinkedIssueIconColor\": \"#98971a\",\n\
  \    \"gitlens.openPullRequestIconColor\": \"#98971a\",\n\
  \    \"gitlens.trailingLineBackgroundColor\": \"#282828a0\",\n\
  \    \"gitlens.trailingLineForegroundColor\": \"#928374a0\",\n\
  \    \"gitlens.unpublishedChangesIconColor\": \"#98971a\",\n\
  \    \"gitlens.unpublishedCommitIconColor\": \"#98971a\",\n\
  \    \"gitlens.unpulledChangesIconColor\": \"#fe8019\",\n\
  \    \"icon.foreground\": \"#ebdbb2\",\n\
  \    \"input.background\": \"#282828\",\n\
  \    \"input.border\": \"#3c3836\",\n\
  \    \"input.foreground\": \"#ebdbb2\",\n\
  \    \"input.placeholderForeground\": \"#ebdbb260\",\n\
  \    \"inputOption.activeBorder\": \"#ebdbb260\",\n\
  \    \"inputValidation.errorBackground\": \"#cc241d\",\n\
  \    \"inputValidation.errorBorder\": \"#fb4934\",\n\
  \    \"inputValidation.infoBackground\": \"#45858880\",\n\
  \    \"inputValidation.infoBorder\": \"#83a598\",\n\
  \    \"inputValidation.warningBackground\": \"#d79921\",\n\
  \    \"inputValidation.warningBorder\": \"#fabd2f\",\n\
  \    \"list.activeSelectionBackground\": \"#3c383680\",\n\
  \    \"list.activeSelectionForeground\": \"#8ec07c\",\n\
  \    \"list.dropBackground\": \"#3c3836\",\n\
  \    \"list.focusBackground\": \"#3c3836\",\n\
  \    \"list.focusForeground\": \"#ebdbb2\",\n\
  \    \"list.highlightForeground\": \"#689d6a\",\n\
  \    \"list.hoverBackground\": \"#3c383680\",\n\
  \    \"list.hoverForeground\": \"#d5c4a1\",\n\
  \    \"list.inactiveSelectionBackground\": \"#3c383680\",\n\
  \    \"list.inactiveSelectionForeground\": \"#689d6a\",\n\
  \    \"menu.border\": \"#3c3836\",\n\
  \    \"menu.separatorBackground\": \"#3c3836\",\n\
  \    \"merge.border\": \"#0000\",\n\
  \    \"merge.currentContentBackground\": \"#45858820\",\n\
  \    \"merge.currentHeaderBackground\": \"#45858840\",\n\
  \    \"merge.incomingContentBackground\": \"#689d6a20\",\n\
  \    \"merge.incomingHeaderBackground\": \"#689d6a40\",\n\
  \    \"notebook.cellBorderColor\": \"#504945\",\n\
  \    \"notebook.cellEditorBackground\": \"#3c3836\",\n\
  \    \"notebook.focusedCellBorder\": \"#a89984\",\n\
  \    \"notebook.focusedEditorBorder\": \"#504945\",\n\
  \    \"panel.border\": \"#3c3836\",\n\
  \    \"panelTitle.activeForeground\": \"#ebdbb2\",\n\
  \    \"peekView.border\": \"#3c3836\",\n\
  \    \"peekViewEditor.background\": \"#3c383670\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#504945\",\n\
  \    \"peekViewEditorGutter.background\": \"#3c383670\",\n\
  \    \"peekViewResult.background\": \"#3c383670\",\n\
  \    \"peekViewResult.fileForeground\": \"#ebdbb2\",\n\
  \    \"peekViewResult.lineForeground\": \"#ebdbb2\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#504945\",\n\
  \    \"peekViewResult.selectionBackground\": \"#45858820\",\n\
  \    \"peekViewResult.selectionForeground\": \"#ebdbb2\",\n\
  \    \"peekViewTitle.background\": \"#3c383670\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#bdae93\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#ebdbb2\",\n\
  \    \"progressBar.background\": \"#689d6a\",\n\
  \    \"scmGraph.historyItemHoverDefaultLabelForeground\": \"#ebdbb2\",\n\
  \    \"scmGraph.historyItemHoverLabelForeground\": \"#ebdbb2\",\n\
  \    \"scrollbar.shadow\": \"#282828\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#689d6a\",\n\
  \    \"scrollbarSlider.background\": \"#50494599\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#665c54\",\n\
  \    \"selection.background\": \"#689d6a80\",\n\
  \    \"sideBar.background\": \"#282828\",\n\
  \    \"sideBar.border\": \"#3c3836\",\n\
  \    \"sideBar.foreground\": \"#d5c4a1\",\n\
  \    \"sideBarSectionHeader.background\": \"#0000\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#ebdbb2\",\n\
  \    \"sideBarTitle.foreground\": \"#ebdbb2\",\n\
  \    \"statusBar.background\": \"#282828\",\n\
  \    \"statusBar.border\": \"#3c3836\",\n\
  \    \"statusBar.debuggingBackground\": \"#fe8019\",\n\
  \    \"statusBar.debuggingBorder\": \"#0000\",\n\
  \    \"statusBar.debuggingForeground\": \"#282828\",\n\
  \    \"statusBar.foreground\": \"#ebdbb2\",\n\
  \    \"statusBar.noFolderBackground\": \"#282828\",\n\
  \    \"statusBar.noFolderBorder\": \"#0000\",\n\
  \    \"tab.activeBackground\": \"#3c3836\",\n\
  \    \"tab.activeBorder\": \"#689d6a\",\n\
  \    \"tab.activeForeground\": \"#ebdbb2\",\n\
  \    \"tab.border\": \"#0000\",\n\
  \    \"tab.inactiveBackground\": \"#282828\",\n\
  \    \"tab.inactiveForeground\": \"#a89984\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#0000\",\n\
  \    \"tab.unfocusedActiveForeground\": \"#a89984\",\n\
  \    \"tab.unfocusedInactiveForeground\": \"#928374\",\n\
  \    \"terminal.ansiBlack\": \"#3c3836\",\n\
  \    \"terminal.ansiBlue\": \"#458588\",\n\
  \    \"terminal.ansiBrightBlack\": \"#928374\",\n\
  \    \"terminal.ansiBrightBlue\": \"#83a598\",\n\
  \    \"terminal.ansiBrightCyan\": \"#8ec07c\",\n\
  \    \"terminal.ansiBrightGreen\": \"#b8bb26\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#d3869b\",\n\
  \    \"terminal.ansiBrightRed\": \"#fb4934\",\n\
  \    \"terminal.ansiBrightWhite\": \"#ebdbb2\",\n\
  \    \"terminal.ansiBrightYellow\": \"#fabd2f\",\n\
  \    \"terminal.ansiCyan\": \"#689d6a\",\n\
  \    \"terminal.ansiGreen\": \"#98971a\",\n\
  \    \"terminal.ansiMagenta\": \"#b16286\",\n\
  \    \"terminal.ansiRed\": \"#cc241d\",\n\
  \    \"terminal.ansiWhite\": \"#a89984\",\n\
  \    \"terminal.ansiYellow\": \"#d79921\",\n\
  \    \"terminal.background\": \"#282828\",\n\
  \    \"terminal.foreground\": \"#ebdbb2\",\n\
  \    \"textLink.activeForeground\": \"#458588\",\n\
  \    \"textLink.foreground\": \"#83a598\",\n\
  \    \"titleBar.activeBackground\": \"#282828\",\n\
  \    \"titleBar.activeForeground\": \"#ebdbb2\",\n\
  \    \"titleBar.inactiveBackground\": \"#282828\",\n\
  \    \"widget.border\": \"#3c3836\",\n\
  \    \"widget.shadow\": \"#28282830\"\n\
  \  },\n\
  \  \"displayName\": \"Gruvbox Dark Medium\",\n\
  \  \"name\": \"gruvbox-dark-medium\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"component\": \"#fe8019\",\n\
  \    \"constant.builtin\": \"#d3869b\",\n\
  \    \"function\": \"#8ec07c\",\n\
  \    \"function.builtin\": \"#fe8019\",\n\
  \    \"method\": \"#8ec07c\",\n\
  \    \"parameter\": \"#83a598\",\n\
  \    \"property\": \"#83a598\",\n\
  \    \"property:python\": \"#ebdbb2\",\n\
  \    \"variable\": \"#ebdbb2\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"emphasis\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"strong\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"header\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#458588\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"punctuation.definition.comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#928374\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant\",\n\
  \        \"support.constant\",\n\
  \        \"variable.arguments\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.rgb-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag\",\n\
  \        \"punctuation.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"invalid\",\n\
  \        \"invalid.illegal\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#cc241d\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.deprecated\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b16286\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.header.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type\",\n\
  \        \"storage.modifier\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quasi\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.entity\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"object\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"module.node\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#689d6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.module\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.less\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d79921\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.new\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"metatag.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#689d6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.sha.git-rebase\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.type.name\",\n\
  \        \"meta.return.type\",\n\
  \        \"meta.return-type\",\n\
  \        \"meta.cast\",\n\
  \        \"meta.type.annotation\",\n\
  \        \"support.type\",\n\
  \        \"storage.type.cs\",\n\
  \        \"variable.class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.this\",\n\
  \        \"support.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name\",\n\
  \        \"entity.static\",\n\
  \        \"entity.name.class.static.function\",\n\
  \        \"entity.name.function\",\n\
  \        \"entity.name.class\",\n\
  \        \"entity.name.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.function\",\n\
  \        \"entity.name.function.static\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.function-call\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.builtin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.method\",\n\
  \        \"entity.name.method.function-call\",\n\
  \        \"entity.name.static.function-call\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#689d6a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"brace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d5c4a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.parameter.type.variable\",\n\
  \        \"variable.parameter\",\n\
  \        \"variable.name\",\n\
  \        \"variable.other\",\n\
  \        \"variable\",\n\
  \        \"string.constant.other.placeholder\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"prototype\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#a89984\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.quoted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.quasi\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"*url*\",\n\
  \        \"*link*\",\n\
  \        \"*uri*\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function.python\",\n\
  \        \"entity.name.function.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type.function.python\",\n\
  \        \"storage.modifier.declaration\",\n\
  \        \"storage.type.class.python\",\n\
  \        \"storage.type.string.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type.function.async.python\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.generic\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.arguments\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d5c4a1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.decorator\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.caps\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.logical\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.logical-expression\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.interpolated.dollar.shell\",\n\
  \        \"string.interpolated.backtick.shell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control.directive\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.C99\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.function.cs\",\n\
  \        \"entity.name.function.cs\",\n\
  \        \"entity.name.type.namespace.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.using.cs\",\n\
  \        \"entity.name.variable.field.cs\",\n\
  \        \"entity.name.variable.local.cs\",\n\
  \        \"variable.other.readwrite.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.this.cs\",\n\
  \        \"keyword.other.base.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.scope.prerequisites\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function.target\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.import.java\",\n\
  \        \"storage.modifier.package.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bdae93\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.import.java\",\n\
  \        \"keyword.other.package.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.annotation\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.documentation.javadoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.block.javadoc variable.parameter.java\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java variable.other.object\",\n\
  \        \"source.java variable.other.definition.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-parameters.lisp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.other.link.title.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\",\n\
  \        \"foreground\": \"#928374\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline.link\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.1.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.2.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.3.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.4.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.5.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"heading.6.markdown entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d65d0e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.punctuation.quote.beginning\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98971a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.punctuation.list.beginning\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.inline.raw\",\n\
  \        \"markup.fenced_code.block\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.quoted.double.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css meta.selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css support.function.transform\",\n\
  \        \"source.css support.function.timing-function\",\n\
  \        \"source.css support.function.misc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.property-value\",\n\
  \        \"constant.rgb-value\",\n\
  \        \"support.property-value.scss\",\n\
  \        \"constant.rgb-value.scss\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d65d0e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag.css\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html entity.name.tag\",\n\
  \        \"text.html punctuation.tag\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js variable.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts variable.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go storage.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go entity.name.import\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go keyword.package\",\n\
  \        \"source.go keyword.import\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go keyword.interface\",\n\
  \        \"source.go keyword.struct\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go entity.name.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebdbb2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.go entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.cucumber.table\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.reason string.double\",\n\
  \        \"source.reason string.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b8bb26\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.reason keyword.control.less\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.reason entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#83a598\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.reason support.property-value\",\n\
  \        \"source.reason entity.name.filename\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.powershell variable.other.member.powershell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.powershell support.function.powershell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fabd2f\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.powershell support.function.attribute.powershell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bdae93\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.powershell meta.hashtable.assignment.powershell \
   variable.other.readwrite.powershell\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.function.be.latex\",\n\
  \        \"support.function.general.tex\",\n\
  \        \"support.function.section.latex\",\n\
  \        \"support.function.textbf.latex\",\n\
  \        \"support.function.textit.latex\",\n\
  \        \"support.function.texttt.latex\",\n\
  \        \"support.function.emph.latex\",\n\
  \        \"support.function.url.latex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fb4934\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.math.block.tex\",\n\
  \        \"support.class.math.block.environment.latex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#fe8019\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.preamble.latex\",\n\
  \        \"keyword.control.include.latex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d3869b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.latex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8ec07c\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let kanagawa_wave =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.background\": \"#2A2A37\",\n\
  \    \"activityBar.foreground\": \"#DCD7BA\",\n\
  \    \"activityBarBadge.background\": \"#658594\",\n\
  \    \"activityBarBadge.foreground\": \"#DCD7BA\",\n\
  \    \"badge.background\": \"#2A2A37\",\n\
  \    \"button.background\": \"#2A2A37\",\n\
  \    \"button.foreground\": \"#C8C093\",\n\
  \    \"button.secondaryBackground\": \"#223249\",\n\
  \    \"button.secondaryForeground\": \"#DCD7BA\",\n\
  \    \"checkbox.border\": \"#223249\",\n\
  \    \"debugToolBar.background\": \"#16161D\",\n\
  \    \"descriptionForeground\": \"#DCD7BA\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#2B332880\",\n\
  \    \"dropdown.background\": \"#16161D\",\n\
  \    \"dropdown.border\": \"#16161D\",\n\
  \    \"editor.background\": \"#1F1F28\",\n\
  \    \"editor.findMatchBackground\": \"#2D4F67\",\n\
  \    \"editor.findMatchBorder\": \"#FF9E3B\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#2D4F6780\",\n\
  \    \"editor.foreground\": \"#DCD7BA\",\n\
  \    \"editor.lineHighlightBackground\": \"#363646\",\n\
  \    \"editor.selectionBackground\": \"#223249\",\n\
  \    \"editor.selectionHighlightBackground\": \"#36364680\",\n\
  \    \"editor.selectionHighlightBorder\": \"#54546D\",\n\
  \    \"editor.wordHighlightBackground\": \"#3636464D\",\n\
  \    \"editor.wordHighlightBorder\": \"#54546D\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#3636464D\",\n\
  \    \"editor.wordHighlightStrongBorder\": \"#54546D\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#957FB8\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#FFA066\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#7E9CD8\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#D27E99\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#E6C384\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#7AA89F\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#FF5D62\",\n\
  \    \"editorBracketMatch.background\": \"#16161D\",\n\
  \    \"editorBracketMatch.border\": \"#54546D\",\n\
  \    \"editorBracketPairGuide.activeBackground1\": \"#957FB8\",\n\
  \    \"editorBracketPairGuide.activeBackground2\": \"#FFA066\",\n\
  \    \"editorBracketPairGuide.activeBackground3\": \"#7E9CD8\",\n\
  \    \"editorBracketPairGuide.activeBackground4\": \"#D27E99\",\n\
  \    \"editorBracketPairGuide.activeBackground5\": \"#E6C384\",\n\
  \    \"editorBracketPairGuide.activeBackground6\": \"#7AA89F\",\n\
  \    \"editorCursor.background\": \"#1F1F28\",\n\
  \    \"editorCursor.foreground\": \"#DCD7BA\",\n\
  \    \"editorError.foreground\": \"#E82424\",\n\
  \    \"editorGroup.border\": \"#16161D\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#16161D\",\n\
  \    \"editorGutter.addedBackground\": \"#76946A\",\n\
  \    \"editorGutter.deletedBackground\": \"#C34043\",\n\
  \    \"editorGutter.modifiedBackground\": \"#DCA561\",\n\
  \    \"editorHoverWidget.background\": \"#1F1F28\",\n\
  \    \"editorHoverWidget.border\": \"#2A2A37\",\n\
  \    \"editorHoverWidget.highlightForeground\": \"#658594\",\n\
  \    \"editorIndentGuide.activeBackground1\": \"#363646\",\n\
  \    \"editorIndentGuide.background1\": \"#2A2A37\",\n\
  \    \"editorInlayHint.background\": \"#1F1F28\",\n\
  \    \"editorInlayHint.foreground\": \"#727169\",\n\
  \    \"editorLineNumber.activeForeground\": \"#FFA066\",\n\
  \    \"editorLineNumber.foreground\": \"#54546D\",\n\
  \    \"editorMarkerNavigation.background\": \"#363646\",\n\
  \    \"editorRuler.foreground\": \"#363646\",\n\
  \    \"editorSuggestWidget.background\": \"#223249\",\n\
  \    \"editorSuggestWidget.border\": \"#223249\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#2D4F67\",\n\
  \    \"editorWarning.foreground\": \"#FF9E3B\",\n\
  \    \"editorWhitespace.foreground\": \"#1F1F28\",\n\
  \    \"editorWidget.background\": \"#1F1F28\",\n\
  \    \"focusBorder\": \"#223249\",\n\
  \    \"foreground\": \"#DCD7BA\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#727169\",\n\
  \    \"input.background\": \"#16161D\",\n\
  \    \"list.activeSelectionBackground\": \"#363646\",\n\
  \    \"list.activeSelectionForeground\": \"#DCD7BA\",\n\
  \    \"list.focusBackground\": \"#2A2A37\",\n\
  \    \"list.focusForeground\": \"#DCD7BA\",\n\
  \    \"list.highlightForeground\": \"#7E9CD8\",\n\
  \    \"list.hoverBackground\": \"#363646\",\n\
  \    \"list.hoverForeground\": \"#DCD7BA\",\n\
  \    \"list.inactiveSelectionBackground\": \"#2A2A37\",\n\
  \    \"list.inactiveSelectionForeground\": \"#DCD7BA\",\n\
  \    \"list.warningForeground\": \"#FF9E3B\",\n\
  \    \"menu.background\": \"#363646\",\n\
  \    \"menu.border\": \"#16161D\",\n\
  \    \"menu.foreground\": \"#DCD7BA\",\n\
  \    \"menu.selectionBackground\": \"#16161D\",\n\
  \    \"menu.selectionForeground\": \"#DCD7BA\",\n\
  \    \"menu.separatorBackground\": \"#54546D\",\n\
  \    \"menubar.selectionBackground\": \"#16161D\",\n\
  \    \"menubar.selectionForeground\": \"#DCD7BA\",\n\
  \    \"minimapGutter.addedBackground\": \"#76946A\",\n\
  \    \"minimapGutter.deletedBackground\": \"#C34043\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#DCA561\",\n\
  \    \"panel.border\": \"#16161D\",\n\
  \    \"panelSectionHeader.background\": \"#1F1F28\",\n\
  \    \"peekView.border\": \"#54546D\",\n\
  \    \"peekViewEditor.background\": \"#2A2A37\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#2D4F67\",\n\
  \    \"peekViewResult.background\": \"#363646\",\n\
  \    \"scrollbar.shadow\": \"#363646\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#2A2A3780\",\n\
  \    \"scrollbarSlider.background\": \"#54546D66\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#54546D80\",\n\
  \    \"settings.focusedRowBackground\": \"#363646\",\n\
  \    \"settings.headerForeground\": \"#DCD7BA\",\n\
  \    \"sideBar.background\": \"#1F1F28\",\n\
  \    \"sideBar.border\": \"#16161D\",\n\
  \    \"sideBar.foreground\": \"#DCD7BA\",\n\
  \    \"sideBarSectionHeader.background\": \"#363646\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#DCD7BA\",\n\
  \    \"statusBar.background\": \"#16161D\",\n\
  \    \"statusBar.debuggingBackground\": \"#E82424\",\n\
  \    \"statusBar.debuggingBorder\": \"#957FB8\",\n\
  \    \"statusBar.debuggingForeground\": \"#DCD7BA\",\n\
  \    \"statusBar.foreground\": \"#C8C093\",\n\
  \    \"statusBar.noFolderBackground\": \"#1F1F28\",\n\
  \    \"statusBarItem.hoverBackground\": \"#363646\",\n\
  \    \"statusBarItem.remoteBackground\": \"#2D4F67\",\n\
  \    \"statusBarItem.remoteForeground\": \"#DCD7BA\",\n\
  \    \"tab.activeBackground\": \"#2A2A37\",\n\
  \    \"tab.activeForeground\": \"#7E9CD8\",\n\
  \    \"tab.border\": \"#2A2A37\",\n\
  \    \"tab.hoverBackground\": \"#363646\",\n\
  \    \"tab.inactiveBackground\": \"#1A1A22\",\n\
  \    \"tab.unfocusedHoverBackground\": \"#1F1F28\",\n\
  \    \"terminal.ansiBlack\": \"#16161D\",\n\
  \    \"terminal.ansiBlue\": \"#7E9CD8\",\n\
  \    \"terminal.ansiBrightBlack\": \"#727169\",\n\
  \    \"terminal.ansiBrightBlue\": \"#7FB4CA\",\n\
  \    \"terminal.ansiBrightCyan\": \"#7AA89F\",\n\
  \    \"terminal.ansiBrightGreen\": \"#98BB6C\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#938AA9\",\n\
  \    \"terminal.ansiBrightRed\": \"#E82424\",\n\
  \    \"terminal.ansiBrightWhite\": \"#DCD7BA\",\n\
  \    \"terminal.ansiBrightYellow\": \"#E6C384\",\n\
  \    \"terminal.ansiCyan\": \"#6A9589\",\n\
  \    \"terminal.ansiGreen\": \"#76946A\",\n\
  \    \"terminal.ansiMagenta\": \"#957FB8\",\n\
  \    \"terminal.ansiRed\": \"#C34043\",\n\
  \    \"terminal.ansiWhite\": \"#C8C093\",\n\
  \    \"terminal.ansiYellow\": \"#C0A36E\",\n\
  \    \"terminal.background\": \"#1F1F28\",\n\
  \    \"terminal.border\": \"#16161D\",\n\
  \    \"terminal.foreground\": \"#DCD7BA\",\n\
  \    \"terminal.selectionBackground\": \"#223249\",\n\
  \    \"textBlockQuote.background\": \"#1F1F28\",\n\
  \    \"textBlockQuote.border\": \"#16161D\",\n\
  \    \"textLink.foreground\": \"#6A9589\",\n\
  \    \"textPreformat.foreground\": \"#FF9E3B\",\n\
  \    \"titleBar.activeBackground\": \"#363646\",\n\
  \    \"titleBar.activeForeground\": \"#DCD7BA\",\n\
  \    \"titleBar.inactiveBackground\": \"#1F1F28\",\n\
  \    \"titleBar.inactiveForeground\": \"#DCD7BA\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#1F1F28\"\n\
  \  },\n\
  \  \"displayName\": \"Kanagawa Wave\",\n\
  \  \"name\": \"kanagawa-wave\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"arithmetic\": \"#C0A36E\",\n\
  \    \"function\": \"#7E9CD8\",\n\
  \    \"keyword.controlFlow\": {\n\
  \      \"fontStyle\": \"bold\",\n\
  \      \"foreground\": \"#957FB8\"\n\
  \    },\n\
  \    \"macro\": \"#E46876\",\n\
  \    \"method\": \"#7FB4CA\",\n\
  \    \"operator\": \"#C0A36E\",\n\
  \    \"parameter\": \"#B8B4D0\",\n\
  \    \"parameter.declaration\": \"#B8B4D0\",\n\
  \    \"parameter.definition\": \"#B8B4D0\",\n\
  \    \"variable\": \"#DCD7BA\",\n\
  \    \"variable.readonly\": \"#DCD7BA\",\n\
  \    \"variable.readonly.defaultLibrary\": \"#DCD7BA\",\n\
  \    \"variable.readonly.local\": \"#DCD7BA\"\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"comment\",\n\
  \        \"punctuation.definition.comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#727169\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable\",\n\
  \        \"string constant.other.placeholder\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.color\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"invalid\",\n\
  \        \"invalid.illegal\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E82424\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.flow\",\n\
  \        \"keyword.control.conditional\",\n\
  \        \"keyword.control.loop\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control\",\n\
  \        \"constant.other.color\",\n\
  \        \"meta.tag\",\n\
  \        \"keyword.other.template\",\n\
  \        \"keyword.other.substitution\",\n\
  \        \"keyword.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.definition.ini\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.trycatch\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#FF5D62\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.unit\",\n\
  \        \"keyword.operator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation\",\n\
  \        \"punctuation.definition.tag\",\n\
  \        \"punctuation.separator.inheritance.php\",\n\
  \        \"punctuation.definition.tag.html\",\n\
  \        \"punctuation.definition.tag.begin.html\",\n\
  \        \"punctuation.definition.tag.end.html\",\n\
  \        \"punctuation.section.embedded\",\n\
  \        \"meta.brace\",\n\
  \        \"keyword.operator.type.annotation\",\n\
  \        \"keyword.operator.namespace\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#9CABCA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.tag\",\n\
  \        \"meta.tag.sgml\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"meta.function-call\",\n\
  \        \"variable.function\",\n\
  \        \"support.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7E9CD8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.special-method\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.macro\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E46876\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.block variable.other\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.enummember\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.other.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.other.link\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\",\n\
  \        \"constant.language\",\n\
  \        \"support.constant\",\n\
  \        \"constant.character\",\n\
  \        \"constant.escape\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.boolean\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D27E99\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string\",\n\
  \        \"punctuation.definition.string\",\n\
  \        \"constant.other.symbol\",\n\
  \        \"constant.other.key\",\n\
  \        \"entity.other.inherited-class\",\n\
  \        \"markup.heading\",\n\
  \        \"markup.inserted.git_gutter\",\n\
  \        \"meta.group.braces.curly constant.other.object.key.js \
   string.unquoted.label.js\",\n\
  \        \"markup.inline.raw.string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98BB6C\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name\",\n\
  \        \"support.type\",\n\
  \        \"support.class\",\n\
  \        \"support.other.namespace.use.php\",\n\
  \        \"meta.use.php\",\n\
  \        \"support.other.namespace.php\",\n\
  \        \"support.type.sys-types\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7AA89F\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.type.module\",\n\
  \        \"entity.name.namespace\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.import.go\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98BB6C\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.blade\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.property\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.import\",\n\
  \        \"keyword.import\",\n\
  \        \"meta.import\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css support.type.property-name\",\n\
  \        \"source.sass support.type.property-name\",\n\
  \        \"source.scss support.type.property-name\",\n\
  \        \"source.less support.type.property-name\",\n\
  \        \"source.stylus support.type.property-name\",\n\
  \        \"source.postcss support.type.property-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7AA89F\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.module.js\",\n\
  \        \"variable.import.parameter.js\",\n\
  \        \"variable.other.class.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FF5D62\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FF5D62\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.method.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.class-method.js entity.name.function.js\",\n\
  \        \"variable.function.constructor\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.sass keyword.control\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.inserted\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#76946A\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.deleted\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#C34043\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.changed\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCA561\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#C0A36E\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.escape\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"*url*\",\n\
  \        \"*link*\",\n\
  \        \"*uri*\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"tag.decorator.js entity.name.tag.js\",\n\
  \        \"tag.decorator.js punctuation.definition.tag.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js constant.other.object.key.js string.unquoted.label.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FF5D62\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D27E99\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FF5D62\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7E9CD8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D27E99\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   meta.structure.dictionary.value.json meta.structure.dictionary.json \
   support.type.property-name.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98BB6C\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.tag JSXNested\",\n\
  \        \"meta.jsx.children\",\n\
  \        \"text.html\",\n\
  \        \"text.log\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown\",\n\
  \        \"punctuation.definition.list_item.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown markup.inline.raw.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown markup.inline.raw.markdown \
   punctuation.definition.raw.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markdown.heading\",\n\
  \        \"entity.name.section.markdown\",\n\
  \        \"markup.heading.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7E9CD8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.italic\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#E46876\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.bold\",\n\
  \        \"markup.bold string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.bold markup.italic\",\n\
  \        \"markup.italic markup.bold\",\n\
  \        \"markup.quote markup.bold\",\n\
  \        \"markup.bold markup.italic string\",\n\
  \        \"markup.italic markup.bold string\",\n\
  \        \"markup.quote markup.bold string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#E46876\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.underline\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\",\n\
  \        \"foreground\": \"#7FB4CA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.quote punctuation.definition.blockquote.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#727169\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.quote\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.other.link.title.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#FFA066\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.other.link.description.title.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.reference.link.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#E6C384\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.raw.block\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#957FB8\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.raw.block.fenced.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#727169\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.fenced.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#727169\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.raw.block.fenced.markdown\",\n\
  \        \"variable.language.fenced.markdown\",\n\
  \        \"punctuation.section.class.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.language.fenced.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#727169\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.separator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#9CABCA\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"markup.table\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#DCD7BA\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let nord =
  "{\n\
  \  \"colors\": {\n\
  \    \"activityBar.activeBackground\": \"#3b4252\",\n\
  \    \"activityBar.activeBorder\": \"#88c0d0\",\n\
  \    \"activityBar.background\": \"#2e3440\",\n\
  \    \"activityBar.dropBackground\": \"#3b4252\",\n\
  \    \"activityBar.foreground\": \"#d8dee9\",\n\
  \    \"activityBarBadge.background\": \"#88c0d0\",\n\
  \    \"activityBarBadge.foreground\": \"#2e3440\",\n\
  \    \"badge.background\": \"#88c0d0\",\n\
  \    \"badge.foreground\": \"#2e3440\",\n\
  \    \"button.background\": \"#88c0d0ee\",\n\
  \    \"button.foreground\": \"#2e3440\",\n\
  \    \"button.hoverBackground\": \"#88c0d0\",\n\
  \    \"button.secondaryBackground\": \"#434c5e\",\n\
  \    \"button.secondaryForeground\": \"#d8dee9\",\n\
  \    \"button.secondaryHoverBackground\": \"#4c566a\",\n\
  \    \"charts.blue\": \"#81a1c1\",\n\
  \    \"charts.foreground\": \"#d8dee9\",\n\
  \    \"charts.green\": \"#a3be8c\",\n\
  \    \"charts.lines\": \"#88c0d0\",\n\
  \    \"charts.orange\": \"#d08770\",\n\
  \    \"charts.purple\": \"#b48ead\",\n\
  \    \"charts.red\": \"#bf616a\",\n\
  \    \"charts.yellow\": \"#ebcb8b\",\n\
  \    \"debugConsole.errorForeground\": \"#bf616a\",\n\
  \    \"debugConsole.infoForeground\": \"#88c0d0\",\n\
  \    \"debugConsole.sourceForeground\": \"#616e88\",\n\
  \    \"debugConsole.warningForeground\": \"#ebcb8b\",\n\
  \    \"debugConsoleInputIcon.foreground\": \"#81a1c1\",\n\
  \    \"debugExceptionWidget.background\": \"#4c566a\",\n\
  \    \"debugExceptionWidget.border\": \"#2e3440\",\n\
  \    \"debugToolBar.background\": \"#3b4252\",\n\
  \    \"descriptionForeground\": \"#d8dee9e6\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#81a1c133\",\n\
  \    \"diffEditor.removedTextBackground\": \"#bf616a4d\",\n\
  \    \"dropdown.background\": \"#3b4252\",\n\
  \    \"dropdown.border\": \"#3b4252\",\n\
  \    \"dropdown.foreground\": \"#d8dee9\",\n\
  \    \"editor.background\": \"#2e3440\",\n\
  \    \"editor.findMatchBackground\": \"#88c0d066\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#88c0d033\",\n\
  \    \"editor.findRangeHighlightBackground\": \"#88c0d033\",\n\
  \    \"editor.focusedStackFrameHighlightBackground\": \"#5e81ac\",\n\
  \    \"editor.foreground\": \"#d8dee9\",\n\
  \    \"editor.hoverHighlightBackground\": \"#3b4252\",\n\
  \    \"editor.inactiveSelectionBackground\": \"#434c5ecc\",\n\
  \    \"editor.inlineValuesBackground\": \"#4c566a\",\n\
  \    \"editor.inlineValuesForeground\": \"#eceff4\",\n\
  \    \"editor.lineHighlightBackground\": \"#3b4252\",\n\
  \    \"editor.lineHighlightBorder\": \"#3b4252\",\n\
  \    \"editor.rangeHighlightBackground\": \"#434c5e52\",\n\
  \    \"editor.selectionBackground\": \"#434c5ecc\",\n\
  \    \"editor.selectionHighlightBackground\": \"#434c5ecc\",\n\
  \    \"editor.stackFrameHighlightBackground\": \"#5e81ac\",\n\
  \    \"editor.wordHighlightBackground\": \"#81a1c166\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#81a1c199\",\n\
  \    \"editorActiveLineNumber.foreground\": \"#d8dee9cc\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#8fbcbb\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#88c0d0\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#81a1c1\",\n\
  \    \"editorBracketHighlight.foreground4\": \"#5e81ac\",\n\
  \    \"editorBracketHighlight.foreground5\": \"#8fbcbb\",\n\
  \    \"editorBracketHighlight.foreground6\": \"#88c0d0\",\n\
  \    \"editorBracketHighlight.unexpectedBracket.foreground\": \"#bf616a\",\n\
  \    \"editorBracketMatch.background\": \"#2e344000\",\n\
  \    \"editorBracketMatch.border\": \"#88c0d0\",\n\
  \    \"editorCodeLens.foreground\": \"#4c566a\",\n\
  \    \"editorCursor.foreground\": \"#d8dee9\",\n\
  \    \"editorError.border\": \"#bf616a00\",\n\
  \    \"editorError.foreground\": \"#bf616a\",\n\
  \    \"editorGroup.background\": \"#2e3440\",\n\
  \    \"editorGroup.border\": \"#3b425201\",\n\
  \    \"editorGroup.dropBackground\": \"#3b425299\",\n\
  \    \"editorGroupHeader.border\": \"#3b425200\",\n\
  \    \"editorGroupHeader.noTabsBackground\": \"#2e3440\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#2e3440\",\n\
  \    \"editorGroupHeader.tabsBorder\": \"#3b425200\",\n\
  \    \"editorGutter.addedBackground\": \"#a3be8c\",\n\
  \    \"editorGutter.background\": \"#2e3440\",\n\
  \    \"editorGutter.deletedBackground\": \"#bf616a\",\n\
  \    \"editorGutter.modifiedBackground\": \"#ebcb8b\",\n\
  \    \"editorHint.border\": \"#ebcb8b00\",\n\
  \    \"editorHint.foreground\": \"#ebcb8b\",\n\
  \    \"editorHoverWidget.background\": \"#3b4252\",\n\
  \    \"editorHoverWidget.border\": \"#3b4252\",\n\
  \    \"editorIndentGuide.activeBackground\": \"#4c566a\",\n\
  \    \"editorIndentGuide.background\": \"#434c5eb3\",\n\
  \    \"editorInlayHint.background\": \"#434c5e\",\n\
  \    \"editorInlayHint.foreground\": \"#d8dee9\",\n\
  \    \"editorLineNumber.activeForeground\": \"#d8dee9\",\n\
  \    \"editorLineNumber.foreground\": \"#4c566a\",\n\
  \    \"editorLink.activeForeground\": \"#88c0d0\",\n\
  \    \"editorMarkerNavigation.background\": \"#5e81acc0\",\n\
  \    \"editorMarkerNavigationError.background\": \"#bf616ac0\",\n\
  \    \"editorMarkerNavigationWarning.background\": \"#ebcb8bc0\",\n\
  \    \"editorOverviewRuler.addedForeground\": \"#a3be8c\",\n\
  \    \"editorOverviewRuler.border\": \"#3b4252\",\n\
  \    \"editorOverviewRuler.currentContentForeground\": \"#3b4252\",\n\
  \    \"editorOverviewRuler.deletedForeground\": \"#bf616a\",\n\
  \    \"editorOverviewRuler.errorForeground\": \"#bf616a\",\n\
  \    \"editorOverviewRuler.findMatchForeground\": \"#88c0d066\",\n\
  \    \"editorOverviewRuler.incomingContentForeground\": \"#3b4252\",\n\
  \    \"editorOverviewRuler.infoForeground\": \"#81a1c1\",\n\
  \    \"editorOverviewRuler.modifiedForeground\": \"#ebcb8b\",\n\
  \    \"editorOverviewRuler.rangeHighlightForeground\": \"#88c0d066\",\n\
  \    \"editorOverviewRuler.selectionHighlightForeground\": \"#88c0d066\",\n\
  \    \"editorOverviewRuler.warningForeground\": \"#ebcb8b\",\n\
  \    \"editorOverviewRuler.wordHighlightForeground\": \"#88c0d066\",\n\
  \    \"editorOverviewRuler.wordHighlightStrongForeground\": \"#88c0d066\",\n\
  \    \"editorRuler.foreground\": \"#434c5e\",\n\
  \    \"editorSuggestWidget.background\": \"#2e3440\",\n\
  \    \"editorSuggestWidget.border\": \"#3b4252\",\n\
  \    \"editorSuggestWidget.focusHighlightForeground\": \"#88c0d0\",\n\
  \    \"editorSuggestWidget.foreground\": \"#d8dee9\",\n\
  \    \"editorSuggestWidget.highlightForeground\": \"#88c0d0\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#434c5e\",\n\
  \    \"editorSuggestWidget.selectedForeground\": \"#d8dee9\",\n\
  \    \"editorWarning.border\": \"#ebcb8b00\",\n\
  \    \"editorWarning.foreground\": \"#ebcb8b\",\n\
  \    \"editorWhitespace.foreground\": \"#4c566ab3\",\n\
  \    \"editorWidget.background\": \"#2e3440\",\n\
  \    \"editorWidget.border\": \"#3b4252\",\n\
  \    \"errorForeground\": \"#bf616a\",\n\
  \    \"extensionButton.prominentBackground\": \"#434c5e\",\n\
  \    \"extensionButton.prominentForeground\": \"#d8dee9\",\n\
  \    \"extensionButton.prominentHoverBackground\": \"#4c566a\",\n\
  \    \"focusBorder\": \"#3b4252\",\n\
  \    \"foreground\": \"#d8dee9\",\n\
  \    \"gitDecoration.conflictingResourceForeground\": \"#5e81ac\",\n\
  \    \"gitDecoration.deletedResourceForeground\": \"#bf616a\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#d8dee966\",\n\
  \    \"gitDecoration.modifiedResourceForeground\": \"#ebcb8b\",\n\
  \    \"gitDecoration.stageDeletedResourceForeground\": \"#bf616a\",\n\
  \    \"gitDecoration.stageModifiedResourceForeground\": \"#ebcb8b\",\n\
  \    \"gitDecoration.submoduleResourceForeground\": \"#8fbcbb\",\n\
  \    \"gitDecoration.untrackedResourceForeground\": \"#a3be8c\",\n\
  \    \"input.background\": \"#3b4252\",\n\
  \    \"input.border\": \"#3b4252\",\n\
  \    \"input.foreground\": \"#d8dee9\",\n\
  \    \"input.placeholderForeground\": \"#d8dee999\",\n\
  \    \"inputOption.activeBackground\": \"#5e81ac\",\n\
  \    \"inputOption.activeBorder\": \"#5e81ac\",\n\
  \    \"inputOption.activeForeground\": \"#eceff4\",\n\
  \    \"inputValidation.errorBackground\": \"#bf616a\",\n\
  \    \"inputValidation.errorBorder\": \"#bf616a\",\n\
  \    \"inputValidation.infoBackground\": \"#81a1c1\",\n\
  \    \"inputValidation.infoBorder\": \"#81a1c1\",\n\
  \    \"inputValidation.warningBackground\": \"#d08770\",\n\
  \    \"inputValidation.warningBorder\": \"#d08770\",\n\
  \    \"keybindingLabel.background\": \"#4c566a\",\n\
  \    \"keybindingLabel.border\": \"#4c566a\",\n\
  \    \"keybindingLabel.bottomBorder\": \"#4c566a\",\n\
  \    \"keybindingLabel.foreground\": \"#d8dee9\",\n\
  \    \"list.activeSelectionBackground\": \"#88c0d0\",\n\
  \    \"list.activeSelectionForeground\": \"#2e3440\",\n\
  \    \"list.dropBackground\": \"#88c0d099\",\n\
  \    \"list.errorForeground\": \"#bf616a\",\n\
  \    \"list.focusBackground\": \"#88c0d099\",\n\
  \    \"list.focusForeground\": \"#d8dee9\",\n\
  \    \"list.focusHighlightForeground\": \"#eceff4\",\n\
  \    \"list.highlightForeground\": \"#88c0d0\",\n\
  \    \"list.hoverBackground\": \"#3b4252\",\n\
  \    \"list.hoverForeground\": \"#eceff4\",\n\
  \    \"list.inactiveFocusBackground\": \"#434c5ecc\",\n\
  \    \"list.inactiveSelectionBackground\": \"#434c5e\",\n\
  \    \"list.inactiveSelectionForeground\": \"#d8dee9\",\n\
  \    \"list.warningForeground\": \"#ebcb8b\",\n\
  \    \"merge.border\": \"#3b425200\",\n\
  \    \"merge.currentContentBackground\": \"#81a1c14d\",\n\
  \    \"merge.currentHeaderBackground\": \"#81a1c166\",\n\
  \    \"merge.incomingContentBackground\": \"#8fbcbb4d\",\n\
  \    \"merge.incomingHeaderBackground\": \"#8fbcbb66\",\n\
  \    \"minimap.background\": \"#2e3440\",\n\
  \    \"minimap.errorHighlight\": \"#bf616acc\",\n\
  \    \"minimap.findMatchHighlight\": \"#88c0d0\",\n\
  \    \"minimap.selectionHighlight\": \"#88c0d0cc\",\n\
  \    \"minimap.warningHighlight\": \"#ebcb8bcc\",\n\
  \    \"minimapGutter.addedBackground\": \"#a3be8c\",\n\
  \    \"minimapGutter.deletedBackground\": \"#bf616a\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#ebcb8b\",\n\
  \    \"minimapSlider.activeBackground\": \"#434c5eaa\",\n\
  \    \"minimapSlider.background\": \"#434c5e99\",\n\
  \    \"minimapSlider.hoverBackground\": \"#434c5eaa\",\n\
  \    \"notification.background\": \"#3b4252\",\n\
  \    \"notification.buttonBackground\": \"#434c5e\",\n\
  \    \"notification.buttonForeground\": \"#d8dee9\",\n\
  \    \"notification.buttonHoverBackground\": \"#4c566a\",\n\
  \    \"notification.errorBackground\": \"#bf616a\",\n\
  \    \"notification.errorForeground\": \"#2e3440\",\n\
  \    \"notification.foreground\": \"#d8dee9\",\n\
  \    \"notification.infoBackground\": \"#88c0d0\",\n\
  \    \"notification.infoForeground\": \"#2e3440\",\n\
  \    \"notification.warningBackground\": \"#ebcb8b\",\n\
  \    \"notification.warningForeground\": \"#2e3440\",\n\
  \    \"notificationCenter.border\": \"#3b425200\",\n\
  \    \"notificationCenterHeader.background\": \"#2e3440\",\n\
  \    \"notificationCenterHeader.foreground\": \"#88c0d0\",\n\
  \    \"notificationLink.foreground\": \"#88c0d0\",\n\
  \    \"notificationToast.border\": \"#3b425200\",\n\
  \    \"notifications.background\": \"#3b4252\",\n\
  \    \"notifications.border\": \"#2e3440\",\n\
  \    \"notifications.foreground\": \"#d8dee9\",\n\
  \    \"panel.background\": \"#2e3440\",\n\
  \    \"panel.border\": \"#3b4252\",\n\
  \    \"panelTitle.activeBorder\": \"#88c0d000\",\n\
  \    \"panelTitle.activeForeground\": \"#88c0d0\",\n\
  \    \"panelTitle.inactiveForeground\": \"#d8dee9\",\n\
  \    \"peekView.border\": \"#4c566a\",\n\
  \    \"peekViewEditor.background\": \"#2e3440\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#88c0d04d\",\n\
  \    \"peekViewEditorGutter.background\": \"#2e3440\",\n\
  \    \"peekViewResult.background\": \"#2e3440\",\n\
  \    \"peekViewResult.fileForeground\": \"#88c0d0\",\n\
  \    \"peekViewResult.lineForeground\": \"#d8dee966\",\n\
  \    \"peekViewResult.matchHighlightBackground\": \"#88c0d0cc\",\n\
  \    \"peekViewResult.selectionBackground\": \"#434c5e\",\n\
  \    \"peekViewResult.selectionForeground\": \"#d8dee9\",\n\
  \    \"peekViewTitle.background\": \"#3b4252\",\n\
  \    \"peekViewTitleDescription.foreground\": \"#d8dee9\",\n\
  \    \"peekViewTitleLabel.foreground\": \"#88c0d0\",\n\
  \    \"pickerGroup.border\": \"#3b4252\",\n\
  \    \"pickerGroup.foreground\": \"#88c0d0\",\n\
  \    \"progressBar.background\": \"#88c0d0\",\n\
  \    \"quickInputList.focusBackground\": \"#88c0d0\",\n\
  \    \"quickInputList.focusForeground\": \"#2e3440\",\n\
  \    \"sash.hoverBorder\": \"#88c0d0\",\n\
  \    \"scrollbar.shadow\": \"#00000066\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#434c5eaa\",\n\
  \    \"scrollbarSlider.background\": \"#434c5e99\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#434c5eaa\",\n\
  \    \"selection.background\": \"#88c0d099\",\n\
  \    \"sideBar.background\": \"#2e3440\",\n\
  \    \"sideBar.border\": \"#3b4252\",\n\
  \    \"sideBar.foreground\": \"#d8dee9\",\n\
  \    \"sideBarSectionHeader.background\": \"#3b4252\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#d8dee9\",\n\
  \    \"sideBarTitle.foreground\": \"#d8dee9\",\n\
  \    \"statusBar.background\": \"#3b4252\",\n\
  \    \"statusBar.border\": \"#3b425200\",\n\
  \    \"statusBar.debuggingBackground\": \"#5e81ac\",\n\
  \    \"statusBar.debuggingForeground\": \"#d8dee9\",\n\
  \    \"statusBar.foreground\": \"#d8dee9\",\n\
  \    \"statusBar.noFolderBackground\": \"#3b4252\",\n\
  \    \"statusBar.noFolderForeground\": \"#d8dee9\",\n\
  \    \"statusBarItem.activeBackground\": \"#4c566a\",\n\
  \    \"statusBarItem.errorBackground\": \"#3b4252\",\n\
  \    \"statusBarItem.errorForeground\": \"#bf616a\",\n\
  \    \"statusBarItem.hoverBackground\": \"#434c5e\",\n\
  \    \"statusBarItem.prominentBackground\": \"#3b4252\",\n\
  \    \"statusBarItem.prominentHoverBackground\": \"#434c5e\",\n\
  \    \"statusBarItem.warningBackground\": \"#ebcb8b\",\n\
  \    \"statusBarItem.warningForeground\": \"#2e3440\",\n\
  \    \"tab.activeBackground\": \"#3b4252\",\n\
  \    \"tab.activeBorder\": \"#88c0d000\",\n\
  \    \"tab.activeBorderTop\": \"#88c0d000\",\n\
  \    \"tab.activeForeground\": \"#d8dee9\",\n\
  \    \"tab.border\": \"#3b425200\",\n\
  \    \"tab.hoverBackground\": \"#3b4252cc\",\n\
  \    \"tab.hoverBorder\": \"#88c0d000\",\n\
  \    \"tab.inactiveBackground\": \"#2e3440\",\n\
  \    \"tab.inactiveForeground\": \"#d8dee966\",\n\
  \    \"tab.lastPinnedBorder\": \"#4c566a\",\n\
  \    \"tab.unfocusedActiveBorder\": \"#88c0d000\",\n\
  \    \"tab.unfocusedActiveBorderTop\": \"#88c0d000\",\n\
  \    \"tab.unfocusedActiveForeground\": \"#d8dee999\",\n\
  \    \"tab.unfocusedHoverBackground\": \"#3b4252b3\",\n\
  \    \"tab.unfocusedHoverBorder\": \"#88c0d000\",\n\
  \    \"tab.unfocusedInactiveForeground\": \"#d8dee966\",\n\
  \    \"terminal.ansiBlack\": \"#3b4252\",\n\
  \    \"terminal.ansiBlue\": \"#81a1c1\",\n\
  \    \"terminal.ansiBrightBlack\": \"#4c566a\",\n\
  \    \"terminal.ansiBrightBlue\": \"#81a1c1\",\n\
  \    \"terminal.ansiBrightCyan\": \"#8fbcbb\",\n\
  \    \"terminal.ansiBrightGreen\": \"#a3be8c\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#b48ead\",\n\
  \    \"terminal.ansiBrightRed\": \"#bf616a\",\n\
  \    \"terminal.ansiBrightWhite\": \"#eceff4\",\n\
  \    \"terminal.ansiBrightYellow\": \"#ebcb8b\",\n\
  \    \"terminal.ansiCyan\": \"#88c0d0\",\n\
  \    \"terminal.ansiGreen\": \"#a3be8c\",\n\
  \    \"terminal.ansiMagenta\": \"#b48ead\",\n\
  \    \"terminal.ansiRed\": \"#bf616a\",\n\
  \    \"terminal.ansiWhite\": \"#e5e9f0\",\n\
  \    \"terminal.ansiYellow\": \"#ebcb8b\",\n\
  \    \"terminal.background\": \"#2e3440\",\n\
  \    \"terminal.foreground\": \"#d8dee9\",\n\
  \    \"terminal.tab.activeBorder\": \"#88c0d0\",\n\
  \    \"textBlockQuote.background\": \"#3b4252\",\n\
  \    \"textBlockQuote.border\": \"#81a1c1\",\n\
  \    \"textCodeBlock.background\": \"#4c566a\",\n\
  \    \"textLink.activeForeground\": \"#88c0d0\",\n\
  \    \"textLink.foreground\": \"#88c0d0\",\n\
  \    \"textPreformat.foreground\": \"#8fbcbb\",\n\
  \    \"textSeparator.foreground\": \"#eceff4\",\n\
  \    \"titleBar.activeBackground\": \"#2e3440\",\n\
  \    \"titleBar.activeForeground\": \"#d8dee9\",\n\
  \    \"titleBar.border\": \"#2e344000\",\n\
  \    \"titleBar.inactiveBackground\": \"#2e3440\",\n\
  \    \"titleBar.inactiveForeground\": \"#d8dee966\",\n\
  \    \"tree.indentGuidesStroke\": \"#616e88\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#2e3440\",\n\
  \    \"welcomePage.buttonBackground\": \"#434c5e\",\n\
  \    \"welcomePage.buttonHoverBackground\": \"#4c566a\",\n\
  \    \"widget.shadow\": \"#00000066\"\n\
  \  },\n\
  \  \"displayName\": \"Nord\",\n\
  \  \"name\": \"nord\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"settings\": {\n\
  \        \"background\": \"#2e3440ff\",\n\
  \        \"foreground\": \"#d8dee9ff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"emphasis\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"strong\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#616E88\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.escape\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#B48EAD\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.class\",\n\
  \        \"entity.name.type.class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.inherited-class\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.deprecated\",\n\
  \      \"settings\": {\n\
  \        \"background\": \"#EBCB8B\",\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.illegal\",\n\
  \      \"settings\": {\n\
  \        \"background\": \"#BF616A\",\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.new\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#BF616A\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#A3BE8C\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.preprocessor\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.method-parameters\",\n\
  \        \"punctuation.definition.function-parameters\",\n\
  \        \"punctuation.definition.parameters\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.comment\",\n\
  \        \"punctuation.end.definition.comment\",\n\
  \        \"punctuation.start.definition.comment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#616E88\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.section\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section.embedded.begin\",\n\
  \        \"punctuation.section.embedded.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.terminator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#A3BE8C\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.construct\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.exception\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.debug-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#b48ead\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.error-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#bf616a\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.info-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88c0d0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.warn-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ebcb8b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.pointer-access.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.c meta.preprocessor.include\",\n\
  \        \"source.c string.quoted.other.lt-gt.include\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.cpp keyword.control.directive.conditional\",\n\
  \        \"source.cpp punctuation.definition.directive\",\n\
  \        \"source.c keyword.control.directive.conditional\",\n\
  \        \"source.c punctuation.definition.directive\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css constant.other.color.rgb-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#B48EAD\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css meta.property-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css keyword.control.at-rule.media\",\n\
  \        \"source.css keyword.control.at-rule.media \
   punctuation.definition.keyword\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css punctuation.definition.keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css support.type.property-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.diff meta.diff.range.context\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.diff meta.diff.header.from-file\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.diff punctuation.definition.from-file\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.diff punctuation.definition.range\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.diff punctuation.definition.separator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module.elixir\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.readwrite.module.elixir\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.symbol.elixir\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.constant.elixir\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.go constant.other.placeholder.go\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java comment.block.documentation.javadoc \
   punctuation.definition.entity.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java constant.other\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java keyword.other.documentation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java keyword.other.documentation.author.javadoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java keyword.other.documentation.directive\",\n\
  \        \"source.java keyword.other.documentation.custom\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java keyword.other.documentation.see.javadoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java meta.method-call meta.method\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java meta.tag.template.link.javadoc\",\n\
  \        \"source.java string.other.link.title.javadoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java meta.tag.template.value.javadoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java punctuation.definition.keyword.javadoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.java punctuation.definition.tag.begin.javadoc\",\n\
  \        \"source.java punctuation.definition.tag.end.javadoc\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#616E88\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.modifier.import\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.modifier.package\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.type.annotation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.type.generic\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java storage.type.primitive\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js punctuation.decorator\",\n\
  \        \"source.js meta.decorator variable.other.readwrite\",\n\
  \        \"source.js meta.decorator entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js meta.object-literal.key\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js storage.type.class.jsdoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js string.quoted.template punctuation.quasi.element.begin\",\n\
  \        \"source.js string.quoted.template punctuation.quasi.element.end\",\n\
  \        \"source.js string.template \
   punctuation.definition.template-expression\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js string.quoted.template \
   meta.method-call.with-arguments\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js string.template meta.template.expression \
   support.variable.property\",\n\
  \        \"source.js string.template meta.template.expression \
   variable.other.object\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js support.type.primitive\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js variable.other.object\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.js variable.other.readwrite.alias\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.js meta.embedded.line meta.brace.square\",\n\
  \        \"source.js meta.embedded.line meta.brace.round\",\n\
  \        \"source.js string.quoted.template meta.brace.square\",\n\
  \        \"source.js string.quoted.template meta.brace.round\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.basic constant.character.entity.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.basic constant.other.inline-data\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.basic meta.tag.sgml.doctype\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.basic punctuation.definition.entity\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.properties entity.name.section.group-title.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.properties punctuation.separator.key-value.ini\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown markup.fenced_code.block\",\n\
  \        \"text.html.markdown markup.fenced_code.block \
   punctuation.definition\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown markup.inline.raw\",\n\
  \        \"text.html.markdown markup.inline.raw punctuation.definition.raw\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown markup.italic\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown markup.underline.link\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown \
   beginning.punctuation.definition.list\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown \
   beginning.punctuation.definition.quote\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown markup.quote\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#616E88\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown constant.character.math.tex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown punctuation.definition.math.begin\",\n\
  \        \"text.html.markdown punctuation.definition.math.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown \
   punctuation.definition.function.math.tex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown punctuation.math.operator.latex\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.markdown punctuation.definition.heading\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown punctuation.definition.constant\",\n\
  \        \"text.html.markdown punctuation.definition.string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.html.markdown constant.other.reference.link\",\n\
  \        \"text.html.markdown string.other.link.description\",\n\
  \        \"text.html.markdown string.other.link.title\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.perl punctuation.definition.variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.php meta.function-call\",\n\
  \        \"source.php meta.function-call.object\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.python entity.name.function.decorator\",\n\
  \        \"source.python meta.function.decorator support.type\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.python meta.function-call.generic\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.python support.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.python variable.parameter.function.language\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.python meta.function.parameters \
   variable.parameter.function.language.special.self\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.rust entity.name.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.rust meta.macro entity.name.function\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\",\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.rust meta.attribute\",\n\
  \        \"source.rust meta.attribute punctuation\",\n\
  \        \"source.rust meta.attribute keyword.operator\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.rust entity.name.type.trait\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"bold\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.rust punctuation.definition.interpolation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#EBCB8B\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.css.scss \
   punctuation.definition.interpolation.begin.bracket.curly\",\n\
  \        \"source.css.scss \
   punctuation.definition.interpolation.end.bracket.curly\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#81A1C1\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.css.scss variable.interpolation\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts punctuation.decorator\",\n\
  \        \"source.ts meta.decorator variable.other.readwrite\",\n\
  \        \"source.ts meta.decorator entity.name.function\",\n\
  \        \"source.tsx punctuation.decorator\",\n\
  \        \"source.tsx meta.decorator variable.other.readwrite\",\n\
  \        \"source.tsx meta.decorator entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts meta.object-literal.key\",\n\
  \        \"source.tsx meta.object-literal.key\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts meta.object-literal.key entity.name.function\",\n\
  \        \"source.tsx meta.object-literal.key entity.name.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#88C0D0\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts support.class\",\n\
  \        \"source.ts support.type\",\n\
  \        \"source.ts entity.name.type\",\n\
  \        \"source.ts entity.name.class\",\n\
  \        \"source.tsx support.class\",\n\
  \        \"source.tsx support.type\",\n\
  \        \"source.tsx entity.name.type\",\n\
  \        \"source.tsx entity.name.class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts support.constant.math\",\n\
  \        \"source.ts support.constant.dom\",\n\
  \        \"source.ts support.constant.json\",\n\
  \        \"source.tsx support.constant.math\",\n\
  \        \"source.tsx support.constant.dom\",\n\
  \        \"source.tsx support.constant.json\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts support.variable\",\n\
  \        \"source.tsx support.variable\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#D8DEE9\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ts meta.embedded.line meta.brace.square\",\n\
  \        \"source.ts meta.embedded.line meta.brace.round\",\n\
  \        \"source.tsx meta.embedded.line meta.brace.square\",\n\
  \        \"source.tsx meta.embedded.line meta.brace.round\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ECEFF4\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.xml entity.name.tag.namespace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.xml keyword.other.doctype\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.xml meta.tag.preprocessor entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5E81AC\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.xml string.unquoted.cdata\",\n\
  \        \"text.xml string.unquoted.cdata punctuation.definition.string\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#D08770\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.yaml entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#8FBCBB\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
let one_dark_pro =
  "{\n\
  \  \"colors\": {\n\
  \    \"actionBar.toggledBackground\": \"#525761\",\n\
  \    \"activityBar.background\": \"#282c34\",\n\
  \    \"activityBar.foreground\": \"#d7dae0\",\n\
  \    \"activityBarBadge.background\": \"#4d78cc\",\n\
  \    \"activityBarBadge.foreground\": \"#f8fafd\",\n\
  \    \"badge.background\": \"#282c34\",\n\
  \    \"button.background\": \"#404754\",\n\
  \    \"button.secondaryBackground\": \"#30333d\",\n\
  \    \"button.secondaryForeground\": \"#c0bdbd\",\n\
  \    \"checkbox.border\": \"#404754\",\n\
  \    \"debugToolBar.background\": \"#21252b\",\n\
  \    \"descriptionForeground\": \"#abb2bf\",\n\
  \    \"diffEditor.insertedTextBackground\": \"#00809b33\",\n\
  \    \"dropdown.background\": \"#21252b\",\n\
  \    \"dropdown.border\": \"#21252b\",\n\
  \    \"editor.background\": \"#282c34\",\n\
  \    \"editor.findMatchBackground\": \"#d19a6644\",\n\
  \    \"editor.findMatchBorder\": \"#ffffff5a\",\n\
  \    \"editor.findMatchHighlightBackground\": \"#ffffff22\",\n\
  \    \"editor.foreground\": \"#abb2bf\",\n\
  \    \"editor.lineHighlightBackground\": \"#2c313c\",\n\
  \    \"editor.selectionBackground\": \"#67769660\",\n\
  \    \"editor.selectionHighlightBackground\": \"#ffd33d44\",\n\
  \    \"editor.selectionHighlightBorder\": \"#dddddd\",\n\
  \    \"editor.wordHighlightBackground\": \"#d2e0ff2f\",\n\
  \    \"editor.wordHighlightBorder\": \"#7f848e\",\n\
  \    \"editor.wordHighlightStrongBackground\": \"#abb2bf26\",\n\
  \    \"editor.wordHighlightStrongBorder\": \"#7f848e\",\n\
  \    \"editorBracketHighlight.foreground1\": \"#d19a66\",\n\
  \    \"editorBracketHighlight.foreground2\": \"#c678dd\",\n\
  \    \"editorBracketHighlight.foreground3\": \"#56b6c2\",\n\
  \    \"editorBracketMatch.background\": \"#515a6b\",\n\
  \    \"editorBracketMatch.border\": \"#515a6b\",\n\
  \    \"editorCursor.background\": \"#ffffffc9\",\n\
  \    \"editorCursor.foreground\": \"#528bff\",\n\
  \    \"editorError.foreground\": \"#c24038\",\n\
  \    \"editorGroup.background\": \"#181a1f\",\n\
  \    \"editorGroup.border\": \"#181a1f\",\n\
  \    \"editorGroupHeader.tabsBackground\": \"#21252b\",\n\
  \    \"editorGutter.addedBackground\": \"#109868\",\n\
  \    \"editorGutter.deletedBackground\": \"#9A353D\",\n\
  \    \"editorGutter.modifiedBackground\": \"#948B60\",\n\
  \    \"editorHoverWidget.background\": \"#21252b\",\n\
  \    \"editorHoverWidget.border\": \"#181a1f\",\n\
  \    \"editorHoverWidget.highlightForeground\": \"#61afef\",\n\
  \    \"editorIndentGuide.activeBackground1\": \"#c8c8c859\",\n\
  \    \"editorIndentGuide.background1\": \"#3b4048\",\n\
  \    \"editorInlayHint.background\": \"#2c313c\",\n\
  \    \"editorInlayHint.foreground\": \"#abb2bf\",\n\
  \    \"editorLineNumber.activeForeground\": \"#abb2bf\",\n\
  \    \"editorLineNumber.foreground\": \"#495162\",\n\
  \    \"editorMarkerNavigation.background\": \"#21252b\",\n\
  \    \"editorOverviewRuler.addedBackground\": \"#109868\",\n\
  \    \"editorOverviewRuler.deletedBackground\": \"#9A353D\",\n\
  \    \"editorOverviewRuler.modifiedBackground\": \"#948B60\",\n\
  \    \"editorRuler.foreground\": \"#abb2bf26\",\n\
  \    \"editorSuggestWidget.background\": \"#21252b\",\n\
  \    \"editorSuggestWidget.border\": \"#181a1f\",\n\
  \    \"editorSuggestWidget.selectedBackground\": \"#2c313a\",\n\
  \    \"editorWarning.foreground\": \"#d19a66\",\n\
  \    \"editorWhitespace.foreground\": \"#ffffff1d\",\n\
  \    \"editorWidget.background\": \"#21252b\",\n\
  \    \"focusBorder\": \"#3e4452\",\n\
  \    \"gitDecoration.ignoredResourceForeground\": \"#636b78\",\n\
  \    \"input.background\": \"#1d1f23\",\n\
  \    \"input.foreground\": \"#abb2bf\",\n\
  \    \"list.activeSelectionBackground\": \"#2c313a\",\n\
  \    \"list.activeSelectionForeground\": \"#d7dae0\",\n\
  \    \"list.focusBackground\": \"#323842\",\n\
  \    \"list.focusForeground\": \"#f0f0f0\",\n\
  \    \"list.highlightForeground\": \"#ecebeb\",\n\
  \    \"list.hoverBackground\": \"#2c313a\",\n\
  \    \"list.hoverForeground\": \"#abb2bf\",\n\
  \    \"list.inactiveSelectionBackground\": \"#323842\",\n\
  \    \"list.inactiveSelectionForeground\": \"#d7dae0\",\n\
  \    \"list.warningForeground\": \"#d19a66\",\n\
  \    \"menu.foreground\": \"#abb2bf\",\n\
  \    \"menu.separatorBackground\": \"#343a45\",\n\
  \    \"minimapGutter.addedBackground\": \"#109868\",\n\
  \    \"minimapGutter.deletedBackground\": \"#9A353D\",\n\
  \    \"minimapGutter.modifiedBackground\": \"#948B60\",\n\
  \    \"multiDiffEditor.headerBackground\": \"#21252b\",\n\
  \    \"panel.border\": \"#3e4452\",\n\
  \    \"panelSectionHeader.background\": \"#21252b\",\n\
  \    \"peekViewEditor.background\": \"#1b1d23\",\n\
  \    \"peekViewEditor.matchHighlightBackground\": \"#29244b\",\n\
  \    \"peekViewResult.background\": \"#22262b\",\n\
  \    \"scrollbar.shadow\": \"#23252c\",\n\
  \    \"scrollbarSlider.activeBackground\": \"#747d9180\",\n\
  \    \"scrollbarSlider.background\": \"#4e566660\",\n\
  \    \"scrollbarSlider.hoverBackground\": \"#5a637580\",\n\
  \    \"settings.focusedRowBackground\": \"#282c34\",\n\
  \    \"settings.headerForeground\": \"#fff\",\n\
  \    \"sideBar.background\": \"#21252b\",\n\
  \    \"sideBar.foreground\": \"#abb2bf\",\n\
  \    \"sideBarSectionHeader.background\": \"#282c34\",\n\
  \    \"sideBarSectionHeader.foreground\": \"#abb2bf\",\n\
  \    \"statusBar.background\": \"#21252b\",\n\
  \    \"statusBar.debuggingBackground\": \"#cc6633\",\n\
  \    \"statusBar.debuggingBorder\": \"#ff000000\",\n\
  \    \"statusBar.debuggingForeground\": \"#ffffff\",\n\
  \    \"statusBar.foreground\": \"#9da5b4\",\n\
  \    \"statusBar.noFolderBackground\": \"#21252b\",\n\
  \    \"statusBarItem.remoteBackground\": \"#4d78cc\",\n\
  \    \"statusBarItem.remoteForeground\": \"#f8fafd\",\n\
  \    \"tab.activeBackground\": \"#282c34\",\n\
  \    \"tab.activeBorder\": \"#b4b4b4\",\n\
  \    \"tab.activeForeground\": \"#dcdcdc\",\n\
  \    \"tab.border\": \"#181a1f\",\n\
  \    \"tab.hoverBackground\": \"#323842\",\n\
  \    \"tab.inactiveBackground\": \"#21252b\",\n\
  \    \"tab.unfocusedHoverBackground\": \"#323842\",\n\
  \    \"terminal.ansiBlack\": \"#3f4451\",\n\
  \    \"terminal.ansiBlue\": \"#4aa5f0\",\n\
  \    \"terminal.ansiBrightBlack\": \"#4f5666\",\n\
  \    \"terminal.ansiBrightBlue\": \"#4dc4ff\",\n\
  \    \"terminal.ansiBrightCyan\": \"#4cd1e0\",\n\
  \    \"terminal.ansiBrightGreen\": \"#a5e075\",\n\
  \    \"terminal.ansiBrightMagenta\": \"#de73ff\",\n\
  \    \"terminal.ansiBrightRed\": \"#ff616e\",\n\
  \    \"terminal.ansiBrightWhite\": \"#e6e6e6\",\n\
  \    \"terminal.ansiBrightYellow\": \"#f0a45d\",\n\
  \    \"terminal.ansiCyan\": \"#42b3c2\",\n\
  \    \"terminal.ansiGreen\": \"#8cc265\",\n\
  \    \"terminal.ansiMagenta\": \"#c162de\",\n\
  \    \"terminal.ansiRed\": \"#e05561\",\n\
  \    \"terminal.ansiWhite\": \"#d7dae0\",\n\
  \    \"terminal.ansiYellow\": \"#d18f52\",\n\
  \    \"terminal.background\": \"#282c34\",\n\
  \    \"terminal.border\": \"#3e4452\",\n\
  \    \"terminal.foreground\": \"#abb2bf\",\n\
  \    \"terminal.selectionBackground\": \"#abb2bf30\",\n\
  \    \"textBlockQuote.background\": \"#2e3440\",\n\
  \    \"textBlockQuote.border\": \"#4b5362\",\n\
  \    \"textLink.foreground\": \"#61afef\",\n\
  \    \"textPreformat.foreground\": \"#d19a66\",\n\
  \    \"titleBar.activeBackground\": \"#282c34\",\n\
  \    \"titleBar.activeForeground\": \"#9da5b4\",\n\
  \    \"titleBar.inactiveBackground\": \"#282c34\",\n\
  \    \"titleBar.inactiveForeground\": \"#6b717d\",\n\
  \    \"tree.indentGuidesStroke\": \"#ffffff1d\",\n\
  \    \"walkThrough.embeddedEditorBackground\": \"#2e3440\",\n\
  \    \"welcomePage.buttonHoverBackground\": \"#404754\"\n\
  \  },\n\
  \  \"displayName\": \"One Dark Pro\",\n\
  \  \"name\": \"one-dark-pro\",\n\
  \  \"semanticHighlighting\": true,\n\
  \  \"semanticTokenColors\": {\n\
  \    \"annotation:dart\": {\n\
  \      \"foreground\": \"#d19a66\"\n\
  \    },\n\
  \    \"enumMember\": {\n\
  \      \"foreground\": \"#56b6c2\"\n\
  \    },\n\
  \    \"macro\": {\n\
  \      \"foreground\": \"#d19a66\"\n\
  \    },\n\
  \    \"memberOperatorOverload\": {\n\
  \      \"foreground\": \"#c678dd\"\n\
  \    },\n\
  \    \"parameter.label:dart\": {\n\
  \      \"foreground\": \"#abb2bf\"\n\
  \    },\n\
  \    \"property:dart\": {\n\
  \      \"foreground\": \"#d19a66\"\n\
  \    },\n\
  \    \"tomlArrayKey\": {\n\
  \      \"foreground\": \"#e5c07b\"\n\
  \    },\n\
  \    \"variable.constant\": {\n\
  \      \"foreground\": \"#d19a66\"\n\
  \    },\n\
  \    \"variable.defaultLibrary\": {\n\
  \      \"foreground\": \"#e5c07b\"\n\
  \    },\n\
  \    \"variable:dart\": {\n\
  \      \"foreground\": \"#d19a66\"\n\
  \    }\n\
  \  },\n\
  \  \"tokenColors\": [\n\
  \    {\n\
  \      \"scope\": \"meta.embedded\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.definition.delayed.unison,punctuation.definition.list.begin.unison,punctuation.definition.list.end.unison,punctuation.definition.ability.begin.unison,punctuation.definition.ability.end.unison,punctuation.operator.assignment.as.unison,punctuation.separator.pipe.unison,punctuation.separator.delimiter.unison,punctuation.definition.hash.unison\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.generic-type.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.haskell\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.variable.magic.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.separator.period.python,punctuation.separator.element.python,punctuation.parenthesis.begin.python,punctuation.parenthesis.end.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"variable.parameter.function.language.special.self.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.function.language.special.cls.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.modifier.lifetime.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function.std.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.lifetime.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.edge\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.character-class.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.word\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.quantifier.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment markup.link\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5c6370\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.changed.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"meta.diff.header.from-file,meta.diff.header.to-file,punctuation.definition.from-file.diff,punctuation.definition.to-file.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted.diff\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.c,meta.function.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.section.block.begin.bracket.curly.cpp,punctuation.section.block.end.bracket.curly.cpp,punctuation.terminator.statement.c,punctuation.section.block.begin.bracket.curly.c,punctuation.section.block.end.bracket.curly.c,punctuation.section.parens.begin.bracket.round.c,punctuation.section.parens.end.bracket.round.c,punctuation.section.parameters.begin.bracket.round.c,punctuation.section.parameters.end.bracket.round.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.key-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.expression.import\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.math\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.property.math\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.constant\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.type.annotation.java\",\n\
  \        \"storage.type.object.array.java\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.section.block.begin.java,punctuation.section.block.end.java,punctuation.definition.method-parameters.begin.java,punctuation.definition.method-parameters.end.java,meta.method.identifier.java,punctuation.section.method.begin.java,punctuation.section.method.end.java,punctuation.terminator.java,punctuation.section.class.begin.java,punctuation.section.class.end.java,punctuation.section.inner-class.begin.java,punctuation.section.inner-class.end.java,meta.method-call.java,punctuation.section.class.begin.bracket.curly.java,punctuation.section.class.end.bracket.curly.java,punctuation.section.method.begin.bracket.curly.java,punctuation.section.method.end.bracket.curly.java,punctuation.separator.period.java,punctuation.bracket.angle.java,punctuation.definition.annotation.java,meta.method.body.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.method.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"storage.modifier.import.java,storage.type.java,storage.type.generic.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.instanceof.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.definition.variable.name.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.logical\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.bitwise\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.channel\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.constant.property-value.scss,support.constant.property-value.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.css,keyword.operator.scss,keyword.operator.less\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.constant.color.w3c-standard-color-name.css,support.constant.color.w3c-standard-color-name.scss\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.list.comma.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.color.w3c-standard-color-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.vendored.property-name.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.module.node,support.type.object.module,support.module.node\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.module\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"variable.other.readwrite,meta.object-literal.key,support.variable.property,support.variable.object.process,support.variable.object.node\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.expression.instanceof\",\n\
  \        \"keyword.operator.new\",\n\
  \        \"keyword.operator.ternary\",\n\
  \        \"keyword.operator.optional\",\n\
  \        \"keyword.operator.expression.keyof\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.object.console\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.variable.property.process\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.function,support.function.console\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.misc.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.sigil.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.delete\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.object.dom\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.variable.dom,support.variable.property.dom\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.arithmetic,keyword.operator.comparison,keyword.operator.decrement,keyword.operator.increment,keyword.operator.relational\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.assignment.c,keyword.operator.comparison.c,keyword.operator.c,keyword.operator.increment.c,keyword.operator.decrement.c,keyword.operator.bitwise.shift.c,keyword.operator.assignment.cpp,keyword.operator.comparison.cpp,keyword.operator.cpp,keyword.operator.increment.cpp,keyword.operator.decrement.cpp,keyword.operator.bitwise.shift.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.delimiter\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.separator.c,punctuation.separator.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.type.posix-reserved.c,support.type.posix-reserved.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.sizeof.c,keyword.operator.sizeof.cpp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.function.language.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.logical.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.parameter.function.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.definition.arguments.begin.python,punctuation.definition.arguments.end.python,punctuation.separator.arguments.python,punctuation.definition.list.begin.python,punctuation.definition.list.end.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function-call.generic.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.character.format.placeholder.other.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.assignment.compound\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.assignment.compound.js,keyword.operator.assignment.compound.ts\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.namespace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.language\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.variable.parameter.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"import.storage.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.package.keyword\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.package\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function\",\n\
  \        \"meta.require\",\n\
  \        \"support.function.any-method\",\n\
  \        \"variable.function\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type.namespace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.class, entity.name.type.class\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.class.identifier.namespace.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.class\",\n\
  \        \"variable.other.class.js\",\n\
  \        \"variable.other.class.ts\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.class.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.type\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.control\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"control.elements, keyword.operator.less\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.special-method\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.storage\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.expression.delete,keyword.operator.expression.in,keyword.operator.expression.of,keyword.operator.expression.instanceof,keyword.operator.new,keyword.operator.expression.typeof,keyword.operator.expression.void\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.storage.type.java\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.function\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.toml, \
   support.type.property-name.table.toml, \
   support.type.property-name.array.toml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.property-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.font-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.other.symbol\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.numeric\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.constant\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.tag\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.id\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.other.attribute-name.class.css\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.selector\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading punctuation.definition.heading, \
   entity.name.section\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.other.unit\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.bold,todo.bold\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.bold\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic, \
   punctuation.definition.italic,todo.emphasis\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"emphasis md\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.section.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.heading.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.list.begin.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.heading.setext\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.bold.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inline.raw.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inline.raw.string.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.raw.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.list.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.string.begin.markdown\",\n\
  \        \"punctuation.definition.string.end.markdown\",\n\
  \        \"punctuation.definition.metadata.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"beginning.punctuation.definition.list.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.metadata.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"markup.underline.link.markdown,markup.underline.link.image.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"string.other.link.title.markdown,string.other.link.description.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.raw.monospace.asciidoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.asciidoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.list.asciidoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.link.asciidoc,markup.other.url.asciidoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.unquoted.asciidoc,markup.other.url.asciidoc\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"string.regexp\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.section.embedded, variable.interpolation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.section.embedded.begin,punctuation.section.embedded.end\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.illegal\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffffff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.illegal.bad-ampersand.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.illegal.unrecognized-tag.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.broken\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffffff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.deprecated\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffffff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.deprecated.entity.other.attribute-name.html\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.unimplemented\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffffff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.json meta.structure.dictionary.json > \
   string.quoted.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.json meta.structure.dictionary.json > \
   string.quoted.json > punctuation.string\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.json meta.structure.dictionary.json > value.json \
   > string.quoted.json,source.json meta.structure.array.json > value.json > \
   string.quoted.json,source.json meta.structure.dictionary.json > value.json \
   > string.quoted.json > punctuation,source.json meta.structure.array.json > \
   value.json > string.quoted.json > punctuation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"source.json meta.structure.dictionary.json > \
   constant.language.json,source.json meta.structure.array.json > \
   constant.language.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.json\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.type.property-name.json punctuation\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.laravel-blade source.php.embedded.line.html \
   entity.name.tag.laravel-blade\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"text.html.laravel-blade source.php.embedded.line.html \
   support.constant.laravel-blade\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.other.namespace.use.php,support.other.namespace.use-as.php,entity.other.alias.php,meta.interface.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.error-control.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.type.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.section.array.begin.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.section.array.end.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"invalid.illegal.non-null-typehinted.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f44747\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"storage.type.php,meta.other.type.phpdoc.php,keyword.other.type.php,keyword.other.array.phpdoc.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"meta.function-call.php,meta.function-call.object.php,meta.function-call.static.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"punctuation.definition.parameters.begin.bracket.round.php,punctuation.definition.parameters.end.bracket.round.php,punctuation.separator.delimiter.php,punctuation.section.scope.begin.php,punctuation.section.scope.end.php,punctuation.terminator.expression.php,punctuation.definition.arguments.begin.bracket.round.php,punctuation.definition.arguments.end.bracket.round.php,punctuation.definition.storage-type.begin.bracket.round.php,punctuation.definition.storage-type.end.bracket.round.php,punctuation.definition.array.begin.bracket.round.php,punctuation.definition.array.end.bracket.round.php,punctuation.definition.begin.bracket.round.php,punctuation.definition.end.bracket.round.php,punctuation.definition.begin.bracket.curly.php,punctuation.definition.end.bracket.curly.php,punctuation.definition.section.switch-block.end.bracket.curly.php,punctuation.definition.section.switch-block.start.bracket.curly.php,punctuation.definition.section.switch-block.begin.bracket.curly.php,punctuation.definition.section.switch-block.end.bracket.curly.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"support.constant.core.rust\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.constant.ext.php,support.constant.std.php,support.constant.core.php,support.constant.parser-token.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.goto-label.php,support.other.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.logical.php,keyword.operator.bitwise.php,keyword.operator.arithmetic.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.regexp.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.comparison.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"keyword.operator.heredoc.php,keyword.operator.nowdoc.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"meta.function.decorator.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.token.decorator.python,meta.function.decorator.identifier.python\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"function.parameter\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"function.brace\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"function.parameter.ruby, function.parameter.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.symbol.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"constant.language.symbol.hashkey.ruby\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"rgb-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"inline-color-decoration rgb-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"less rgb-value\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"selector.sass\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"support.type.primitive.ts,support.type.builtin.ts,support.type.primitive.tsx,support.type.builtin.tsx\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"block.scope.end,block.scope.begin\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"storage.type.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.variable.local.cs\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.info-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.warn-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.error-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#f44747\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"token.debug-token\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.template-expression.begin\",\n\
  \        \"punctuation.definition.template-expression.end\",\n\
  \        \"punctuation.section.embedded\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.template.expression\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.module\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.type.flowtype\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.primitive\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.property.object\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter.function.js\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.template.begin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.template.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.substitution.begin\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.other.substitution.end\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.assignment\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.assignment.go\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.arithmetic.go\",\n\
  \        \"keyword.operator.address.go\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.operator.arithmetic.c\",\n\
  \        \"keyword.operator.arithmetic.cpp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.package.go\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.prelude.elm\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.constant.elm\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.quasi.element\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.entity\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.attribute-name.pseudo-element\",\n\
  \        \"entity.other.attribute-name.pseudo-class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.global.clojure\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.symbol.clojure\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.keyword.clojure\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.arguments.coffee\",\n\
  \        \"variable.parameter.function.coffee\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.ini\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.scope.prerequisites.makefile\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"source.makefile\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"storage.modifier.import.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.method.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.definition.variable.name.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"meta.definition.class.inherited.classes.groovy\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.variable.semantic.hlsl\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.texture.hlsl\",\n\
  \        \"support.type.sampler.hlsl\",\n\
  \        \"support.type.object.hlsl\",\n\
  \        \"support.type.object.rw.hlsl\",\n\
  \        \"support.type.fx.hlsl\",\n\
  \        \"support.type.object.hlsl\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"text.variable\",\n\
  \        \"text.bracketed\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.type.swift\",\n\
  \        \"support.type.vb.asp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.function.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.class.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.character-class.regexp.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.regexp.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"keyword.control.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"invalid.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"beginning.punctuation.definition.quote.markdown.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"beginning.punctuation.definition.list.markdown.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#7f848e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"accent.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"wikiword.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.other.color.rgb-value.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#ffffff\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.definition.tag.xi\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5c6370\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.label.cs\",\n\
  \        \"entity.name.scope-resolution.function.call\",\n\
  \        \"entity.name.scope-resolution.function.definition\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.label.cs\",\n\
  \        \"markup.heading.setext.1.markdown\",\n\
  \        \"markup.heading.setext.2.markdown\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \" meta.brace.square\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment, punctuation.definition.comment\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\",\n\
  \        \"foreground\": \"#7f848e\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.quote.markdown\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#5c6370\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"punctuation.definition.block.sequence.item.yaml\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.language.symbol.elixir\",\n\
  \        \"constant.language.symbol.double-quoted.elixir\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.variable.parameter.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.name.variable.field.cs\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.deleted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.inserted\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.underline\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"underline\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"punctuation.section.embedded.begin.php\",\n\
  \        \"punctuation.section.embedded.end.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#BE5046\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.other.namespace.php\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.parameter.function.latex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.object\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"variable.other.constant.property\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"entity.other.inherited-class\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"variable.other.readwrite.c\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"entity.name.variable.parameter.php,punctuation.separator.colon.php,constant.other.php\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#abb2bf\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.numeric.decimal.asm.x86_64\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.other.parenthesis.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#d19a66\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.escape\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#56b6c2\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"string.regexp\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"log.info\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"log.warning\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e5c07b\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"log.error\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"keyword.operator.expression.is\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#c678dd\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"entity.name.label\",\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#e06c75\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"support.class.math.block.environment.latex\",\n\
  \        \"constant.other.general.math.tex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#61afef\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": [\n\
  \        \"constant.character.math.tex\"\n\
  \      ],\n\
  \      \"settings\": {\n\
  \        \"foreground\": \"#98c379\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \
   \"entity.other.attribute-name.js,entity.other.attribute-name.ts,entity.other.attribute-name.jsx,entity.other.attribute-name.tsx,variable.parameter,variable.language.super\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"comment.line.double-slash,comment.block.documentation\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    },\n\
  \    {\n\
  \      \"scope\": \"markup.italic.markdown\",\n\
  \      \"settings\": {\n\
  \        \"fontStyle\": \"italic\"\n\
  \      }\n\
  \    }\n\
  \  ],\n\
  \  \"type\": \"dark\"\n\
   }\n"
