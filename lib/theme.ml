type color = string
type font_style = Token.font_style = Bold | Italic | Underline | Strikethrough

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : font_style list option;
}

type token_color_rule = {
  name : string option;
  scope : string list;
  settings : token_color_settings;
}

type theme = {
  name : string;
  colors : (string * color) list;
  fg : color;
  bg : color;
  token_colors : token_color_rule list;
}

type loaded_theme_data = {
  name_opt : string option;
  colors : (string * color) list;
  fg_legacy : color option;
  bg_legacy : color option;
  token_colors : token_color_rule list;
}

let empty_settings = { foreground = None; background = None; font_style = None }

let rule ?name ?(scope = []) ?foreground ?background ?font_style () =
  { name; scope; settings = { foreground; background; font_style } }

let json_field key = function
  | `Assoc fields ->
      List.assoc_opt key fields
  | _ ->
      None

let parse_scope = function
  | `String s ->
      [ s ]
  | `List l ->
      List.filter_map (function `String s -> Some s | _ -> None) l
  | _ ->
      []

let parse_font_style = function
  | "bold" ->
      Some Bold
  | "italic" ->
      Some Italic
  | "underline" ->
      Some Underline
  | "strikethrough" ->
      Some Strikethrough
  | _ ->
      None

let parse_font_style_raw raw =
  let trimmed = String.trim raw in
  if trimmed = "" || trimmed = "none" then
    Some []
  else
    Some
      (String.split_on_char ' ' trimmed
      |> List.map String.trim
      |> List.filter (fun s -> s <> "")
      |> List.filter_map parse_font_style
      )

let parse_settings = function
  | `Assoc _ as json ->
      let foreground =
        match json_field "foreground" json with
        | Some (`String s) ->
            Some s
        | _ ->
            None
      in
      let background =
        match json_field "background" json with
        | Some (`String s) ->
            Some s
        | _ ->
            None
      in
      let font_style =
        match json_field "fontStyle" json with
        | Some (`String s) ->
            parse_font_style_raw s
        | Some _ ->
            Some []
        | None ->
            None
      in
      { foreground; background; font_style }
  | _ ->
      empty_settings

let parse_token_color_rule = function
  | `Assoc _ as json ->
      let name =
        match json_field "name" json with
        | Some (`String s) ->
            Some s
        | _ ->
            None
      in
      let scope =
        match json_field "scope" json with
        | Some v ->
            parse_scope v
        | None ->
            []
      in
      let settings =
        match json_field "settings" json with
        | Some s ->
            parse_settings s
        | None ->
            empty_settings
      in
      Some { name; scope; settings }
  | _ ->
      (* Non-object entries in tokenColors are malformed; skip rather than fail
         because real-world themes sometimes include stray nulls or comments. *)
      None

let parse_rules_json = function
  | `List entries ->
      List.filter_map parse_token_color_rule entries
  | _ ->
      []

let merge_colors base overlay =
  List.fold_left
    (fun acc (key, value) ->
      let without_key = List.filter (fun (k, _) -> k <> key) acc in
      without_key @ [ (key, value) ]
    )
    base overlay

let parse_colors = function
  | `Assoc fields ->
      List.filter_map
        (function key, `String value -> Some (key, value) | _ -> None)
        fields
  | _ ->
      []

let assoc_color key colors =
  match List.find_opt (fun (k, _) -> k = key) colors with
  | Some (_, value) ->
      Some value
  | None ->
      None

let resolve_defaults_from_scope_less token_colors =
  List.fold_left
    (fun (fg, bg) rule ->
      if rule.scope = [] then
        let fg =
          match rule.settings.foreground with Some c -> Some c | None -> fg
        in
        let bg =
          match rule.settings.background with Some c -> Some c | None -> bg
        in
        (fg, bg)
      else
        (fg, bg)
    )
    (None, None) token_colors

let resolve_color primary fallback default =
  match primary with Some c -> c | None -> Option.value fallback ~default

let finalize_theme ~name ~colors ~fg_legacy ~bg_legacy ~token_colors =
  let defaults_fg, defaults_bg =
    resolve_defaults_from_scope_less token_colors
  in
  let fg =
    resolve_color
      (assoc_color "editor.foreground" colors)
      (match fg_legacy with Some c -> Some c | None -> defaults_fg)
      "#000000"
  in
  let bg =
    resolve_color
      (assoc_color "editor.background" colors)
      (match bg_legacy with Some c -> Some c | None -> defaults_bg)
      "#ffffff"
  in
  { name; colors; fg; bg; token_colors }

let parse_theme_fields ?base_dir json =
  let name_opt =
    match json_field "name" json with Some (`String s) -> Some s | _ -> None
  in
  let colors =
    match json_field "colors" json with Some v -> parse_colors v | None -> []
  in
  (* fg/bg fall back through "fg" -> "foreground" -> None. Non-string values
     are ignored because some themes use objects or numbers here; the color
     cascade in finalize_theme will supply a sensible default. *)
  let fg_legacy =
    match json_field "fg" json with
    | Some (`String s) ->
        Some s
    | _ -> (
        match json_field "foreground" json with
        | Some (`String s) ->
            Some s
        | _ ->
            None
      )
  in
  let bg_legacy =
    match json_field "bg" json with
    | Some (`String s) ->
        Some s
    | _ -> (
        match json_field "background" json with
        | Some (`String s) ->
            Some s
        | _ ->
            None
      )
  in
  let load_rules_from_ref = function
    | `String rel_path -> (
        match base_dir with
        | Some dir ->
            let path =
              if Filename.is_relative rel_path then
                Filename.concat dir rel_path
              else
                rel_path
            in
            Yojson.Basic.from_file path |> parse_rules_json
        | None ->
            []
      )
    | json_rules ->
        parse_rules_json json_rules
  in
  (* Missing tokenColors is common in themes that rely entirely on "settings"
     or inherit all rules via "include". Producing empty rules here is correct;
     merge_loaded or settings_rules below will supply the actual rules. *)
  let token_colors =
    match json_field "tokenColors" json with
    | Some value ->
        load_rules_from_ref value
    | None ->
        []
  in
  let settings_rules =
    match json_field "settings" json with
    | Some value ->
        load_rules_from_ref value
    | None ->
        []
  in
  let include_path =
    match json_field "include" json with
    | Some (`String s) ->
        Some s
    | _ ->
        None
  in
  ( {
      name_opt;
      colors;
      fg_legacy;
      bg_legacy;
      token_colors = token_colors @ settings_rules;
    },
    include_path
  )

let merge_loaded parent child =
  {
    name_opt =
      ( match child.name_opt with
      | Some _ ->
          child.name_opt
      | None ->
          parent.name_opt
      );
    colors = merge_colors parent.colors child.colors;
    fg_legacy =
      ( match child.fg_legacy with
      | Some _ ->
          child.fg_legacy
      | None ->
          parent.fg_legacy
      );
    bg_legacy =
      ( match child.bg_legacy with
      | Some _ ->
          child.bg_legacy
      | None ->
          parent.bg_legacy
      );
    token_colors = parent.token_colors @ child.token_colors;
  }

let rec load_theme_data_from_json ?base_dir ~visited json =
  let local, include_path = parse_theme_fields ?base_dir json in
  match (include_path, base_dir) with
  | Some include_path, Some dir ->
      let resolved =
        if Filename.is_relative include_path then
          Filename.concat dir include_path
        else
          include_path
      in
      if List.mem resolved visited then
        failwith ("Theme include cycle detected at: " ^ resolved)
      else
        let parent =
          load_theme_data_from_path ~visited:(resolved :: visited) resolved
        in
        merge_loaded parent local
  | _ ->
      local

and load_theme_data_from_path ~visited path =
  let json = Yojson.Basic.from_file path in
  let dir = Filename.dirname path in
  load_theme_data_from_json ~base_dir:dir ~visited json

let make ~name ?(colors = []) ~token_colors () =
  finalize_theme ~name ~colors ~fg_legacy:None ~bg_legacy:None ~token_colors

let load path =
  let data = load_theme_data_from_path ~visited:[ path ] path in
  let name = Option.value data.name_opt ~default:(Filename.basename path) in
  finalize_theme ~name ~colors:data.colors ~fg_legacy:data.fg_legacy
    ~bg_legacy:data.bg_legacy ~token_colors:data.token_colors

let load_from_string ?base_dir str =
  let json = Yojson.Basic.from_string str in
  (* Without base_dir, any "include" field in the JSON is silently ignored
     because we have no directory to resolve relative paths against. *)
  let data = load_theme_data_from_json ?base_dir ~visited:[] json in
  let name = Option.value data.name_opt ~default:"unnamed" in
  finalize_theme ~name ~colors:data.colors ~fg_legacy:data.fg_legacy
    ~bg_legacy:data.bg_legacy ~token_colors:data.token_colors

let load_builtin json ~name =
  let theme = load_from_string json in
  { theme with name }

let lazy_builtin json ~name = lazy (load_builtin json ~name)

let lazy_themes : (string * theme Lazy.t) list =
  [
    ("dark", lazy_builtin Theme_builtin_json.dark_plus ~name:"dark");
    ("light", lazy_builtin Theme_builtin_json.light_plus ~name:"light");
    ( "tokyonight",
      lazy_builtin Theme_builtin_json.tokyo_night ~name:"tokyonight"
    );
    ( "everforest",
      lazy_builtin Theme_builtin_json.everforest_dark ~name:"everforest"
    );
    ("ayu", lazy_builtin Theme_builtin_json.ayu_dark ~name:"ayu");
    ( "catppuccin",
      lazy_builtin Theme_builtin_json.catppuccin_mocha ~name:"catppuccin"
    );
    ( "catppuccin-macchiato",
      lazy_builtin Theme_builtin_json.catppuccin_macchiato
        ~name:"catppuccin-macchiato"
    );
    ( "gruvbox",
      lazy_builtin Theme_builtin_json.gruvbox_dark_medium ~name:"gruvbox"
    );
    ("kanagawa", lazy_builtin Theme_builtin_json.kanagawa_wave ~name:"kanagawa");
    ("nord", lazy_builtin Theme_builtin_json.nord ~name:"nord");
    ( "matrix",
      lazy
        (make ~name:"matrix"
           ~colors:
             [
               ("editor.foreground", "#00ff41"); ("editor.background", "#000000");
             ]
           ~token_colors:
             [
               rule ~scope:[ "comment" ] ~foreground:"#008f11"
                 ~font_style:[ Italic ] ();
               rule ~scope:[ "string" ] ~foreground:"#00cc33" ();
               rule ~scope:[ "constant.numeric" ] ~foreground:"#66ff66" ();
               rule ~scope:[ "keyword" ] ~foreground:"#39ff14" ();
               rule ~scope:[ "entity.name.function" ] ~foreground:"#00ff99" ();
               rule ~scope:[ "entity.name.type" ] ~foreground:"#00ff66" ();
             ]
           ()
        )
    );
    ("one-dark", lazy_builtin Theme_builtin_json.one_dark_pro ~name:"one-dark");
  ]

let find name =
  match List.assoc_opt name lazy_themes with
  | Some t ->
      Some (Lazy.force t)
  | None ->
      None

let available_names = List.map fst lazy_themes
let themes = List.map (fun (name, t) -> (name, Lazy.force t)) lazy_themes
let dark = Lazy.force (List.assoc "dark" lazy_themes)
let light = Lazy.force (List.assoc "light" lazy_themes)
let tokyonight = Lazy.force (List.assoc "tokyonight" lazy_themes)
let everforest = Lazy.force (List.assoc "everforest" lazy_themes)
let ayu = Lazy.force (List.assoc "ayu" lazy_themes)
let catppuccin = Lazy.force (List.assoc "catppuccin" lazy_themes)
let catppuccin_macchiato =
  Lazy.force (List.assoc "catppuccin-macchiato" lazy_themes)
let gruvbox = Lazy.force (List.assoc "gruvbox" lazy_themes)
let kanagawa = Lazy.force (List.assoc "kanagawa" lazy_themes)
let nord = Lazy.force (List.assoc "nord" lazy_themes)
let matrix = Lazy.force (List.assoc "matrix" lazy_themes)
let one_dark = Lazy.force (List.assoc "one-dark" lazy_themes)
