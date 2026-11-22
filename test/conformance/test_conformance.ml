let parity =
  [
    "ocaml";
    "reason";
    "javascript";
    "typescript";
    "tsx";
    "json";
    "html";
    "css";
    "markdown";
    "shellscript";
    "python";
    "rust";
    "go";
    "c";
    "cpp";
    "java";
    "yaml";
    "toml";
    "sql";
    "diff";
  ]

let expected_failures : (string * string) list = []

type token = { text : string; scopes : string list }

let read_file path = In_channel.with_open_bin path In_channel.input_all

let write_file path contents =
  Out_channel.with_open_bin path (fun oc -> output_string oc contents)

let sample_path ~samples lang = Filename.concat samples (lang ^ ".sample")

let golden_path ~golden lang = Filename.concat golden (lang ^ ".json")

let source_lines source =
  match String.split_on_char '\n' source with
  | [ "" ] ->
      []
  | lines when String.ends_with ~suffix:"\n" source ->
      List.filteri (fun i _ -> i < List.length lines - 1) lines
  | lines ->
      lines

let without_newline line =
  match List.rev line with
  | last :: rest when String.ends_with ~suffix:"\n" last.text ->
      let text = String.sub last.text 0 (String.length last.text - 1) in
      if text = "" && rest <> [] then
        List.rev rest
      else
        List.rev ({ last with text } :: rest)
  | _ ->
      line

let ochre_tokens hl ~lang source =
  Ochre.to_tokens hl ~theme:Ochre.Theme.dark ~lang source
  |> List.map (fun line ->
      List.map
        (fun (tok : Ochre.Token.styled_token) ->
          { text = tok.text; scopes = List.rev tok.scopes }
        )
        line
  )

let comparable lines = List.map without_newline lines

let token_to_json { text; scopes } =
  `List [ `String text; `List (List.map (fun s -> `String s) scopes) ]

let token_of_json = function
  | `List [ `String text; `List scopes ] ->
      {
        text;
        scopes =
          List.map
            (function
              | `String s -> s | _ -> failwith "golden: scope is not a string"
              )
            scopes;
      }
  | _ ->
      failwith "golden: token is not [text, scopes]"

let golden_to_string ~lang lines =
  let line_json line =
    Yojson.Safe.to_string (`List (List.map token_to_json line))
  in
  Printf.sprintf "{\"lang\": %S,\n \"lines\": [\n%s\n]}\n" lang
    (String.concat ",\n" (List.map line_json lines))

let read_golden path =
  match Yojson.Safe.from_file path with
  | `Assoc fields -> (
      match List.assoc_opt "lines" fields with
      | Some (`List lines) ->
          List.map
            (function
              | `List toks ->
                  List.map token_of_json toks
              | _ ->
                  failwith "golden: line is not a list"
              )
            lines
      | _ ->
          failwith "golden: missing lines"
    )
  | _ ->
      failwith "golden: not an object"

let render_line line =
  line
  |> List.map (fun { text; scopes } ->
      Printf.sprintf "  %S %s" text (String.concat " > " scopes)
  )
  |> String.concat "\n"

let rec after_common_prefix expected actual =
  match (expected, actual) with
  | e :: es, a :: as_ when e = a ->
      after_common_prefix es as_
  | _ ->
      (expected, actual)

let mismatched_lines ~expected ~actual =
  let rec go i expected actual acc =
    match (expected, actual) with
    | [], [] ->
        List.rev acc
    | e :: es, a :: as_ ->
        go (i + 1) es as_
          ( if e = a then
              acc
            else
              (i, e, a) :: acc
          )
    | e :: es, [] ->
        go (i + 1) es [] ((i, e, []) :: acc)
    | [], a :: as_ ->
        go (i + 1) [] as_ ((i, [], a) :: acc)
  in
  go 1 expected actual []

let bundled_highlighter = lazy (Ochre.load_exn Tm_grammars.all)

let sampled_langs ~samples =
  List.filter_map
    (fun (lang, _) ->
      if Sys.file_exists (sample_path ~samples lang) then
        Some lang
      else
        None
    )
    Tm_grammars.all

let bundled_collection =
  lazy
    (let t = TmLanguage.create () in
     let grammars =
       List.map
         (fun (lang, json) ->
           let grammar =
             TmLanguage.of_yojson_exn (Yojson.Basic.from_string json)
           in
           TmLanguage.add_grammar t grammar;
           (lang, grammar)
         )
         Tm_grammars.all
     in
     (t, grammars)
    )

let tm_language_tokens ?time_limit lang source =
  let t, grammars = Lazy.force bundled_collection in
  let grammar = List.assoc lang grammars in
  let lines = source_lines source in
  let last = List.length lines - 1 in
  let lines =
    List.mapi
      (fun i line ->
        if i < last || String.ends_with ~suffix:"\n" source then
          line ^ "\n"
        else
          line
      )
      lines
  in
  List.fold_left_map
    (fun stack line ->
      let tokens, stack =
        TmLanguage.tokenize_exn ?time_limit t grammar stack line
      in
      ( stack,
        List.map
          (fun tok -> (TmLanguage.ending tok, TmLanguage.scopes tok))
          tokens
      )
    )
    TmLanguage.empty lines
  |> snd

let first_difference a b =
  let rec go i a b =
    match (a, b) with
    | [], [] ->
        None
    | x :: xs, y :: ys when x = y ->
        go (i + 1) xs ys
    | _ ->
        Some i
  in
  go 1 a b

let check_sample ~samples lang () =
  let source = read_file (sample_path ~samples lang) in
  let hl = Lazy.force bundled_highlighter in
  let text =
    ochre_tokens hl ~lang source
    |> List.concat_map (List.map (fun tok -> tok.text))
    |> String.concat ""
  in
  Alcotest.(check string) "token texts join back to the sample" source text;
  match
    first_difference
      (tm_language_tokens lang source)
      (tm_language_tokens ~time_limit:Float.infinity lang source)
  with
  | None ->
      ()
  | Some line ->
      Alcotest.failf "%s: line %d hit the tokenizer time limit" lang line

let parity_failures ~samples ~golden lang =
  let source = read_file (sample_path ~samples lang) in
  let actual =
    comparable (ochre_tokens (Lazy.force bundled_highlighter) ~lang source)
  in
  let expected = read_golden (golden_path ~golden lang) in
  mismatched_lines ~expected ~actual

let check_parity ~samples ~golden lang () =
  let mismatches = parity_failures ~samples ~golden lang in
  match (List.assoc_opt lang expected_failures, mismatches) with
  | None, [] ->
      ()
  | None, (line, expected, actual) :: _ ->
      let expected, actual = after_common_prefix expected actual in
      Alcotest.failf
        "%s: %d line(s) differ from vscode-textmate. First at line %d, from \
         the first differing token.\n\
         ochre:\n\
         %s\n\
         vscode-textmate:\n\
         %s"
        lang (List.length mismatches) line (render_line actual)
        (render_line expected)
  | Some _, [] ->
      Alcotest.failf
        "%s now matches vscode-textmate: remove it from expected_failures" lang
  | Some _, _ :: _ ->
      ()

let check_lists ~samples ~golden () =
  let problems =
    List.filter_map
      (fun lang ->
        if not (List.mem_assoc lang Tm_grammars.all) then
          Some (lang ^ " is not a bundled grammar")
        else if not (Sys.file_exists (sample_path ~samples lang)) then
          Some (lang ^ " has no sample")
        else if not (Sys.file_exists (golden_path ~golden lang)) then
          Some (lang ^ " has no golden file")
        else
          None
      )
      parity
    @ List.filter_map
        (fun (lang, _) ->
          if List.mem lang parity then
            None
          else
            Some (lang ^ " is an expected failure but not on the parity list")
        )
        expected_failures
  in
  Alcotest.(check (list string)) "parity list is consistent" [] problems

let run_tests () =
  let samples = "samples" and golden = "golden" in
  Alcotest.run "conformance"
    [
      ( "lists",
        [
          Alcotest.test_case "parity list" `Quick (check_lists ~samples ~golden);
        ]
      );
      ( "sample",
        List.map
          (fun lang ->
            Alcotest.test_case lang `Quick (check_sample ~samples lang)
          )
          (sampled_langs ~samples)
      );
      ( "parity",
        List.map
          (fun lang ->
            Alcotest.test_case lang `Quick (check_parity ~samples ~golden lang)
          )
          parity
      );
    ]

let scope_name grammar_json =
  match Yojson.Safe.from_string grammar_json with
  | `Assoc fields -> (
      match List.assoc_opt "scopeName" fields with
      | Some (`String s) ->
          s
      | _ ->
          failwith "grammar has no scopeName"
    )
  | _ ->
      failwith "grammar is not a JSON object"

let prepare ~samples ~out =
  let out =
    if Filename.is_relative out then
      Filename.concat (Sys.getcwd ()) out
    else
      out
  in
  let grammars_dir = Filename.concat out "grammars" in
  if not (Sys.file_exists grammars_dir) then Sys.mkdir grammars_dir 0o755;
  let bundled =
    List.map
      (fun (lang, json) ->
        let path = Filename.concat grammars_dir (lang ^ ".json") in
        write_file path json;
        (lang, scope_name json, path)
      )
      Tm_grammars.all
  in
  let cases =
    List.filter_map
      (fun (lang, scope, path) ->
        if Sys.file_exists (sample_path ~samples lang) then
          let lines = source_lines (read_file (sample_path ~samples lang)) in
          Some
            (`Assoc
               [
                 ("id", `String lang);
                 ("scope_name", `String scope);
                 ("grammar_path", `String path);
                 ("lines", `List (List.map (fun l -> `String l) lines));
               ]
            )
        else
          None
      )
      bundled
  in
  let bundled_json =
    List.map
      (fun (lang, scope, path) ->
        `Assoc
          [
            ("lang", `String lang);
            ("scope_name", `String scope);
            ("grammar_path", `String path);
          ]
      )
      bundled
  in
  Yojson.Safe.to_file
    (Filename.concat out "request.json")
    (`Assoc [ ("bundled_grammars", `List bundled_json); ("cases", `List cases) ])

let read_vscode path =
  let member key = function
    | `Assoc fields -> (
        match List.assoc_opt key fields with
        | Some value ->
            value
        | None ->
            failwith ("vscode output: missing key " ^ key)
      )
    | _ ->
        failwith ("vscode output: expected an object with " ^ key)
  in
  let to_list = function
    | `List l ->
        l
    | _ ->
        failwith "vscode output: expected a list"
  in
  let to_string = function
    | `String s ->
        s
    | _ ->
        failwith "vscode output: expected a string"
  in
  Yojson.Safe.from_file path |> member "cases" |> to_list
  |> List.map (fun case ->
      ( to_string (member "id" case),
        member "tokens_by_line" case
        |> to_list
        |> List.map (fun line ->
            to_list line
            |> List.map (fun tok ->
                {
                  text = to_string (member "text" tok);
                  scopes = List.map to_string (to_list (member "scopes" tok));
                }
            )
        )
      )
  )

let write_golden ~vscode ~golden =
  let by_lang = read_vscode vscode in
  List.iter
    (fun lang ->
      match List.assoc_opt lang by_lang with
      | Some lines ->
          write_file (golden_path ~golden lang) (golden_to_string ~lang lines)
      | None ->
          failwith (lang ^ ": no vscode-textmate tokens")
    )
    parity

let write_report ~vscode ~samples ~report =
  let by_lang = read_vscode vscode in
  let hl = Lazy.force bundled_highlighter in
  let rows =
    List.map
      (fun (lang, _) ->
        match List.assoc_opt lang by_lang with
        | None ->
            Printf.sprintf "| %s | | no sample |" lang
        | Some expected ->
            let source = read_file (sample_path ~samples lang) in
            let actual = comparable (ochre_tokens hl ~lang source) in
            Printf.sprintf "| %s | %d | %d |" lang (List.length expected)
              (List.length (mismatched_lines ~expected ~actual))
      )
      Tm_grammars.all
  in
  write_file report
    (String.concat "\n"
       ([
          "# Conformance report";
          "";
          "Generated by `make conformance-report`. For each bundled grammar, \
           ochre tokenizes the Shiki sample in `test/conformance/samples/`, \
           and vscode-textmate 9.x with vscode-oniguruma tokenizes it too. A \
           mismatched line is a sample line whose token texts or scope stacks \
           differ.";
          "";
          "| Grammar | Lines | Mismatched lines |";
          "| --- | ---: | ---: |";
        ]
       @ rows
       )
    ^ "\n"
    )

let () =
  match Array.to_list Sys.argv with
  | [ _; "prepare"; samples; out ] ->
      prepare ~samples ~out
  | [ _; "golden"; vscode; golden ] ->
      write_golden ~vscode ~golden
  | [ _; "report"; vscode; samples; report ] ->
      write_report ~vscode ~samples ~report
  | [ _ ] ->
      run_tests ()
  | _ ->
      prerr_endline
        "Usage: test_conformance.exe\n\
        \       test_conformance.exe prepare SAMPLES OUT\n\
        \       test_conformance.exe golden VSCODE_JSON GOLDEN_DIR\n\
        \       test_conformance.exe report VSCODE_JSON SAMPLES REPORT";
      exit 2
