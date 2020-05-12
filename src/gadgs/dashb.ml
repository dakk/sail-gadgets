open React;;

let name = "dashboard";;

let create (data: Util.Ndata.t) (nb:GPack.notebook) =
  let tab_label = GMisc.label ~text:"Dashboard" () in

  let box = GPack.vbox ~spacing:0 ~packing:(fun w -> ignore (nb#append_page ~tab_label:(tab_label#coerce) w)) () in

  let label_speed = GMisc.label ~text:"Speed" ~packing:(fun w -> box#add w) () in
  let label_hdg = GMisc.label ~text:"HDG" ~packing:(fun w -> box#add w) () in
  let label_coord = GMisc.label ~text:"Coordinates" ~packing:(fun w -> box#add w) () in
	
  S.l1 (fun hdg -> label_hdg#set_text @@ Printf.sprintf "HDG: %.2f°" hdg) (fst data.hdg) |> ignore;
  S.l1 (fun sog -> label_speed#set_text @@ Printf.sprintf "Speed: %.2f kts" sog) (fst data.sog) |> ignore;
  S.l1 (fun ll -> label_coord#set_text @@ Printf.sprintf "Position: %s" @@ Nmea.Coord.to_string ll) (fst data.ll) |> ignore;
  
  Some(GBin.frame ~label_xalign:(0.01) ~label:"Dashboard" ())
;;