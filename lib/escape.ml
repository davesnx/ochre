let html buf s =
  let length = String.length s in
  let exception First_char_to_escape of int in
  match
    for i = 0 to length - 1 do
      match String.unsafe_get s i with
      | '&' | '<' | '>' | '\'' | '"' -> raise_notrace (First_char_to_escape i)
      | _ -> ()
    done
  with
  | exception First_char_to_escape first ->
      if first > 0 then Buffer.add_substring buf s 0 first;
      for i = first to length - 1 do
        match String.unsafe_get s i with
        | '&' -> Buffer.add_string buf "&amp;"
        | '<' -> Buffer.add_string buf "&lt;"
        | '>' -> Buffer.add_string buf "&gt;"
        | '\'' -> Buffer.add_string buf "&apos;"
        | '"' -> Buffer.add_string buf "&quot;"
        | c -> Buffer.add_char buf c
      done
  | _ -> Buffer.add_string buf s
