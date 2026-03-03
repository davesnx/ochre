type color = string
type font_style = Bold | Italic | Underline | Strikethrough

type decoration_properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type styled_token = {
  text : string;
  foreground : color option;
  background : color option;
  font_style : font_style list;
  scopes : string list;
  decoration : decoration_properties option;
}

type line = styled_token list
type highlighted_code = line list
