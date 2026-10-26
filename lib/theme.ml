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
  kind : string option;
  colors : (string * color) list;
  fg_legacy : color option;
  bg_legacy : color option;
  token_colors : token_color_rule list;
}

(* Yojson's own message already names the line/byte range; just fold its
   embedded newline so the error reads as one line. *)
let describe_json_error msg = String.map (function '\n' -> ' ' | c -> c) msg

let empty_settings = { foreground = None; background = None; font_style = None }

let rule ?name ?(scope = []) ?foreground ?background ?font_style () =
  { name; scope; settings = { foreground; background; font_style } }

let json_field key = function
  | `Assoc fields ->
      List.assoc_opt key fields
  | _ ->
      None

let is_valid_color color =
  let is_hex c =
    (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')
  in
  let length = String.length color in
  length > 0
  && color.[0] = '#'
  && List.mem (length - 1) [ 3; 4; 6; 8 ]
  && String.for_all is_hex (String.sub color 1 (length - 1))

let strip_commas text =
  let is_comma c = c = ',' in
  let length = String.length text in
  let first = ref 0 and last = ref length in
  while !first < length && is_comma text.[!first] do
    incr first
  done;
  while !last > !first && is_comma text.[!last - 1] do
    decr last
  done;
  String.sub text !first (!last - !first)

let parse_scope = function
  | `String s ->
      Some (String.split_on_char ',' (strip_commas s))
  | `List l -> (
      match List.filter_map (function `String s -> Some s | _ -> None) l with
      | [] ->
          None
      | scopes ->
          Some scopes
    )
  | _ ->
      Some []

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
        | _ ->
            None
      in
      { foreground; background; font_style }
  | _ ->
      empty_settings

let parse_token_color_rule = function
  | `Assoc _ as json -> (
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
            Some []
      in
      let settings =
        match json_field "settings" json with
        | None
        | Some `Null
        | Some (`Bool false)
        | Some (`Int 0)
        | Some (`String "") ->
            None
        | Some s ->
            Some (parse_settings s)
      in
      match (scope, settings) with
      | Some scope, Some settings ->
          Some { name; scope; settings }
      | _ ->
          None
    )
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

let is_global_rule rule =
  rule.scope = [] || List.exists (fun s -> String.trim s = "") rule.scope

let resolve_defaults_from_scope_less token_colors =
  let valid = function Some c when is_valid_color c -> Some c | _ -> None in
  List.fold_left
    (fun (fg, bg) rule ->
      if is_global_rule rule then
        let fg =
          match valid rule.settings.foreground with
          | Some c ->
              Some c
          | None ->
              fg
        in
        let bg =
          match valid rule.settings.background with
          | Some c ->
              Some c
          | None ->
              bg
        in
        (fg, bg)
      else
        (fg, bg)
    )
    (None, None) token_colors

let fallback_colors = function
  | Some "dark" ->
      ("#bbbbbb", "#1e1e1e")
  | Some "light" ->
      ("#333333", "#fffffe")
  | _ ->
      ("#000000", "#ffffff")

let finalize_theme ~name ~kind ~colors ~fg_legacy ~bg_legacy ~token_colors =
  let defaults_fg, defaults_bg =
    resolve_defaults_from_scope_less token_colors
  in
  let fallback_fg, fallback_bg = fallback_colors kind in
  let first options fallback =
    match List.find_map Fun.id options with Some c -> c | None -> fallback
  in
  let fg =
    first
      [ defaults_fg; fg_legacy; assoc_color "editor.foreground" colors ]
      fallback_fg
  in
  let bg =
    first
      [ defaults_bg; bg_legacy; assoc_color "editor.background" colors ]
      fallback_bg
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
  (* Missing tokenColors is common in themes that inherit all rules via
     "include". Producing empty rules here is correct; merge_loaded supplies
     the actual rules. "settings" wins over "tokenColors", as in Shiki's
     normalizeTheme. *)
  let token_colors =
    let falsy = function
      | None
      | Some `Null
      | Some (`Bool false)
      | Some (`Int 0)
      | Some (`String "") ->
          true
      | _ ->
          false
    in
    match (json_field "settings" json, json_field "tokenColors" json) with
    | settings, _ when not (falsy settings) ->
        load_rules_from_ref (Option.get settings)
    | _, Some value ->
        load_rules_from_ref value
    | _, None ->
        []
  in
  let kind =
    match json_field "type" json with Some (`String s) -> Some s | _ -> None
  in
  let include_path =
    match json_field "include" json with
    | Some (`String s) ->
        Some s
    | _ ->
        None
  in
  ({ name_opt; kind; colors; fg_legacy; bg_legacy; token_colors }, include_path)

let merge_loaded parent child =
  {
    name_opt =
      ( match child.name_opt with
      | Some _ ->
          child.name_opt
      | None ->
          parent.name_opt
      );
    kind = (match child.kind with Some _ -> child.kind | None -> parent.kind);
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

(* Lexical normalization so that cycle detection compares equal paths even when
   includes are written with "." or ".." segments (e.g. "./a.json"). *)
let normalize_path path =
  let absolute = not (Filename.is_relative path) in
  let resolved =
    List.fold_left
      (fun acc segment ->
        match segment with
        | "" | "." ->
            acc
        | ".." -> (
            match acc with
            | head :: rest when head <> ".." ->
                rest
            | _ ->
                if absolute then
                  acc
                else
                  ".." :: acc
          )
        | segment ->
            segment :: acc
      )
      []
      (String.split_on_char '/' path)
  in
  let body = String.concat "/" (List.rev resolved) in
  if absolute then
    "/" ^ body
  else if body = "" then
    "."
  else
    body

let rec load_theme_data_from_json ?base_dir ~visited json =
  let local, include_path = parse_theme_fields ?base_dir json in
  match (include_path, base_dir) with
  | Some include_path, Some dir ->
      let resolved =
        normalize_path
          ( if Filename.is_relative include_path then
              Filename.concat dir include_path
            else
              include_path
          )
      in
      if List.mem resolved visited then
        failwith ("Theme include cycle detected at: " ^ resolved)
      else
        let parent =
          load_theme_data_from_path ~visited:(resolved :: visited) resolved
        in
        merge_loaded parent local
  | Some include_path, None ->
      failwith
        (Printf.sprintf
           "theme includes %S but no base_dir was given to resolve it"
           include_path
        )
  | None, _ ->
      local

and load_theme_data_from_path ~visited path =
  let json =
    try Yojson.Basic.from_file path
    with Yojson.Json_error msg ->
      failwith
        (Printf.sprintf "%s: invalid JSON: %s" path (describe_json_error msg))
  in
  let dir = Filename.dirname path in
  load_theme_data_from_json ~base_dir:dir ~visited json

let make ~name ?(colors = []) ~token_colors () =
  finalize_theme ~name ~kind:None ~colors ~fg_legacy:None ~bg_legacy:None
    ~token_colors

let load_from_file_exn path =
  Exn_utils.wrap_exn (fun () ->
      let data =
        load_theme_data_from_path ~visited:[ normalize_path path ] path
      in
      let name = Option.value data.name_opt ~default:(Filename.basename path) in
      finalize_theme ~name ~kind:data.kind ~colors:data.colors
        ~fg_legacy:data.fg_legacy ~bg_legacy:data.bg_legacy
        ~token_colors:data.token_colors
  )

let load_from_file path =
  try Ok (load_from_file_exn path) with Failure msg -> Error msg

let load_exn ?base_dir str =
  Exn_utils.wrap_exn (fun () ->
      let json =
        try Yojson.Basic.from_string str
        with Yojson.Json_error msg ->
          failwith (Printf.sprintf "invalid JSON: %s" (describe_json_error msg))
      in
      let data = load_theme_data_from_json ?base_dir ~visited:[] json in
      let name = Option.value data.name_opt ~default:"unnamed" in
      finalize_theme ~name ~kind:data.kind ~colors:data.colors
        ~fg_legacy:data.fg_legacy ~bg_legacy:data.bg_legacy
        ~token_colors:data.token_colors
  )

let load ?base_dir str =
  try Ok (load_exn ?base_dir str) with Failure msg -> Error msg

let load_builtin json ~name =
  let theme = load_exn json in
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
