Output docs/video/ochre-examples.gif

Set Shell "fish"
Set FontSize 23
Set FontFamily "JetBrains Mono"
Set Width 1280
Set Height 720
Set Padding 28
Set Theme "Chalk"

Type `echo "let a = 33" | ochre 'ocaml' --format ansi`
Enter
Sleep 2s

Type `echo "let a = 33" | ochre 'ocaml' --format html`
Enter
Sleep 2s

Type `echo "let a = 33" | ochre 'ocaml' --format svg`
Enter
Sleep 2s

Type `echo "let a = 33" | ochre 'ocaml' --format latex`
Enter
Sleep 2s

Type `echo "console.log(33)" | ochre 'javascript' --format ansi`
Enter
Sleep 2s
