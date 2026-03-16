Keyword and number with ANSI escape codes
  $ ./test_render_ansi.exe keyword-and-number
  \e[1m\e[38;2;255;0;0mlet\e[0m\e[38;2;212;212;212m x = \e[0m\e[38;2;0;0;255m42\e[0m\e[38;2;212;212;212m
  \e[0m

Comment with italic ANSI code
  $ ./test_render_ansi.exe comment
  \e[3m\e[38;2;136;136;136m# a comment\e[0m\e[38;2;212;212;212m
  \e[0m

Multiple lines with ANSI codes
  $ ./test_render_ansi.exe multi-line
  \e[1m\e[38;2;255;0;0mlet\e[0m\e[38;2;212;212;212m x = \e[0m\e[38;2;0;0;255m42\e[0m\e[38;2;212;212;212m
  \e[0m
  \e[1m\e[38;2;255;0;0mlet\e[0m\e[38;2;212;212;212m y = \e[0m\e[38;2;0;0;255m10\e[0m\e[38;2;212;212;212m
  \e[0m

Compound scope entries prefer string over function scopes
  $ ./test_render_ansi.exe compound-scope
  \e[38;2;0;255;0mx\e[0m\e[38;2;212;212;212m
  \e[0m
