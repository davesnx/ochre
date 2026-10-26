let is_continuation source index =
  index < String.length source
  && Char.code (String.unsafe_get source index) land 0xc0 = 0x80

let in_range source index low high =
  index < String.length source
  &&
  let byte = Char.code (String.unsafe_get source index) in
  byte >= low && byte <= high

let scalar_length source offset =
  let byte = Char.code source.[offset] in
  if byte <= 0x7f then
    1
  else if byte >= 0xc2 && byte <= 0xdf then
    if is_continuation source (offset + 1) then
      2
    else
      0
  else if byte >= 0xe0 && byte <= 0xef then
    let second_ok =
      match byte with
      | 0xe0 ->
          in_range source (offset + 1) 0xa0 0xbf
      | 0xed ->
          in_range source (offset + 1) 0x80 0x9f
      | _ ->
          is_continuation source (offset + 1)
    in
    if second_ok && is_continuation source (offset + 2) then
      3
    else
      0
  else if byte >= 0xf0 && byte <= 0xf4 then
    let second_ok =
      match byte with
      | 0xf0 ->
          in_range source (offset + 1) 0x90 0xbf
      | 0xf4 ->
          in_range source (offset + 1) 0x80 0x8f
      | _ ->
          is_continuation source (offset + 1)
    in
    if
      second_ok
      && is_continuation source (offset + 2)
      && is_continuation source (offset + 3)
    then
      4
    else
      0
  else
    0

let placeholder = '_'

let mask_invalid source =
  let length = String.length source in
  let rec first_invalid offset =
    if offset >= length then
      None
    else
      match scalar_length source offset with
      | 0 ->
          Some offset
      | n ->
          first_invalid (offset + n)
  in
  match first_invalid 0 with
  | None ->
      source
  | Some first ->
      let masked = Bytes.of_string source in
      let rec loop offset =
        if offset < length then
          match scalar_length source offset with
          | 0 ->
              Bytes.unsafe_set masked offset placeholder;
              loop (offset + 1)
          | n ->
              loop (offset + n)
      in
      loop first;
      Bytes.unsafe_to_string masked
