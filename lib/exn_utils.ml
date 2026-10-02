(* Internal helper, not re-exported via ochre.mli: every `_exn` loader in this
   library should raise exactly `Failure`, never a raw exception from the
   library it delegates to (Yojson, Sys, ...). Wrap the loader's body in this
   instead of repeating the same try/with in each one. *)
let wrap_exn f =
  try f () with
  | Failure _ as exn ->
      raise exn
  | Sys_error msg ->
      failwith msg
  | (Out_of_memory | Stack_overflow | Sys.Break) as exn ->
      raise exn
  | exn ->
      failwith (Printexc.to_string exn)
