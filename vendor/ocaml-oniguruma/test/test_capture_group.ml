(* Oniguruma's default syntax disables numbered-group capture once a named
   group is present anywhere in the same pattern
   (ONIGERR_NUMBERED_BACKREF_OR_CALL_NOT_ALLOWED, "numbered backref/call is
   not allowed. (use name)"), unless ONIG_OPTION_CAPTURE_GROUP is set.
   TextMate grammars routinely mix the two (e.g. Swift's bundled grammar has
   a regex-literal-callout rule using a numbered subroutine call, \g<20>,
   alongside several (?<name>...) groups), and vscode-oniguruma always
   compiles with this option set. ocaml-textmate-language's
   [TmLanguage.compile_regex] (vendor/ocaml-textmate-language/src/common.ml)
   relies on the same option to load such grammars; this locks in the
   Oniguruma-level behavior that depends on. *)

let pattern = "(?<name>a)(b)\\g<2>"

let () =
  ( match
      Oniguruma.create pattern Oniguruma.Options.none Oniguruma.Encoding.utf8
        Oniguruma.Syntax.default
    with
  | Error _ ->
      ()
  | Ok _ ->
      failwith
        "expected a numbered subroutine call next to a named group to be \
         rejected without ONIG_OPTION_CAPTURE_GROUP"
  );
  match
    Oniguruma.create pattern Oniguruma.Options.capture_group
      Oniguruma.Encoding.utf8 Oniguruma.Syntax.default
  with
  | Error err ->
      failwith ("expected capture_group to allow " ^ pattern ^ ": " ^ err)
  | Ok re -> (
      let str = "abb" in
      match
        Oniguruma.search re str 0 (String.length str) Oniguruma.Options.none
      with
      | None ->
          failwith "expected a match"
      | Some region ->
          assert (Oniguruma.Region.capture_beg region 0 = 0);
          assert (Oniguruma.Region.capture_end region 0 = 3)
    )
