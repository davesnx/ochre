let range (d : Ochre.Decoration.t) =
  (d.start.line, d.start.character, d.end_.line, d.end_.character)

let types ?load_path source =
  (Ochre_merlin.analyze ?load_path source).decorations
  |> List.filter_map (fun (d : Ochre.Decoration.t) ->
      List.assoc_opt "ochre-type" d.properties.data
      |> Option.map (fun ty -> (range d, ty))
  )

let check_type ?load_path source ~range:(l1, c1, l2, c2) expected =
  let found =
    List.filter_map
      (fun (r, ty) ->
        if r = (l1, c1, l2, c2) then
          Some ty
        else
          None
      )
      (types ?load_path source)
  in
  Alcotest.(check (list string))
    (Printf.sprintf "type at %d:%d-%d:%d" l1 c1 l2 c2)
    [ expected ] found

let test_identifier_types () =
  let source = "let x = List.map succ [1]" in
  check_type source ~range:(0, 8, 0, 16) "('a -> 'b) -> 'a list -> 'b list";
  check_type source ~range:(0, 4, 0, 5) "int list"

let test_unicode_positions () =
  let source = "(* été *)\nlet s = \"héllo 🐫\" let n = String.length s" in
  check_type source ~range:(1, 26, 1, 39) "string -> int";
  check_type source ~range:(1, 40, 1, 41) "string"

let test_constrained_and_alias_patterns () =
  let source =
    "let y : string = \"a\"\n\
     let f (l : int list) = match l with _ :: _ as v -> v | [] -> []"
  in
  check_type source ~range:(0, 4, 0, 5) "string";
  check_type source ~range:(1, 46, 1, 47) "int list"

let test_constructors_and_fields () =
  let source =
    "type r = { name : string }\n\
     let a = Some 1\n\
     let n r = r.name\n\
     let f = function None -> 0 | Some x -> x"
  in
  check_type source ~range:(1, 8, 1, 12) "'a -> 'a option";
  check_type source ~range:(2, 12, 2, 16) "string";
  check_type source ~range:(3, 17, 3, 21) "'a option";
  check_type source ~range:(3, 29, 3, 33) "'a -> 'a option"

let test_recovered_expressions_have_no_type () =
  let source = "let s : int = \"a\"\nlet g = Missing.f" in
  let ranges = List.map fst (types source) in
  Alcotest.(check bool)
    "no type on ill-typed constant" false
    (List.mem (0, 14, 0, 17) ranges);
  Alcotest.(check bool)
    "no type on unbound identifier" false
    (List.mem (1, 8, 1, 17) ranges)

let test_line_directive_keeps_physical_lines () =
  let source = "# 100 \"x.ml\"\nlet x = succ 1\nlet y : string = 1" in
  check_type source ~range:(1, 4, 1, 5) "int";
  check_type source ~range:(1, 8, 1, 12) "int -> int";
  Alcotest.(check (list (pair (pair int int) (pair int int))))
    "diagnostic range"
    [ ((2, 17), (2, 18)) ]
    (List.map
       (fun (d : Ochre_merlin.diagnostic) ->
         ((d.start.line, d.start.character), (d.end_.line, d.end_.character))
       )
       (Ochre_merlin.analyze source).diagnostics
    )

let test_shadowed_type_names_are_qualified () =
  let source =
    "type 'a option = Local of 'a\nlet f = List.find_opt\nlet v = Some 1"
  in
  let found = types source in
  List.iter
    (fun range ->
      match List.assoc_opt range found with
      | None ->
          Alcotest.fail "no type"
      | Some ty ->
          Alcotest.(check bool)
            (ty ^ " does not show a bare option")
            false
            (List.exists
               (fun word -> word = "option")
               (String.split_on_char ' ' ty)
            )
    )
    [ (1, 8, 1, 21); (2, 4, 2, 5); (2, 8, 2, 12) ]

let test_type_error () =
  let source = "let y : string = 1" in
  let result = Ochre_merlin.analyze source in
  match result.diagnostics with
  | [ { severity = Error; start; end_; message } ] ->
      Alcotest.(check (pair (pair int int) (pair int int)))
        "error range"
        ((0, 17), (0, 18))
        ((start.line, start.character), (end_.line, end_.character));
      Alcotest.(check string)
        "merlin message"
        "The constant 1 has type int but an expression was expected of type \
         string"
        message;
      let marks =
        List.filter
          (fun (d : Ochre.Decoration.t) ->
            d.properties.class_ = Some "ochre-error"
          )
          result.decorations
      in
      Alcotest.(check (list (pair (pair int int) (pair int int))))
        "error decoration range"
        [ ((0, 17), (0, 18)) ]
        (List.map
           (fun (d : Ochre.Decoration.t) ->
             ((d.start.line, d.start.character), (d.end_.line, d.end_.character))
           )
           marks
        );
      Alcotest.(check (list (option string)))
        "error decoration message" [ Some message ]
        (List.map
           (fun (d : Ochre.Decoration.t) ->
             List.assoc_opt "ochre-diagnostic" d.properties.data
           )
           marks
        )
  | diagnostics ->
      Alcotest.failf "expected one error, got %d diagnostics"
        (List.length diagnostics)

let test_syntax_error_does_not_raise () =
  let result = Ochre_merlin.analyze "let = = (\n\"unterminated" in
  Alcotest.(check bool)
    "has an error" true
    (List.exists
       (fun (d : Ochre_merlin.diagnostic) -> d.severity = Error)
       result.diagnostics
    )

let test_warning () =
  let result = Ochre_merlin.analyze "let f () = let x = 1 in 2" in
  Alcotest.(check (list (pair string (pair int int))))
    "warning decorations"
    [ ("ochre-warning", (15, 16)) ]
    (List.filter_map
       (fun (d : Ochre.Decoration.t) ->
         match List.assoc_opt "ochre-diagnostic" d.properties.data with
         | Some _ ->
             Some
               ( Option.value ~default:"" d.properties.class_,
                 (d.start.character, d.end_.character)
               )
         | None ->
             None
       )
       result.decorations
    )

let contains ~sub s =
  let n = String.length sub in
  let rec go i =
    i + n <= String.length s && (String.sub s i n = sub || go (i + 1))
  in
  go 0

let ok = function
  | Ok value ->
      value
  | Error error ->
      Alcotest.fail (Ochre.Error.to_string error)

let html_of source =
  let { Ochre_merlin.decorations; _ } = Ochre_merlin.analyze source in
  let highlighter =
    ok
      (Ochre.load
         [
           (Tm_grammar_ocaml.lang_id, Tm_grammar_ocaml.json);
           (Tm_grammar_ocaml_interface.lang_id, Tm_grammar_ocaml_interface.json);
         ]
      )
  in
  let lang = ok (Ochre.lang highlighter "ocaml") in
  Ochre.to_html
    (Ochre.highlight ~decorations
       ~theme:(Ochre.Theme.make ~name:"plain" ~token_colors:[] ())
       ~lang source
    )

let test_html_escapes_data () =
  let source = "let o = object method m = 1 end\nlet f = function \"a\" -> 1" in
  let html = html_of source in
  List.iter
    (fun (expected, present) ->
      Alcotest.(check bool) expected present (contains ~sub:expected html)
    )
    [
      ({|data-ochre-type="&lt; m : int &gt;"|}, true);
      ({|data-ochre-type="< m : int >"|}, false);
      ({|not matched: &quot;&quot;"|}, true);
    ]

let escape s =
  String.concat ""
    (List.map
       (function
         | '&' ->
             "&amp;"
         | '<' ->
             "&lt;"
         | '>' ->
             "&gt;"
         | '"' ->
             "&quot;"
         | '\'' ->
             "&apos;"
         | c ->
             String.make 1 c
         )
       (List.of_seq (String.to_seq s))
    )

let diagnostic_tooltips html =
  let key = "data-ochre-diagnostic=\"" in
  let rec collect from acc =
    match
      List.find_opt
        (fun i -> String.sub html i (String.length key) = key)
        (List.init
           (max 0 (String.length html - String.length key - from + 1))
           (fun i -> from + i)
        )
    with
    | None ->
        List.rev acc
    | Some i ->
        let start = i + String.length key in
        let stop = String.index_from html start '"' in
        collect stop (String.sub html start (stop - start) :: acc)
  in
  collect 0 []

let test_overlapping_diagnostics_all_shown () =
  let source = "let f x = match x with 0 -> \"a\" + 1" in
  let { Ochre_merlin.diagnostics; _ } = Ochre_merlin.analyze source in
  Alcotest.(check int) "two diagnostics" 2 (List.length diagnostics);
  Alcotest.(check bool)
    "one tooltip holds both messages" true
    (List.exists
       (fun tooltip ->
         List.for_all
           (fun (d : Ochre_merlin.diagnostic) ->
             contains ~sub:(escape d.message) tooltip
           )
           diagnostics
       )
       (diagnostic_tooltips (html_of source))
    )

let test_zero_width_diagnostic_is_shown () =
  List.iter
    (fun source ->
      let { Ochre_merlin.diagnostics; _ } = Ochre_merlin.analyze source in
      Alcotest.(check bool)
        "a zero-width diagnostic keeps its position" true
        (List.exists
           (fun (d : Ochre_merlin.diagnostic) -> d.start = d.end_)
           diagnostics
        );
      Alcotest.(check bool)
        (Printf.sprintf "html of %S has a diagnostic tooltip" source)
        true
        (diagnostic_tooltips (html_of source) <> [])
    )
    [ "let x ="; "let x =\n"; "let x =\n\n" ]

let test_warning_as_error_is_error () =
  let result =
    Ochre_merlin.analyze
      "[@@@ocaml.warnerror \"+26\"]\nlet f () = let x = 1 in 2"
  in
  Alcotest.(check (list bool))
    "severity is Error" [ true ]
    (List.map
       (fun (d : Ochre_merlin.diagnostic) -> d.severity = Error)
       result.diagnostics
    )

let test_sub_messages_are_kept () =
  let result = Ochre_merlin.analyze "let lenght = 1\nlet y = lengt" in
  Alcotest.(check bool)
    "hint in message" true
    (List.exists
       (fun (d : Ochre_merlin.diagnostic) ->
         contains ~sub:"Hint: Did you mean lenght?" d.message
       )
       result.diagnostics
    )

let test_css_targets_decorations () =
  List.iter
    (fun sub -> Alcotest.(check bool) sub true (contains ~sub Ochre_merlin.css))
    [
      "content: attr(data-ochre-type)";
      "content: attr(data-ochre-diagnostic)";
      ".ochre-error";
      ".ochre-warning";
    ]

let test_load_path () =
  let fixture_dir = Filename.dirname Sys.argv.(1) in
  check_type ~load_path:[ fixture_dir ] "let g = Fixture_lib.greet"
    ~range:(0, 8, 0, 25) "string -> string"

let () =
  Alcotest.run
    ~argv:[| Sys.argv.(0) |]
    "Ochre_merlin"
    [
      ( "analyze",
        [
          Alcotest.test_case "identifier types" `Quick test_identifier_types;
          Alcotest.test_case "unicode positions" `Quick test_unicode_positions;
          Alcotest.test_case "constrained and alias patterns" `Quick
            test_constrained_and_alias_patterns;
          Alcotest.test_case "constructors and fields" `Quick
            test_constructors_and_fields;
          Alcotest.test_case "type error" `Quick test_type_error;
          Alcotest.test_case "line directive keeps physical lines" `Quick
            test_line_directive_keeps_physical_lines;
          Alcotest.test_case "shadowed type names are qualified" `Quick
            test_shadowed_type_names_are_qualified;
          Alcotest.test_case "recovered expressions have no type" `Quick
            test_recovered_expressions_have_no_type;
          Alcotest.test_case "warning" `Quick test_warning;
          Alcotest.test_case "load path" `Quick test_load_path;
          Alcotest.test_case "html escapes data" `Quick test_html_escapes_data;
          Alcotest.test_case "css targets decorations" `Quick
            test_css_targets_decorations;
          Alcotest.test_case "syntax error does not raise" `Quick
            test_syntax_error_does_not_raise;
          Alcotest.test_case "overlapping diagnostics all shown" `Quick
            test_overlapping_diagnostics_all_shown;
          Alcotest.test_case "zero-width diagnostic is shown" `Quick
            test_zero_width_diagnostic_is_shown;
          Alcotest.test_case "warning as error is error" `Quick
            test_warning_as_error_is_error;
          Alcotest.test_case "sub-messages are kept" `Quick
            test_sub_messages_are_kept;
        ]
      );
    ]
