Every theme of a multi-theme page computes the font weight, font style,
text decoration, background and colour of its own theme, once the CSS custom
properties are resolved as a browser does
  $ ./test_cascade.exe
  inline: ok, 14 tokens in 2 themes
  classes: ok, 14 tokens in 2 themes
  no default color: ok, 14 tokens in 2 themes
  three themes: ok, 14 tokens in 3 themes
  three themes, no default color: ok, 14 tokens in 3 themes
