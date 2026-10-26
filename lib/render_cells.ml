let tab_width = 8

let in_ranges code ranges =
  List.exists (fun (low, high) -> code >= low && code <= high) ranges

let zero_width =
  [
    (0x0300, 0x036F);
    (0x200B, 0x200F);
    (0x2060, 0x2064);
    (0xFE00, 0xFE0F);
    (0xFEFF, 0xFEFF);
  ]

let wide =
  [
    (0x1100, 0x115F);
    (0x2E80, 0x303E);
    (0x3041, 0x33FF);
    (0x3400, 0x4DBF);
    (0x4E00, 0x9FFF);
    (0xA000, 0xA4CF);
    (0xAC00, 0xD7A3);
    (0xF900, 0xFAFF);
    (0xFE30, 0xFE4F);
    (0xFF00, 0xFF60);
    (0xFFE0, 0xFFE6);
    (0x1F300, 0x1F64F);
    (0x1F900, 0x1F9FF);
    (0x20000, 0x3FFFD);
  ]

let scalar_width code =
  if code < 0x20 || code = 0x7F then
    1
  else if in_ranges code zero_width then
    0
  else if in_ranges code wide then
    2
  else
    1

let expand_tabs ~column text =
  let length = String.length text in
  let buf = Buffer.create length in
  let rec loop i column =
    if i >= length then
      column
    else
      let decoded = String.get_utf_8_uchar text i in
      let size = Uchar.utf_decode_length decoded in
      if not (Uchar.utf_decode_is_valid decoded) then (
        Buffer.add_substring buf text i size;
        loop (i + size) (column + 1)
      ) else
        match Uchar.to_int (Uchar.utf_decode_uchar decoded) with
        | 0x09 ->
            let width = tab_width - (column mod tab_width) in
            Buffer.add_string buf (String.make width ' ');
            loop (i + size) (column + width)
        | 0x0D ->
            Buffer.add_char buf '\r';
            loop (i + size) column
        | code ->
            Buffer.add_substring buf text i size;
            loop (i + size) (column + scalar_width code)
  in
  let column = loop 0 column in
  (Buffer.contents buf, column)
