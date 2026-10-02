type escaped = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

let escape_string s =
  let buf = Buffer.create (String.length s) in
  Escape.html buf s;
  Buffer.contents buf

let escape (dec : Token.decoration_properties) =
  {
    class_ = Option.map escape_string dec.class_;
    style = Option.map escape_string dec.style;
    data = List.map (fun (k, v) -> (k, escape_string v)) dec.data;
  }
