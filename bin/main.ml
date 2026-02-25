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

let highlight lang theme_path grammar_dirs format use_stdin input_file =
  try
    let highlighter = Ochre.create ~grammar_paths:grammar_dirs () in

    (match theme_path with
    | Some path -> Ochre.load_theme_from_file highlighter path
    | None -> ());

    let source =
      if use_stdin then read_stdin ()
      else
        match input_file with
        | Some path -> read_file path
        | None -> failwith "Either provide a file path or use --stdin"
    in

    let output =
      match format with
      | "html" -> Ochre.highlight_to_html highlighter ~lang source
      | "ansi" -> Ochre.highlight_to_ansi highlighter ~lang source
      | "tokens" ->
          let tokens = Ochre.highlight_to_tokens highlighter ~lang source in
          (* Simple token dump for debugging *)
          List.map
            (fun line ->
              List.map
                (fun (t : Ochre.Token.styled_token) ->
                  Printf.sprintf "{%s}[%s]" t.text
                    (String.concat "," t.scopes))
                line
              |> String.concat "")
            tokens
          |> String.concat "\n"
      | _ -> failwith ("Unknown format: " ^ format)
    in
    print_endline output;
    `Ok ()
  with
  | Failure msg ->
      Printf.eprintf "Error: %s\n" msg;
      `Error (false, msg)
  | e ->
      Printf.eprintf "Error: %s\n" (Printexc.to_string e);
      `Error (false, Printexc.to_string e)

let lang =
  let doc = "Language identifier (e.g., ocaml, javascript, python)" in
  Arg.(required & pos 0 (some string) None & info [] ~docv:"LANG" ~doc)

let theme_path =
  let doc = "Path to a TextMate theme JSON file" in
  Arg.(value & opt (some string) None & info [ "theme"; "t" ] ~docv:"PATH" ~doc)

let grammar_dirs =
  let doc =
    "Directory containing .tmLanguage.json grammar files (can be specified \
     multiple times)"
  in
  Arg.(value & opt_all string [] & info [ "grammar-dir"; "g" ] ~docv:"DIR" ~doc)

let format =
  let doc = "Output format: html, ansi, or tokens" in
  Arg.(value & opt string "html" & info [ "format"; "f" ] ~docv:"FORMAT" ~doc)

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
        (const highlight $ lang $ theme_path $ grammar_dirs $ format $ use_stdin
        $ input_file))

let () = exit (Cmd.eval cmd)
