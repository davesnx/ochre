let langs =
  [
    "ocaml";
    "ocaml-interface";
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

let get_ok = function
  | Ok value ->
      value
  | Error error ->
      failwith (Ochre.Error.to_string error)

let highlighter =
  get_ok
    (Ochre.load
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
    )

let theme = fst (get_ok (Ochre.Theme.load Tm_themes.dark_plus))

let check_tokens lang source =
  let tokens =
    List.concat
      (Ochre.highlight ~theme
         ~lang:(get_ok (Ochre.lang highlighter lang))
         source
      )
        .lines
  in
  List.iter
    (fun (token : Ochre.Token.t) ->
      if token.text = "" then Crowbar.failf "%s: empty token" lang
    )
    tokens;
  Crowbar.check_eq ~pp:Crowbar.pp_string source
    (String.concat ""
       (List.map (fun (token : Ochre.Token.t) -> token.text) tokens)
    )

let () =
  List.iter
    (fun lang ->
      Crowbar.add_test ~name:lang
        [ Crowbar.list Crowbar.bytes ]
        (fun parts -> check_tokens lang (String.concat "\n" parts))
    )
    langs
