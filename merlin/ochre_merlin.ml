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

let scalar_count source start stop =
  let stop = min stop (String.length source) in
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
  count start 0

let positions source =
  let length = String.length source in
  let line_starts =
    List.init length Fun.id
    |> List.filter_map (fun i ->
        if source.[i] = '\n' then
          Some (i + 1)
        else
          None
    )
    |> List.cons 0 |> Array.of_list
  in
  fun (p : Lexing.position) ->
    let offset = max 0 (min p.pos_cnum length) in
    let rec search low high =
      if low >= high then
        low
      else
        let mid = (low + high + 1) / 2 in
        if line_starts.(mid) <= offset then
          search mid high
        else
          search low (mid - 1)
    in
    let line = search 0 (Array.length line_starts - 1) in
    Ochre.Decoration.pos line (scalar_count source line_starts.(line) offset)

let config load_path =
  let initial = Mconfig.initial in
  {
    initial with
    ocaml = { initial.ocaml with include_dirs = load_path };
    query =
      { initial.query with filename = "snippet.ml"; directory = Sys.getcwd () };
  }

let print_in env printer value =
  Type_utils.Printtyp.wrap_printing_env env ~verbosity:Mconfig.Verbosity.default
    (fun () -> Format.asprintf "%a" printer value
  )

let print_type env ty = print_in env (Type_utils.Printtyp.type_scheme env) ty

let print_constructor env desc =
  print_in env
    (Type_utils.print_constr ~verbosity:Mconfig.Verbosity.default env)
    desc

let decoration ?class_ ~data ~start ~end_ () =
  Ochre.Decoration.make ?class_ ~data ~start ~end_ ()
  |> Result.map_error (fun error ->
      { severity = Error; start; end_; message = Ochre.Error.to_string error }
  )

let type_decorations position typedtree =
  let found = ref [] in
  let add (loc : Location.t) printed =
    if not loc.loc_ghost then
      found :=
        decoration
          ~data:[ ("ochre-type", printed) ]
          ~start:(position loc.loc_start) ~end_:(position loc.loc_end) ()
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

let diagnostic position (report : Location.report) =
  let loc = Location.loc_of_report report in
  let main = Format.asprintf "@[%a@]" Location.print_main report in
  let subs =
    List.map (Format.asprintf "@[%a@]" Location.print_sub_msg) report.sub
  in
  let message = String.concat "\n" (List.map String.trim (main :: subs)) in
  {
    severity = severity report message;
    start = position loc.loc_start;
    end_ = position loc.loc_end;
    message;
  }

let visible_range line_lengths d =
  let length line =
    if line >= 0 && line < Array.length line_lengths then
      line_lengths.(line)
    else
      0
  in
  let rec last_character line =
    if line < 0 then
      (d.start, d.end_)
    else
      match length line with
      | 0 ->
          last_character (line - 1)
      | n ->
          (Ochre.Decoration.pos line (n - 1), Ochre.Decoration.pos line n)
  in
  let { Ochre.Decoration.line; character } = d.start in
  if d.start <> d.end_ then
    (d.start, d.end_)
  else if character < length line then
    (d.start, Ochre.Decoration.pos line (character + 1))
  else
    last_character line

let segment_decoration start end_ covering =
  let class_ =
    if List.exists (fun d -> d.severity = Error) covering then
      "ochre-error"
    else
      "ochre-warning"
  in
  let message = String.concat "\n\n" (List.map (fun d -> d.message) covering) in
  decoration ~class_ ~data:[ ("ochre-diagnostic", message) ] ~start ~end_ ()

let diagnostic_decorations source diagnostics =
  let line_lengths =
    String.split_on_char '\n' source
    |> List.map (fun line -> scalar_count line 0 (String.length line))
    |> Array.of_list
  in
  let ranges =
    List.map (fun d -> (visible_range line_lengths d, d)) diagnostics
  in
  let points =
    List.sort_uniq compare
      (List.concat_map (fun ((start, end_), _) -> [ start; end_ ]) ranges)
  in
  let rec segments = function
    | start :: (end_ :: _ as rest) -> (
        let covering =
          List.filter_map
            (fun ((s, e), d) ->
              if compare s start <= 0 && compare end_ e <= 0 then
                Some d
              else
                None
            )
            ranges
        in
        match covering with
        | [] ->
            segments rest
        | _ ->
            segment_decoration start end_ covering :: segments rest
      )
    | _ ->
        []
  in
  segments points

let analyze ?(load_path = []) source =
  let pipeline = Mpipeline.make (config load_path) (Msource.make source) in
  let position = positions source in
  Mpipeline.with_pipeline pipeline (fun () ->
      let typedtree = Mtyper.get_typedtree (Mpipeline.typer_result pipeline) in
      let diagnostics =
        Query_commands.dispatch pipeline
          (Errors { lexing = true; parsing = true; typing = true })
        |> List.map (diagnostic position)
      in
      let decorations, rejected =
        List.partition_map
          (function Ok d -> Either.Left d | Error d -> Either.Right d)
          (type_decorations position typedtree
          @ diagnostic_decorations source diagnostics
          )
      in
      { decorations; diagnostics = diagnostics @ rejected }
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
