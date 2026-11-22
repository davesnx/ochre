open Ocaml_parsing
open Ocaml_typing
open Merlin_kernel
open Merlin_analysis

type severity = Error | Warning

type diagnostic = {
  severity : severity;
  start : Ochre.Decoration.position;
  end_ : Ochre.Decoration.position;
  message : string;
}

type t = {
  decorations : Ochre.Decoration.t list;
  diagnostics : diagnostic list;
}

let position source (p : Lexing.position) =
  if p.pos_lnum < 1 || p.pos_cnum < 0 then
    Ochre.Decoration.pos 0 0
  else
    let stop = min p.pos_cnum (String.length source) in
    let rec count offset acc =
      if offset >= stop then
        acc
      else
        let decoded = String.get_utf_8_uchar source offset in
        let length =
          if Uchar.utf_decode_is_valid decoded then
            Uchar.utf_decode_length decoded
          else
            1
        in
        count (offset + length) (acc + 1)
    in
    Ochre.Decoration.pos (p.pos_lnum - 1) (count p.pos_bol 0)

let config load_path =
  let initial = Mconfig.initial in
  {
    initial with
    ocaml = { initial.ocaml with include_dirs = load_path };
    query =
      { initial.query with filename = "snippet.ml"; directory = Sys.getcwd () };
  }

let print_type env ty =
  Format.asprintf "%a" (Type_utils.Printtyp.type_scheme env) ty

let print_constructor env desc =
  Format.asprintf "%a"
    (Type_utils.print_constr ~verbosity:Mconfig.Verbosity.default env)
    desc

let type_decorations source typedtree =
  let found = ref [] in
  let add (loc : Location.t) printed =
    if not loc.loc_ghost then
      found :=
        Ochre.Decoration.make
          ~data:[ ("ochre-type", printed) ]
          ~start:(position source loc.loc_start)
          ~end_:(position source loc.loc_end)
          ()
        :: !found
  in
  let expr sub (e : Typedtree.expression) =
    ( match e.exp_desc with
    | _ when Mbrowse.is_recovered_expression e ->
        ()
    | Texp_ident (_, lid, desc) ->
        add lid.loc (print_type e.exp_env desc.val_type)
    | Texp_construct (lid, desc, _) ->
        add lid.loc (print_constructor e.exp_env desc)
    | Texp_field (_, lid, _) ->
        add lid.loc (print_type e.exp_env e.exp_type)
    | _ ->
        ()
    );
    Tast_iterator.default_iterator.expr sub e
  in
  let pat : type k. _ -> k Typedtree.general_pattern -> unit =
   fun sub p ->
    ( match p.pat_desc with
    | Tpat_var (_, name, _) | Tpat_alias (_, _, name, _, _) ->
        add name.loc (print_type p.pat_env p.pat_type)
    | Tpat_construct (lid, desc, _, _) ->
        add lid.loc (print_constructor p.pat_env desc)
    | _ ->
        ()
    );
    Tast_iterator.default_iterator.pat sub p
  in
  let iterator = { Tast_iterator.default_iterator with expr; pat } in
  ( match typedtree with
  | `Implementation structure ->
      iterator.structure iterator structure
  | `Interface signature ->
      iterator.signature iterator signature
  );
  List.rev !found

let severity (report : Location.report) message =
  match report.source with
  | Warning when not (String.starts_with ~prefix:"Error" message) ->
      Warning
  | _ ->
      Error

let diagnostic source (report : Location.report) =
  let loc = Location.loc_of_report report in
  let message =
    String.trim (Format.asprintf "@[%a@]" Location.print_main report)
  in
  {
    severity = severity report message;
    start = position source loc.loc_start;
    end_ = position source loc.loc_end;
    message;
  }

let diagnostic_decoration d =
  let class_ =
    match d.severity with Error -> "ochre-error" | Warning -> "ochre-warning"
  in
  Ochre.Decoration.make ~class_
    ~data:[ ("ochre-diagnostic", d.message) ]
    ~start:d.start ~end_:d.end_ ()

let analyze ?(load_path = []) source =
  let pipeline = Mpipeline.make (config load_path) (Msource.make source) in
  Mpipeline.with_pipeline pipeline (fun () ->
      let typedtree = Mtyper.get_typedtree (Mpipeline.typer_result pipeline) in
      let diagnostics =
        Query_commands.dispatch pipeline
          (Errors { lexing = true; parsing = true; typing = true })
        |> List.map (diagnostic source)
      in
      {
        decorations =
          type_decorations source typedtree
          @ List.map diagnostic_decoration diagnostics;
        diagnostics;
      }
  )

let css =
  {|[data-ochre-type],
[data-ochre-diagnostic] {
  position: relative;
}
[data-ochre-type]:hover::after,
[data-ochre-diagnostic]:hover::before {
  position: absolute;
  left: 0;
  z-index: 1;
  padding: 0.25em 0.5em;
  border-radius: 4px;
  font-size: 0.85em;
  white-space: pre-wrap;
  width: max-content;
  max-width: 60ch;
  pointer-events: none;
  color: var(--ochre-tooltip-fg, #f0f0f0);
  background: var(--ochre-tooltip-bg, #2b2b2b);
}
[data-ochre-type]:hover::after {
  content: attr(data-ochre-type);
  top: 100%;
}
[data-ochre-diagnostic]:hover::before {
  content: attr(data-ochre-diagnostic);
  bottom: 100%;
}
.ochre-error {
  text-decoration: underline wavy #e5484d;
}
.ochre-warning {
  text-decoration: underline wavy #f5a524;
}
|}
