open Cmdliner

let name_path path msg =
  if String.starts_with ~prefix:(path ^ ": ") msg then
    msg
  else
    path ^ ": " ^ msg

let read_file path =
  try In_channel.with_open_bin path In_channel.input_all
  with Sys_error msg -> failwith (name_path path msg)

let read_stdin () =
  try In_channel.input_all stdin
  with Sys_error msg -> failwith (name_path "<stdin>" msg)

exception Output_failed of Unix.error

let write_stdout s =
  let rec go off =
    if off < String.length s then
      match Unix.write_substring Unix.stdout s off (String.length s - off) with
      | n ->
          go (off + n)
      | exception Unix.Unix_error (Unix.EINTR, _, _) ->
          go off
      | exception Unix.Unix_error ((Unix.EAGAIN | Unix.EWOULDBLOCK), _, _) ->
          ( match Unix.select [] [ Unix.stdout ] [] (-1.) with
          | _ ->
              ()
          | exception Unix.Unix_error (Unix.EINTR, _, _) ->
              ()
          | exception Unix.Unix_error (err, _, _) ->
              raise (Output_failed err)
          );
          go off
      | exception Unix.Unix_error (err, _, _) ->
          raise (Output_failed err)
  in
  go 0

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
        Option.bind (parse_bg value) (fun bg ->
            if bg = 7 || (bg >= 9 && bg <= 15) then
              Some Light
            else if (bg >= 0 && bg <= 6) || bg = 8 then
              Some Dark
            else
              None
        )
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

let default_theme =
  match detect_theme_mode () with
  | Dark ->
      Ochre.Theme.dark
  | Light ->
      Ochre.Theme.light

let warn message =
  try prerr_endline ("ochre: warning: " ^ message) with Sys_error _ -> ()

let resolve_theme_name_or_path name_or_path =
  match Ochre.Theme.find name_or_path with
  | Some theme ->
      Ok theme
  | None ->
      if Sys.file_exists name_or_path then
        match Ochre.Theme.load_from_file name_or_path with
        | Ok (theme, warnings) ->
            List.iter
              (fun warning -> warn (Ochre.Theme.warning_to_string warning))
              warnings;
            Ok theme
        | Error error ->
            Error (name_path name_or_path (Ochre.Error.to_string error))
      else
        Error
          (Printf.sprintf
             "Unknown theme '%s': not a built-in name and not a file. \
              Available: %s"
             name_or_path
             (String.concat ", " Ochre.Theme.available_names)
          )

let error msg = `Error (false, msg)

let render ~format ~options themed =
  match format with
  | Ochre.Html ->
      write_stdout (Ochre.to_html ~options themed ^ "\n")
  | _ ->
      write_stdout (Ochre.to_string ~format themed)

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
              Ok default_theme
        )
    )

let resolve_multi_themes ~theme_path ~theme_dark ~theme_light ~format =
  match (format, theme_path, theme_light, theme_dark) with
  | Ochre.Html, None, Some light_name, Some dark_name -> (
      match resolve_theme_name_or_path light_name with
      | Error _ as err ->
          err
      | Ok light -> (
          match resolve_theme_name_or_path dark_name with
          | Error _ as err ->
              err
          | Ok dark ->
              Ok (Some (light, [ ("dark", dark) ]))
        )
    )
  | _ ->
      Ok None

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

let bundled_dependencies = function
  | "ocaml" | "mlx" ->
      [ ("ocaml-interface", Tm_grammars.ocaml_interface) ]
  | _ ->
      []

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
      let unknown_language () =
        match grammars with
        | _ :: _ ->
            Printf.sprintf
              "LANG is '%s' but none of the --grammar files register under \
               that id. A --grammar file's id comes from its filename (e.g. \
               'ocaml.tmLanguage.json' registers as 'ocaml'); rename the file \
               or change LANG to match."
              lang
        | [] ->
            Printf.sprintf
              "No bundled grammar for '%s'. Available: %s. Use --grammar to \
               provide one."
              lang
              (String.concat ", " Tm_grammars.available)
      in
      let load_lang () =
        match resolve_includes () with
        | Error msg ->
            Error msg
        | Ok include_grammars -> (
            let include_grammars = List.rev include_grammars in
            let grammars =
              match grammars with
              | _ :: _ ->
                  List.map grammar_json_of_path grammars @ include_grammars
              | [] -> (
                  match Tm_grammars.find lang with
                  | Some json ->
                      let required =
                        List.filter
                          (fun (id, _) ->
                            not (List.mem_assoc id include_grammars)
                          )
                          (bundled_dependencies lang)
                      in
                      ((lang, json) :: required) @ include_grammars
                  | None ->
                      include_grammars
                )
            in
            match Ochre.load grammars with
            | Error error ->
                Error (Ochre.Error.to_string error)
            | Ok highlighter -> (
                match Ochre.lang highlighter lang with
                | Ok lang ->
                    Ok lang
                | Error (Ochre.Error.Unknown_language _) ->
                    Error (unknown_language ())
                | Error error ->
                    Error (Ochre.Error.to_string error)
              )
          )
      in
      let options =
        build_html_options ~css_classes ~line_numbers ~no_default_color
          ~css_var_prefix ~scopes_data
      in
      let themed ~lang =
        match
          resolve_multi_themes ~theme_path ~theme_dark ~theme_light ~format
        with
        | Error msg ->
            Error msg
        | Ok (Some (theme, extra_themes)) ->
            Result.map_error Ochre.Error.to_string
              (Ochre.highlight_themes ~label:"light" ~theme ~extra_themes ~lang
                 source
              )
        | Ok None ->
            Result.map
              (fun theme -> Ochre.highlight ~theme ~lang source)
              (resolve_theme ~theme_path ~theme_dark ~theme_light)
      in
      match Result.bind (load_lang ()) (fun lang -> themed ~lang) with
      | Error msg ->
          error msg
      | Ok themed ->
          render ~format ~options themed;
          `Ok ()
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
     with CSS light-dark() colors, which follow the page color-scheme"
  in
  Arg.(value & opt (some string) None & info [ "theme-dark" ] ~docv:"THEME" ~doc)

let theme_light =
  let doc =
    "Theme name or path for light mode. When both --theme-light and \
     --theme-dark are given with --format html, produces dual-theme output \
     with CSS light-dark() colors, which follow the page color-scheme"
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
     you control theme switching entirely via CSS. Light and dark themes use \
     light-dark() colors with or without this flag"
  in
  Arg.(value & flag & info [ "no-default-color" ] ~doc)

let css_var_prefix =
  let doc =
    "CSS custom property prefix for multi-theme output (default: --ochre-). \
     With --theme-light and --theme-dark, colors use light-dark() and read no \
     variable, so the prefix applies only to font styles"
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

let version =
  match Build_info.V1.version () with
  | None ->
      "dev"
  | Some v ->
      Build_info.V1.Version.to_string v

let output_error_code = 3

let exits =
  [
    Cmd.Exit.info Cmd.Exit.ok ~doc:"on success.";
    Cmd.Exit.info 1
      ~doc:
        "on a user/input error: an invalid command line (unknown option, too \
         many arguments, a missing required argument), an unresolvable \
         language/theme/grammar, a malformed theme/grammar file, a missing \
         input file, or any other error this CLI can name. Reported on \
         standard error as \"ochre: <message>\".";
    Cmd.Exit.info output_error_code
      ~doc:
        "when the output cannot be written to standard output (for example the \
         disk is full, or standard output is closed). Reported on standard \
         error as \"ochre: cannot write output: <reason>\". When the reader of \
         a pipe closes it early (EPIPE), ochre exits with this code and no \
         message, because the reader chose to stop. ochre ignores SIGPIPE, so \
         this holds whatever the parent process set.";
    Cmd.Exit.info Cmd.Exit.cli_error
      ~doc:
        "on an option given a malformed value (wrong type, e.g. --format) or \
         missing its required value (e.g. --theme with no argument).";
    Cmd.Exit.info Cmd.Exit.internal_error
      ~doc:"on an unexpected internal error (a bug - please report it).";
  ]

let cmd =
  let doc = "Syntax highlighter using TextMate grammars and themes" in
  let info = Cmd.info "ochre" ~version ~doc ~exits in
  Cmd.v info
    Term.(
      ret
        (const highlight $ lang $ theme_path $ theme_dark $ theme_light
       $ grammars $ includes $ format $ input_file $ css_classes $ line_numbers
       $ no_default_color $ css_var_prefix $ scopes_data
        )
    )

let report msg = try prerr_endline ("ochre: " ^ msg) with Sys_error _ -> ()

let run () =
  try Cmd.eval ~catch:false ~term_err:1 cmd with
  | Output_failed Unix.EPIPE ->
      output_error_code
  | Output_failed err ->
      report ("cannot write output: " ^ Unix.error_message err);
      output_error_code
  | Sys_error msg | Failure msg | Invalid_argument msg ->
      report msg;
      1
  | exn ->
      report (Printexc.to_string exn);
      1

let () =
  Sys.set_signal Sys.sigpipe Sys.Signal_ignore;
  let code = run () in
  (try flush stderr with Sys_error _ -> ());
  exit code
