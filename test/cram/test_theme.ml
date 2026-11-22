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

let test_named name =
  match Tm_themes.find name with
  | Some json ->
      print_theme_summary (Ochre.Theme.load_exn json)
  | None ->
      Printf.eprintf "unknown theme: %s\n" name;
      exit 1

let test_load_file path =
  match Ochre.Theme.load_from_file path with
  | Ok theme ->
      print_theme theme
  | Error msg ->
      Printf.printf "error: %s\n" msg;
      exit 1

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
  | "dark-plus" ->
      test_named "dark-plus"
  | "light-plus" ->
      test_named "light-plus"
  | "tokyo-night" ->
      test_named "tokyo-night"
  | "load-file" ->
      test_load_file Sys.argv.(2)
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
