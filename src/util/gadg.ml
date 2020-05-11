module type t = sig 
  val name: string
  (* name of the gadget, used as reference *)

  val create: Ndata.t -> GPack.notebook -> GBin.frame option
  (* [create data nb] creates the gadget, appending pages to nb; it maybe returns a settings frame *)
end