
# Module `Ochre.Error`

```ocaml
type t = 
  | Unknown_language of string (* No grammar is registered under this language id. *)
  | Grammar_error of {
    lang : string;
    path : string option;
    message : string;
  } (* A grammar cannot be read or parsed, or its id is a duplicate. path is the file, when the grammar came from a file. *)
  | Theme_error of {
    path : string option;
    message : string;
  } (* A theme cannot be read or parsed. path is the file, when the theme came from a file. *)
  | Include_cycle of string list (* Theme files include each other. The list is the chain of paths, from the first file to the file that closes the cycle. *)
  | Duplicate_theme_label of string (* Two themes of a Themed value have the same label. *)
  | Unknown_theme_label of string (* Themed.select was given a label that no theme has. *)
  | Foreign_token of {
    transform : string;
  } (* The transform returned a token taken from another Themed value with a different number of themes. *)
  | Invalid_data_key of string (* A decoration data key is empty or holds a byte outside A-Za-z0-9_-. *)
```
Every error that loading grammars, themes and languages can return.

```ocaml
val to_string : t -> string
```
A message for humans.
