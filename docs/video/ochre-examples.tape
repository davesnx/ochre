Output docs/video/ochre-examples.gif

Set Shell "zsh"
Set FontSize 20
Set FontFamily "JetBrains Mono"
Set Width 1600
Set Height 940
Set CursorBlink false

Hide
Type `PROMPT_EOL_MARK='' PROMPT=$'\n%F{magenta}>%f '`
Enter
Type "clear"
Enter
Show

Type `echo "let a = 33" | ochre ocaml --format ansi`
Enter
Sleep 1.5s

Type `echo "let a = 33" | ochre ocaml --format html`
Enter
Sleep 1.5s

Type `echo "let a = 33" | ochre ocaml --format svg`
Enter
Sleep 1.5s

Type `echo "let a = 33" | ochre ocaml --format latex`
Enter
Sleep 3s
