let replacement = "\xEF\xBF\xBD"

let is_xml_char u =
  let c = Uchar.to_int u in
  c = 0x9 || c = 0xA || c = 0xD
  || (c >= 0x20 && c <= 0xD7FF)
  || (c >= 0xE000 && c <= 0xFFFD)
  || (c >= 0x10000 && c <= 0x10FFFF)

let add_specials buf = function
  | '&' ->
      Buffer.add_string buf "&amp;"
  | '<' ->
      Buffer.add_string buf "&lt;"
  | '>' ->
      Buffer.add_string buf "&gt;"
  | '\'' ->
      Buffer.add_string buf "&apos;"
  | '"' ->
      Buffer.add_string buf "&quot;"
  | c ->
      Buffer.add_char buf c

let needs_attention = function
  | '&' | '<' | '>' | '\'' | '"' | '\000' ->
      true
  | c ->
      Char.code c >= 0x80

let html buf s =
  if not (String.exists needs_attention s) then
    Buffer.add_string buf s
  else
    let length = String.length s in
    let rec loop i =
      if i < length then (
        let c = String.unsafe_get s i in
        if Char.code c < 0x80 then (
          if c = '\000' then
            Buffer.add_string buf replacement
          else
            add_specials buf c;
          loop (i + 1)
        ) else
          let d = String.get_utf_8_uchar s i in
          let n = Uchar.utf_decode_length d in
          if Uchar.utf_decode_is_valid d then
            Buffer.add_substring buf s i n
          else
            Buffer.add_string buf replacement;
          loop (i + n)
      )
    in
    loop 0

let xml_filtered ~attr buf s =
  let length = String.length s in
  let rec loop i =
    if i < length then (
      let d = String.get_utf_8_uchar s i in
      let n = Uchar.utf_decode_length d in
      let u = Uchar.utf_decode_uchar d in
      if Uchar.utf_decode_is_valid d && is_xml_char u then
        if n = 1 then
          match String.unsafe_get s i with
          | '\r' ->
              Buffer.add_string buf "&#13;"
          | '\t' when attr ->
              Buffer.add_string buf "&#9;"
          | '\n' when attr ->
              Buffer.add_string buf "&#10;"
          | c ->
              add_specials buf c
        else
          Buffer.add_substring buf s i n
      else
        Buffer.add_string buf replacement;
      loop (i + n)
    )
  in
  loop 0

let xml_with ~attr buf s =
  if
    not
      (String.exists
         (fun c ->
           needs_attention c
           || (Char.code c < 0x20 && (attr || (c <> '\t' && c <> '\n')))
         )
         s
      )
  then
    Buffer.add_string buf s
  else
    xml_filtered ~attr buf s

let xml = xml_with ~attr:false
let xml_attr = xml_with ~attr:true

let to_string f s =
  let buf = Buffer.create (String.length s) in
  f buf s;
  Buffer.contents buf

let is_ident_char = function
  | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '-' ->
      true
  | _ ->
      false

let css_ident s =
  String.map
    (fun c ->
      if is_ident_char c then
        c
      else
        '_'
    )
    s

let is_alpha = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false
let is_hex = function
  | '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' ->
      true
  | _ ->
      false

let color_functions =
  [ "rgb"; "rgba"; "hsl"; "hsla"; "hwb"; "lab"; "lch"; "oklab"; "oklch" ]

let is_color_arg_char = function
  | '0' .. '9' | '.' | ',' | '%' | '/' | ' ' | '+' | '-' ->
      true
  | c ->
      is_alpha c

let css_color s =
  let n = String.length s in
  let valid =
    if n = 0 then
      false
    else if s.[0] = '#' then
      (n = 4 || n = 5 || n = 7 || n = 9)
      && String.for_all is_hex (String.sub s 1 (n - 1))
    else if String.for_all is_alpha s then
      true
    else
      match String.index_opt s '(' with
      | Some i when s.[n - 1] = ')' ->
          List.mem (String.lowercase_ascii (String.sub s 0 i)) color_functions
          && String.for_all is_color_arg_char (String.sub s (i + 1) (n - i - 2))
      | _ ->
          false
  in
  if valid then
    Some s
  else
    None
