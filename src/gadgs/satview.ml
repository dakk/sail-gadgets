open React;;
open Nmea;;
open Gobject.Data;;

let name = "satview";;


let cols = new GTree.column_list
let prn = cols#add string
let elev = cols#add string
let azim = cols#add string
let sndr = cols#add string
let store = GTree.tree_store cols;;

let update_model (sl: Sentence.sat list) =
	store#clear ();
	let rec ite sl = match sl with 
	  [] -> store
	| (s: Sentence.sat)::sl' -> (
		let row = store#append () in
		store#set ~row ~column:prn @@ Printf.sprintf "%d" s.prn;
		store#set ~row ~column:elev @@ Printf.sprintf "%d" s.elev_dgr;
		store#set ~row ~column:azim @@ Printf.sprintf "%d" s.azimuth;
		store#set ~row ~column:sndr @@ Printf.sprintf "%d" s.snr_db;
		ite sl'
	) in ite sl;
;;
	
let create (data: Util.Ndata.t) (nb:GPack.notebook) =
  let tab_label = GMisc.label ~text:"Sat View" () in

  let box = GPack.hbox ~spacing:0 ~packing:(fun w -> ignore (nb#append_page ~tab_label:(tab_label#coerce) w)) () in
  let view = GTree.view ~model:store ~packing:box#add () in
  let col = GTree.view_column ~title:"PRN" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",prn]) in
  view#append_column col |> ignore;
  let col = GTree.view_column ~title:"Elevation (degree)" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",elev]) in
  view#append_column col |> ignore;
  let col = GTree.view_column ~title:"Azimuth" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",azim]) in
  view#append_column col |> ignore;
  let col = GTree.view_column ~title:"SND (db)" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",sndr]) in
  view#append_column col |> ignore;

  S.l1 (fun (sats: Sentence.sat list ) -> update_model sats) (fst data.sats) |> ignore;
  None
;;