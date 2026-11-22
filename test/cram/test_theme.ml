let print_rule (rule : Ochre.Theme.token_color_rule) =
  Printf.printf "  scopes: [%s]\n" (String.concat ", " rule.scope);
  Printf.printf "  fg: %s\n"
    (Option.fold ~none:"none" ~some:Support.hex rule.settings.foreground);
  Option.iter
    (fun c -> Printf.printf "  bg: %s\n" (Support.hex c))
    rule.settings.background;
  Option.iter
    (fun font_style ->
      Printf.printf "  styles: [%s]\n"
        (String.concat ", " (Support.font_style_names font_style))
    )
    rule.settings.font_style

let print_theme (theme : Ochre.Theme.theme) =
  Printf.printf "name: %s\n" theme.name;
  Printf.printf "fg: %s\n" (Support.hex theme.fg);
  Printf.printf "bg: %s\n" (Support.hex theme.bg);
  Printf.printf "rules: %d\n" (List.length theme.token_colors);
  List.iter print_rule theme.token_colors

let print_theme_summary (theme : Ochre.Theme.theme) =
  Printf.printf "name: %s\n" theme.name;
  Printf.printf "fg: %s\n" (Support.hex theme.fg);
  Printf.printf "bg: %s\n" (Support.hex theme.bg);
  Printf.printf "rules: %d\n" (List.length theme.token_colors)

let test_load () =
  fst
    (Support.get_ok
       (Ochre.Theme.load
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
       )
    )
  |> print_theme

let test_defaults () =
  fst (Support.get_ok (Ochre.Theme.load {|{}|})) |> print_theme

let test_multiple_styles () =
  fst
    (Support.get_ok
       (Ochre.Theme.load
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
       )
    )
  |> print_theme

let test_no_settings () =
  fst
    (Support.get_ok
       (Ochre.Theme.load
          {|{
    "name": "no-settings",
    "tokenColors": [
      { "scope": "comment" }
    ]
  }|}
       )
    )
  |> print_theme

let test_array_scope () =
  fst
    (Support.get_ok
       (Ochre.Theme.load
          {|{
    "name": "array-scope",
    "tokenColors": [
      {
        "scope": ["string", "string.quoted", "string.template"],
        "settings": { "foreground": "#ce9178" }
      }
    ]
  }|}
       )
    )
  |> print_theme

let test_alt_keys () =
  fst
    (Support.get_ok
       (Ochre.Theme.load
          {|{
    "name": "alt-keys",
    "fg": "#aabbcc",
    "bg": "#112233"
  }|}
       )
    )
  |> print_theme

let test_named name =
  match Tm_themes.find name with
  | Some json ->
      print_theme_summary (Support.load_theme json)
  | None ->
      Printf.eprintf "unknown theme: %s\n" name;
      exit 1

let test_load_file path =
  match Ochre.Theme.load_from_file path with
  | Ok (theme, warnings) ->
      List.iter
        (fun w ->
          Printf.printf "warning: %s\n" (Ochre.Theme.warning_to_string w)
        )
        warnings;
      print_theme theme
  | Error error ->
      Printf.printf "error: %s\n" (Ochre.Error.to_string error);
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
