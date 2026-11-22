type color = Color.t

type token_color_settings = {
  foreground : color option;
  background : color option;
  font_style : Style.font_style option;
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

type warning = { path : string option; location : string; value : string }

let warning_to_string { path; location; value } =
  Printf.sprintf "%s%s: invalid color %S dropped"
    (match path with Some path -> path ^ ": " | None -> "")
    location value

type loaded_theme_data = {
  name_opt : string option;
  kind : string option;
  colors : (string * color) list;
  fg_legacy : color option;
  bg_legacy : color option;
  token_colors : token_color_rule list;
  warnings : warning list;
}

let describe_json_error msg = String.map (function '\n' -> ' ' | c -> c) msg

let rule ?name ?(scope = []) ?foreground ?background ?font_style () =
  { name; scope; settings = { foreground; background; font_style } }

let json_field key = function
  | `Assoc fields ->
      List.assoc_opt key fields
  | _ ->
      None

type parser = { path : string option; mutable warnings : warning list }

let parse_color parser ~location value =
  match Color.of_hex value with
  | Some _ as color ->
      color
  | None ->
      parser.warnings <-
        { path = parser.path; location; value } :: parser.warnings;
      None

let string_color parser ~location = function
  | Some (`String value) ->
      parse_color parser ~location value
  | _ ->
      None

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

let parse_font_style raw =
  List.fold_left
    (fun (style : Style.font_style) word ->
      match word with
      | "bold" ->
          { style with bold = true }
      | "italic" ->
          { style with italic = true }
      | "underline" ->
          { style with underline = true }
      | "strikethrough" ->
          { style with strikethrough = true }
      | _ ->
          style
    )
    Style.plain
    (String.split_on_char ' ' (String.trim raw))

let parse_settings parser ~location json =
  let color key =
    string_color parser ~location:(location ^ "." ^ key) (json_field key json)
  in
  let foreground = color "foreground" in
  let background = color "background" in
  let font_style =
    match json_field "fontStyle" json with
    | Some (`String s) ->
        Some (parse_font_style s)
    | _ ->
        None
  in
  { foreground; background; font_style }

let is_falsy = function
  | None | Some `Null | Some (`Bool false) | Some (`Int 0) | Some (`String "")
    ->
      true
  | _ ->
      false

let parse_token_color_rule parser ~location = function
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
        | settings when is_falsy settings ->
            None
        | Some (`Assoc _ as settings) ->
            Some
              (parse_settings parser ~location:(location ^ ".settings") settings)
        | _ ->
            Some { foreground = None; background = None; font_style = None }
      in
      match (scope, settings) with
      | Some scope, Some settings ->
          Some { name; scope; settings }
      | _ ->
          None
    )
  | _ ->
      None

let parse_rules_json parser ~key = function
  | `List entries ->
      List.filter_map Fun.id
        (List.mapi
           (fun i entry ->
             parse_token_color_rule parser
               ~location:(Printf.sprintf "%s[%d]" key i)
               entry
           )
           entries
        )
  | _ ->
      []

let merge_colors base overlay =
  List.fold_left
    (fun acc (key, value) ->
      let without_key = List.filter (fun (k, _) -> k <> key) acc in
      without_key @ [ (key, value) ]
    )
    base overlay

let parse_colors parser = function
  | `Assoc fields ->
      List.filter_map
        (function
          | (("editor.foreground" | "editor.background") as key), `String value
            ->
              Option.map
                (fun color -> (key, color))
                (parse_color parser ~location:("colors." ^ key) value)
          | key, `String value ->
              Option.map (fun color -> (key, color)) (Color.of_hex value)
          | _ ->
              None
          )
        fields
  | _ ->
      []

let is_global_rule rule =
  rule.scope = [] || List.exists (fun s -> String.trim s = "") rule.scope

let resolve_defaults_from_scope_less token_colors =
  List.fold_left
    (fun (fg, bg) rule ->
      if is_global_rule rule then
        let pick current = function Some _ as c -> c | None -> current in
        (pick fg rule.settings.foreground, pick bg rule.settings.background)
      else
        (fg, bg)
    )
    (None, None) token_colors

let fallback_colors = function
  | Some "dark" ->
      (Color.rgb 0xbb 0xbb 0xbb, Color.rgb 0x1e 0x1e 0x1e)
  | Some "light" ->
      (Color.rgb 0x33 0x33 0x33, Color.rgb 0xff 0xff 0xfe)
  | _ ->
      (Color.rgb 0 0 0, Color.rgb 0xff 0xff 0xff)

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
      [ defaults_fg; fg_legacy; List.assoc_opt "editor.foreground" colors ]
      fallback_fg
  in
  let bg =
    first
      [ defaults_bg; bg_legacy; List.assoc_opt "editor.background" colors ]
      fallback_bg
  in
  { name; colors; fg; bg; token_colors }

let read_json_file path =
  match Yojson.Basic.from_file path with
  | json ->
      Ok json
  | exception Yojson.Json_error msg ->
      Error
        (Error.Theme_error
           {
             path = Some path;
             message = "invalid JSON: " ^ describe_json_error msg;
           }
        )
  | exception Sys_error msg ->
      let prefix = path ^ ": " in
      let message =
        if String.starts_with ~prefix msg then
          String.sub msg (String.length prefix)
            (String.length msg - String.length prefix)
        else
          msg
      in
      Error (Error.Theme_error { path = Some path; message })

let ( let* ) = Result.bind

let resolve_path dir path =
  if Filename.is_relative path then
    Filename.concat dir path
  else
    path

let needs_base_dir ~path ~field file =
  Error
    (Error.Theme_error
       {
         path;
         message =
           Printf.sprintf "%s %S needs a base_dir to be resolved" field file;
       }
    )

let parse_theme_fields ?path ?base_dir json =
  let parser = { path; warnings = [] } in
  let string_field keys =
    List.find_map
      (fun key ->
        match json_field key json with
        | Some (`String s) ->
            Some (key, s)
        | _ ->
            None
      )
      keys
  in
  let name_opt = Option.map snd (string_field [ "name" ]) in
  let colors =
    match json_field "colors" json with
    | Some v ->
        parse_colors parser v
    | None ->
        []
  in
  let legacy keys =
    List.find_map
      (fun key ->
        match json_field key json with
        | Some (`String value) ->
            parse_color parser ~location:key value
        | _ ->
            None
      )
      keys
  in
  let fg_legacy = legacy [ "fg"; "foreground" ] in
  let bg_legacy = legacy [ "bg"; "background" ] in
  let load_rules ~key = function
    | `String rel_path -> (
        match base_dir with
        | Some dir ->
            let rules_path = resolve_path dir rel_path in
            let* json = read_json_file rules_path in
            let rules_parser = { path = Some rules_path; warnings = [] } in
            let rules = parse_rules_json rules_parser ~key json in
            parser.warnings <- rules_parser.warnings @ parser.warnings;
            Ok rules
        | None ->
            needs_base_dir ~path ~field:key rel_path
      )
    | json_rules ->
        Ok (parse_rules_json parser ~key json_rules)
  in
  let* token_colors =
    match (json_field "settings" json, json_field "tokenColors" json) with
    | (Some settings as field), _ when not (is_falsy field) ->
        load_rules ~key:"settings" settings
    | _, Some value ->
        load_rules ~key:"tokenColors" value
    | _, None ->
        Ok []
  in
  let kind = Option.map snd (string_field [ "type" ]) in
  let include_path = Option.map snd (string_field [ "include" ]) in
  Ok
    ( {
        name_opt;
        kind;
        colors;
        fg_legacy;
        bg_legacy;
        token_colors;
        warnings = List.rev parser.warnings;
      },
      include_path
    )

let merge_loaded parent child =
  let either child parent =
    match child with Some _ -> child | None -> parent
  in
  {
    name_opt = either child.name_opt parent.name_opt;
    kind = either child.kind parent.kind;
    colors = merge_colors parent.colors child.colors;
    fg_legacy = either child.fg_legacy parent.fg_legacy;
    bg_legacy = either child.bg_legacy parent.bg_legacy;
    token_colors = parent.token_colors @ child.token_colors;
    warnings = parent.warnings @ child.warnings;
  }

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

let rec load_theme_data_from_json ?path ?base_dir ~visited json =
  let* local, include_path = parse_theme_fields ?path ?base_dir json in
  match (include_path, base_dir) with
  | Some include_path, Some dir ->
      let resolved = normalize_path (resolve_path dir include_path) in
      if List.mem resolved visited then
        Error (Error.Include_cycle (List.rev (resolved :: visited)))
      else
        let* parent =
          load_theme_data_from_path ~visited:(resolved :: visited) resolved
        in
        Ok (merge_loaded parent local)
  | Some include_path, None ->
      needs_base_dir ~path ~field:"include" include_path
  | None, _ ->
      Ok local

and load_theme_data_from_path ~visited path =
  let* json = read_json_file path in
  load_theme_data_from_json ~path ~base_dir:(Filename.dirname path) ~visited
    json

let make ~name ?(colors = []) ~token_colors () =
  finalize_theme ~name ~kind:None ~colors ~fg_legacy:None ~bg_legacy:None
    ~token_colors

let theme_of_data ~default_name data =
  let name = Option.value data.name_opt ~default:default_name in
  ( finalize_theme ~name ~kind:data.kind ~colors:data.colors
      ~fg_legacy:data.fg_legacy ~bg_legacy:data.bg_legacy
      ~token_colors:data.token_colors,
    data.warnings
  )

let load_from_file path =
  let* data = load_theme_data_from_path ~visited:[ normalize_path path ] path in
  Ok (theme_of_data ~default_name:(Filename.basename path) data)

let load ?base_dir str =
  let* json =
    match Yojson.Basic.from_string str with
    | json ->
        Ok json
    | exception Yojson.Json_error msg ->
        Error
          (Error.Theme_error
             {
               path = None;
               message = "invalid JSON: " ^ describe_json_error msg;
             }
          )
  in
  let* data = load_theme_data_from_json ?base_dir ~visited:[] json in
  Ok (theme_of_data ~default_name:"unnamed" data)

let load_builtin json ~name =
  match load json with
  | Ok (theme, _) ->
      { theme with name }
  | Error _ ->
      make ~name ~token_colors:[] ()

let dark = load_builtin Theme_builtin_json.dark_plus ~name:"dark"
let light = load_builtin Theme_builtin_json.light_plus ~name:"light"
let tokyonight = load_builtin Theme_builtin_json.tokyo_night ~name:"tokyonight"
let everforest =
  load_builtin Theme_builtin_json.everforest_dark ~name:"everforest"
let ayu = load_builtin Theme_builtin_json.ayu_dark ~name:"ayu"
let catppuccin =
  load_builtin Theme_builtin_json.catppuccin_mocha ~name:"catppuccin"

let catppuccin_macchiato =
  load_builtin Theme_builtin_json.catppuccin_macchiato
    ~name:"catppuccin-macchiato"

let gruvbox =
  load_builtin Theme_builtin_json.gruvbox_dark_medium ~name:"gruvbox"
let kanagawa = load_builtin Theme_builtin_json.kanagawa_wave ~name:"kanagawa"
let nord = load_builtin Theme_builtin_json.nord ~name:"nord"

let matrix =
  make ~name:"matrix"
    ~colors:
      [
        ("editor.foreground", Color.rgb 0x00 0xff 0x41);
        ("editor.background", Color.rgb 0x00 0x00 0x00);
      ]
    ~token_colors:
      [
        rule ~scope:[ "comment" ] ~foreground:(Color.rgb 0x00 0x8f 0x11)
          ~font_style:{ Style.plain with italic = true }
          ();
        rule ~scope:[ "string" ] ~foreground:(Color.rgb 0x00 0xcc 0x33) ();
        rule ~scope:[ "constant.numeric" ]
          ~foreground:(Color.rgb 0x66 0xff 0x66) ();
        rule ~scope:[ "keyword" ] ~foreground:(Color.rgb 0x39 0xff 0x14) ();
        rule ~scope:[ "entity.name.function" ]
          ~foreground:(Color.rgb 0x00 0xff 0x99) ();
        rule ~scope:[ "entity.name.type" ]
          ~foreground:(Color.rgb 0x00 0xff 0x66) ();
      ]
    ()

let one_dark = load_builtin Theme_builtin_json.one_dark_pro ~name:"one-dark"

let themes =
  [
    ("dark", dark);
    ("light", light);
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

let available_names = List.map fst themes
let find name = List.assoc_opt name themes
