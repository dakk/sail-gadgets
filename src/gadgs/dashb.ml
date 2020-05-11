open React;;
let name = "dashboard";;

let create (data: Util.Ndata.t) (nb:GPack.notebook) =
  let tab_label = GMisc.label ~text:"Dashboard" () in
  (* let button = GButton.button ~label:"Page 1 B"  *)
  let label = GMisc.label ~text:"Page 1 B" 
    ~packing:(fun w -> ignore (nb#append_page ~tab_label:(tab_label#coerce) w)) () in
  (* button#connect#clicked ~callback:
    (fun () -> prerr_endline "Hello again - cool button 1 was pressed") |> ignore; *)

  S.l2 (fun h s -> label#set_text @@ Printf.sprintf "HDG: %f; SPEED: %f" h s) (fst data.hdg) (fst data.sog) |> ignore;
  
  Some(GBin.frame ~label_xalign:(0.01) ~label:"Dashboard" ())
;;