type style_mode = Inline_styles | Css_classes of { class_prefix : string }
type default_color = Default_color | No_default_color

type t = {
  style_mode : style_mode;
  default_color : default_color;
  pre_class : string option;
  code_class : string option;
  line_numbers : bool;
  css_variable_prefix : string;
  scopes_as_data_attrs : bool;
}

let default =
  {
    style_mode = Inline_styles;
    default_color = Default_color;
    pre_class = None;
    code_class = None;
    line_numbers = false;
    css_variable_prefix = "--ochre-";
    scopes_as_data_attrs = false;
  }

let make ?(style_mode = Inline_styles) ?(default_color = Default_color)
    ?pre_class ?code_class ?(line_numbers = false)
    ?(css_variable_prefix = "--ochre-") ?(scopes_as_data_attrs = false) () =
  {
    style_mode;
    default_color;
    pre_class;
    code_class;
    line_numbers;
    css_variable_prefix;
    scopes_as_data_attrs;
  }
