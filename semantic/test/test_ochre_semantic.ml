let spans source =
  match Ochre_semantic.classify source with
  | Ok spans ->
      List.map
        (fun { Ochre_semantic.offset; length; scope } ->
          (String.sub source offset length, scope)
        )
        spans
  | Error message ->
      Alcotest.failf "unexpected parse error: %s" message

let check name source expected =
  Alcotest.(check (list (pair string string))) name expected (spans source)

let test_module_path () =
  check "Foo.bar" "let _ = Foo.bar" [ ("Foo", "entity.name.namespace") ]

let test_nested_module_path () =
  check "A.B.c" "let _ = A.B.c"
    [ ("A", "entity.name.namespace"); ("B", "entity.name.namespace") ]

let test_modules () =
  check "module, module type, functor and open"
    "module type S = sig end\n\
     module F (X : S) : S = X\n\
     open Foo.Bar\n\
     let _ = Baz.(x)"
    [
      ("S", "entity.name.type.interface");
      ("F", "entity.name.namespace");
      ("X", "entity.name.namespace");
      ("S", "entity.name.type.interface");
      ("S", "entity.name.type.interface");
      ("X", "entity.name.namespace");
      ("Foo", "entity.name.namespace");
      ("Bar", "entity.name.namespace");
      ("Baz", "entity.name.namespace");
    ]

let test_first_class_modules () =
  check "(module M : S)" "let f (module M : S) = (module M : S)"
    [
      ("f", "entity.name.function");
      ("M", "entity.name.namespace");
      ("S", "entity.name.type.interface");
      ("M", "entity.name.namespace");
      ("S", "entity.name.type.interface");
    ]

let test_constructor () =
  check "Some x" "let _ = Some x" [ ("Some", "variable.other.enummember") ];
  check "qualified constructor in a pattern"
    "let _ = function M.None -> () | () -> ()"
    [ ("M", "entity.name.namespace"); ("None", "variable.other.enummember") ]

let test_booleans () =
  check "true and false" "let _ = function true -> false | false -> true" []

let test_polymorphic_variant () =
  check "`Tag" "let _ = `Tag 1" [ ("`Tag", "variable.other.enummember") ];
  check "`Tag in a pattern and a type"
    "let _ : [ `Tag ] -> unit = function `Tag -> ()"
    [
      ("`Tag", "variable.other.enummember");
      ("unit", "entity.name.type");
      ("`Tag", "variable.other.enummember");
    ]

let test_labels_at_call_site () =
  check "~label and ?opt" "let _ = f ~label:x ?opt:y ~punned ?optpun"
    [
      ("~label", "variable.parameter");
      ("?opt", "variable.parameter");
      ("~punned", "variable.parameter");
      ("?optpun", "variable.parameter");
    ]

let test_labels_in_parameters () =
  check "~label, ?opt and ?(opt = default)"
    "let _ = fun ~label ~renamed:x ?opt ?(default = 1) -> ()"
    [
      ("~label", "variable.parameter");
      ("~renamed", "variable.parameter");
      ("?opt", "variable.parameter");
      ("default", "variable.parameter");
    ]

let test_record_fields () =
  check "{ name = 1 }" "let _ = { name = 1 }"
    [ ("name", "variable.other.property") ];
  check "punned { name; M.other }" "let _ = { name; M.other }"
    [
      ("name", "variable.other.property");
      ("M", "entity.name.namespace");
      ("other", "variable.other.property");
    ];
  check "r.name" "let _ = r.name" [ ("name", "variable.other.property") ];
  check "r.M.name <- v" "let _ = r.M.name <- v"
    [ ("M", "entity.name.namespace"); ("name", "variable.other.property") ];
  check "{ name } in a pattern" "let _ = function { name } -> name"
    [ ("name", "variable.other.property") ]

let test_types () =
  check "type t = A of 'a" "type t = A of 'a"
    [
      ("t", "entity.name.type.enum");
      ("A", "variable.other.enummember");
      ("'a", "entity.name.type.parameter");
    ];
  check "record type" "type r = { name : M.t }"
    [
      ("r", "entity.name.type.struct");
      ("name", "variable.other.property");
      ("M", "entity.name.namespace");
      ("t", "entity.name.type");
    ];
  check "abstract type with a parameter" "type 'a t = 'a list"
    [
      ("'a", "entity.name.type.parameter");
      ("t", "entity.name.type");
      ("'a", "entity.name.type.parameter");
      ("list", "entity.name.type");
    ]

let test_bindings () =
  check "function and value bindings"
    "let f x = x\n\
     let g = function _ -> ()\n\
     let h : int -> int = succ\n\
     let v = let k () = 1 in k ()"
    [
      ("f", "entity.name.function");
      ("g", "entity.name.function");
      ("h", "entity.name.function");
      ("int", "entity.name.type");
      ("int", "entity.name.type");
      ("v", "variable.other.readwrite");
      ("k", "entity.name.function");
    ]

let test_locally_abstract_types () =
  check "(type a) and type b."
    "let v (type a) = ()\n\
     let f (type a) (x : a) = x\n\
     let g : type b. b -> b = Fun.id"
    [
      ("v", "variable.other.readwrite");
      ("a", "entity.name.type.parameter");
      ("f", "entity.name.function");
      ("a", "entity.name.type.parameter");
      ("a", "entity.name.type");
      ("g", "entity.name.function");
      ("b", "entity.name.type.parameter");
      ("b", "entity.name.type");
      ("b", "entity.name.type");
      ("Fun", "entity.name.namespace");
    ]

let test_byte_offsets () =
  match Ochre_semantic.classify "let _ = \"\xc3\xa9\" ^ Foo.bar" with
  | Ok [ { offset; length; scope } ] ->
      Alcotest.(check (triple int int string))
        "offset counts bytes"
        (15, 3, "entity.name.namespace")
        (offset, length, scope)
  | Ok spans ->
      Alcotest.failf "expected one span, got %d" (List.length spans)
  | Error message ->
      Alcotest.failf "unexpected parse error: %s" message

let stderr_of f =
  let path = Filename.temp_file "ochre_semantic" ".stderr" in
  let file = Unix.openfile path [ Unix.O_WRONLY; Unix.O_TRUNC ] 0o600 in
  let saved = Unix.dup Unix.stderr in
  Unix.dup2 file Unix.stderr;
  Fun.protect
    ~finally:(fun () ->
      Format.pp_print_flush Format.err_formatter ();
      flush stderr;
      Unix.dup2 saved Unix.stderr;
      Unix.close saved;
      Unix.close file
    )
    f;
  let output = In_channel.with_open_bin path In_channel.input_all in
  Sys.remove path;
  output

let test_lexer_warnings_are_silent () =
  Alcotest.(check string)
    "no output on stderr" ""
    (stderr_of (fun () -> ignore (Ochre_semantic.classify "let x = ( *)")))

let test_parenthesized_variant () =
  check "f (`A 1)" "let _ = f (`A 1)" [ ("`A", "variable.other.enummember") ];
  check "f ((`A))" "let _ = f ((`A))" [ ("`A", "variable.other.enummember") ];
  check "(`A) in a pattern" "let _ = function (`A) -> ()"
    [ ("`A", "variable.other.enummember") ]

let test_constrained_call_site_labels () =
  check "~(x : int)" "let _ = f ~(x : int)"
    [ ("x", "variable.parameter"); ("int", "entity.name.type") ]

let test_constrained_binding_pattern () =
  check "let (f : int -> int)" "let (f : int -> int) = succ"
    [
      ("f", "entity.name.function");
      ("int", "entity.name.type");
      ("int", "entity.name.type");
    ]

let test_external () =
  check "external" "external f : int -> int = \"f\"\nexternal v : int = \"v\""
    [
      ("f", "entity.name.function");
      ("int", "entity.name.type");
      ("int", "entity.name.type");
      ("v", "variable.other.readwrite");
      ("int", "entity.name.type");
    ]

let test_type_extension () =
  check "type t += A" "type t += A\ntype M.u += B"
    [
      ("t", "entity.name.type");
      ("A", "variable.other.enummember");
      ("M", "entity.name.namespace");
      ("u", "entity.name.type");
      ("B", "variable.other.enummember");
    ]

let test_type_alias_variable () =
  check "'a list as 'b" "type 'a t = 'a list as 'b"
    [
      ("'a", "entity.name.type.parameter");
      ("t", "entity.name.type");
      ("'a", "entity.name.type.parameter");
      ("list", "entity.name.type");
      ("'b", "entity.name.type.parameter");
    ]

let test_constrained_function_expression () =
  check "(fun x -> x : int -> int)"
    "let f = (fun x -> x : int -> int)\nlet g = (fun x -> x :> int -> int)"
    [
      ("f", "entity.name.function");
      ("int", "entity.name.type");
      ("int", "entity.name.type");
      ("g", "entity.name.function");
      ("int", "entity.name.type");
      ("int", "entity.name.type");
    ]

let test_shebang () =
  check "#! line" "#!/usr/bin/env ocaml\nlet x = Foo.y"
    [ ("x", "variable.other.readwrite"); ("Foo", "entity.name.namespace") ]

let test_function_behind_binding_forms () =
  check "newtype, let open, let module and let"
    "let f (type a) = fun (x : a) -> x\n\
     let g = let open M in fun x -> x\n\
     let h = let module N = M in fun x -> x\n\
     let i = let y = 1 in fun x -> x + y"
    [
      ("f", "entity.name.function");
      ("a", "entity.name.type.parameter");
      ("a", "entity.name.type");
      ("g", "entity.name.function");
      ("M", "entity.name.namespace");
      ("h", "entity.name.function");
      ("N", "entity.name.namespace");
      ("M", "entity.name.namespace");
      ("i", "entity.name.function");
      ("y", "variable.other.readwrite");
    ]

let test_functor_application_path () =
  check "F(X).t" "type u = F(X).t"
    [
      ("u", "entity.name.type");
      ("F", "entity.name.namespace");
      ("X", "entity.name.namespace");
      ("t", "entity.name.type");
    ]

let test_toplevel_directive () =
  check "#require" "#require \"x\";;\nlet x = Foo.y"
    [ ("x", "variable.other.readwrite"); ("Foo", "entity.name.namespace") ]

let test_syntax_error () =
  match Ochre_semantic.classify "let x = (" with
  | Error _ ->
      ()
  | Ok _ ->
      Alcotest.fail "expected a parse error"

let test_string_literal () =
  check "string literal" {|let _ = "Foo.bar"|} [];
  check "quoted string and comment" "let _ = {|Foo.bar|} (* Foo.bar *)" []

let test_lexer_error () =
  match Ochre_semantic.classify "let _ = \"Foo.bar" with
  | Error _ ->
      ()
  | Ok _ ->
      Alcotest.fail "expected a parse error"

let ocaml =
  match Ochre.load [ ("ocaml", Tm_grammars.ocaml) ] with
  | Ok highlighter -> (
      match Ochre.lang highlighter "ocaml" with
      | Ok lang ->
          lang
      | Error error ->
          failwith (Ochre.Error.to_string error)
    )
  | Error error ->
      failwith (Ochre.Error.to_string error)

let color hex = Option.get (Ochre.Color.of_hex hex)

let theme rules =
  Ochre.Theme.make ~name:"semantic-test"
    ~colors:
      [
        ("editor.foreground", color "#111111");
        ("editor.background", color "#fafafa");
      ]
    ~token_colors:
      (List.map
         (fun (scope, hex) ->
           Ochre.Theme.rule ~scope:[ scope ] ~foreground:(color hex) ()
         )
         rules
      )
    ()

let semantic_theme =
  theme
    [
      ("entity.name.namespace", "#ff0000");
      ("variable.other.enummember", "#00aa00");
    ]

let html ?scopes theme source =
  Ochre.to_html (Ochre.highlight ?scopes ~theme ~lang:ocaml source)

let semantic_html theme source =
  match Ochre_semantic.scope_spans source with
  | Ok scopes ->
      html ~scopes theme source
  | Error message ->
      Alcotest.failf "unexpected error: %s" message

let contains ~sub text =
  let n = String.length sub in
  let rec go i =
    i + n <= String.length text && (String.sub text i n = sub || go (i + 1))
  in
  go 0

let test_semantic_colors_in_html () =
  let output = semantic_html semantic_theme "let _ = Foo.bar (Some x)" in
  Alcotest.(check bool)
    "Foo is red" true
    (contains ~sub:{|color:var(--ochre,#ff0000)">Foo</span>|} output);
  Alcotest.(check bool)
    "Some is green" true
    (contains ~sub:{|color:var(--ochre,#00aa00)">Some</span>|} output)

let test_theme_without_semantic_rules () =
  let plain = theme [ ("keyword", "#0000ff") ] in
  let source =
    "module M = Foo.Bar\n\
     let f ~label ?opt (x : M.t) = Some { r with name = `Tag }"
  in
  Alcotest.(check string)
    "same HTML" (html plain source)
    (semantic_html plain source)

let test_booleans_keep_their_color () =
  let source = "let _ = true && false" in
  Alcotest.(check string)
    "same HTML"
    (html semantic_theme source)
    (semantic_html semantic_theme source)

let test_scope_spans_parse_error () =
  match Ochre_semantic.scope_spans "let x = (" with
  | Error _ ->
      ()
  | Ok _ ->
      Alcotest.fail "expected a parse error"

let () =
  Alcotest.run "ochre-semantic"
    [
      ( "classify",
        [
          Alcotest.test_case "module path" `Quick test_module_path;
          Alcotest.test_case "nested module path" `Quick test_nested_module_path;
          Alcotest.test_case "modules" `Quick test_modules;
          Alcotest.test_case "first-class modules" `Quick
            test_first_class_modules;
          Alcotest.test_case "constructor" `Quick test_constructor;
          Alcotest.test_case "booleans" `Quick test_booleans;
          Alcotest.test_case "polymorphic variant" `Quick
            test_polymorphic_variant;
          Alcotest.test_case "labels at a call site" `Quick
            test_labels_at_call_site;
          Alcotest.test_case "labels in parameters" `Quick
            test_labels_in_parameters;
          Alcotest.test_case "record fields" `Quick test_record_fields;
          Alcotest.test_case "types" `Quick test_types;
          Alcotest.test_case "bindings" `Quick test_bindings;
          Alcotest.test_case "locally abstract types" `Quick
            test_locally_abstract_types;
          Alcotest.test_case "byte offsets" `Quick test_byte_offsets;
          Alcotest.test_case "parenthesized variant" `Quick
            test_parenthesized_variant;
          Alcotest.test_case "constrained call-site labels" `Quick
            test_constrained_call_site_labels;
          Alcotest.test_case "constrained binding pattern" `Quick
            test_constrained_binding_pattern;
          Alcotest.test_case "external" `Quick test_external;
          Alcotest.test_case "type extension" `Quick test_type_extension;
          Alcotest.test_case "type alias variable" `Quick
            test_type_alias_variable;
          Alcotest.test_case "constrained function expression" `Quick
            test_constrained_function_expression;
          Alcotest.test_case "shebang" `Quick test_shebang;
          Alcotest.test_case "function behind binding forms" `Quick
            test_function_behind_binding_forms;
          Alcotest.test_case "functor application path" `Quick
            test_functor_application_path;
          Alcotest.test_case "toplevel directive" `Quick test_toplevel_directive;
          Alcotest.test_case "syntax error" `Quick test_syntax_error;
          Alcotest.test_case "string literal" `Quick test_string_literal;
          Alcotest.test_case "lexer error" `Quick test_lexer_error;
          Alcotest.test_case "lexer warnings are silent" `Quick
            test_lexer_warnings_are_silent;
        ]
      );
      ( "highlight",
        [
          Alcotest.test_case "semantic colors in HTML" `Quick
            test_semantic_colors_in_html;
          Alcotest.test_case "theme without semantic rules" `Quick
            test_theme_without_semantic_rules;
          Alcotest.test_case "booleans keep their color" `Quick
            test_booleans_keep_their_color;
          Alcotest.test_case "parse error" `Quick test_scope_spans_parse_error;
        ]
      );
    ]
