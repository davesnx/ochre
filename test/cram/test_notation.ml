let theme = Ochre.Theme.dark

let highlighter =
  let grammars =
    List.filter_map
      (fun lang -> Option.map (fun json -> (lang, json)) (Tm_grammars.find lang))
      [
        "javascript";
        "typescript";
        "c";
        "python";
        "ruby";
        "yaml";
        "sql";
        "lua";
        "rust";
        "go";
        "toml";
        "java";
        "ocaml";
        "css";
        "html";
        "markdown";
      ]
  in
  Ochre.load_exn grammars

let mark (line : Ochre.Token.styled_token list) =
  match line with
  | [] ->
      "."
  | first :: _ -> (
      match first.background with
      | Some "#ffffff22" ->
          "hl"
      | Some "#22883322" ->
          "++"
      | Some "#88222222" ->
          "--"
      | Some _ ->
          "bg"
      | None ->
          "."
    )

let text (line : Ochre.Token.styled_token list) =
  String.concat ""
    (List.map
       (fun (tok : Ochre.Token.styled_token) ->
         if tok.foreground = Some "#ffff00" then
           "[" ^ tok.text ^ "]"
         else
           tok.text
       )
       line
    )

let show ?(name = "") lang transforms source =
  let tokens = Ochre.to_tokens highlighter ~transforms ~theme ~lang source in
  Printf.printf "%s%s\n" lang
    ( if name = "" then
        ""
      else
        " (" ^ name ^ ")"
    );
  List.iter
    (fun line -> Printf.printf "  %-2s %S\n" (mark line) (text line))
    tokens;
  let joined =
    String.concat ""
      (List.map
         (fun line ->
           String.concat ""
             (List.map (fun (tok : Ochre.Token.styled_token) -> tok.text) line)
         )
         tokens
      )
  in
  if String.length joined > 0 && not (String.contains joined '\n') then
    print_endline "  (no newline)"

let highlight = [ Ochre.Transform_builtin.notation_highlight () ]
let diff = [ Ochre.Transform_builtin.notation_diff () ]
let word = [ Ochre.Transform_builtin.notation_word_highlight () ]

let line_comment_cases =
  [
    ("javascript", "let x = 42; // [!code highlight]\nlet y = 10;\n");
    ("typescript", "const x: number = 1; // [!code highlight]\nconst y = 2;\n");
    ("c", "int x; // [!code highlight]\nnext\n");
    ("python", "x = 1  # [!code highlight]\ny = 2\n");
    ("ruby", "x = 1 # [!code highlight]\ny = 2\n");
    ("yaml", "a: 1 # [!code highlight]\nb: 2\n");
    ("sql", "select 1 -- [!code highlight]\nselect 2;\n");
    ("lua", "local x = 1 -- [!code highlight]\nlocal y = 2\n");
    ("rust", "let x = 1; // [!code highlight]\nlet y = 2;\n");
    ("go", "x := 1 // [!code highlight]\ny := 2\n");
    ("toml", "a = 1 # [!code highlight]\nb = 2\n");
    ("java", "int x = 1; // [!code highlight]\nint y = 2;\n");
    ("ocaml", "let x = 1 (* [!code highlight] *)\nlet y = 2\n");
    ("css", "a { color: red } /* [!code highlight] */\nb { }\n");
    ("html", "<p>x</p> <!-- [!code highlight] -->\n<p>y</p>\n");
    ("markdown", "foo # [!code highlight]\nbar\n");
    ("plaintext", "foo // [!code highlight]\nbar\n");
  ]

let non_comment_text line =
  String.concat ""
    (List.map
       (fun (tok : Ochre.Token.styled_token) ->
         if
           List.exists
             (fun scope ->
               scope = "comment" || String.starts_with ~prefix:"comment." scope
             )
             tok.scopes
         then
           ""
         else
           String.concat ""
             (String.split_on_char ' '
                (String.map
                   (function '\n' | '\r' | '\t' -> ' ' | c -> c)
                   tok.text
                )
             )
       )
       line
    )

let property () =
  Random.init 7;
  let fragments =
    [|
      "x";
      "let";
      "1";
      "= ";
      "; ";
      "% ";
      "-- ";
      "# ";
      "// ";
      "/* ";
      " */";
      "<!-- ";
      " -->";
      "(* ";
      " *)";
      "\"";
      "'";
      "[!code highlight]";
      "[!code ++]";
      "[!code word:x]";
      "[!code hl:2]";
      " ";
      "{";
      "}";
      ":";
      "<";
      ">";
      "/";
      "*";
      "\t";
    |]
  in
  let langs =
    [
      "javascript";
      "typescript";
      "c";
      "python";
      "ruby";
      "yaml";
      "sql";
      "lua";
      "rust";
      "go";
      "toml";
      "java";
      "ocaml";
      "css";
      "html";
    ]
  in
  let transforms =
    [
      Ochre.Transform_builtin.notation_highlight ();
      Ochre.Transform_builtin.notation_diff ();
      Ochre.Transform_builtin.notation_word_highlight ();
    ]
  in
  List.iter
    (fun lang ->
      let bad = ref 0 and example = ref "" in
      for _ = 1 to 400 do
        let line =
          String.concat ""
            (List.init
               (1 + Random.int 8)
               (fun _ -> fragments.(Random.int (Array.length fragments)))
            )
        in
        let source = line ^ "\nlet z = 1\n" in
        let before = Ochre.to_tokens highlighter ~theme ~lang source in
        let after =
          Ochre.to_tokens highlighter ~transforms ~theme ~lang source
        in
        let code tokens = String.concat "" (List.map non_comment_text tokens) in
        if code before <> code after then (
          incr bad;
          example := source
        )
      done;
      if !bad = 0 then
        Printf.printf "%s: only comments change\n" lang
      else
        Printf.printf "%s: %d cases lose code, for example %S\n" lang !bad
          !example
    )
    langs

let speed () =
  List.iter
    (fun markers ->
      let source =
        "x = \""
        ^ String.concat "" (List.init markers (fun _ -> "[!code highlight]"))
        ^ "\"\n"
      in
      let start = Unix.gettimeofday () in
      ignore
        (Ochre.to_tokens highlighter
           ~transforms:[ Ochre.Transform_builtin.notation_highlight () ]
           ~theme ~lang:"javascript" source
        );
      let seconds = Unix.gettimeofday () -. start in
      Printf.printf "%d markers in a string: under 2s: %b\n" markers
        (seconds < 2.0)
    )
    [ 2500; 5000; 20000 ]

let () =
  match Sys.argv with
  | [| _; "highlight" |] ->
      List.iter
        (fun (lang, source) -> show lang highlight source)
        line_comment_cases
  | [| _; "diff" |] ->
      show "javascript" diff
        "let a = 1; // [!code ++]\nlet b = 2; // [!code --]\nlet c = 3;\n";
      show "python" diff "a = 1  # [!code ++]\nb = 2  # [!code --]\nc = 3\n";
      show "ocaml" diff
        "let a = 1 (* [!code ++] *)\nlet b = 2 (* [!code --] *)\nlet c = 3\n"
  | [| _; "word" |] ->
      show "javascript" word
        "let foo = 1; // [!code word:foo]\nfoo + foo;\nbar;\n";
      show ~name:"range" "javascript" word
        "let foo = 1; // [!code word:foo:1]\nfoo + foo;\nbar;\n";
      show ~name:"comment line" "javascript" word
        "// [!code word:foo:1]\nfoo + 1;\nfoo;\n";
      show ~name:"across tokens" "c" word "int xy; // [!code word:xy]\n";
      show ~name:"escaped" "javascript" word "a:b; // [!code word:a\\:b]\n"
  | [| _; "edge" |] ->
      show ~name:"text and newline stay" "javascript" highlight
        "let x = 1; // [!code highlight] keep me\nlet y = 2;\n";
      show ~name:"comment only line" "javascript" highlight
        "// [!code highlight]\nlet y = 10;\nlet z = 1;\n";
      show ~name:"indented comment only line" "python" highlight
        "if x:\n    # [!code highlight]\n    y = 1\n";
      show ~name:"range" "javascript" highlight
        "let a = 1; // [!code highlight:2]\nlet b = 2;\nlet c = 3;\n";
      show ~name:"hl alias" "javascript" highlight
        "let a = 1; // [!code hl]\nlet b = 2;\n";
      show ~name:"no trailing newline" "javascript" highlight
        "let a = 1;\nlet b = 2; // [!code highlight]";
      show ~name:"crlf" "c" highlight "int x; // [!code highlight]\r\nnext\r\n";
      show ~name:"marker in string" "javascript" highlight
        "let s = \"// [!code highlight]\";\n";
      show ~name:"block comment not last" "javascript" highlight
        "f(/* [!code highlight] */ x);\n";
      show ~name:"marker in middle of block" "css" highlight
        "a { } /* note [!code highlight] more */\nb { }\n";
      show ~name:"both transforms" "javascript" (highlight @ diff)
        "let a = 1; // [!code highlight] [!code ++]\nlet b = 2;\n";
      show ~name:"no marker" "javascript" highlight "let a = 1; // plain\n";
      show ~name:"empty source" "javascript" highlight ""
  | [| _; "code" |] ->
      show ~name:"semicolon is code" "javascript" highlight
        "let x = 1; [!code highlight]\nlet y = 2;\n";
      show ~name:"semicolon after string" "javascript" highlight
        "x = \"a\"; [!code hl]\n";
      show ~name:"preprocessor line" "c" highlight "#define X 1 [!code hl]\n";
      show ~name:"css declaration" "css" highlight
        "a { color: red;[!code highlight] }\n";
      show ~name:"typescript soup" "typescript" highlight
        "<!--(*%%[!code highlight]\n";
      show ~name:"comment after code" "javascript" highlight
        "x = 1; // note [!code highlight]\n"
  | [| _; "property" |] ->
      property ()
  | [| _; "speed" |] ->
      speed ()
  | _ ->
      prerr_endline "unknown case";
      exit 1
