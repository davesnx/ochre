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

let default_theme : Ochre.Theme.theme =
  { name = "default"; fg = "#000000"; bg = "#ffffff"; token_colors = [] }

let error msg = `Error (false, msg)

let render highlighter ~theme ~lang ~format source =
  print_endline (Ochre.to_string highlighter ~format ~theme ~lang source);
  `Ok ()

let highlight lang theme_path grammars format use_stdin input_file =
  let theme =
    match theme_path with
    | Some path -> Ochre.Theme.load_from_file path
    | None -> default_theme
  in
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
  let doc = "Path to a TextMate theme JSON file" in
  Arg.(value & opt (some string) None & info [ "theme"; "t" ] ~docv:"PATH" ~doc)

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
        (const highlight $ lang $ theme_path $ grammars $ format $ use_stdin
       $ input_file))

let () = exit (Cmd.eval cmd)
