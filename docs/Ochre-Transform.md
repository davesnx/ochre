
# Module `Ochre.Transform`

```ocaml
type token = Token.t
```
```ocaml
type line = token list
```
```ocaml
type document = line list
```

### attribute\_hooks

```ocaml
type attributes = JSX.attribute list
```
```ocaml
type attribute_hooks = {
  pre : (document -> attributes -> attributes) option; (* Changes the attributes of the <pre>. It gets the rendered lines. *)
  line : (line_index:int -> line -> attributes -> attributes) option; (* Changes the attributes of the <span class="line"> of the rendered line line_index (from 0), which holds the tokens of line. *)
  span : (line_index:int ->
         column:int ->
         token ->
         attributes ->
         attributes)
         option; (* Changes the attributes of the <span> of token on the rendered line line_index. token is the token of line, as the line hook gets it, and column is the byte offset of token in the text of that line. The <span> can hold a different text: the HTML backend moves the "\r" that ends a token into the next token when that one starts with "\n", so that the pair stays together. Such a <span> starts at column - 1, one byte before token. A token that holds only that "\r" has no <span> and no span call. A token with no attributes after every hook is written as text, with no <span>. *)
}
```
HTML attribute hooks, run by [`to_jsx`](./Ochre.md#val-to_jsx) and [`to_html`](./Ochre.md#val-to_html). Each hook takes the attributes built so far and returns the new list. The HTML backend escapes the values. An attribute name must match `[A-Za-z_:][A-Za-z0-9_.:-]*`; rendering never fails, so the HTML backend replaces each other character of a name with `_`, and an empty name becomes `_`. Names are compared without case. When the list has several `class` attributes, they become one `class` with each name once, in order; several `style` attributes become one `style`, joined with `;`. For any other name, the last value wins, at the place of the first. So a hook can add a class or a style with `attrs @ [ ("class", `String "name") ]`, and replace a value with `attrs @ [ ("tabindex", `Int (-1)) ]`.


### t

```ocaml
type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
  attributes : (document -> attribute_hooks) option;
}
```
A transform with named hooks. Each hook is optional. The pipeline calls them in this order:

1. `attributes` then `before_render`, on the full document
2. `before_line` for each line (by index)
3. `after_line` for each line (by index)
4. `after_render` on the full document
When multiple transforms are provided, each hook phase folds over all transforms in list order before moving to the next phase.

`attributes` runs once per highlight, with the document as the transform sees it: after the `before_render` of the transforms before it, and before its own. Its hooks are kept in [`Themed.t.hooks`](./Ochre-Themed.md#type-t.hooks), and the HTML backend calls them in the order of the transforms. The `line_index` of a hook is the index of the rendered line, and the `column` of a `span` hook is a byte offset in its text. An `attributes` sees only the `before_render` changes of the transforms before it. It does not see the `before_render` changes of the transforms after it, or the changes of any `before_line`, `after_line` or `after_render` hook, because those run after every `attributes`. When one of these changes adds or removes lines, or changes the text of a line, a `line_index` or `column` that `attributes` computed from its document no longer matches the rendered code. The [`Token.position`](./Ochre-Token.md#type-position) of a token does not change, so identify lines and tokens by it: a `line` hook by the `position.line` of the tokens of `line`, and a `span` hook by the source bytes of `token`. The built-in transforms do this for the lines and tokens they mark, so they give the same classes in any order.


### make

```ocaml
val make : 
  ?before_line:(line_index:int -> line -> line) ->
  ?after_line:(line_index:int -> line -> line) ->
  ?before_render:(document -> document) ->
  ?after_render:(document -> document) ->
  ?attributes:(document -> attribute_hooks) ->
  string ->
  t
```
`make name` creates a transform with the given hooks.

```ocaml
let bold_keywords =
  Ochre.Transform.make "bold-keywords"
    ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Ochre.Token.t) ->
          if tok.text = "let" || tok.text = "in" then
            Ochre.Token.map_style
              (fun _ style ->
                {
                  style with
                  font_style = { style.font_style with bold = true };
                }
              )
              tok
          else
            tok
        )
        line
  )
```
A transform that adds a `data-line-count` attribute to the `<pre>`:

```ocaml
let line_count =
  Ochre.Transform.make "line-count" ~attributes:(fun _ ->
      {
        pre =
          Some
            (fun doc attrs ->
              attrs @ [ ("data-line-count", `Int (List.length doc)) ]
            );
        line = None;
        span = None;
      }
  )
```

### run

```ocaml
val run : t list -> document -> document
```
`run transforms document` applies all transforms to the document.

Transforms are applied in list order. An empty list returns the document unchanged.
