let style_to_string = function
  | Ochre.Theme.Bold ->
      "bold"
  | Italic ->
      "italic"
  | Underline ->
      "underline"
  | Strikethrough ->
      "strikethrough"

let print_rule (rule : Ochre.Theme.token_color_rule) =
  Printf.printf "  scopes: [%s]\n" (String.concat ", " rule.scope);
  Printf.printf "  fg: %s\n"
    (Option.value ~default:"none" rule.settings.foreground);
  ( match rule.settings.background with
  | Some c ->
      Printf.printf "  bg: %s\n" c
  | None ->
      ()
  );
  match rule.settings.font_style with
  | Some font_style ->
      let styles = List.map style_to_string font_style in
      Printf.printf "  styles: [%s]\n" (String.concat ", " styles)
  | None ->
      ()

let print_theme (theme : Ochre.Theme.theme) =
  Printf.printf "name: %s\n" theme.name;
  Printf.printf "fg: %s\n" theme.fg;
  Printf.printf "bg: %s\n" theme.bg;
  Printf.printf "rules: %d\n" (List.length theme.token_colors);
  List.iter print_rule theme.token_colors

let print_theme_summary (theme : Ochre.Theme.theme) =
  Printf.printf "name: %s\n" theme.name;
  Printf.printf "fg: %s\n" theme.fg;
  Printf.printf "bg: %s\n" theme.bg;
  Printf.printf "rules: %d\n" (List.length theme.token_colors)

let test_load () =
  Ochre.Theme.load_exn
    {|{
    "name": "test-theme",
    "colors": {
      "editor.foreground": "#abcdef",
      "editor.background": "#123456"
    },
    "tokenColors": [
      {
        "scope": "comment",
        "settings": {
          "foreground": "#888888",
          "fontStyle": "italic"
        }
      },
      {
        "scope": ["keyword", "storage.type"],
        "settings": {
          "foreground": "#ff0000",
          "fontStyle": "bold"
        }
      }
    ]
  }|}
  |> print_theme

let test_defaults () = Ochre.Theme.load_exn {|{}|} |> print_theme

let test_multiple_styles () =
  Ochre.Theme.load_exn
    {|{
    "name": "multi-style",
    "tokenColors": [
      {
        "scope": "emphasis",
        "settings": {
          "fontStyle": "bold italic underline"
        }
      }
    ]
  }|}
  |> print_theme

let test_no_settings () =
  Ochre.Theme.load_exn
    {|{
    "name": "no-settings",
    "tokenColors": [
      { "scope": "comment" }
    ]
  }|}
  |> print_theme

let test_array_scope () =
  Ochre.Theme.load_exn
    {|{
    "name": "array-scope",
    "tokenColors": [
      {
        "scope": ["string", "string.quoted", "string.template"],
        "settings": { "foreground": "#ce9178" }
      }
    ]
  }|}
  |> print_theme

let test_alt_keys () =
  Ochre.Theme.load_exn
    {|{
    "name": "alt-keys",
    "fg": "#aabbcc",
    "bg": "#112233"
  }|}
  |> print_theme

let test_builtin_name name =
  match Ochre.Theme.find name with
  | Some theme ->
      print_theme_summary theme
  | None ->
      Printf.eprintf "unknown built-in theme: %s\n" name;
      exit 1

let test_builtin_alias name =
  match Ochre.Theme.find name with
  | Some theme ->
      print_theme_summary theme
  | None ->
      Printf.eprintf "unknown built-in theme: %s\n" name;
      exit 1

let test_available () = List.iter print_endline Ochre.Theme.available_names

let () =
  match Sys.argv.(1) with
  | "load" ->
      test_load ()
  | "defaults" ->
      test_defaults ()
  | "multiple-styles" ->
      test_multiple_styles ()
  | "no-settings" ->
      test_no_settings ()
  | "array-scope" ->
      test_array_scope ()
  | "alt-keys" ->
      test_alt_keys ()
  | "builtin-dark" ->
      test_builtin_name "dark"
  | "builtin-light" ->
      test_builtin_name "light"
  | "tokyonight" ->
      test_builtin_name "tokyonight"
  | "load-dark-alias" ->
      test_builtin_alias "dark"
  | "available" ->
      test_available ()
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
