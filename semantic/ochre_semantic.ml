open Ppxlib

type span = { offset : int; length : int; scope : string }

let namespace = "entity.name.namespace"
let enum_member = "variable.other.enummember"
let parameter = "variable.parameter"
let property = "variable.other.property"
let type_ = "entity.name.type"
let enum = "entity.name.type.enum"
let struct_ = "entity.name.type.struct"
let interface = "entity.name.type.interface"
let function_ = "entity.name.function"
let variable = "variable.other.readwrite"
let type_parameter = "entity.name.type.parameter"

let rec components = function
  | Lident name ->
      [ name ]
  | Ldot (prefix, name) ->
      components prefix @ [ name ]
  | Lapply (functor_, argument) ->
      components functor_ @ components argument

let text_at source offset text =
  offset >= 0
  && offset + String.length text <= String.length source
  && String.sub source offset (String.length text) = text

let is_space = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let rec skip_spaces_backward source offset =
  if offset > 0 && is_space source.[offset - 1] then
    skip_spaces_backward source (offset - 1)
  else
    offset

let rec skip_separators source offset =
  if offset < String.length source then
    match source.[offset] with
    | ' ' | '\t' | '\n' | '\r' | '.' | '(' | ')' ->
        skip_separators source (offset + 1)
    | _ ->
        offset
  else
    offset

let name_span source offset name scope =
  let offset = skip_separators source offset in
  if text_at source offset name then
    [ { offset; length = String.length name; scope } ]
  else
    []

let text_span source (loc : location) text scope =
  let offset = loc.loc_start.pos_cnum in
  if (not loc.loc_ghost) && text_at source offset text then
    [ { offset; length = String.length text; scope } ]
  else
    []

let name_at source scope { txt; loc } = text_span source loc txt scope

let is_arrow t =
  match t.ptyp_desc with
  | Ptyp_arrow _ | Ptyp_poly (_, { ptyp_desc = Ptyp_arrow _; _ }) ->
      true
  | _ ->
      false

let rec is_function_expression e =
  match e.pexp_desc with
  | Pexp_function _ ->
      true
  | Pexp_constraint (e, t) | Pexp_coerce (e, _, t) ->
      is_arrow t || is_function_expression e
  | Pexp_newtype (_, e)
  | Pexp_open (_, e)
  | Pexp_letmodule (_, _, e)
  | Pexp_let (_, _, e)
  | Pexp_letexception (_, e) ->
      is_function_expression e
  | _ ->
      false

let is_function_constraint = function
  | Some (Pvc_constraint { typ = t; _ } | Pvc_coercion { coercion = t; _ }) ->
      is_arrow t
  | None ->
      false

let binding_name binding =
  match binding.pvb_pat.ppat_desc with
  | Ppat_var name ->
      Some (name, false)
  | Ppat_constraint ({ ppat_desc = Ppat_var name; _ }, t) ->
      Some (name, is_arrow t)
  | _ ->
      None

let value_scope is_function =
  if is_function then
    function_
  else
    variable

let module_name_span source scope { txt; loc } =
  match txt with Some name -> text_span source loc name scope | None -> []

let rec skip_open_parens source offset =
  if
    offset < String.length source
    && (source.[offset] = '(' || is_space source.[offset])
  then
    skip_open_parens source (offset + 1)
  else
    offset

let variant_span source (loc : location) label =
  let text = "`" ^ label in
  let offset = skip_open_parens source loc.loc_start.pos_cnum in
  if (not loc.loc_ghost) && text_at source offset text then
    [ { offset; length = String.length text; scope = enum_member } ]
  else
    []

let type_variable_span source loc name =
  text_span source loc ("'" ^ name) type_parameter

let label_text = function
  | Nolabel ->
      None
  | Labelled name ->
      Some ("~", name)
  | Optional name ->
      Some ("?", name)

let parameter_span offset text =
  [ { offset; length = String.length text; scope = parameter } ]

let argument_label_span source label (argument : expression) =
  match label_text label with
  | None ->
      []
  | Some _ when argument.pexp_loc.loc_ghost ->
      []
  | Some (sigil, name) ->
      let text = sigil ^ name in
      let start = argument.pexp_loc.loc_start.pos_cnum in
      let colon = skip_spaces_backward source start - 1 in
      let explicit = colon - String.length text in
      if text_at source (start - 1) text then
        parameter_span (start - 1) text
      else if text_at source (start - 1) (sigil ^ "(") then
        name_span source (start + 1) name parameter
      else if text_at source colon ":" && text_at source explicit text then
        parameter_span explicit text
      else
        []

let parameter_label_span source label (loc : location) =
  match label_text label with
  | None ->
      []
  | Some _ when loc.loc_ghost ->
      []
  | Some (sigil, name) ->
      let text = sigil ^ name in
      let start = loc.loc_start.pos_cnum in
      if text_at source start text then
        parameter_span start text
      else if text_at source start (sigil ^ "(") then
        name_span source (start + 2) name parameter
      else
        []

let path_spans ?last source { txt; loc } =
  let rec go offset = function
    | [] ->
        []
    | [ name ] -> (
        match last with
        | Some scope ->
            name_span source offset name scope
        | None ->
            []
      )
    | name :: rest -> (
        match name_span source offset name namespace with
        | [ span ] ->
            span :: go (span.offset + span.length) rest
        | _ ->
            []
      )
  in
  if loc.loc_ghost then
    []
  else
    go loc.loc_start.pos_cnum (components txt)

class collector source =
  object (self)
    inherit Ast_traverse.iter as super
    val mutable spans = []
    method spans = List.sort (fun a b -> compare a.offset b.offset) spans

    method private add new_spans = spans <- new_spans @ spans

    method private constructor lid =
      match lid.txt with
      | Lident ("::" | "[]" | "()") ->
          ()
      | _ ->
          self#add (path_spans ~last:enum_member source lid)

    method private field lid (value_loc : location) =
      let lid =
        if lid.loc.loc_ghost then
          { lid with loc = value_loc }
        else
          lid
      in
      self#add (path_spans ~last:property source lid)

    method! expression e =
      ( match e.pexp_desc with
      | Pexp_ident lid ->
          self#add (path_spans source lid)
      | Pexp_construct (lid, _) ->
          self#constructor lid
      | Pexp_apply (_, arguments) ->
          List.iter
            (fun (label, argument) ->
              self#add (argument_label_span source label argument)
            )
            arguments
      | Pexp_newtype (name, _) ->
          self#add (name_at source type_parameter name)
      | Pexp_letmodule (name, _, _) ->
          self#add (module_name_span source namespace name)
      | Pexp_record (fields, _) ->
          List.iter (fun (lid, value) -> self#field lid value.pexp_loc) fields
      | Pexp_field (_, lid) | Pexp_setfield (_, lid, _) ->
          self#field lid lid.loc
      | Pexp_variant (label, _) ->
          self#add (variant_span source e.pexp_loc label)
      | _ ->
          ()
      );
      super#expression e

    method! pattern p =
      ( match p.ppat_desc with
      | Ppat_construct (lid, _) ->
          self#constructor lid
      | Ppat_unpack name ->
          self#add (module_name_span source namespace name)
      | Ppat_open (lid, _) ->
          self#add (path_spans ~last:namespace source lid)
      | Ppat_record (fields, _) ->
          List.iter (fun (lid, value) -> self#field lid value.ppat_loc) fields
      | Ppat_variant (label, _) ->
          self#add (variant_span source p.ppat_loc label)
      | _ ->
          ()
      );
      super#pattern p

    method! function_param param =
      ( match param.pparam_desc with
      | Pparam_val (label, _, _) ->
          self#add (parameter_label_span source label param.pparam_loc)
      | Pparam_newtype name ->
          self#add (name_at source type_parameter name)
      );
      super#function_param param

    method! value_constraint constraint_ =
      ( match constraint_ with
      | Pvc_constraint { locally_abstract_univars; _ } ->
          List.iter
            (fun name -> self#add (name_at source type_parameter name))
            locally_abstract_univars
      | Pvc_coercion _ ->
          ()
      );
      super#value_constraint constraint_

    method! core_type t =
      ( match t.ptyp_desc with
      | Ptyp_var name ->
          self#add (type_variable_span source t.ptyp_loc name)
      | Ptyp_constr (lid, _) ->
          self#add (path_spans ~last:type_ source lid)
      | Ptyp_alias (_, { txt; loc }) ->
          self#add (type_variable_span source loc txt)
      | Ptyp_package (lid, _) ->
          self#add (path_spans ~last:interface source lid)
      | Ptyp_poly (variables, _) ->
          List.iter
            (fun { txt; loc } -> self#add (type_variable_span source loc txt))
            variables
      | _ ->
          ()
      );
      super#core_type t

    method! type_declaration declaration =
      let scope =
        match declaration.ptype_kind with
        | Ptype_abstract | Ptype_open ->
            type_
        | Ptype_variant _ ->
            enum
        | Ptype_record _ ->
            struct_
      in
      self#add (name_at source scope declaration.ptype_name);
      super#type_declaration declaration

    method! constructor_declaration declaration =
      self#add (name_at source enum_member declaration.pcd_name);
      List.iter
        (fun { txt; loc } -> self#add (type_variable_span source loc txt))
        declaration.pcd_vars;
      super#constructor_declaration declaration

    method! extension_constructor constructor =
      self#add (name_at source enum_member constructor.pext_name);
      super#extension_constructor constructor

    method! label_declaration declaration =
      self#add (name_at source property declaration.pld_name);
      super#label_declaration declaration

    method! value_binding binding =
      ( match binding_name binding with
      | Some (name, arrow_pattern) ->
          let is_function =
            arrow_pattern
            || is_function_expression binding.pvb_expr
            || is_function_constraint binding.pvb_constraint
          in
          self#add (name_at source (value_scope is_function) name)
      | None ->
          ()
      );
      super#value_binding binding

    method! value_description description =
      let scope = value_scope (is_arrow description.pval_type) in
      self#add (name_at source scope description.pval_name);
      super#value_description description

    method! type_extension extension =
      self#add (path_spans ~last:type_ source extension.ptyext_path);
      super#type_extension extension

    method! module_expr m =
      ( match m.pmod_desc with
      | Pmod_ident lid ->
          self#add (path_spans ~last:namespace source lid)
      | _ ->
          ()
      );
      super#module_expr m

    method! module_type m =
      ( match m.pmty_desc with
      | Pmty_ident lid ->
          self#add (path_spans ~last:interface source lid)
      | Pmty_alias lid ->
          self#add (path_spans ~last:namespace source lid)
      | _ ->
          ()
      );
      super#module_type m

    method! functor_parameter parameter =
      ( match parameter with
      | Named (name, _) ->
          self#add (module_name_span source namespace name)
      | Unit ->
          ()
      );
      super#functor_parameter parameter

    method! module_binding binding =
      self#add (module_name_span source namespace binding.pmb_name);
      super#module_binding binding

    method! module_declaration declaration =
      self#add (module_name_span source namespace declaration.pmd_name);
      super#module_declaration declaration

    method! module_type_declaration declaration =
      self#add (name_at source interface declaration.pmtd_name);
      super#module_type_declaration declaration

    method! row_field field =
      ( match field.prf_desc with
      | Rtag ({ txt; loc }, _, _) ->
          self#add (variant_span source loc txt)
      | Rinherit _ ->
          ()
      );
      super#row_field field
  end

let without_warnings f =
  let warnings = Ocaml_common.Location.formatter_for_warnings in
  let saved = !warnings in
  warnings := Format.make_formatter (fun _ _ _ -> ()) ignore;
  Fun.protect ~finally:(fun () -> warnings := saved) f

let blank_shebang source =
  if String.starts_with ~prefix:"#!" source then
    let line_end =
      Option.value (String.index_opt source '\n') ~default:(String.length source)
    in
    String.make line_end ' '
    ^ String.sub source line_end (String.length source - line_end)
  else
    source

let parse source =
  let lexbuf = Lexing.from_string (blank_shebang source) in
  match without_warnings (fun () -> Parse.use_file lexbuf) with
  | phrases ->
      Ok phrases
  | exception exn -> (
      match Location.Error.of_exn exn with
      | Some error ->
          Error (Location.Error.message error)
      | None ->
          raise exn
    )

let classify source =
  Result.map
    (fun phrases ->
      let collector = new collector source in
      List.iter
        (function
          | Ptop_def structure ->
              collector#structure structure
          | Ptop_dir _ ->
              ()
          )
        phrases;
      collector#spans
    )
    (parse source)
