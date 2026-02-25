Plain token with no ANSI codes
  $ ./test_render_ansi.exe plain
  hello

Foreground color produces 24-bit ANSI escape
  $ ./test_render_ansi.exe colored
  \e[38;2;255;0;0mred\e[0m

Bold + foreground color
  $ ./test_render_ansi.exe bold
  \e[1m\e[38;2;0;255;0mbold green\e[0m

Background color
  $ ./test_render_ansi.exe background
  \e[48;2;255;0;0m\e[38;2;255;255;255malert\e[0m

Multiple tokens on one line, mixed styled and plain
  $ ./test_render_ansi.exe multi-token
  \e[38;2;255;0;0mred \e[0mplain \e[38;2;0;0;255mblue\e[0m

Multiple lines
  $ ./test_render_ansi.exe multi-line
  \e[38;2;255;0;0mline1\e[0m
  \e[38;2;0;255;0mline2\e[0m

All font styles combined
  $ ./test_render_ansi.exe all-styles
  \e[1m\e[3m\e[4m\e[9mstyled\e[0m
