open Melange_json.Primitives

type settings_json = {
  foreground : string option; [@json.option]
  background : string option; [@json.option]
  font_style_raw : string option; [@json.option] [@json.key "fontStyle"]
}
[@@deriving of_json] [@@json.allow_extra_fields]

type colors = {
  editor_foreground : string option;
      [@json.option] [@json.key "editor.foreground"]
  editor_background : string option;
      [@json.option] [@json.key "editor.background"]
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
type font_style = Token.font_style = Bold | Italic | Underline | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list;
}

type token_color_rule = { scope : string list; settings : token_color_settings }

type theme = {
  name : string;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}

let theme_settings ?foreground ?background ?(font_style = []) () =
  { foreground; background; font_style }

let theme_rule scope settings = { scope; settings }

let make_theme ~name ~fg ~bg ~comment ~string ~number ~keyword ~fn ~typ =
  {
    name;
    fg;
    bg;
    token_colors =
      [
        theme_rule [ "comment" ] (theme_settings ~foreground:comment ());
        theme_rule [ "string" ] (theme_settings ~foreground:string ());
        theme_rule [ "constant.numeric" ] (theme_settings ~foreground:number ());
        theme_rule [ "keyword" ] (theme_settings ~foreground:keyword ());
        theme_rule [ "entity.name.function" ] (theme_settings ~foreground:fn ());
        theme_rule [ "entity.name.type" ] (theme_settings ~foreground:typ ());
      ];
  }

let opencode_dark =
  make_theme ~name:"opencode-dark" ~fg:"#d4d4d4" ~bg:"#1e1e1e"
    ~comment:"#6a9955" ~string:"#ce9178" ~number:"#b5cea8" ~keyword:"#569cd6"
    ~fn:"#dcdcaa" ~typ:"#4ec9b0"

let opencode_light =
  make_theme ~name:"opencode-light" ~fg:"#1f2328" ~bg:"#ffffff"
    ~comment:"#6a737d" ~string:"#032f62" ~number:"#005cc5" ~keyword:"#d73a49"
    ~fn:"#6f42c1" ~typ:"#22863a"

let tokyonight =
  make_theme ~name:"tokyonight" ~fg:"#c0caf5" ~bg:"#1a1b26" ~comment:"#565f89"
    ~string:"#9ece6a" ~number:"#ff9e64" ~keyword:"#7aa2f7" ~fn:"#7dcfff"
    ~typ:"#2ac3de"

let everforest =
  make_theme ~name:"everforest" ~fg:"#d3c6aa" ~bg:"#2d353b" ~comment:"#859289"
    ~string:"#a7c080" ~number:"#d699b6" ~keyword:"#e67e80" ~fn:"#83c092"
    ~typ:"#7fbbb3"

let ayu =
  make_theme ~name:"ayu" ~fg:"#b3b1ad" ~bg:"#0a0e14" ~comment:"#5c6773"
    ~string:"#aad94c" ~number:"#ff8f40" ~keyword:"#ffb454" ~fn:"#ffd580"
    ~typ:"#73d0ff"

let catppuccin =
  make_theme ~name:"catppuccin" ~fg:"#cdd6f4" ~bg:"#1e1e2e" ~comment:"#6c7086"
    ~string:"#a6e3a1" ~number:"#fab387" ~keyword:"#cba6f7" ~fn:"#89b4fa"
    ~typ:"#94e2d5"

let catppuccin_macchiato =
  make_theme ~name:"catppuccin-macchiato" ~fg:"#cad3f5" ~bg:"#24273a"
    ~comment:"#6e738d" ~string:"#a6da95" ~number:"#f5a97f" ~keyword:"#c6a0f6"
    ~fn:"#8aadf4" ~typ:"#8bd5ca"

let gruvbox =
  make_theme ~name:"gruvbox" ~fg:"#ebdbb2" ~bg:"#282828" ~comment:"#928374"
    ~string:"#b8bb26" ~number:"#d3869b" ~keyword:"#fb4934" ~fn:"#fabd2f"
    ~typ:"#8ec07c"

let kanagawa =
  make_theme ~name:"kanagawa" ~fg:"#dcd7ba" ~bg:"#1f1f28" ~comment:"#727169"
    ~string:"#98bb6c" ~number:"#ffa066" ~keyword:"#957fb8" ~fn:"#7e9cd8"
    ~typ:"#7aa89f"

let nord =
  make_theme ~name:"nord" ~fg:"#d8dee9" ~bg:"#2e3440" ~comment:"#616e88"
    ~string:"#a3be8c" ~number:"#b48ead" ~keyword:"#81a1c1" ~fn:"#88c0d0"
    ~typ:"#8fbcbb"

let matrix =
  make_theme ~name:"matrix" ~fg:"#00ff41" ~bg:"#000000" ~comment:"#008f11"
    ~string:"#00cc33" ~number:"#66ff66" ~keyword:"#39ff14" ~fn:"#00ff99"
    ~typ:"#00ff66"

let one_dark =
  make_theme ~name:"one-dark" ~fg:"#abb2bf" ~bg:"#282c34" ~comment:"#5c6370"
    ~string:"#98c379" ~number:"#d19a66" ~keyword:"#c678dd" ~fn:"#61afef"
    ~typ:"#e5c07b"

let named_themes =
  [
    ("opencode-dark", opencode_dark);
    ("opencode-light", opencode_light);
    ("tokyonight", tokyonight);
    ("everforest", everforest);
    ("ayu", ayu);
    ("catppuccin", catppuccin);
    ("catppuccin-macchiato", catppuccin_macchiato);
    ("gruvbox", gruvbox);
    ("kanagawa", kanagawa);
    ("nord", nord);
    ("matrix", matrix);
    ("one-dark", one_dark);
  ]

let theme_aliases =
  [
    ("dark", "opencode-dark");
    ("light", "opencode-light");
    ("builtin-dark", "opencode-dark");
    ("builtin-light", "opencode-light");
    ("catppuccin_macchiato", "catppuccin-macchiato");
    ("onedark", "one-dark");
    ("one_dark", "one-dark");
  ]

let normalize_name s = String.lowercase_ascii (String.trim s)

let canonical_name name =
  let normalized = normalize_name name in
  Option.value (List.assoc_opt normalized theme_aliases) ~default:normalized

let available_names = List.map fst named_themes

let make name =
  let key = canonical_name name in
  List.assoc_opt key named_themes

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

let load path =
  let json = Yojson.Basic.from_file path in
  let theme = load_theme json in
  let name =
    if theme.name = "unnamed" then Filename.basename path else theme.name
  in
  { theme with name }

let load_from_string str = Yojson.Basic.from_string str |> load_theme

let load_any name_or_path =
  match make name_or_path with Some theme -> theme | None -> load name_or_path
