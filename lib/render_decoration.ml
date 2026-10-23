type escaped = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

let escape_with escape_string (dec : Token.decoration_properties) =
  {
    class_ = Option.map escape_string dec.class_;
    style = Option.map escape_string dec.style;
    data = List.map (fun (k, v) -> (k, escape_string v)) dec.data;
  }

let escape = escape_with (Escape.to_string Escape.html)
let escape_xml = escape_with (Escape.to_string Escape.xml_attr)
