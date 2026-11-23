type escaped = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

val escape_xml : Token.decoration_properties -> escaped
