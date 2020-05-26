let gadgets: ((module Util.Gadg.t) list) = [
	(module Gadgs.Dashb);
	(module Gadgs.Satview)
];;

let data = Util.Ndata.empty ();;

let settings_general () =
  let b = GBin.frame ~label_xalign:(0.01) ~label:"General" () in
  let bnmi = GBin.frame ~border_width:5 ~label_xalign:(0.01) ~label:"NMEA Inputs" () in
  b#add bnmi#coerce;
  b
;;

let main () =
  GMain.init () |> ignore;
  let window = GWindow.window ~width:800 ~height:400 ~title:"Sail Gadgets" ~border_width:10 () in
  window#connect#destroy ~callback:GMain.quit |> ignore;

  let mbox = GPack.vbox ~spacing:0 () in
  mbox#set_homogeneous false;
  let notebook = GPack.notebook ~packing:mbox#add () in
  notebook#set_vexpand true;
  (* let statusbar = GMisc.label ~text:"Statusbar" ~packing:mbox#add () in *)
  window#add mbox#coerce; 

  (* create gadgets *)
  let settings = List.map (fun (module T: Util.Gadg.t) -> (
    Printf.printf "Loading gadget %s\n%!" T.name;
    T.create data notebook
  )) gadgets in

  (* create settings page *)
  let sett_lab = GMisc.label ~text:"Settings" () in
  let sett_box = GPack.vbox ~border_width:5 ~packing:(fun w -> ignore (notebook#append_page ~tab_label:(sett_lab#coerce) w)) () in

  (* general settings *)
  let sett_general = settings_general () in
  sett_box#add sett_general#coerce;

  (* gadget related settings *)
  List.iter (fun b -> match b with 
      Some(b') -> sett_box#add b'#coerce
    | None -> ()
  ) settings;

  window#show ();

  Thread.create Util.Ndata.polling data |> ignore;

  GMain.main ()
;;

let _ = main ()