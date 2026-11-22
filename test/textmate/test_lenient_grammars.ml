(* Regression tests for grammars that are technically malformed per the
   TextMate spec but that vscode-textmate still loads and tokenizes
   leniently rather than rejecting outright (see data/lenient.json for the
   shapes and reader.ml for the matching vscode-textmate behavior each one
   mirrors). ochre's bundled tm-grammars package ships several real-world
   grammars with exactly these bugs (Blade, CodeQL, D, Move, Racket, Stata,
   Wikitext, XML); this file isolates the shapes in a small synthetic
   grammar instead of depending on tm-grammars from the vendored library's
   own test suite. *)
open Util

(* Checks that tokenizing [line] does not raise and that the emitted tokens
   cover the whole line: endings strictly increase, start at > 0, and the
   last one reaches the end of the line. This is the same "no byte lost or
   double-counted" property the full ochre pipeline checks by concatenating
   token text back to the source. *)
let check_full_coverage t grammar line () =
  let open TmLanguage in
  let toks, (_ : stack) = tokenize_exn t grammar empty line in
  Alcotest.(check bool) (line ^ ": at least one token") true (toks <> []);
  let last_ending =
    List.fold_left
      (fun prev tok ->
        let e = ending tok in
        Alcotest.(check bool) (line ^ ": ending increases") true (e > prev);
        e
      )
      0 toks
  in
  Alcotest.(check int)
    (line ^ ": last token reaches end of line")
    (String.length line) last_ending

let check_top_scope t grammar line expected () =
  let open TmLanguage in
  let toks, (_ : stack) = tokenize_exn t grammar empty line in
  match toks with
  | tok :: _ ->
      Alcotest.(check string) line expected (List.hd (scopes tok))
  | [] ->
      Alcotest.fail (line ^ ": expected at least one token")

let make_suite name read =
  let grammar = read "data/lenient.json" in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  let find () = Option.get (TmLanguage.find_by_scope_name t "source.lenient") in
  ( name,
    [
      Alcotest.test_case "begin without end/while runs to end of input" `Quick
        (check_top_scope t (find ()) "BEGIN rest of the line" "no.end");
      Alcotest.test_case "match wins when both match and begin are present"
        `Quick
        (check_top_scope t (find ()) "MATCHWINS" "match.wins");
      Alcotest.test_case "non-dict capture value degrades to no name" `Quick
        (check_full_coverage t (find ()) "BADCAP");
      Alcotest.test_case "null contentName degrades to no content name" `Quick
        (check_full_coverage t (find ()) "NCSTART inside NCEND");
    ]
  )

let () =
  Alcotest.run "Lenient grammars"
    [ make_suite "Yojson" read_yojson_basic; make_suite "Ezjsonm" read_ezjsonm ]
