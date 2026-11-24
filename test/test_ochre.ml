let get_ok = function
  | Ok value ->
      value
  | Error error ->
      failwith (Ochre.Error.to_string error)

let load_theme json = fst (get_ok (Ochre.Theme.load json))
let dark_plus = load_theme Tm_themes.dark_plus
let light_plus = load_theme Tm_themes.light_plus
let nord = load_theme Tm_themes.nord

let hex = Ochre.Color.to_hex
let color s = Option.get (Ochre.Color.of_hex s)
let fg (tok : Ochre.Token.t) = hex (Ochre.Token.style tok).foreground
let bg (tok : Ochre.Token.t) = Option.map hex (Ochre.Token.style tok).background

let font_styles (tok : Ochre.Token.t) =
  let style = (Ochre.Token.style tok).font_style in
  List.filter_map
    (fun (on, name) ->
      if on then
        Some name
      else
        None
    )
    [
      (style.bold, "bold");
      (style.italic, "italic");
      (style.underline, "underline");
      (style.strikethrough, "strikethrough");
    ]

let lines_of pieces =
  let source = String.concat "" (List.concat pieces) in
  let themed =
    Ochre.highlight ~theme:dark_plus ~lang:Ochre.Lang.plaintext source
  in
  List.map2
    (fun line pieces ->
      match line with
      | [ (token : Ochre.Token.t) ] ->
          let _, tokens =
            List.fold_left
              (fun (pos, acc) piece ->
                let len = String.length piece in
                match Ochre.Token.sub token ~pos ~len with
                | Some piece ->
                    (pos + len, piece :: acc)
                | None ->
                    Alcotest.failf "piece %S is not inside %S" piece token.text
              )
              (0, []) pieces
          in
          List.rev tokens
      | _ ->
          assert false
    )
    themed.lines pieces

let make_tok text = List.hd (List.hd (lines_of [ [ text ] ]))

let with_style f (tok : Ochre.Token.t) =
  Ochre.Token.map_style (fun _ s -> f s) tok

let with_fg c tok =
  with_style (fun s -> { s with Ochre.Style.foreground = color c }) tok

let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.test" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.test" }
  ]
}|}

let highlight () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = get_ok (Ochre.load_from_files [ path ]) in
  Sys.remove path;
  hl

let test_theme_loading () =
  let theme_json =
    {|
    {
      "name": "test-theme",
      "colors": {
        "editor.foreground": "#000000",
        "editor.background": "#ffffff"
      },
      "tokenColors": [
        {
          "scope": "comment",
          "settings": {
            "foreground": "#888888",
            "fontStyle": "italic"
          }
        }
      ]
    }
  |}
  in
  let theme = fst (get_ok (Ochre.Theme.load theme_json)) in
  Alcotest.(check string) "theme name" "test-theme" theme.name;
  Alcotest.(check string) "theme fg" "#000000" (hex theme.fg);
  Alcotest.(check string) "theme bg" "#ffffff" (hex theme.bg);
  Alcotest.(check int) "token_colors length" 1 (List.length theme.token_colors)

let test_source_text_is_preserved () =
  let highlighter = highlight () in
  let rendered_source source =
    (Ochre.highlight ~theme:dark_plus
       ~lang:(get_ok (Ochre.lang highlighter "test"))
       source
    )
      .lines |> List.concat
    |> List.map (fun (token : Ochre.Token.t) -> token.text)
    |> String.concat ""
  in
  List.iter
    (fun source ->
      Alcotest.(check string) "source text" source (rendered_source source)
    )
    [ ""; "let x = 1"; "let x = 1\n"; "let x = 1\nlet y = 2" ]

let test_theme_make_raw () =
  let theme =
    Ochre.Theme.make ~name:"raw-theme"
      ~colors:
        [
          ("editor.foreground", color "#111111");
          ("editor.background", color "#fafafa");
        ]
      ~token_colors:
        [
          Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:(color "#ff0000") ();
          Ochre.Theme.rule ~scope:[ "comment" ] ~foreground:(color "#00aa00")
            ~font_style:{ Ochre.Style.plain with italic = true }
            ();
        ]
      ()
  in
  Alcotest.(check string) "theme name" "raw-theme" theme.name;
  Alcotest.(check string) "theme fg" "#111111" (hex theme.fg);
  Alcotest.(check string) "theme bg" "#fafafa" (hex theme.bg);
  Alcotest.(check int) "token_colors length" 2 (List.length theme.token_colors)

let test_scope_matching () =
  let hl = highlight () in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
         )
      )
  in
  let tokens =
    (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl "test")) "let x = 42")
      .lines
  in
  match tokens with
  | (first :: _) :: _ ->
      Alcotest.(check string) "keyword gets red" "#ff0000" (fg first)
  | _ ->
      Alcotest.fail "expected at least one token"

let test_scope_property_merge () =
  let hl = highlight () in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "merge-test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } },
        { "scope": "keyword.control", "settings": { "fontStyle": "bold" } }
      ]
    }|}
         )
      )
  in
  let tokens =
    (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl "test")) "let x = 42")
      .lines
  in
  match tokens with
  | (first :: _) :: _ ->
      Alcotest.(check string)
        "foreground merged from broader rule" "#ff0000" (fg first);
      Alcotest.(check bool)
        "font style merged from narrower rule" true
        (List.mem "bold" (font_styles first))
  | _ ->
      Alcotest.fail "expected at least one token"

let test_capture_arrays_in_grammar () =
  let grammar_with_capture_array =
    {|{
    "scopeName": "source.capture-array",
    "name": "capture-array",
    "patterns": [
      {
        "begin": "(let)",
        "end": "$",
        "beginCaptures": [
          { "name": "keyword.control.test" }
        ]
      }
    ]
  }|}
  in
  let hl =
    get_ok (Ochre.load [ ("capture-array", grammar_with_capture_array) ])
  in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "test",
      "colors": {
        "editor.foreground": "#d4d4d4",
        "editor.background": "#1e1e1e"
      },
      "tokenColors": []
    }|}
         )
      )
  in
  let _ =
    (Ochre.highlight ~theme
       ~lang:(get_ok (Ochre.lang hl "capture-array"))
       "let x = 1"
    )
      .lines
  in
  ()

let test_transform_empty_passthrough () =
  let hl = highlight () in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
         )
      )
  in
  let tokens =
    (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl "test")) "let x = 42")
      .lines
  in
  let tokens_with =
    (Ochre.highlight ~transforms:[] ~theme
       ~lang:(get_ok (Ochre.lang hl "test"))
       "let x = 42"
    )
      .lines
  in
  Alcotest.(check int)
    "same number of lines" (List.length tokens) (List.length tokens_with);
  List.iter2
    (fun line1 line2 ->
      List.iter2
        (fun (t1 : Ochre.Token.t) (t2 : Ochre.Token.t) ->
          Alcotest.(check string) "same text" t1.text t2.text;
          Alcotest.(check string) "same fg" (fg t1) (fg t2);
          Alcotest.(check (option string)) "same bg" (bg t1) (bg t2)
        )
        line1 line2
    )
    tokens tokens_with

let test_transform_ordering () =
  let doc : Ochre.Token.line list =
    [
      [
        {
          (with_fg "#ff0000" (make_tok "let")) with
          scopes = [ "keyword.control.test"; "source.test" ];
        };
      ];
    ]
  in
  let t1 =
    Ochre.Transform.make "first" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.t) ->
            with_style
              (fun s ->
                { s with Ochre.Style.background = Some (color "#111111") }
              )
              tok
          )
          line
    )
  in
  let t2 =
    Ochre.Transform.make "second" ~after_line:(fun ~line_index:_ line ->
        List.map
          (fun (tok : Ochre.Token.t) ->
            with_style
              (fun s ->
                { s with Ochre.Style.background = Some (color "#222222") }
              )
              tok
          )
          line
    )
  in
  let result = Ochre.Transform.run [ t1; t2 ] doc in
  match result with
  | [ [ tok ] ] ->
      Alcotest.(check (option string))
        "last transform wins" (Some "#222222") (bg tok)
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_transform_determinism () =
  let doc : Ochre.Token.line list =
    [ [ make_tok "a" ]; [ make_tok "b" ]; [ make_tok "c" ] ]
  in
  let transforms =
    [
      Ochre.Transform_builtin.line_highlight [ 0; 2 ];
      Ochre.Transform.make "tag" ~after_line:(fun ~line_index:_ line ->
          List.map
            (fun (tok : Ochre.Token.t) ->
              with_style
                (fun s ->
                  {
                    s with
                    Ochre.Style.font_style =
                      { s.font_style with underline = true };
                  }
                )
                tok
            )
            line
      );
    ]
  in
  let run_once () = Ochre.Transform.run transforms doc in
  let r1 = run_once () in
  let r2 = run_once () in
  List.iter2
    (fun line1 line2 ->
      List.iter2
        (fun (t1 : Ochre.Token.t) (t2 : Ochre.Token.t) ->
          Alcotest.(check string) "deterministic text" t1.text t2.text;
          Alcotest.(check string) "deterministic fg" (fg t1) (fg t2);
          Alcotest.(check (option string)) "deterministic bg" (bg t1) (bg t2)
        )
        line1 line2
    )
    r1 r2

let test_transform_line_highlight () =
  let doc : Ochre.Token.line list = [ [ make_tok "a" ]; [ make_tok "b" ] ] in
  let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok0 ]; [ tok1 ] ] ->
      Alcotest.(check (option string))
        "line 0 highlighted" (Some "#8888883a") (bg tok0);
      Alcotest.(check (option string)) "line 1 unchanged" None (bg tok1)
  | _ ->
      Alcotest.fail "expected 2 lines with 1 token each"

let test_default_highlight_shows_on_light_and_dark () =
  let highlighter = highlight () in
  let transforms = [ Ochre.Transform_builtin.line_highlight [ 0 ] ] in
  List.iter
    (fun (name, theme) ->
      let plain =
        Ochre.to_ansi
          (Ochre.highlight ~theme
             ~lang:(get_ok (Ochre.lang highlighter "test"))
             "x"
          )
      in
      let lit =
        Ochre.to_ansi
          (Ochre.highlight ~transforms ~theme
             ~lang:(get_ok (Ochre.lang highlighter "test"))
             "x"
          )
      in
      Alcotest.(check bool) (name ^ ": highlight is visible") true (plain <> lit)
    )
    [ ("dark", dark_plus); ("light", light_plus) ]

let test_transform_before_render_then_line () =
  let doc : Ochre.Token.line list = [ [ make_tok "x" ] ] in
  let log = ref [] in
  let t =
    Ochre.Transform.make "logger"
      ~before_render:(fun doc ->
        log := "before_render" :: !log;
        doc
      )
      ~before_line:(fun ~line_index:_ line ->
        log := "before_line" :: !log;
        line
      )
      ~after_line:(fun ~line_index:_ line ->
        log := "after_line" :: !log;
        line
      )
      ~after_render:(fun doc ->
        log := "after_render" :: !log;
        doc
      )
  in
  let _ = Ochre.Transform.run [ t ] doc in
  let order = List.rev !log in
  Alcotest.(check (list string))
    "hook execution order"
    [ "before_render"; "before_line"; "after_line"; "after_render" ]
    order

let test_decoration_empty_passthrough () =
  let tokens = [ [ make_tok "hello" ] ] in
  let result = Ochre.Decoration.apply ~source:"hello" [] tokens in
  match result with
  | [ [ tok ] ] ->
      Alcotest.(check string) "text unchanged" "hello" tok.text;
      Alcotest.(check bool) "no decoration" true (tok.decoration = None)
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_decoration_whole_token () =
  let tokens = [ [ make_tok "hello" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 0 5) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"hello" [ d ] tokens in
  match result with
  | [ [ tok ] ] -> (
      Alcotest.(check string) "text unchanged" "hello" tok.text;
      match tok.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "class set" (Some "hl") dec.class_
      | None ->
          Alcotest.fail "expected decoration"
    )
  | _ ->
      Alcotest.fail "expected 1 line with 1 token"

let test_decoration_token_splitting () =
  let tokens = [ [ make_tok "console.log" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"target" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 0 7) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"console.log" [ d ] tokens in
  match result with
  | [ [ t1; t2 ] ] ->
      Alcotest.(check string) "first fragment" "console" t1.text;
      Alcotest.(check string) "second fragment" ".log" t2.text;
      ( match t1.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "decorated" (Some "target") dec.class_
      | None ->
          Alcotest.fail "first fragment should be decorated"
      );
      Alcotest.(check bool) "second not decorated" true (t2.decoration = None)
  | [ toks ] ->
      Alcotest.fail
        (Printf.sprintf "expected 2 tokens, got %d: [%s]" (List.length toks)
           (String.concat ", "
              (List.map
                 (fun (t : Ochre.Token.t) -> Printf.sprintf "%S" t.text)
                 toks
              )
           )
        )
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_mid_token_split () =
  let tokens = [ [ make_tok "abcdef" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"mid" ~start:(Ochre.Decoration.pos 0 2)
         ~end_:(Ochre.Decoration.pos 0 4) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"abcdef" [ d ] tokens in
  match result with
  | [ [ t1; t2; t3 ] ] ->
      Alcotest.(check string) "before" "ab" t1.text;
      Alcotest.(check string) "middle" "cd" t2.text;
      Alcotest.(check string) "after" "ef" t3.text;
      Alcotest.(check bool) "before not decorated" true (t1.decoration = None);
      ( match t2.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "middle decorated" (Some "mid") dec.class_
      | None ->
          Alcotest.fail "middle should be decorated"
      );
      Alcotest.(check bool) "after not decorated" true (t3.decoration = None)
  | [ toks ] ->
      Alcotest.fail
        (Printf.sprintf "expected 3 tokens, got %d" (List.length toks))
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_multi_token () =
  let tokens = lines_of [ [ "let"; " x" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"all" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 0 5) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"let x" [ d ] tokens in
  match result with
  | [ [ t1; t2 ] ] -> (
      Alcotest.(check string) "first" "let" t1.text;
      Alcotest.(check string) "second" " x" t2.text;
      match (t1.decoration, t2.decoration) with
      | Some d1, Some d2 ->
          Alcotest.(check (option string)) "t1 class" (Some "all") d1.class_;
          Alcotest.(check (option string)) "t2 class" (Some "all") d2.class_
      | _ ->
          Alcotest.fail "both tokens should be decorated"
    )
  | _ ->
      Alcotest.fail "expected 1 line with 2 tokens"

let test_decoration_negative_character () =
  let tokens = lines_of [ [ "hello"; "\n" ]; [ "world"; "\n" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"line0" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 0 (-1))
         ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"hello\nworld" [ d ] tokens in
  match result with
  | [ line0; line1 ] ->
      let hello = List.nth line0 0 in
      let newline = List.nth line0 1 in
      ( match hello.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "hello decorated" (Some "line0") dec.class_
      | None ->
          Alcotest.fail "hello should be decorated"
      );
      Alcotest.(check bool)
        "newline not decorated" true
        (newline.decoration = None);
      List.iter
        (fun (tok : Ochre.Token.t) ->
          Alcotest.(check bool)
            "line1 not decorated" true (tok.decoration = None)
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_decoration_unicode_scalar_positions () =
  let source = "a\195\169\240\159\153\130z" in
  let tokens = [ [ make_tok source ] ] in
  let decoration =
    get_ok
      (Ochre.Decoration.make ~class_:"unicode" ~start:(Ochre.Decoration.pos 0 1)
         ~end_:(Ochre.Decoration.pos 0 3) ()
      )
  in
  let result = Ochre.Decoration.apply ~source [ decoration ] tokens in
  match result with
  | [ [ before; highlighted; after ] ] ->
      Alcotest.(check string) "before scalar" "a" before.text;
      Alcotest.(check string)
        "highlighted scalars" "\195\169\240\159\153\130" highlighted.text;
      Alcotest.(check string) "after scalar" "z" after.text;
      Alcotest.(check bool)
        "before not decorated" true (before.decoration = None);
      ( match highlighted.decoration with
      | Some decoration ->
          Alcotest.(check (option string))
            "highlighted decorated" (Some "unicode") decoration.class_
      | None ->
          Alcotest.fail "highlighted scalars should be decorated"
      );
      Alcotest.(check bool) "after not decorated" true (after.decoration = None)
  | _ ->
      Alcotest.fail "expected 1 line with 3 tokens"

let test_decoration_unicode_negative_character () =
  let source = "\195\169\240\159\153\130" in
  let tokens = [ [ make_tok source ] ] in
  let decoration =
    get_ok
      (Ochre.Decoration.make ~class_:"last-scalar"
         ~start:(Ochre.Decoration.pos 0 (-2))
         ~end_:(Ochre.Decoration.pos 0 (-1))
         ()
      )
  in
  let result = Ochre.Decoration.apply ~source [ decoration ] tokens in
  match result with
  | [ [ before; highlighted ] ] -> (
      Alcotest.(check string) "before final scalar" "\195\169" before.text;
      Alcotest.(check string) "final scalar" "\240\159\153\130" highlighted.text;
      match highlighted.decoration with
      | Some decoration ->
          Alcotest.(check (option string))
            "final scalar decorated" (Some "last-scalar") decoration.class_
      | None ->
          Alcotest.fail "final scalar should be decorated"
    )
  | _ ->
      Alcotest.fail "expected 1 line with 2 tokens"

let test_decoration_invalid_utf8 () =
  let source = "\195\040" in
  let tokens = [ [ make_tok source ] ] in
  Alcotest.(check bool)
    "no decorations returns tokens unchanged" true
    (Ochre.Decoration.apply ~source [] tokens = tokens)

let test_decoration_invalid_utf8_scalars () =
  let source = "a\255b\n" in
  let tokens = [ [ make_tok "a\255b\n" ] ] in
  let decoration =
    get_ok
      (Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 1)
         ~end_:(Ochre.Decoration.pos 0 2) ()
      )
  in
  let texts =
    Ochre.Decoration.apply ~source [ decoration ] tokens
    |> List.concat
    |> List.filter_map (fun (tok : Ochre.Token.t) ->
        Option.map (fun _ -> tok.text) tok.decoration
    )
  in
  Alcotest.(check (list string))
    "invalid byte is one character" [ "\255" ] texts

let check_invalid_data_key key =
  match
    Ochre.Decoration.make
      ~data:[ ("ok", "value"); (key, "value") ]
      ~start:(Ochre.Decoration.pos 0 0) ~end_:(Ochre.Decoration.pos 0 1) ()
  with
  | Ok _ ->
      Alcotest.failf "data key %S should be rejected" key
  | Error error ->
      Alcotest.(check string)
        "error names the key"
        (Ochre.Error.to_string (Ochre.Error.Invalid_data_key key))
        (Ochre.Error.to_string error)

let test_decoration_invalid_data_key () =
  check_invalid_data_key {|note"onmouseover="x|}

let test_decoration_empty_data_key () = check_invalid_data_key ""

let test_decoration_overlapping () =
  let tokens = [ [ make_tok "abcd" ] ] in
  let d1 =
    get_ok
      (Ochre.Decoration.make ~class_:"first" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 0 3) ()
      )
  in
  let d2 =
    get_ok
      (Ochre.Decoration.make ~class_:"second" ~start:(Ochre.Decoration.pos 0 1)
         ~end_:(Ochre.Decoration.pos 0 4) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"abcd" [ d1; d2 ] tokens in
  match result with
  | [ toks ] -> (
      Alcotest.(check int) "3 fragments" 3 (List.length toks);
      let t1 = List.nth toks 0 in
      let t2 = List.nth toks 1 in
      let t3 = List.nth toks 2 in
      Alcotest.(check string) "frag1" "a" t1.text;
      Alcotest.(check string) "frag2" "bc" t2.text;
      Alcotest.(check string) "frag3" "d" t3.text;
      ( match t1.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "a class" (Some "first") dec.class_
      | None ->
          Alcotest.fail "a should be decorated"
      );
      ( match t2.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "bc class" (Some "first second") dec.class_
      | None ->
          Alcotest.fail "bc should be decorated"
      );
      match t3.decoration with
      | Some dec ->
          Alcotest.(check (option string)) "d class" (Some "second") dec.class_
      | None ->
          Alcotest.fail "d should be decorated"
    )
  | _ ->
      Alcotest.fail "expected 1 line"

let test_decoration_multiline () =
  let tokens = lines_of [ [ "ab"; "\n" ]; [ "cd"; "\n" ] ] in
  let d =
    get_ok
      (Ochre.Decoration.make ~class_:"span" ~start:(Ochre.Decoration.pos 0 1)
         ~end_:(Ochre.Decoration.pos 1 1) ()
      )
  in
  let result = Ochre.Decoration.apply ~source:"ab\ncd" [ d ] tokens in
  match result with
  | [ line0; line1 ] ->
      let l0_texts = List.map (fun (t : Ochre.Token.t) -> t.text) line0 in
      Alcotest.(check (list string)) "line0 texts" [ "a"; "b"; "\n" ] l0_texts;
      let a = List.nth line0 0 in
      let b = List.nth line0 1 in
      Alcotest.(check bool) "a not decorated" true (a.decoration = None);
      ( match b.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "b decorated" (Some "span") dec.class_
      | None ->
          Alcotest.fail "b should be decorated"
      );
      let l1_texts = List.map (fun (t : Ochre.Token.t) -> t.text) line1 in
      Alcotest.(check (list string)) "line1 texts" [ "c"; "d"; "\n" ] l1_texts;
      let c = List.nth line1 0 in
      let d_tok = List.nth line1 1 in
      ( match c.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "c decorated" (Some "span") dec.class_
      | None ->
          Alcotest.fail "c should be decorated"
      );
      Alcotest.(check bool) "d not decorated" true (d_tok.decoration = None)
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_decoration_with_highlighter () =
  let hl = highlight () in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
      ]
    }|}
         )
      )
  in
  let source = "let x = 42" in
  let decorations =
    [
      get_ok
        (Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
           ~end_:(Ochre.Decoration.pos 0 3) ()
        );
    ]
  in
  let tokens =
    (Ochre.highlight ~decorations ~transforms:[] ~theme
       ~lang:(get_ok (Ochre.lang hl "test"))
       source
    )
      .lines
  in
  match tokens with
  | [ first :: _ ] -> (
      Alcotest.(check string) "first token text" "let" first.text;
      match first.decoration with
      | Some dec ->
          Alcotest.(check (option string))
            "first token decorated" (Some "hl") dec.class_
      | None ->
          Alcotest.fail "first token should be decorated"
    )
  | _ ->
      Alcotest.fail "expected at least one line with tokens"

let long_arithmetic_line n =
  "let x = " ^ String.concat " + " (List.init n string_of_int)

let tokens_text tokens =
  tokens
  |> List.concat_map (fun line ->
      List.map (fun (tok : Ochre.Token.t) -> tok.text) line
  )
  |> String.concat ""

let invalid_utf8_cases =
  [
    ("plaintext", "caf\xe9\n");
    ("plaintext", "\xff");
    ("go", "\xff\n");
    ("go", "package \xC3");
    ("shellscript", "C \xf4");
    ("shellscript", "<<\x90'");
    ("bibtex", "\xc3");
    ("bibtex", "@article{k\xc3,\n}\n");
    ("perl", "<<E\xc6D");
    ("ruby", "<<HEREDD\xe7C\n");
    ("php", "<<<\xb1OT");
    ("reason", "{\xc3js|");
    ("cpp", "R\"\x80(");
    ("ocaml", "let caf\xe9 = \"\xff\xfe\" (* \xc0\xaf *)\n");
    ("json", "[\"\xed\xa0\x80\", \"\xf4\x90\x80\x80\"]\n");
  ]

let invalid_utf8_highlighter =
  lazy
    (get_ok
       (Ochre.load
          [
            ("go", Tm_grammars.go);
            ("shellscript", Tm_grammars.shellscript);
            ("bibtex", Tm_grammars.bibtex);
            ("perl", Tm_grammars.perl);
            ("ruby", Tm_grammars.ruby);
            ("php", Tm_grammars.php);
            ("reason", Tm_grammars.reason);
            ("cpp", Tm_grammars.cpp);
            ("ocaml", Tm_grammars.ocaml);
            ("ocaml-interface", Tm_grammars.ocaml_interface);
            ("json", Tm_grammars.json);
          ]
       )
    )

let test_invalid_utf8_keeps_bytes () =
  let hl = Lazy.force invalid_utf8_highlighter in
  let theme = dark_plus in
  List.iter
    (fun (lang, source) ->
      let label = Printf.sprintf "%s %S" lang source in
      Alcotest.(check string)
        (label ^ " token text") source
        (tokens_text
           (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) source)
             .lines
        );
      let decoration =
        get_ok
          (Ochre.Decoration.make ~class_:"hl" ~start:(Ochre.Decoration.pos 0 0)
             ~end_:(Ochre.Decoration.pos 0 (-1))
             ()
          )
      in
      Alcotest.(check string)
        (label ^ " decorated token text")
        source
        (tokens_text
           (Ochre.highlight ~decorations:[ decoration ] ~theme
              ~lang:(get_ok (Ochre.lang hl lang))
              source
           )
             .lines
        );
      List.iter
        (fun render -> ignore (render hl ~theme ~lang source : string))
        [
          (fun hl ~theme ~lang s ->
            Ochre.to_html
              (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) s)
          );
          (fun hl ~theme ~lang s ->
            Ochre.to_ansi
              (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) s)
          );
          (fun hl ~theme ~lang s ->
            Ochre.to_latex
              (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) s)
          );
          (fun hl ~theme ~lang s ->
            Ochre.to_svg
              (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) s)
          );
          (fun hl ~theme ~lang s ->
            Ochre.to_debug_tokens
              (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) s)
          );
        ]
    )
    invalid_utf8_cases

let test_invalid_utf8_does_not_split_valid_text () =
  let hl = Lazy.force invalid_utf8_highlighter in
  let tokens =
    (Ochre.highlight ~theme:dark_plus
       ~lang:(get_ok (Ochre.lang hl "json"))
       "{\"a\": \"\xff\", \"b\": 12}\n"
    )
      .lines
  in
  let texts =
    List.concat tokens |> List.map (fun (tok : Ochre.Token.t) -> tok.text)
  in
  Alcotest.(check bool)
    "string with an invalid byte stays one token" true
    (List.mem "\"\xff\"" texts || List.mem "\xff" texts);
  Alcotest.(check bool) "number after it is intact" true (List.mem "12" texts)

let sweep_corpus =
  [
    "";
    "a\n\n\n";
    "no newline at the end";
    ".a { color: red; }";
    "type t = { id : string } [@@deriving codec]";
    ".a { color: red; }\n\
     #id > p::before { content: \"\\201C\"; }\n\
     @media (min-width: 1px) { a:hover { x: 1 } }\n";
    "type t = { id : string } [@@deriving codec]\nlet f x = x [@inline]\n";
    "export const";
    "declare const";
    "/b/";
    "inline t f(";
    "export const x = 1;\ndeclare const y: number;\n";
    "const re = /a(b|c)+\\/[^/]*/gi;\n\
     let s = `t ${x} \\`` + 'q\\'' + \"d\\\"\";\n";
    "int main() { return 0; }\n#define X(a) a + 1\n";
    "# Title\n\n\
     - [link](http://x.com) **b** _i_ `c`\n\n\
     ```ocaml\n\
     let x = 1\n\
     ```\n";
    "---\n\
     title: x\n\
     ---\n\
     <div class=\"a\" id='b'>t &amp; <b>x</b></div>\n\
     <!-- c -->\n\
     <script>let a = 1 < 2;</script>\n\
     <style>.a{color:red}</style>\n";
    "cat <<EOF\nhello $USER\nEOF\nFOO=bar\nBAZ=\"quoted value\"\n$ echo hello\n";
    "/* block\n\
    \ comment */ // line\n\
     # hash\n\
     -- dash\n\
     ; semi\n\
     (* ml *) {- hs -} <!-- x -->\n";
    "def f(a, *b, **c):\n\
    \    \"\"\"doc\"\"\"\n\
    \    return a @ b\n\
     @decorator\n\
     class C: pass\n";
    "package main\n\
     func (r *T) M() (int, error) { return 0, nil }\n\
     fn main() -> Result<(), E> { println!(\"{}\", x?); }\n";
    "{\"a\": [1, 2.5e-3, true, null], \"b\": {\"c\": \"\\u00e9\"}}\n";
    "SELECT a, COUNT(*) FROM t WHERE x = 'y' -- c\n";
    "line one\r\nline two\r\n";
    "unterminated \"string\n(* open comment\n{ [ ( <";
    "\t\tindent\n\
    \    caf\xc3\xa9 \xe6\x97\xa5\xe6\x9c\xac \xf0\x9f\x9a\x80 \xce\xbb\n";
    "\\begin{document}\\textbf{b} $x^2$ \\end{document}\n%% comment\n";
    "<?php echo $x; ?>\n{{ var | filter }}\n{% if x %}y{% endif %}\n<%= x %>\n";
    "x = r\"raw\\d\" + R\"(raw)\" + @\"verbatim\" + b'bytes' + 0x1F + 1_000 + \
     3.14e+10\n";
    "[section]\nkey = value\n[[array]]\nk: v\n- item\n  nested: |\n    block\n";
    "#!/usr/bin/env node\n'use strict'\nimport { a as b } from \"m\";\n";
    ";;;;}}}})))]]]>>>\"\"\"'''```\n";
  ]

let test_every_bundled_grammar_covers_the_source () =
  let hl = get_ok (Ochre.load Tm_grammars.all) in
  let theme = nord in
  let failures =
    List.concat_map
      (fun (lang, _) ->
        List.filter_map
          (fun source ->
            match
              tokens_text
                (Ochre.highlight ~theme
                   ~lang:(get_ok (Ochre.lang hl lang))
                   source
                )
                  .lines
            with
            | text when text = source ->
                None
            | text ->
                Some (Printf.sprintf "%s %S: tokens give %S" lang source text)
            | exception e ->
                Some
                  (Printf.sprintf "%s %S: %s" lang source (Printexc.to_string e))
          )
          sweep_corpus
      )
      Tm_grammars.all
  in
  Alcotest.(check (list string))
    "every grammar tokenizes every sample into exactly its source" [] failures

let styles_of ~theme ~lang source =
  let hl = Lazy.force invalid_utf8_highlighter in
  (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) source).lines
  |> List.concat_map
       (List.map (fun (tok : Ochre.Token.t) ->
            (tok.text, fg tok, bg tok, font_styles tok)
        )
       )

let selector_theme rules =
  Ochre.Theme.make ~name:"selectors"
    ~token_colors:
      (List.map
         (fun (scope, foreground) ->
           Ochre.Theme.rule ~scope ~foreground:(color foreground)
             ~font_style:{ Ochre.Style.plain with bold = true }
             ()
         )
         rules
      )
    ()

let scope_grammar =
  {|{
  "scopeName": "source.t",
  "patterns": [
    { "match": "\\bx\\b", "name": "a.b" },
    { "begin": "<", "end": ">", "name": "a",
      "patterns": [ { "match": "\\bx\\b", "name": "a.b" } ] },
    { "begin": "\\(", "end": "\\)", "name": "meta.group",
      "patterns": [
        { "match": "\\bx\\b", "name": "a.b" },
        { "begin": "\\[", "end": "\\]", "name": "meta.inner",
          "patterns": [ { "match": "\\bx\\b", "name": "a.b" } ] }
      ] }
  ]
}|}

let scope_highlighter = lazy (get_ok (Ochre.load [ ("t", scope_grammar) ]))

let x_style ~theme source =
  let token =
    (Ochre.highlight ~theme
       ~lang:(get_ok (Ochre.lang (Lazy.force scope_highlighter) "t"))
       source
    )
      .lines |> List.concat
    |> List.find (fun (tok : Ochre.Token.t) -> tok.text = "x")
  in
  (fg token, bg token, font_styles token)

let style_testable = Alcotest.(triple string (option string) (list string))

let font_style_of names =
  List.fold_left
    (fun (style : Ochre.Style.font_style) name ->
      match name with
      | "bold" ->
          { style with bold = true }
      | "italic" ->
          { style with italic = true }
      | "underline" ->
          { style with underline = true }
      | _ ->
          { style with strikethrough = true }
    )
    Ochre.Style.plain names

let rules_theme rules =
  Ochre.Theme.make ~name:"rules"
    ~token_colors:
      (List.map
         (fun (scope, foreground, background, font_style) ->
           Ochre.Theme.rule ~scope
             ?foreground:(Option.map color foreground)
             ?background:(Option.map color background)
             ?font_style:(Option.map font_style_of font_style)
             ()
         )
         rules
      )
    ()

let json_theme ?(extra = "") token_colors =
  fst
    (get_ok
       (Ochre.Theme.load
          (Printf.sprintf {|{ %s "tokenColors": [ %s ] }|} extra token_colors)
       )
    )

let red = "#ff0000"
let green = "#00ff00"
let blue = "#0000ff"
let default_fg = "#000000"

let check_style label expected theme source =
  Alcotest.check style_testable label expected (x_style ~theme source)

let test_descendant_selector_order () =
  let theme = rules_theme [ ([ "source.t a" ], Some red, None, None) ] in
  check_style "outer scope first" (red, None, []) theme "x\n";
  let theme = rules_theme [ ([ "a source.t" ], Some red, None, None) ] in
  check_style "inner scope first" (default_fg, None, []) theme "x\n"

let test_deepest_scope_wins () =
  let rules =
    [ ([ "a a" ], Some red, None, None); ([ "a.b" ], Some green, None, None) ]
  in
  check_style "more specific scope" (green, None, []) (rules_theme rules)
    "<x>\n";
  check_style "rule order does not matter" (green, None, [])
    (rules_theme (List.rev rules))
    "<x>\n"

let test_attributes_come_from_one_rule () =
  let theme =
    rules_theme
      [
        ([ "a.b" ], Some red, None, None);
        ([ "a a" ], None, Some blue, Some [ "bold" ]);
      ]
  in
  check_style "weaker rule adds nothing" (red, None, []) theme "<x>\n"

let test_outer_attributes_are_kept () =
  let theme =
    rules_theme
      [
        ([ "meta.group" ], Some red, Some blue, Some [ "italic" ]);
        ([ "a.b" ], Some green, None, None);
      ]
  in
  check_style "unset attributes come from the enclosing scope"
    (green, Some blue, [ "italic" ])
    theme "(x)\n"

let test_theme_default_background () =
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "colors": { "editor.foreground": "#111111", "editor.background": "#10141c" },
      "tokenColors": [
        { "settings": { "foreground": "#bfbdb6", "background": "#0d1017" } },
        { "scope": "a", "settings": { "foreground": "#ff0000" } },
        { "scope": "meta.group", "settings": { "background": "#0D1017" } },
        { "scope": "meta.inner", "settings": { "background": "#0000ff" } }
      ]
    }|}
         )
      )
  in
  Alcotest.(check string) "theme bg" "#0d1017" (hex theme.bg);
  Alcotest.(check string) "theme fg" "#bfbdb6" (hex theme.fg);
  check_style "no background from the scope-less rule" (red, None, []) theme
    "x\n";
  check_style "background equal to the default is dropped" (red, None, []) theme
    "(x)\n";
  check_style "background that differs is kept" (red, Some blue, []) theme
    "([x])\n"

let test_invalid_colors_are_ignored () =
  let rules value =
    Printf.sprintf
      {| { "scope": "a", "settings": { "foreground": "#00ff00" } },
         { "scope": "a.b", "settings": { "foreground": %S, "background": "notacolor" } } |}
      value
  in
  List.iter
    (fun value ->
      check_style value (green, None, []) (json_theme (rules value)) "x\n"
    )
    [ "red"; ""; "#12345"; "#12"; "#1234567"; "#ggg"; "ff0000" ];
  List.iter
    (fun (value, expected) ->
      check_style value (expected, None, []) (json_theme (rules value)) "x\n"
    )
    [
      ("#f00", "#ff0000");
      ("#f008", "#ff000088");
      ("#ff0000", "#ff0000");
      ("#FF000080", "#ff000080");
    ]

let test_child_combinator () =
  let theme = rules_theme [ ([ "meta.group > a" ], Some red, None, None) ] in
  check_style "direct child" (red, None, []) theme "(x)\n";
  check_style "not a direct child" (default_fg, None, []) theme "([x])\n";
  let theme = rules_theme [ ([ "meta.group a" ], Some red, None, None) ] in
  check_style "descendant" (red, None, []) theme "([x])\n"

let test_empty_scope_is_global () =
  let theme =
    json_theme {| { "scope": "", "settings": { "foreground": "#ff0000" } } |}
  in
  check_style "empty string" (red, None, []) theme "x\n";
  Alcotest.(check string) "theme fg" red (hex theme.fg);
  let theme =
    json_theme {| { "scope": [], "settings": { "foreground": "#ff0000" } } |}
  in
  check_style "empty array" (default_fg, None, []) theme "x\n"

let test_selector_edge_parsing () =
  let theme = rules_theme [ ([ "a." ], Some red, None, None) ] in
  check_style "trailing dot" (red, None, []) theme "x\n";
  let theme =
    json_theme
      {| { "scope": ["zz, a.b"], "settings": { "foreground": "#ff0000" } } |}
  in
  check_style "array entry is not split on commas" (default_fg, None, []) theme
    "x\n";
  let theme =
    json_theme
      {| { "scope": "zz, a.b", "settings": { "foreground": "#ff0000" } } |}
  in
  check_style "string is split on commas" (red, None, []) theme "x\n";
  let theme =
    json_theme
      {| { "scope": "source.t  a", "settings": { "foreground": "#ff0000" } } |}
  in
  check_style "double space never matches" (default_fg, None, []) theme "x\n"

let test_unset_font_style () =
  List.iter
    (fun font_style ->
      let theme =
        json_theme
          (Printf.sprintf
             {| { "scope": "a", "settings": { "fontStyle": "bold" } },
                { "scope": "a.b",
                  "settings": { "foreground": "#00ff00", "fontStyle": %s } } |}
             font_style
          )
      in
      check_style font_style (green, None, [ "bold" ]) theme "x\n"
    )
    [ "null"; "5"; "true" ];
  let theme =
    json_theme
      {| { "scope": "a", "settings": { "fontStyle": "bold" } },
         { "scope": "a.b", "settings": { "foreground": "#00ff00", "fontStyle": "" } } |}
  in
  check_style "empty string resets" (green, None, []) theme "x\n"

let test_theme_type_picks_default_colors () =
  let load kind =
    fst
      (get_ok
         (Ochre.Theme.load
            (Printf.sprintf {|{ "type": %S, "tokenColors": [] }|} kind)
         )
      )
  in
  let dark = load "dark" and light = load "light" in
  Alcotest.(check (pair string string))
    "dark" ("#bbbbbb", "#1e1e1e")
    (hex dark.fg, hex dark.bg);
  Alcotest.(check (pair string string))
    "light" ("#333333", "#fffffe")
    (hex light.fg, hex light.bg);
  let colored =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{ "type": "dark", "colors": { "editor.foreground": "#123456", "editor.background": "#654321" } }|}
         )
      )
  in
  Alcotest.(check (pair string string))
    "editor colours win" ("#123456", "#654321")
    (hex colored.fg, hex colored.bg)

let test_include_needs_base_dir () =
  match
    Ochre.Theme.load {|{ "include": "./base.json", "tokenColors": [] }|}
  with
  | Ok _ ->
      Alcotest.fail "an include that cannot be resolved must not be dropped"
  | Error message ->
      Alcotest.(check bool)
        "message names the include" true
        (String.length (Ochre.Error.to_string message) > 0)

let test_falsy_settings_use_token_colors () =
  List.iter
    (fun settings ->
      let theme =
        fst
          (get_ok
             (Ochre.Theme.load
                (Printf.sprintf
                   {|{ "settings": %s,
                 "tokenColors": [ { "scope": "a", "settings": { "foreground": "#00ff00" } },
                                  { "scope": "zz", "settings": 0 },
                                  { "scope": "zz", "settings": "" } ] }|}
                   settings
                )
             )
          )
      in
      Alcotest.(check int) settings 1 (List.length theme.token_colors);
      check_style settings (green, None, []) theme "x\n"
    )
    [ "null"; {|""|}; "0"; "false" ]

let test_foreground_falls_back_to_theme () =
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{ "colors": { "editor.foreground": "#aabbcc" },
          "tokenColors": [ { "scope": "a", "settings": { "fontStyle": "italic" } } ] }|}
         )
      )
  in
  check_style "font style only" ("#aabbcc", None, [ "italic" ]) theme "x\n"

let test_settings_win_over_token_colors () =
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "tokenColors": [ { "scope": "a", "settings": { "foreground": "#00ff00" } },
                       { "scope": "zz", "settings": { "foreground": "#0000ff" } } ],
      "settings": [ { "scope": "a", "settings": { "foreground": "#ff0000" } } ]
    }|}
         )
      )
  in
  Alcotest.(check int) "only settings" 1 (List.length theme.token_colors);
  check_style "settings rule" (red, None, []) theme "x\n"

let deep_json_objects n =
  String.concat "" (List.init n (fun _ -> "{\"a\":"))
  ^ "1" ^ String.make n '}' ^ "\n"

let check_under ~seconds label f =
  let start = Unix.gettimeofday () in
  f ();
  let elapsed = Unix.gettimeofday () -. start in
  Alcotest.(check bool)
    (Printf.sprintf "%s took %.2fs, budget %.1fs" label elapsed seconds)
    true (elapsed < seconds)

let test_deep_nesting_theme_matching () =
  let hl = Lazy.force invalid_utf8_highlighter in
  check_under ~seconds:30.0 "json 1600 deep" (fun () ->
      ignore
        ( (Ochre.highlight ~theme:nord
             ~lang:(get_ok (Ochre.lang hl "json"))
             (deep_json_objects 1600)
          )
            .lines
          : Ochre.Token.line list
          )
  )

let test_long_nested_line_theme () =
  let hl =
    get_ok
      (Ochre.load [ ("yaml", Tm_grammars.yaml); ("json", Tm_grammars.json) ])
  in
  let source = String.make 9_999 '[' ^ "\n" in
  List.iter
    (fun lang ->
      check_under ~seconds:2.0 (lang ^ " 9999 brackets") (fun () ->
          ignore
            ( (Ochre.highlight ~theme:dark_plus
                 ~lang:(get_ok (Ochre.lang hl lang))
                 source
              )
                .lines
              : Ochre.Token.line list
              )
      )
    )
    [ "yaml"; "json" ]

let test_many_part_selector () =
  let hl = Lazy.force invalid_utf8_highlighter in
  let nested n = String.make n '[' ^ "1" ^ String.make n ']' ^ "\n" in
  let selector =
    String.concat " " (List.init 12 (fun _ -> "meta.structure.array.json"))
  in
  let theme = selector_theme [ ([ selector ], "#ffffff") ] in
  check_under ~seconds:10.0 "12-part selector on 40 deep arrays" (fun () ->
      ignore
        ( (Ochre.highlight ~theme
             ~lang:(get_ok (Ochre.lang hl "json"))
             (nested 40)
          )
            .lines
          : Ochre.Token.line list
          )
  )

let test_decorations_scale () =
  let hl = Lazy.force invalid_utf8_highlighter in
  let lines = 40_000 and count = 4_000 in
  let source =
    String.concat "\n" (List.init lines (fun i -> string_of_int i))
  in
  let decorations =
    List.init count (fun i ->
        get_ok
          (Ochre.Decoration.make ~class_:"hl"
             ~start:(Ochre.Decoration.pos (i * 10) 0)
             ~end_:(Ochre.Decoration.pos (i * 10) 1)
             ()
          )
    )
  in
  check_under ~seconds:10.0 "40k lines x 4k decorations" (fun () ->
      let tokens =
        (Ochre.highlight ~decorations ~theme:nord
           ~lang:(get_ok (Ochre.lang hl "plaintext"))
           source
        )
          .lines
      in
      let decorated =
        List.concat tokens
        |> List.filter (fun (tok : Ochre.Token.t) -> tok.decoration <> None)
      in
      Alcotest.(check int) "decorated tokens" count (List.length decorated)
  )

let js_like_source lines =
  let line i =
    match i mod 10 with
    | 0 ->
        Printf.sprintf "function f%d(a, b) {" i
    | 1 ->
        "  // Combine both values."
    | 2 ->
        Printf.sprintf "  var s = a + b * %d, t = \"item\";" i
    | 3 ->
        "  if (s > 10 && b !== null) { return [a, b, 'x']; }"
    | 4 ->
        "  return a.map(function (x) { return x * 2; });"
    | 5 ->
        "}"
    | _ ->
        ""
  in
  String.concat "\n" (List.init lines line) ^ "\n"

let test_budget_js_file_to_html () =
  let hl = get_ok (Ochre.load [ ("javascript", Tm_grammars.javascript) ]) in
  let source = js_like_source 10_000 in
  check_under ~seconds:10.0 "10,000-line JS to_html" (fun () ->
      ignore
        ( Ochre.to_html
            (Ochre.highlight ~theme:dark_plus
               ~lang:(get_ok (Ochre.lang hl "javascript"))
               source
            )
          : string
          )
  )

let test_whole_theme_css_scales_with_values () =
  let hex_color i = color (Printf.sprintf "#%06x" i) in
  let rules prefix n make =
    List.init n (fun i ->
        make ~scope:[ Printf.sprintf "%s%d" prefix i ] (hex_color (i + 1))
    )
  in
  let font_styles =
    Ochre.Style.
      [
        { plain with bold = true };
        { plain with italic = true };
        { plain with underline = true };
        { plain with strikethrough = true };
      ]
  in
  let theme =
    Ochre.Theme.make ~name:"many"
      ~colors:
        [
          ("editor.foreground", color "#ffffff");
          ("editor.background", color "#000000");
        ]
      ~token_colors:
        (rules "fg" 500 (fun ~scope c ->
             Ochre.Theme.rule ~scope ~foreground:c ()
         )
        @ rules "bg" 50 (fun ~scope c ->
            Ochre.Theme.rule ~scope ~background:c ()
        )
        @ List.mapi
            (fun i font_style ->
              Ochre.Theme.rule ~scope:[ Printf.sprintf "fs%d" i ] ~font_style ()
            )
            font_styles
        )
      ()
  in
  let css = ref "" in
  check_under ~seconds:1.0 "500 colours x 50 backgrounds x 4 font styles"
    (fun () ->
      css := Ochre.html_render_whole_theme_css ~class_prefix:"c-" theme;
      ignore
        ( Ochre.to_html
            ~options:
              (Ochre.Html_options.make
                 ~style_mode:(Css_classes { class_prefix = "c-" })
                 ()
              )
            (Ochre.highlight ~theme ~lang:Ochre.Lang.plaintext "x")
          : string
          )
  );
  let declarations =
    List.filter_map
      (fun line ->
        match String.index_opt line '{' with
        | Some i when String.starts_with ~prefix:".c-" line ->
            Some (String.sub line (i + 2) (String.length line - i - 2))
        | _ ->
            None
      )
      (String.split_on_char '\n' !css)
  in
  let count props =
    List.length
      (List.filter
         (fun decl ->
           List.exists (fun prefix -> String.starts_with ~prefix decl) props
         )
         declarations
      )
  in
  Alcotest.(check (list int))
    "one rule per distinct colour, background and font style" [ 501; 50; 4 ]
    [
      count [ "color:" ];
      count [ "background-color:" ];
      count [ "font-weight:"; "font-style:"; "text-decoration:" ];
    ];
  Alcotest.(check int) "no other rule" 555 (List.length declarations)

let test_budget_long_line_without_limits () =
  let grammar =
    TmLanguage.of_yojson_exn (Yojson.Basic.from_string Tm_grammars.ocaml)
  in
  let t = TmLanguage.create () in
  TmLanguage.add_grammar t grammar;
  TmLanguage.add_grammar t
    (TmLanguage.of_yojson_exn
       (Yojson.Basic.from_string Tm_grammars.ocaml_interface)
    );
  let source = long_arithmetic_line 6400 in
  check_under ~seconds:0.5 "6400-term OCaml line without limits" (fun () ->
      ignore
        ( TmLanguage.tokenize_exn ~max_line_length:max_int
            ~time_limit:Float.infinity t grammar TmLanguage.empty source
          : TmLanguage.token list * TmLanguage.stack
          )
  )

let test_budget_minified_line () =
  let hl = get_ok (Ochre.load [ ("javascript", Tm_grammars.javascript) ]) in
  let chunk = "var a=function(b,c){return b+c*2},d=\"s\",e=/x+/g;" in
  let minified bytes =
    let chunks =
      List.init ((bytes / String.length chunk) + 1) (fun _ -> chunk)
    in
    String.sub (String.concat "" chunks) 0 bytes
  in
  List.iter
    (fun bytes ->
      check_under ~seconds:2.0 (Printf.sprintf "%d-byte minified JS line" bytes)
        (fun () ->
          ignore
            ( (Ochre.highlight ~theme:dark_plus
                 ~lang:(get_ok (Ochre.lang hl "javascript"))
                 (minified bytes)
              )
                .lines
              : Ochre.Token.line list
              )
      )
    )
    [ 9_999 ]

let make_comment text =
  {
    (with_style
       (fun s ->
         {
           s with
           Ochre.Style.foreground = color "#888888";
           font_style = { Ochre.Style.plain with italic = true };
         }
       )
       (make_tok text)
    )
    with
    scopes = [ "comment.line.test"; "source.test" ];
  }

let test_notation_highlight_basic () =
  let doc =
    [
      [
        with_fg "#ff0000" (make_tok "let");
        make_tok " x = ";
        with_fg "#0000ff" (make_tok "42");
        make_tok " ";
        make_comment "# [!code highlight]";
        make_tok "\n";
      ];
      [ make_tok "let y = 10"; make_tok "\n" ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line0; line1 ] ->
      List.iter
        (fun (tok : Ochre.Token.t) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "line0 token %S highlighted" tok.text)
              (Some "#8888883a") (bg tok)
        )
        line0;
      let texts = List.map (fun (t : Ochre.Token.t) -> t.text) line0 in
      Alcotest.(check bool)
        "comment removed"
        (not (List.exists (fun t -> String.length t > 0 && t.[0] = '#') texts))
        true;
      List.iter
        (fun (tok : Ochre.Token.t) ->
          Alcotest.(check (option string)) "line1 not highlighted" None (bg tok)
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_notation_highlight_no_match () =
  let doc = [ [ make_tok "let x = 42"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; nl ] ] ->
      Alcotest.(check string) "text unchanged" "let x = 42" tok.text;
      Alcotest.(check string) "newline kept" "\n" nl.text;
      Alcotest.(check (option string)) "no background" None (bg tok)
  | _ ->
      Alcotest.fail "expected 1 line with 2 tokens"

let test_notation_diff_add () =
  let doc =
    [
      [
        make_tok "let x = 42";
        make_tok " ";
        make_comment "# [!code ++]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      List.iter
        (fun (tok : Ochre.Token.t) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "token %S has add bg" tok.text)
              (Some "#22883322") (bg tok)
        )
        line;
      let texts = List.map (fun (t : Ochre.Token.t) -> t.text) line in
      Alcotest.(check bool)
        "notation removed"
        (not (List.exists (fun t -> String.length t > 0 && t.[0] = '#') texts))
        true
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_diff_remove () =
  let doc =
    [
      [
        make_tok "let y = 10";
        make_tok " ";
        make_comment "# [!code --]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      List.iter
        (fun (tok : Ochre.Token.t) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "token %S has remove bg" tok.text)
              (Some "#88222222") (bg tok)
        )
        line
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_diff_no_match () =
  let doc = [ [ make_tok "let z = 0"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_diff () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; _ ] ] ->
      Alcotest.(check (option string)) "no background" None (bg tok)
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_word_highlight_basic () =
  let doc =
    [
      [
        make_tok "let";
        make_tok " x = ";
        make_tok "42";
        make_tok " ";
        make_comment "# [!code word:x]";
        make_tok "\n";
      ];
    ]
  in
  let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ line ] ->
      let x_tokens =
        List.filter (fun (t : Ochre.Token.t) -> t.text = "x") line
      in
      Alcotest.(check bool) "found x token" true (List.length x_tokens > 0);
      List.iter
        (fun (tok : Ochre.Token.t) ->
          Alcotest.(check string) "x foreground" "#ffff00" (fg tok);
          Alcotest.(check bool) "x bold" true (List.mem "bold" (font_styles tok))
        )
        x_tokens;
      let has_comment =
        List.exists
          (fun (t : Ochre.Token.t) ->
            String.length t.text > 0 && t.text.[0] = '#'
          )
          line
      in
      Alcotest.(check bool) "comment removed" false has_comment
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_word_highlight_no_match () =
  let doc = [ [ make_tok "let x = 42"; make_tok "\n" ] ] in
  let transforms = [ Ochre.Transform_builtin.notation_word_highlight () ] in
  let result = Ochre.Transform.run transforms doc in
  match result with
  | [ [ tok; _ ] ] ->
      Alcotest.(check string) "unchanged" "let x = 42" tok.text;
      Alcotest.(check string) "no fg change" (hex dark_plus.fg) (fg tok)
  | _ ->
      Alcotest.fail "expected 1 line"

let test_notation_highlight_with_highlighter () =
  let hl = highlight () in
  let theme =
    fst
      (get_ok
         (Ochre.Theme.load
            {|{
      "name": "test",
      "colors": { "editor.foreground": "#d4d4d4", "editor.background": "#1e1e1e" },
      "tokenColors": [
        { "scope": "comment", "settings": { "foreground": "#888888", "fontStyle": "italic" } },
        { "scope": "keyword", "settings": { "foreground": "#ff0000", "fontStyle": "bold" } },
        { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
      ]
    }|}
         )
      )
  in
  let source = "let x = 42 # [!code highlight]\nlet y = 10" in
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  let tokens =
    (Ochre.highlight ~transforms ~theme
       ~lang:(get_ok (Ochre.lang hl "test"))
       source
    )
      .lines
  in
  match tokens with
  | [ line0; line1 ] ->
      let visible0 =
        List.filter
          (fun (t : Ochre.Token.t) -> String.trim t.text <> "" && t.text <> "\n")
          line0
      in
      List.iter
        (fun (tok : Ochre.Token.t) ->
          Alcotest.(check (option string))
            (Printf.sprintf "%S bg" tok.text)
            (Some "#8888883a") (bg tok)
        )
        visible0;
      let all_texts = List.map (fun (t : Ochre.Token.t) -> t.text) line0 in
      Alcotest.(check bool)
        "no comment in line0"
        (not
           (List.exists
              (fun t ->
                String.length t > 0
                && String.sub t 0 (min 1 (String.length t)) = "#"
              )
              all_texts
           )
        )
        true;
      List.iter
        (fun (tok : Ochre.Token.t) ->
          if String.trim tok.text <> "" && tok.text <> "\n" then
            Alcotest.(check (option string))
              (Printf.sprintf "%S no bg" tok.text)
              None (bg tok)
        )
        line1
  | _ ->
      Alcotest.fail "expected 2 lines"

let test_plaintext_langs () =
  let hl = get_ok (Ochre.load []) in
  let theme = dark_plus in
  List.iter
    (fun lang ->
      match
        (Ochre.highlight ~theme
           ~lang:(get_ok (Ochre.lang hl lang))
           "hello\nworld"
        )
          .lines
      with
      | [ [ first ]; [ second ] ] ->
          Alcotest.(check string)
            (lang ^ " first line") "hello\n" first.Ochre.Token.text;
          Alcotest.(check string)
            (lang ^ " second line") "world" second.Ochre.Token.text;
          Alcotest.(check string)
            (lang ^ " default fg") (hex theme.Ochre.Theme.fg) (fg first);
          Alcotest.(check (list string))
            (lang ^ " no scopes") [] first.Ochre.Token.scopes
      | _ ->
          Alcotest.fail (lang ^ ": expected two lines of one token")
    )
    [ "plaintext"; "text"; "txt" ]

let has_sub s sub =
  let sub_len = String.length sub in
  let max_start = String.length s - sub_len in
  let rec scan i =
    i <= max_start && (String.sub s i sub_len = sub || scan (i + 1))
  in
  max_start >= 0 && scan 0

let error_message name = function
  | Ok _ ->
      Alcotest.fail (name ^ ": expected an error")
  | Error error ->
      Ochre.Error.to_string error

let test_malformed_json_message_is_readable () =
  let msg =
    error_message "Ochre.load with malformed grammar JSON"
      (Ochre.load [ ("bad", "{not valid json") ])
  in
  Alcotest.(check bool)
    "names the lang id, no OCaml exception constructor name" true
    (has_sub msg "bad" && has_sub msg "invalid JSON"
    && (not (has_sub msg "Yojson"))
    && not (has_sub msg "Json_error")
    );
  let theme_msg =
    error_message "Ochre.Theme.load with malformed theme JSON"
      (Ochre.Theme.load "{not valid json")
  in
  Alcotest.(check bool)
    "no OCaml exception constructor name" true
    (has_sub theme_msg "invalid JSON"
    && (not (has_sub theme_msg "Yojson"))
    && not (has_sub theme_msg "Json_error")
    );
  let path = "bad-theme-test.json" in
  let oc = open_out path in
  output_string oc "{not valid json";
  close_out oc;
  let file_msg =
    error_message "Ochre.Theme.load_from_file with malformed JSON"
      (Ochre.Theme.load_from_file path)
  in
  Sys.remove path;
  Alcotest.(check bool)
    "names the file path, no OCaml exception constructor name" true
    (has_sub file_msg path
    && has_sub file_msg "invalid JSON"
    && (not (has_sub file_msg "Yojson"))
    && not (has_sub file_msg "Json_error")
    );
  let grammar_path = "bad-grammar.tmLanguage.json" in
  let oc = open_out grammar_path in
  output_string oc "{not valid json";
  close_out oc;
  let grammar_file_msg =
    error_message "Ochre.load_from_files with malformed JSON"
      (Ochre.load_from_files [ grammar_path ])
  in
  Sys.remove grammar_path;
  Alcotest.(check bool)
    "names the file path, no OCaml exception constructor name" true
    (has_sub grammar_file_msg grammar_path
    && has_sub grammar_file_msg "invalid JSON"
    && (not (has_sub grammar_file_msg "Yojson"))
    && not (has_sub grammar_file_msg "Json_error")
    )

let test_missing_file_message_hides_sys_error () =
  let missing_theme = "does-not-exist-theme.json" in
  let theme_msg =
    error_message "Ochre.Theme.load_from_file with a missing file"
      (Ochre.Theme.load_from_file missing_theme)
  in
  Alcotest.(check bool)
    "names the path, no Sys_error constructor name" true
    (has_sub theme_msg missing_theme && not (has_sub theme_msg "Sys_error"));
  let missing_grammar = "does-not-exist-grammar.tmLanguage.json" in
  let grammar_msg =
    error_message "Ochre.load_from_files with a missing file"
      (Ochre.load_from_files [ missing_grammar ])
  in
  Alcotest.(check bool)
    "names the path, no Sys_error constructor name" true
    (has_sub grammar_msg missing_grammar
    && not (has_sub grammar_msg "Sys_error")
    )

let test_load_rejects_duplicate_ids () =
  match Ochre.load [ ("dup", grammar_json); ("dup", grammar_json) ] with
  | Error msg ->
      Alcotest.(check bool)
        "error names the duplicate id" true
        (has_sub (Ochre.Error.to_string msg) "dup")
  | Ok _ ->
      Alcotest.fail "expected duplicate language id to be rejected"

let test_bundled_grammars_that_used_to_fail_to_load () =
  let theme = dark_plus in
  List.iter
    (fun (lang, json, sample) ->
      match Ochre.load [ (lang, json) ] with
      | Error msg ->
          Alcotest.failf "%s: failed to load: %s" lang
            (Ochre.Error.to_string msg)
      | Ok hl ->
          let text =
            (Ochre.highlight ~theme ~lang:(get_ok (Ochre.lang hl lang)) sample)
              .lines |> List.concat
            |> List.map (fun (tok : Ochre.Token.t) -> tok.text)
            |> String.concat ""
          in
          Alcotest.(check string)
            (lang ^ ": tokens cover the source")
            sample text
    )
    [
      ("blade", Tm_grammars.blade, "<div>{{ $name }}</div>\n@if($x)\n@endif\n");
      ("codeql", Tm_grammars.codeql, "predicate foo() { any() }\n");
      ("d", Tm_grammars.d, "void main() {\n  int x = 1;\n}\n");
      ("move", Tm_grammars.move, "module M {\n    fun f() {}\n}\n");
      ("racket", Tm_grammars.racket, "#lang racket\n(define x 1)\n");
      ("stata", Tm_grammars.stata, "display \"hello\"\n");
      ("wikitext", Tm_grammars.wikitext, "== Heading ==\n'''bold''' text\n");
      ("xml", Tm_grammars.xml, "<root><a b=\"c\">text</a></root>\n");
      ("swift", Tm_grammars.swift, "let x = 1\n");
    ]

let test_to_string_html_options_extra_themes () =
  let hl = highlight () in
  let options = Ochre.Html_options.make ~line_numbers:true () in
  let extra_themes = [ ("dark", nord) ] in
  let theme = light_plus in
  let source = "let x = 42" in
  let themed =
    get_ok
      (Ochre.highlight_themes ~label:"light" ~extra_themes ~theme
         ~lang:(get_ok (Ochre.lang hl "test"))
         source
      )
  in
  let via_to_string = Ochre.to_string ~format:Ochre.Html ~options themed in
  let via_to_html = Ochre.to_html ~options themed in
  let contains ~sub s =
    let sub_len = String.length sub in
    let max_start = String.length s - sub_len in
    let rec scan i =
      i <= max_start && (String.sub s i sub_len = sub || scan (i + 1))
    in
    scan 0
  in
  Alcotest.(check string)
    "to_string Html matches to_html" via_to_html via_to_string;
  Alcotest.(check bool)
    "options applied (line numbers)" true
    (contains ~sub:"data-line=" via_to_string);
  Alcotest.(check bool)
    "extra themes applied (light-dark colors)" true
    (contains ~sub:"light-dark(" via_to_string)

let () =
  let open Alcotest in
  run "Ochre"
    [
      ( "theme",
        [
          test_case "Load theme from string" `Quick test_theme_loading;
          test_case "Make raw theme" `Quick test_theme_make_raw;
        ]
      );
      ( "source",
        [
          test_case "Preserves source text and line endings" `Quick
            test_source_text_is_preserved;
        ]
      );
      ( "scope",
        [
          test_case "Scope matching via tokens" `Quick test_scope_matching;
          test_case "Scope properties merge by rule" `Quick
            test_scope_property_merge;
        ]
      );
      ( "grammar",
        [
          test_case "Accept capture arrays" `Quick
            test_capture_arrays_in_grammar;
          test_case "Plaintext languages without a grammar" `Quick
            test_plaintext_langs;
          test_case "Bundled grammars that used to fail to load" `Quick
            test_bundled_grammars_that_used_to_fail_to_load;
          test_case "Every bundled grammar keeps the source text" `Quick
            test_every_bundled_grammar_covers_the_source;
        ]
      );
      ( "errors",
        [
          test_case "load returns Error for a duplicate language id" `Quick
            test_load_rejects_duplicate_ids;
          test_case
            "malformed JSON message names the source and hides the OCaml \
             exception"
            `Quick test_malformed_json_message_is_readable;
          test_case "missing file message names the path and hides Sys_error"
            `Quick test_missing_file_message_hides_sys_error;
        ]
      );
      ( "backend",
        [
          test_case "to_string Html honours options and extra themes" `Quick
            test_to_string_html_options_extra_themes;
        ]
      );
      ( "transform",
        [
          test_case "Empty transforms passthrough" `Quick
            test_transform_empty_passthrough;
          test_case "Transform ordering (last wins)" `Quick
            test_transform_ordering;
          test_case "Transform determinism" `Quick test_transform_determinism;
          test_case "Line highlight builtin" `Quick
            test_transform_line_highlight;
          test_case "Default highlight shows on light and dark" `Quick
            test_default_highlight_shows_on_light_and_dark;
          test_case "Hook execution order" `Quick
            test_transform_before_render_then_line;
        ]
      );
      ( "notation-transform",
        [
          test_case "Notation highlight basic" `Quick
            test_notation_highlight_basic;
          test_case "Notation highlight no match" `Quick
            test_notation_highlight_no_match;
          test_case "Notation diff add" `Quick test_notation_diff_add;
          test_case "Notation diff remove" `Quick test_notation_diff_remove;
          test_case "Notation diff no match" `Quick test_notation_diff_no_match;
          test_case "Notation word highlight basic" `Quick
            test_notation_word_highlight_basic;
          test_case "Notation word highlight no match" `Quick
            test_notation_word_highlight_no_match;
          test_case "Notation highlight with highlighter" `Quick
            test_notation_highlight_with_highlighter;
        ]
      );
      ( "decoration",
        [
          test_case "Empty decorations passthrough" `Quick
            test_decoration_empty_passthrough;
          test_case "Whole token decoration" `Quick test_decoration_whole_token;
          test_case "Token splitting at boundary" `Quick
            test_decoration_token_splitting;
          test_case "Mid-token split" `Quick test_decoration_mid_token_split;
          test_case "Multi-token decoration" `Quick test_decoration_multi_token;
          test_case "Negative character position" `Quick
            test_decoration_negative_character;
          test_case "Unicode scalar positions" `Quick
            test_decoration_unicode_scalar_positions;
          test_case "Unicode scalar negative positions" `Quick
            test_decoration_unicode_negative_character;
          test_case "Invalid UTF-8" `Quick test_decoration_invalid_utf8;
          test_case "Invalid UTF-8 counts one character per byte" `Quick
            test_decoration_invalid_utf8_scalars;
          test_case "Invalid data key" `Quick test_decoration_invalid_data_key;
          test_case "Empty data key" `Quick test_decoration_empty_data_key;
          test_case "Overlapping decorations" `Quick test_decoration_overlapping;
          test_case "Multiline decoration" `Quick test_decoration_multiline;
          test_case "Decoration with highlighter" `Quick
            test_decoration_with_highlighter;
        ]
      );
      ( "performance",
        [
          test_case "Deep nesting resolves theme styles in time" `Quick
            test_deep_nesting_theme_matching;
          test_case "Long nested line resolves theme styles in time" `Quick
            test_long_nested_line_theme;
          test_case "Many-part selector matches in time" `Quick
            test_many_part_selector;
          test_case "Decorations scale with lines plus decorations" `Quick
            test_decorations_scale;
          test_case "10,000-line JS file renders to HTML in budget" `Quick
            test_budget_js_file_to_html;
          test_case "Whole-theme stylesheet scales with distinct values" `Quick
            test_whole_theme_css_scales_with_values;
          test_case "Long line without limits tokenizes in budget" `Quick
            test_budget_long_line_without_limits;
          test_case "Line just under max_line_length tokenizes in budget" `Quick
            test_budget_minified_line;
        ]
      );
      ( "invalid utf-8",
        [
          test_case "Bytes are kept in token texts and renderers do not raise"
            `Quick test_invalid_utf8_keeps_bytes;
          test_case "Valid text around invalid bytes tokenizes normally" `Quick
            test_invalid_utf8_does_not_split_valid_text;
        ]
      );
      ( "theme matching",
        [
          test_case "Descendant selectors follow the scope stack order" `Quick
            test_descendant_selector_order;
          test_case "The deepest matching scope wins over more selector parts"
            `Quick test_deepest_scope_wins;
          test_case "Attributes come from one rule per scope" `Quick
            test_attributes_come_from_one_rule;
          test_case "Unset attributes keep the enclosing scope value" `Quick
            test_outer_attributes_are_kept;
          test_case "Theme default background is not painted on tokens" `Quick
            test_theme_default_background;
          test_case "Invalid colors are ignored" `Quick
            test_invalid_colors_are_ignored;
          test_case "Child combinator needs a direct parent" `Quick
            test_child_combinator;
          test_case "Empty string scope is global, empty array is dropped"
            `Quick test_empty_scope_is_global;
          test_case "Selector edge parsing" `Quick test_selector_edge_parsing;
          test_case "Non-string fontStyle is unset" `Quick test_unset_font_style;
          test_case "Theme type picks default colors" `Quick
            test_theme_type_picks_default_colors;
          test_case "Include without base_dir is an error" `Quick
            test_include_needs_base_dir;
          test_case "Falsy settings fall back to tokenColors" `Quick
            test_falsy_settings_use_token_colors;
          test_case "Foreground falls back to the theme foreground" `Quick
            test_foreground_falls_back_to_theme;
          test_case "settings wins over tokenColors" `Quick
            test_settings_win_over_token_colors;
        ]
      );
    ]
