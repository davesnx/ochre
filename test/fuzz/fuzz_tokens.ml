let langs =
  [
    "ocaml";
    "javascript";
    "typescript";
    "markdown";
    "css";
    "go";
    "python";
    "rust";
    "html";
    "json";
    "yaml";
    "c";
    "shellscript";
    "dotenv";
    "shellsession";
  ]

let highlighter =
  Ochre.load_exn
    (List.map
       (fun lang ->
         match Tm_grammars.find lang with
         | Some json ->
             (lang, json)
         | None ->
             failwith ("tm-grammars has no grammar " ^ lang)
       )
       langs
    )

let theme = Ochre.Theme.dark

let check_tokens lang source =
  let tokens = List.concat (Ochre.to_tokens highlighter ~theme ~lang source) in
  List.iter
    (fun (token : Ochre.Token.styled_token) ->
      if token.text = "" then Crowbar.failf "%s: empty token" lang
    )
    tokens;
  Crowbar.check_eq ~pp:Crowbar.pp_string source
    (String.concat ""
       (List.map (fun (token : Ochre.Token.styled_token) -> token.text) tokens)
    )

let () =
  List.iter
    (fun lang ->
      Crowbar.add_test ~name:lang
        [ Crowbar.list Crowbar.bytes ]
        (fun parts -> check_tokens lang (String.concat "\n" parts))
    )
    langs
