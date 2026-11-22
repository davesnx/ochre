
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
         option; (* Changes the attributes of the <span> of token on the rendered line line_index. token is the token of line, as the line hook gets it, and column is its byte offset in the text of that line. The <span> can hold a different text: the HTML backend moves the "\r" that ends a token into the next token when that one starts with "\n", so that the pair stays together. A token that holds only that "\r" has no <span> and no span call. A token with no attributes after every hook is written as text, with no <span>. *)
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

`attributes` runs once per highlight, with the document as the transform sees it: after the `before_render` of the transforms before it, and before its own. Its hooks are kept in [`Themed.t.hooks`](./Ochre-Themed.md#type-t.hooks), and the HTML backend calls them in the order of the transforms. The `line_index` of a hook is the index of the rendered line, and the `column` of a `span` hook is a byte offset in its text. An `attributes` that computes lines or columns from its document sees the document before the transforms after it. When a later transform adds or removes lines, or changes the text of a line (for example [diff\_markers](./Ochre-Transform_builtin.md#diff_markers), which removes a leading `+`), those lines and columns no longer match the rendered code. Put such a transform first.


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
