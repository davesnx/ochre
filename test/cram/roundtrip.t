The text of every format equals the source, up to what each format documents:
SVG and LaTeX expand tabs, LaTeX drops carriage returns, ANSI shows a lone
carriage return as ^M
  $ ./test_roundtrip.exe
  html: text equals the source in 300 cases
  ansi: text equals the source in 300 cases
  svg: text equals the source in 300 cases
  latex: text equals the source in 300 cases
