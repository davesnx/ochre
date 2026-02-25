let style_to_string = function
  | Ochre.Theme.Bold -> "bold"
  | Italic -> "italic"
  | Underline -> "underline"
  | Strikethrough -> "strikethrough"

let print_rule (rule : Ochre.Theme.token_color_rule) =
  Printf.printf "  scopes: [%s]\n" (String.concat ", " rule.scope);
  Printf.printf "  fg: %s\n"
    (Option.value ~default:"none" rule.settings.foreground);
  (match rule.settings.background with
   | Some c -> Printf.printf "  bg: %s\n" c
   | None -> ());
  let styles = List.map style_to_string rule.settings.font_style in
  if styles <> [] then
    Printf.printf "  styles: [%s]\n" (String.concat ", " styles)

let print_theme (theme : Ochre.Theme.theme) =
  Printf.printf "name: %s\n" theme.name;
  Printf.printf "fg: %s\n" theme.fg;
  Printf.printf "bg: %s\n" theme.bg;
  Printf.printf "rules: %d\n" (List.length theme.token_colors);
  List.iter print_rule theme.token_colors

let test_load () =
  Ochre.Theme.load_from_string {|{
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

let test_defaults () =
  Ochre.Theme.load_from_string {|{}|}
  |> print_theme

let test_multiple_styles () =
  Ochre.Theme.load_from_string {|{
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
  Ochre.Theme.load_from_string {|{
    "name": "no-settings",
    "tokenColors": [
      { "scope": "comment" }
    ]
  }|}
  |> print_theme

let test_array_scope () =
  Ochre.Theme.load_from_string {|{
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
  Ochre.Theme.load_from_string {|{
    "name": "alt-keys",
    "fg": "#aabbcc",
    "bg": "#112233"
  }|}
  |> print_theme

let () =
  match Sys.argv.(1) with
  | "load" -> test_load ()
  | "defaults" -> test_defaults ()
  | "multiple-styles" -> test_multiple_styles ()
  | "no-settings" -> test_no_settings ()
  | "array-scope" -> test_array_scope ()
  | "alt-keys" -> test_alt_keys ()
  | s -> Printf.eprintf "unknown: %s\n" s; exit 1
