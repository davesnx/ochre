open Cmdliner

let read_file path =
  In_channel.with_open_text path (fun ic ->
      let rec read_lines acc =
        match input_line ic with
        | line ->
            read_lines (line :: acc)
        | exception End_of_file ->
            List.rev acc
      in
      String.concat "\n" (read_lines [])
  )

let read_stdin () =
  let rec read_lines acc =
    try
      let line = input_line stdin in
      read_lines (line :: acc)
    with End_of_file -> List.rev acc
  in
  String.concat "\n" (read_lines [])

let stdin_has_data () = not (Unix.isatty Unix.stdin)

type theme_mode = Dark | Light

let getenv_opt key = try Some (Sys.getenv key) with Not_found -> None

let theme_mode_of_string = function
  | "dark" ->
      Some Dark
  | "light" ->
      Some Light
  | _ ->
      None

let detect_theme_mode () =
  let from_env key =
    Option.bind (getenv_opt key) (fun value ->
        theme_mode_of_string (String.lowercase_ascii (String.trim value))
    )
  in
  let from_colorfgbg () =
    let parse_bg value =
      let parts = String.split_on_char ';' value in
      match List.rev parts with
      | bg :: _ ->
          int_of_string_opt (String.trim bg)
      | [] ->
          None
    in
    Option.bind (getenv_opt "COLORFGBG") (fun value ->
        Option.map
          (fun bg ->
            if bg = 7 || bg = 15 || bg >= 250 then
              Light
            else
              Dark
          )
          (parse_bg value)
    )
  in
  match from_env "OCHRE_THEME_MODE" with
  | Some mode ->
      mode
  | None -> (
      match from_env "TERM_THEME" with
      | Some mode ->
          mode
      | None ->
          Option.value (from_colorfgbg ()) ~default:Dark
    )

let builtin_theme name = Ochre.Theme.find name

let default_theme =
  let fallback =
    match detect_theme_mode () with Dark -> "dark" | Light -> "light"
  in
  match builtin_theme fallback with
  | Some theme ->
      theme
  | None ->
      failwith ("Missing built-in theme: " ^ fallback)

let resolve_theme_name_or_path name_or_path =
  match builtin_theme name_or_path with
  | Some theme ->
      theme
  | None ->
      Ochre.Theme.load_from_file_exn name_or_path

let error msg = `Error (false, msg)

let render highlighter ~theme ~lang ~format ~options source =
  match format with
  | Ochre.Html ->
      print_endline (Ochre.to_html highlighter ~options ~theme ~lang source);
      `Ok ()
  | _ ->
      print_string (Ochre.to_string highlighter ~format ~theme ~lang source);
      `Ok ()

let render_html_multi highlighter ~theme ~extra_themes ~lang ~options source =
  print_endline
    (Ochre.to_html highlighter ~options ~theme ~extra_themes ~lang source);
  `Ok ()

let resolve_theme ~theme_path ~theme_dark ~theme_light =
  match theme_path with
  | Some name_or_path ->
      resolve_theme_name_or_path name_or_path
  | None -> (
      let mode = detect_theme_mode () in
      let preferred =
        match mode with Dark -> theme_dark | Light -> theme_light
      in
      let secondary =
        match mode with Dark -> theme_light | Light -> theme_dark
      in
      match preferred with
      | Some name_or_path ->
          resolve_theme_name_or_path name_or_path
      | None -> (
          match secondary with
          | Some name_or_path ->
              resolve_theme_name_or_path name_or_path
          | None ->
              default_theme
        )
    )

(** When --format html and both --theme-light and --theme-dark are given
    (without --theme), use multi-theme rendering with CSS custom properties. *)
let resolve_multi_themes ~theme_path ~theme_dark ~theme_light ~format =
  match (format, theme_path, theme_light, theme_dark) with
  | Ochre.Html, None, Some light_name, Some dark_name ->
      let light = resolve_theme_name_or_path light_name in
      let dark = resolve_theme_name_or_path dark_name in
      Some (light, [ ("dark", dark) ])
  | _ ->
      None

let build_html_options ~css_classes ~line_numbers ~no_default_color
    ~css_var_prefix ~scopes_data =
  let style_mode =
    if css_classes then
      Ochre.Html_options.Css_classes { class_prefix = "ochre-" }
    else
      Ochre.Html_options.Inline_styles
  in
  let default_color =
    if no_default_color then
      Ochre.Html_options.No_default_color
    else
      Ochre.Html_options.Default_color
  in
  let css_variable_prefix =
    match css_var_prefix with Some p -> p | None -> "--ochre-"
  in
  Ochre.Html_options.make ~style_mode ~default_color ~line_numbers
    ~css_variable_prefix ~scopes_as_data_attrs:scopes_data ()

let lang_id_of_path path =
  let base = Filename.basename path in
  match String.split_on_char '.' base with
  | name :: _ when name <> "" ->
      name
  | _ ->
      base

let grammar_json_of_path path = (lang_id_of_path path, read_file path)

let resolve_include name_or_path =
  if Sys.file_exists name_or_path then
    Ok (grammar_json_of_path name_or_path)
  else
    match Tm_grammars.find name_or_path with
    | Some json ->
        Ok (name_or_path, json)
    | None ->
        Error
          (Printf.sprintf
             "Cannot resolve --include '%s': not a file and not a bundled \
              grammar. Available: %s"
             name_or_path
             (String.concat ", " Tm_grammars.available)
          )

let highlight lang theme_path theme_dark theme_light grammars includes format
    input_file css_classes line_numbers no_default_color css_var_prefix
    scopes_data =
  let source =
    match input_file with
    | Some path ->
        Some (read_file path)
    | None ->
        if stdin_has_data () then
          Some (read_stdin ())
        else
          None
  in
  match source with
  | None ->
      error "Provide a file path or pipe input via stdin"
  | Some source -> (
      let resolve_includes () =
        List.fold_left
          (fun acc inc ->
            match acc with
            | Error _ ->
                acc
            | Ok grammars -> (
                match resolve_include inc with
                | Ok g ->
                    Ok (g :: grammars)
                | Error msg ->
                    Error msg
              )
          )
          (Ok []) includes
      in
      let make_highlighter grammars_arg =
        match resolve_includes () with
        | Error msg ->
            Error msg
        | Ok include_grammars -> (
            let include_grammars = List.rev include_grammars in
            match grammars_arg with
            | _ :: _ ->
                let file_grammars =
                  List.map grammar_json_of_path grammars_arg
                in
                Ochre.load (file_grammars @ include_grammars)
            | [] -> (
                match Tm_grammars.find lang with
                | Some json ->
                    Ochre.load ([ (lang, json) ] @ include_grammars)
                | None ->
                    Error
                      (Printf.sprintf
                         "No bundled grammar for '%s'. Available: %s. Use \
                          --grammar to provide one."
                         lang
                         (String.concat ", " Tm_grammars.available)
                      )
              )
          )
      in
      let options =
        build_html_options ~css_classes ~line_numbers ~no_default_color
          ~css_var_prefix ~scopes_data
      in
      match make_highlighter grammars with
      | Error msg ->
          error msg
      | Ok highlighter -> (
          match
            resolve_multi_themes ~theme_path ~theme_dark ~theme_light ~format
          with
          | Some (theme, extra_themes) ->
              render_html_multi highlighter ~theme ~extra_themes ~lang ~options
                source
          | None ->
              let theme = resolve_theme ~theme_path ~theme_dark ~theme_light in
              render highlighter ~theme ~lang ~format ~options source
        )
    )

let lang =
  let doc = "Language identifier (e.g., ocaml, javascript, python)" in
  Arg.(required & pos 0 (some string) None & info [] ~docv:"LANG" ~doc)

let theme_path =
  let names = String.concat ", " Ochre.Theme.available_names in
  let doc =
    Printf.sprintf
      "Theme name or path to a TextMate theme JSON file. Built-ins: %s" names
  in
  Arg.(
    value
    & opt (some string) None
    & info [ "theme"; "t" ] ~docv:"NAME_OR_PATH" ~doc
  )

let theme_dark =
  let doc =
    "Theme name or path for dark mode. When both --theme-light and \
     --theme-dark are given with --format html, produces dual-theme output \
     with CSS custom properties (--ochre-dark-*) for automatic dark mode \
     switching"
  in
  Arg.(value & opt (some string) None & info [ "theme-dark" ] ~docv:"THEME" ~doc)

let theme_light =
  let doc =
    "Theme name or path for light mode. When both --theme-light and \
     --theme-dark are given with --format html, produces dual-theme output \
     with the light theme as default and dark theme as CSS custom properties"
  in
  Arg.(
    value & opt (some string) None & info [ "theme-light" ] ~docv:"THEME" ~doc
  )

let grammars =
  let doc =
    "Path to a .tmLanguage.json grammar file (can be specified multiple times)"
  in
  Arg.(value & opt_all string [] & info [ "grammar"; "g" ] ~docv:"FILE" ~doc)

let includes =
  let doc =
    "Additional grammar to load by name (from bundled grammars) or file path. \
     Use to enable cross-grammar features like HTML embedding CSS/JS. Can be \
     specified multiple times"
  in
  Arg.(
    value & opt_all string []
    & info [ "include"; "i" ] ~docv:"LANG_OR_PATH" ~doc
  )

let format =
  let doc = "Output format: html, ansi, latex, svg, or tokens" in
  Arg.(
    value
    & opt (enum Ochre.output_formats) Ochre.Html
    & info [ "format"; "f" ] ~docv:"FORMAT" ~doc
  )

let input_file =
  let doc = "Input file path" in
  Arg.(value & pos 1 (some string) None & info [] ~docv:"FILE" ~doc)

let css_classes =
  let doc =
    "Use CSS class names instead of inline styles for HTML output. Each unique \
     style gets a deterministic class like ochre-<hash>"
  in
  Arg.(value & flag & info [ "html-css-classes" ] ~doc)

let line_numbers =
  let doc =
    "Add data-line attributes to line spans in HTML output (1-indexed)"
  in
  Arg.(value & flag & info [ "line-numbers" ] ~doc)

let no_default_color =
  let doc =
    "Suppress inline color/background-color on the primary theme. All colors \
     come from CSS custom properties only. Useful with multi-theme output when \
     you control theme switching entirely via CSS"
  in
  Arg.(value & flag & info [ "no-default-color" ] ~doc)

let css_var_prefix =
  let doc =
    "CSS custom property prefix for multi-theme output (default: --ochre-)"
  in
  Arg.(
    value
    & opt (some string) None
    & info [ "css-var-prefix" ] ~docv:"PREFIX" ~doc
  )

let scopes_data =
  let doc =
    "Add data-scope attributes to token spans in HTML output with TextMate \
     scope names"
  in
  Arg.(value & flag & info [ "scopes-data" ] ~doc)

let cmd =
  let doc = "Syntax highlighter using TextMate grammars and themes" in
  let info = Cmd.info "ochre" ~version:"1.0.0" ~doc in
  Cmd.v info
    Term.(
      ret
        (const highlight $ lang $ theme_path $ theme_dark $ theme_light
       $ grammars $ includes $ format $ input_file $ css_classes $ line_numbers
       $ no_default_color $ css_var_prefix $ scopes_data
        )
    )

let () = exit (Cmd.eval cmd)
