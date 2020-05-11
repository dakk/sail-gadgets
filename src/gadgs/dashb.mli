val name: string
(* name of the gadget, used as reference *)

val create: Util.Ndata.t -> GPack.notebook -> unit
(* [create data nb] creates the gadget, appending pages to nb *)