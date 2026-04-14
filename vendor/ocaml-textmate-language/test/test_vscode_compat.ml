open Yojson.Basic.Util

type grammar_format = Json | Plist

type case = {
  id : string;
  grammar_path : string;
  grammar_format : grammar_format;
  scope_name : string;
  lines : string list;
}

type token = { start_pos : int; end_pos : int; scopes : string list }

let read_all chan =
  let buf = Buffer.create 1024 in
  ( try
      while true do
        Buffer.add_char buf (input_char chan)
      done
    with End_of_file -> ()
  );
  Buffer.contents buf

let resolve_test_root () =
  let candidates = [ "vendor/ocaml-textmate-language/test"; "test"; "." ] in
  let has_harness root =
    let script = Filename.concat root "vscode/tokenize_vscode_textmate.mjs" in
    let suite = Filename.concat root "vscode/cases/suite.json" in
    Sys.file_exists script && Sys.file_exists suite
  in
  match List.find_opt has_harness candidates with
  | Some root ->
      root
  | None ->
      failwith
        "Could not locate vendored test root with vscode compatibility harness"

let read_suite suite_path =
  let parse_grammar_format case_id value =
    match value with
    | "json" ->
        Json
    | "plist" ->
        Plist
    | other ->
        failwith
          (Printf.sprintf
             "Case '%s' has unknown grammar_format '%s' (expected json|plist)"
             case_id other
          )
  in
  Yojson.Basic.from_file suite_path
  |> member "cases" |> to_list
  |> List.map (fun entry ->
      let id = entry |> member "id" |> to_string in
      {
        id;
        grammar_path = entry |> member "grammar_path" |> to_string;
        grammar_format =
          entry |> member "grammar_format" |> to_string
          |> parse_grammar_format id;
        scope_name = entry |> member "scope_name" |> to_string;
        lines = entry |> member "lines" |> to_list |> List.map to_string;
      }
  )

let tokenize_with_ocaml (case : case) ~test_root =
  let grammar_path =
    if Filename.is_relative case.grammar_path then
      Filename.concat test_root case.grammar_path
    else
      case.grammar_path
  in
  let grammar =
    match case.grammar_format with
    | Json ->
        TmLanguage.of_yojson_exn (Yojson.Basic.from_file grammar_path)
    | Plist ->
        let channel = open_in_bin grammar_path in
        let plist =
          Fun.protect
            (fun () -> Plist_xml.from_channel channel)
            ~finally:(fun () -> close_in channel)
        in
        TmLanguage.of_plist_exn plist
  in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  let to_line_tokens toks =
    let rec go prev acc = function
      | [] ->
          List.rev acc
      | tok :: rest ->
          let ending = TmLanguage.ending tok in
          let token =
            {
              start_pos = prev;
              end_pos = ending;
              scopes = List.rev (TmLanguage.scopes tok);
            }
          in
          go ending (token :: acc) rest
    in
    go 0 [] toks
  in
  let _, lines =
    List.fold_left
      (fun (stack, acc) line ->
        let toks, stack = TmLanguage.tokenize_exn t grammar stack line in
        (stack, to_line_tokens toks :: acc)
      )
      (TmLanguage.empty, []) case.lines
  in
  (grammar_path, List.rev lines)

let write_node_request temp_path request_cases =
  let json =
    `Assoc
      [
        ( "cases",
          `List
            (List.map
               (fun ((case : case), grammar_path) ->
                 `Assoc
                   [
                     ("id", `String case.id);
                     ("scope_name", `String case.scope_name);
                     ("grammar_path", `String grammar_path);
                     ( "lines",
                       `List (List.map (fun line -> `String line) case.lines)
                     );
                   ]
               )
               request_cases
            )
        );
      ]
  in
  Yojson.Basic.to_file temp_path json

let run_vscode_tokenizer ~script_path ~request_path =
  let stdout_chan, stdin_chan, stderr_chan =
    Unix.open_process_args_full "node"
      [| "node"; script_path; request_path |]
      (Unix.environment ())
  in
  close_out stdin_chan;
  let stdout = read_all stdout_chan in
  let stderr = read_all stderr_chan in
  match Unix.close_process_full (stdout_chan, stdin_chan, stderr_chan) with
  | Unix.WEXITED 0 ->
      Yojson.Basic.from_string stdout
  | Unix.WEXITED code ->
      failwith
        (Printf.sprintf "node exited with code %d\n%s" code
           ( if stderr = "" then
               stdout
             else
               stderr
           )
        )
  | Unix.WSIGNALED signal | Unix.WSTOPPED signal ->
      failwith
        (Printf.sprintf "node terminated by signal %d\n%s" signal
           ( if stderr = "" then
               stdout
             else
               stderr
           )
        )

let parse_node_results json =
  let parse_token tok =
    {
      start_pos = tok |> member "start" |> to_int;
      end_pos = tok |> member "end" |> to_int;
      scopes = tok |> member "scopes" |> to_list |> List.map to_string;
    }
  in
  let parse_case entry =
    let id = entry |> member "id" |> to_string in
    let tokens_by_line =
      entry |> member "tokens_by_line" |> to_list
      |> List.map (fun line_tokens ->
          line_tokens |> to_list |> List.map parse_token
      )
    in
    (id, tokens_by_line)
  in
  json |> member "cases" |> to_list |> List.map parse_case

let slice line start_pos end_pos =
  if start_pos < 0 || end_pos < start_pos || end_pos > String.length line then
    "<invalid-range>"
  else
    String.sub line start_pos (end_pos - start_pos)

let render_tokens line tokens =
  tokens
  |> List.map (fun tok ->
      Printf.sprintf "[%d,%d) %S :: %s" tok.start_pos tok.end_pos
        (slice line tok.start_pos tok.end_pos)
        (String.concat " > " tok.scopes)
  )
  |> String.concat "\n"

let line_at case idx =
  match List.nth_opt case.lines idx with
  | Some line ->
      line
  | None ->
      "<missing-line>"

let collect_case_mismatches case ocaml_lines vscode_lines =
  let rec check_lines idx lines_a lines_b acc =
    match (lines_a, lines_b) with
    | [], [] ->
        List.rev acc
    | [], _ | _, [] ->
        List.rev
          (Printf.sprintf "Case '%s': line count mismatch (ocaml=%d vscode=%d)"
             case.id (List.length ocaml_lines) (List.length vscode_lines)
          :: acc
          )
    | ocaml_tokens :: rest_a, vscode_tokens :: rest_b ->
        let acc =
          if ocaml_tokens = vscode_tokens then
            acc
          else
            let line = line_at case idx in
            let mismatch =
              Printf.sprintf "Case '%s' line %d (%S)\nOCaml:\n%s\n\nVSCode:\n%s"
                case.id (idx + 1) line
                (render_tokens line ocaml_tokens)
                (render_tokens line vscode_tokens)
            in
            mismatch :: acc
        in
        check_lines (idx + 1) rest_a rest_b acc
  in
  check_lines 0 ocaml_lines vscode_lines []

let ensure_node_modules node_root =
  let marker = Filename.concat node_root "node_modules/vscode-textmate" in
  if not (Sys.file_exists marker) then
    failwith
      (Printf.sprintf "Missing Node dependencies. Run: npm ci --prefix %s"
         node_root
      )

let check_vscode_compat () =
  let test_root = resolve_test_root () in
  let suite_path = Filename.concat test_root "vscode/cases/suite.json" in
  let node_root = Filename.concat test_root "vscode" in
  ensure_node_modules node_root;
  let node_script =
    Filename.concat test_root "vscode/tokenize_vscode_textmate.mjs"
  in
  let cases = read_suite suite_path in
  let request_items, ocaml_results =
    List.fold_left
      (fun (request_acc, result_acc) case ->
        let grammar_path, tokens = tokenize_with_ocaml case ~test_root in
        ((case, grammar_path) :: request_acc, (case.id, tokens) :: result_acc)
      )
      ([], []) cases
  in
  let request_file = Filename.temp_file "vscode-compat-request" ".json" in
  Fun.protect
    (fun () ->
      write_node_request request_file (List.rev request_items);
      let vscode_json =
        run_vscode_tokenizer ~script_path:node_script ~request_path:request_file
      in
      let vscode_results = parse_node_results vscode_json in
      let vscode_by_id = Hashtbl.create (List.length vscode_results) in
      List.iter
        (fun (id, toks) -> Hashtbl.replace vscode_by_id id toks)
        vscode_results;
      let mismatches =
        List.fold_left
          (fun acc case ->
            let ocaml_tokens = List.assoc case.id ocaml_results in
            let vscode_tokens =
              match Hashtbl.find_opt vscode_by_id case.id with
              | Some toks ->
                  toks
              | None ->
                  Alcotest.failf "Missing vscode result for case '%s'" case.id
            in
            List.rev_append
              (collect_case_mismatches case ocaml_tokens vscode_tokens)
              acc
          )
          [] cases
      in
      if mismatches <> [] then
        Alcotest.failf "Found %d tokenization mismatches\n\n%s"
          (List.length mismatches)
          (String.concat "\n\n---\n\n" (List.rev mismatches))
    )
    ~finally:(fun () ->
      if Sys.file_exists request_file then Sys.remove request_file
    )

let () =
  Alcotest.run "vscode-textmate compatibility"
    [
      ( "compat",
        [
          Alcotest.test_case "token streams match vscode-textmate" `Quick
            check_vscode_compat;
        ]
      );
    ]
