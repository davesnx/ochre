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

let hl = Ochre.load_exn [ ("test", grammar_json) ]
let theme = Ochre.Theme.dark

let alphabet =
  [|
    "a";
    "b";
    "x";
    "let";
    "if";
    "1";
    "42";
    " ";
    " ";
    "\t";
    "\r";
    "\n";
    "\n";
    "\r\n";
    "#";
    "\"";
    "<";
    ">";
    "&";
    "'";
    "\\";
    "{";
    "}";
    "%";
    "$";
    "_";
    "~";
    "^";
    "\xc3\xa9";
    "\xe6\x97\xa5";
  |]

let random_source () =
  String.concat ""
    (List.init (Random.int 24) (fun _ ->
         alphabet.(Random.int (Array.length alphabet))
     )
    )

let width code =
  if code >= 0x3000 && code <= 0x9FFF then
    2
  else
    1

let expand_tabs line =
  let buf = Buffer.create 16 in
  let column = ref 0 in
  let i = ref 0 in
  while !i < String.length line do
    let d = String.get_utf_8_uchar line !i in
    let n = Uchar.utf_decode_length d in
    let code = Uchar.to_int (Uchar.utf_decode_uchar d) in
    if code = 9 then (
      let w = 8 - (!column mod 8) in
      Buffer.add_string buf (String.make w ' ');
      column := !column + w
    ) else (
      Buffer.add_substring buf line !i n;
      if code <> 13 then column := !column + width code
    );
    i := !i + n
  done;
  Buffer.contents buf

let split_lines source =
  let parts = String.split_on_char '\n' source in
  match List.rev parts with "" :: rest -> List.rev rest | _ -> parts

let replace_all ~sub ~by s =
  let buf = Buffer.create (String.length s) in
  let n = String.length sub in
  let i = ref 0 in
  while !i < String.length s do
    if !i + n <= String.length s && String.sub s !i n = sub then (
      Buffer.add_string buf by;
      i := !i + n
    ) else (
      Buffer.add_char buf s.[!i];
      incr i
    )
  done;
  Buffer.contents buf

let strip_tags s =
  let buf = Buffer.create (String.length s) in
  let inside = ref false in
  String.iter
    (fun c ->
      if c = '<' then
        inside := true
      else if c = '>' && !inside then
        inside := false
      else if not !inside then
        Buffer.add_char buf c
    )
    s;
  Buffer.contents buf

let decode s =
  List.fold_left
    (fun s (sub, by) -> replace_all ~sub ~by s)
    s
    [
      ("&lt;", "<");
      ("&gt;", ">");
      ("&quot;", "\"");
      ("&apos;", "'");
      ("&#39;", "'");
      ("&#13;", "\r");
      ("&amp;", "&");
    ]

let between s ~start ~stop =
  let find sub from =
    let n = String.length sub in
    let rec go i =
      if i + n > String.length s then
        raise Not_found
      else if String.sub s i n = sub then
        i
      else
        go (i + 1)
    in
    go from
  in
  let a = find start 0 + String.length start in
  String.sub s a (find stop a - a)

let html source =
  let out = Ochre.to_html hl ~theme ~lang:"test" source in
  (decode (strip_tags (between out ~start:"<code>" ~stop:"</code>")), source)

let ansi source =
  let out = Ochre.to_ansi hl ~theme ~lang:"test" source in
  let buf = Buffer.create 64 in
  let i = ref 0 in
  while !i < String.length out do
    if out.[!i] = '\x1b' then (
      while out.[!i] <> 'm' do
        incr i
      done;
      incr i
    ) else (
      Buffer.add_char buf out.[!i];
      incr i
    )
  done;
  let expected =
    let buf = Buffer.create 64 in
    String.iteri
      (fun i c ->
        if
          c = '\r' && not (i + 1 < String.length source && source.[i + 1] = '\n')
        then
          Buffer.add_string buf "^M"
        else
          Buffer.add_char buf c
      )
      source;
    Buffer.contents buf
  in
  (Buffer.contents buf, expected)

let svg source =
  let out = Ochre.to_svg hl ~theme ~lang:"test" source in
  let texts =
    List.filter_map
      (fun line ->
        if String.starts_with ~prefix:"  <text " line then
          let start = String.index line '>' + 1 in
          let stop = String.length line - String.length "</text>" in
          Some (decode (strip_tags (String.sub line start (stop - start))))
        else
          None
      )
      (String.split_on_char '\n' out)
  in
  ( String.concat "\n" texts,
    String.concat "\n" (List.map expand_tabs (split_lines source))
  )

let latex source =
  let out = Ochre.to_latex hl ~theme ~lang:"test" source in
  let body = between out ~start:"}\n" ~stop:"\n\\end{ochrehighlight}" in
  let n = String.length body in
  let at i p =
    i + String.length p <= n && String.sub body i (String.length p) = p
  in
  let escapes =
    [
      ("\\ ", " ");
      ("\\{", "{");
      ("\\}", "}");
      ("\\%", "%");
      ("\\$", "$");
      ("\\#", "#");
      ("\\&", "&");
      ("\\_", "_");
      ("\\textbackslash{}", "\\");
      ("\\textasciitilde{}", "~");
      ("\\textasciicircum{}", "^");
    ]
  in
  let buf = Buffer.create n in
  let rec go i =
    if i < n then
      if at i "\\\\\n" then (
        Buffer.add_char buf '\n';
        go (i + 3)
      ) else
        match List.find_opt (fun (e, _) -> at i e) escapes with
        | Some (e, c) ->
            Buffer.add_string buf c;
            go (i + String.length e)
        | None ->
            if at i "\\textcolor[HTML]{" then
              go (String.index_from body i '}' + 2)
            else if at i "\\textbf{" || at i "\\textit{" then
              go (i + 8)
            else if body.[i] = '}' then
              go (i + 1)
            else (
              Buffer.add_char buf body.[i];
              go (i + 1)
            )
  in
  go 0;
  let expected =
    String.concat "\n"
      (List.map
         (fun line -> replace_all ~sub:"\r" ~by:"" (expand_tabs line))
         (split_lines source)
      )
  in
  (Buffer.contents buf, expected)

let () =
  Random.init 20260126;
  let cases = List.init 300 (fun _ -> random_source ()) in
  List.iter
    (fun (name, f) ->
      let failures =
        List.filter
          (fun source ->
            let got, expected = f source in
            got <> expected
          )
          cases
      in
      match failures with
      | [] ->
          Printf.printf "%s: text equals the source in %d cases\n" name
            (List.length cases)
      | source :: _ ->
          let got, expected = f source in
          Printf.printf
            "%s: %d of %d differ, for example %S gives %S, expected %S\n" name
            (List.length failures) (List.length cases) source got expected
    )
    [ ("html", html); ("ansi", ansi); ("svg", svg); ("latex", latex) ]
