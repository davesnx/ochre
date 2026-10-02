Regression test for a tokenizer crash on ordinary input for several bundled
grammars (markdown, css, go, dotenv, shellsession): a sibling capture pair
where a simple (no nested patterns) capture is immediately followed by a
capture with nested patterns produced tokens out of position order, which
crashed lib/ochre.ml's extract_tokens with
`Invalid_argument("String.sub / Bytes.sub")`. These must now tokenize
without crashing and the token texts must reassemble the exact source.

Markdown ATX heading

  $ printf '# Title\n' | ochre markdown --theme nord --format tokens
  line 1:
    "#"  punctuation.definition.heading.markdown, heading.1.markdown, markup.heading.markdown, text.html.markdown
    " "  heading.1.markdown, markup.heading.markdown, text.html.markdown
    "Title"  entity.name.section.markdown, heading.1.markdown, markup.heading.markdown, text.html.markdown
    "\n"  heading.1.markdown, markup.heading.markdown, text.html.markdown

Markdown inline link

  $ printf '[link](http://x.com)\n' | ochre markdown --theme nord --format tokens
  line 1:
    "["  punctuation.definition.link.title.begin.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    "link"  string.other.link.title.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    "]"  punctuation.definition.link.title.end.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    "("  punctuation.definition.metadata.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    "http://x.com"  markup.underline.link.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    ")"  punctuation.definition.metadata.markdown, meta.link.inline.markdown, meta.paragraph.markdown, text.html.markdown
    "\n"  meta.paragraph.markdown, meta.paragraph.markdown, text.html.markdown

CSS rule

  $ printf '.foo {\n  color: red;\n}\n' | ochre css --theme nord --format tokens
  line 1:
    "."  punctuation.definition.entity.css, entity.other.attribute-name.class.css, meta.selector.css, source.css
    "foo"  entity.other.attribute-name.class.css, meta.selector.css, source.css
    " "  source.css
    "{"  punctuation.section.property-list.begin.bracket.curly.css, meta.property-list.css, source.css
    "\n"  meta.property-list.css, meta.property-list.css, source.css
  line 2:
    "  "  meta.property-list.css, source.css
    "color"  support.type.property-name.css, meta.property-name.css, meta.property-list.css, source.css
    ":"  punctuation.separator.key-value.css, meta.property-list.css, source.css
    " "  meta.property-list.css, source.css
    "red"  support.constant.color.w3c-standard-color-name.css, meta.property-value.css, meta.property-list.css, source.css
    ";"  punctuation.terminator.rule.css, meta.property-list.css, source.css
    "\n"  meta.property-list.css, meta.property-list.css, source.css
  line 3:
    "}"  punctuation.section.property-list.end.bracket.curly.css, meta.property-list.css, source.css
    "\n"  source.css

Go program

  $ printf 'package main\nfunc main() { println("hi") }\n' | ochre go --theme nord --format tokens
  line 1:
    "package"  keyword.package.go, source.go
    " "  source.go
    "main"  entity.name.type.package.go, source.go
    "\n"  source.go
  line 2:
    "func"  keyword.function.go, source.go
    " "  source.go
    "main"  source.go
    "("  punctuation.definition.begin.bracket.round.go, source.go
    ")"  punctuation.definition.end.bracket.round.go, source.go
    " "  source.go
    "{"  punctuation.definition.begin.bracket.curly.go, source.go
    " "  source.go
    "println"  entity.name.function.support.builtin.go, source.go
    "("  punctuation.definition.begin.bracket.round.go, source.go
    "\""  punctuation.definition.string.begin.go, string.quoted.double.go, source.go
    "hi"  string.quoted.double.go, source.go
    "\""  punctuation.definition.string.end.go, string.quoted.double.go, source.go
    ")"  punctuation.definition.end.bracket.round.go, source.go
    " "  source.go
    "}"  punctuation.definition.end.bracket.curly.go, source.go
    "\n"  source.go

dotenv

  $ printf 'FOO=bar\nBAZ="quoted value"\n' | ochre dotenv --theme nord --format tokens
  line 1:
    "FOO"  variable.key.dotenv, source.dotenv
    "="  keyword.operator.assignment.dotenv, source.dotenv
    "bar"  property.value.dotenv, source.dotenv
    "\n"  source.dotenv
  line 2:
    "BAZ"  variable.key.dotenv, source.dotenv
    "="  keyword.operator.assignment.dotenv, source.dotenv
    "\"quoted value\""  source.dotenv
    "\n"  source.dotenv

shellsession

  $ printf '$ echo hello\nhello\n' | ochre shellsession --theme nord --format tokens
  line 1:
    "$"  punctuation.separator.prompt.shell-session, text.shell-session
    " "  text.shell-session
    "echo hello"  source.shell, text.shell-session
    "\n"  text.shell-session
  line 2:
    "hello"  meta.output.shell-session, text.shell-session
    "\n"  text.shell-session
