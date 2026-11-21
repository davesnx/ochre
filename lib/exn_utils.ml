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
