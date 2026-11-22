type t =
  | Unknown_language of string
  | Grammar_error of { lang : string; path : string option; message : string }
  | Theme_error of { path : string option; message : string }
  | Include_cycle of string list
  | Duplicate_theme_label of string
  | Unknown_theme_label of string
  | Foreign_token of { transform : string }
  | Invalid_data_key of string

let to_string = function
  | Unknown_language lang ->
      Printf.sprintf "unknown language '%s'" lang
  | Grammar_error { lang = _; path = Some path; message } ->
      path ^ ": " ^ message
  | Grammar_error { lang; path = None; message } ->
      Printf.sprintf "grammar '%s': %s" lang message
  | Theme_error { path = Some path; message } ->
      path ^ ": " ^ message
  | Theme_error { path = None; message } ->
      message
  | Include_cycle paths ->
      "theme include cycle: " ^ String.concat " -> " paths
  | Duplicate_theme_label label ->
      Printf.sprintf
        "the theme label %S is used twice (after replacing characters outside \
         A-Za-z0-9_-); each theme needs its own label"
        label
  | Foreign_token { transform } ->
      Printf.sprintf
        "transform %S returned a token from another highlighted value, which \
         has a different number of themes"
        transform
  | Invalid_data_key key ->
      Printf.sprintf
        "invalid decoration data key %S: it must be non-empty and hold only \
         letters, digits, '-' and '_', since it becomes part of a data-* \
         attribute name"
        key
  | Unknown_theme_label label ->
      Printf.sprintf "no theme has the label %S" label
