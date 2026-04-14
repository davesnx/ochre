
# Module `Ochre.Transform`

```ocaml
type token = Token.styled_token
```
Alias for a styled token.

```ocaml
type line = token list
```
A line of styled tokens.

```ocaml
type document = line list
```
The full highlighted document (list of lines).


### t

```ocaml
type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
}
```
A transform with named hooks. Each hook is optional. The pipeline calls them in this order:

1. `before_render` on the full document
2. `before_line` for each line (by index)
3. `after_line` for each line (by index)
4. `after_render` on the full document
When multiple transforms are provided, each hook phase folds over all transforms in list order before moving to the next phase.


### make

```ocaml
val make : 
  ?before_line:(line_index:int -> line -> line) ->
  ?after_line:(line_index:int -> line -> line) ->
  ?before_render:(document -> document) ->
  ?after_render:(document -> document) ->
  string ->
  t
```
`make name` creates a transform with the given hooks.

```ocaml
let bold_keywords =
  Ochre.Transform.make "bold-keywords"
    ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Ochre.Token.styled_token) ->
          if tok.text = "let" || tok.text = "in" then
            { tok with font_style = Bold :: tok.font_style }
          else
            tok
        )
        line
  )
```

### run

```ocaml
val run : t list -> document -> document
```
`run transforms document` applies all transforms to the document.

Transforms are applied in list order. An empty list returns the document unchanged.

```ocaml
let transformed = Ochre.Transform.run transforms document
```