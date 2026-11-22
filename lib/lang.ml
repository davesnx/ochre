type kind =
  | Plaintext
  | Grammar of { collection : TmLanguage.t; grammar : TmLanguage.grammar }

type t = { name : string; kind : kind }

let plaintext = { name = "plaintext"; kind = Plaintext }
let name t = t.name
let plaintext_names = [ "plaintext"; "text"; "txt" ]

let find loader name =
  match Grammar_loader.find_grammar loader name with
  | Some grammar ->
      Ok
        {
          name;
          kind =
            Grammar
              { collection = Grammar_loader.tm_collection loader; grammar };
        }
  | None when List.mem name plaintext_names ->
      Ok { name; kind = Plaintext }
  | None ->
      Error (Error.Unknown_language name)
