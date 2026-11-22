type t = {
  themes : (string * Theme.theme) * (string * Theme.theme) list;
  lines : Token.t list list;
}

let select label themed =
  let default, extras = themed.themes in
  let indexed = List.mapi (fun i theme -> (i, theme)) (default :: extras) in
  match List.find_opt (fun (_, (name, _)) -> name = label) indexed with
  | None ->
      Error (Error.Unknown_theme_label label)
  | Some (index, chosen) ->
      let others = List.filter (fun (i, _) -> i <> index) indexed in
      let order = Array.of_list (index :: List.map fst others) in
      Ok
        {
          themes = (chosen, List.map snd others);
          lines = List.map (List.map (Token.reorder_styles order)) themed.lines;
        }
