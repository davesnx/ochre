
# Module `Ochre.Lang`

```ocaml
type t
```
A checked language: a loaded grammar with its grammar collection, or plain text. Render functions take a `Lang.t`, so they never fail on an unknown language.

```ocaml
val plaintext : t
```
Plain text: one unstyled token per line, in the theme's default colors.

```ocaml
val name : t -> string
```
The language id that was looked up, or `"plaintext"`.
