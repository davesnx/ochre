open Cmdliner

let read_file path =
  let ic = open_in path in
  let rec read_lines acc =
    try
      let line = input_line ic in
      read_lines (line :: acc)
    with End_of_file ->
      close_in ic;
      List.rev acc
  in
  String.concat "\n" (read_lines [])

let read_stdin () =
  let rec read_lines acc =
    try
      let line = input_line stdin in
      read_lines (line :: acc)
    with End_of_file -> List.rev acc
  in
  String.concat "\n" (read_lines [])

type theme_mode = Dark | Light

let getenv_opt key = try Some (Sys.getenv key) with Not_found -> None

let theme_mode_of_string = function
  | "dark" -> Some Dark
  | "light" -> Some Light
  | _ -> None

let detect_theme_mode () =
  let from_env key =
    Option.bind (getenv_opt key) (fun value ->
        theme_mode_of_string (String.lowercase_ascii (String.trim value)))
  in
  let from_colorfgbg () =
    let parse_bg value =
      let parts = String.split_on_char ';' value in
      match List.rev parts with
      | bg :: _ -> int_of_string_opt (String.trim bg)
      | [] -> None
    in
    Option.bind (getenv_opt "COLORFGBG") (fun value ->
        Option.map
          (fun bg -> if bg = 7 || bg = 15 || bg >= 250 then Light else Dark)
          (parse_bg value))
  in
  match from_env "OCHRE_THEME_MODE" with
  | Some mode -> mode
  | None -> (
      match from_env "TERM_THEME" with
      | Some mode -> mode
      | None -> Option.value (from_colorfgbg ()) ~default:Dark)

let default_theme =
  let fallback =
    match detect_theme_mode () with Dark -> "dark" | Light -> "light"
  in
  match Ochre.Theme.make fallback with
  | Some theme -> theme
  | None -> failwith ("Missing built-in theme: " ^ fallback)

let resolve_theme_name_or_path name_or_path =
  match Ochre.Theme.make name_or_path with
  | Some theme -> theme
  | None -> Ochre.Theme.load name_or_path

let error msg = `Error (false, msg)

let render highlighter ~theme ~lang ~format source =
  print_endline (Ochre.to_string highlighter ~format ~theme ~lang source);
  `Ok ()

let resolve_theme ~theme_path ~theme_dark ~theme_light =
  match theme_path with
  | Some name_or_path -> resolve_theme_name_or_path name_or_path
  | None -> (
      let mode = detect_theme_mode () in
      let preferred =
        match mode with Dark -> theme_dark | Light -> theme_light
      in
      let secondary =
        match mode with Dark -> theme_light | Light -> theme_dark
      in
      match preferred with
      | Some name_or_path -> resolve_theme_name_or_path name_or_path
      | None -> (
          match secondary with
          | Some name_or_path -> resolve_theme_name_or_path name_or_path
          | None -> default_theme))

let highlight lang theme_path theme_dark theme_light grammars format use_stdin
    input_file =
  let theme = resolve_theme ~theme_path ~theme_dark ~theme_light in
  let source =
    if use_stdin then Some (read_stdin ()) else Option.map read_file input_file
  in
  match source with
  | None -> error "Either provide a file path or use --stdin"
  | Some source -> (
      match grammars with
      | _ :: _ -> render (Ochre.create ~grammars ()) ~theme ~lang ~format source
      | [] -> (
          match Tm_grammars_all.find lang with
          | Some json ->
              render
                (Ochre.create_from_json ~grammars:[ (lang, json) ] ())
                ~theme ~lang ~format source
          | None ->
              error
                (Printf.sprintf
                   "No bundled grammar for '%s'. Available: %s. Use --grammar \
                    to provide one."
                   lang
                   (String.concat ", " Tm_grammars_all.available))))

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
    & info [ "theme"; "t" ] ~docv:"NAME_OR_PATH" ~doc)

let theme_dark =
  let doc =
    "Theme name or path to use when terminal mode is detected as dark"
  in
  Arg.(
    value & opt (some string) None & info [ "theme-dark" ] ~docv:"THEME" ~doc)

let theme_light =
  let doc =
    "Theme name or path to use when terminal mode is detected as light"
  in
  Arg.(
    value & opt (some string) None & info [ "theme-light" ] ~docv:"THEME" ~doc)

let grammars =
  let doc =
    "Path to a .tmLanguage.json grammar file (can be specified multiple times)"
  in
  Arg.(value & opt_all string [] & info [ "grammar"; "g" ] ~docv:"FILE" ~doc)

let format =
  let doc = "Output format: html, ansi, latex, svg, or tokens" in
  Arg.(
    value
    & opt (enum Ochre.output_formats) Ochre.Html
    & info [ "format"; "f" ] ~docv:"FORMAT" ~doc)

let use_stdin =
  let doc = "Read source code from stdin" in
  Arg.(value & flag & info [ "stdin"; "s" ] ~doc)

let input_file =
  let doc = "Input file path" in
  Arg.(value & pos 1 (some string) None & info [] ~docv:"FILE" ~doc)

let cmd =
  let doc = "Syntax highlighter using TextMate grammars and themes" in
  let info = Cmd.info "ochre" ~version:"0.1.0" ~doc in
  Cmd.v info
    Term.(
      ret
        (const highlight $ lang $ theme_path $ theme_dark $ theme_light
       $ grammars $ format $ use_stdin $ input_file))

let () = exit (Cmd.eval cmd)
