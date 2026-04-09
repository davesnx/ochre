Output docs/video/ochre-examples.gif

Set Shell "bash"
Set FontSize 22
Set FontFamily "JetBrains Mono"
Set Width 1024
Set Height 600
Set CursorBlink false

Type `echo "let a = 33" | ochre 'ocaml' --format ansi`
Enter
Sleep 2s
Type "clear"
Enter

Type `echo "let a = 33" | ochre 'ocaml' --format html`
Enter
Sleep 2s
Type "clear"
Enter

Type `echo "let a = 33" | ochre 'ocaml' --format svg`
Enter
Sleep 2s
Type "clear"
Enter

Type `echo "let a = 33" | ochre 'ocaml' --format latex`
Enter
Sleep 2s
Type "clear"
Enter

Type `echo "console.log(33)" | ochre 'javascript' --format ansi`
Enter
Sleep 2s
