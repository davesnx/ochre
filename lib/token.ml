type color = string
type font_style = Bold | Italic | Underline | Strikethrough

type styled_token = {
  text : string;
  foreground : color option;
  background : color option;
  font_style : font_style list;
  scopes : string list;
}

type line = styled_token list
type highlighted_code = line list
