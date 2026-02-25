open Melange_json.Primitives

type settings_json = {
  foreground : string option; [@json.option]
  background : string option; [@json.option]
  font_style_raw : string option; [@json.option] [@json.key "fontStyle"]
}
[@@deriving of_json] [@@json.allow_extra_fields]

type colors = {
  editor_foreground : string option; [@json.option] [@json.key "editor.foreground"]
  editor_background : string option; [@json.option] [@json.key "editor.background"]
}
[@@deriving of_json] [@@json.allow_extra_fields]

type theme_json = {
  name : string option; [@json.option]
  fg : string option; [@json.option]
  bg : string option; [@json.option]
  colors : colors option; [@json.option]
}
[@@deriving of_json] [@@json.allow_extra_fields]

type color = string

type font_style = Token.font_style =
  | Bold
  | Italic
  | Underline
  | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list;
}

type token_color_rule = {
  scope : string list;
  settings : token_color_settings;
}

type theme = {
  name : string;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}

let parse_font_style = function
  | "bold" -> Some Bold
  | "italic" -> Some Italic
  | "underline" -> Some Underline
  | "strikethrough" -> Some Strikethrough
  | _ -> None

let parse_font_styles str =
  String.split_on_char ' ' str |> List.filter_map parse_font_style

let settings_of_settings_json (s : settings_json) : token_color_settings =
  {
    foreground = s.foreground;
    background = s.background;
    font_style =
      (match s.font_style_raw with
      | Some str -> parse_font_styles str
      | None -> []);
  }

let parse_scope = function
  | `String s -> [ s ]
  | `List l -> List.filter_map (function `String s -> Some s | _ -> None) l
  | _ -> []

let json_field key = function
  | `Assoc fields -> List.assoc_opt key fields
  | _ -> None

let parse_token_color_rule json =
  let scope =
    match json_field "scope" json with Some v -> parse_scope v | None -> []
  in
  let settings =
    match json_field "settings" json with
    | Some s -> settings_json_of_json s |> settings_of_settings_json
    | None -> { foreground = None; background = None; font_style = [] }
  in
  { scope; settings }

let resolve_color primary fallback default =
  match primary with Some c -> c | None -> Option.value fallback ~default

let load_theme json =
  let tj = theme_json_of_json json in
  let colors_fg = Option.bind tj.colors (fun c -> c.editor_foreground) in
  let colors_bg = Option.bind tj.colors (fun c -> c.editor_background) in
  let name = Option.value tj.name ~default:"unnamed" in
  let fg = resolve_color colors_fg tj.fg "#000000" in
  let bg = resolve_color colors_bg tj.bg "#ffffff" in
  let token_colors =
    match json_field "tokenColors" json with
    | Some (`List l) -> List.map parse_token_color_rule l
    | _ -> []
  in
  { name; fg; bg; token_colors }

let load_from_file path =
  let json = Yojson.Basic.from_file path in
  let theme = load_theme json in
  let name =
    if theme.name = "unnamed" then Filename.basename path else theme.name
  in
  { theme with name }

let load_from_string str = Yojson.Basic.from_string str |> load_theme
