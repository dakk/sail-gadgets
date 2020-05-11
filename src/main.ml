let gadgets: ((module Util.Gadg.t) list) = [
  (module Gadgs.Dashb)
];;

let fakedata = Util.Ndata.fake ();;

let main () =
  GMain.init () |> ignore;
  let window = GWindow.window ~title:"Sail Gadgets" ~border_width:10 () in
  window#connect#destroy ~callback:GMain.quit |> ignore;
  let notebook = GPack.notebook ~packing:window#add () in

  List.iter (fun (module T: Util.Gadg.t) -> (
    Printf.printf "Loading gadget %s\n%!" T.name;
    T.create fakedata notebook
  )) gadgets;

  window#show ();

  (snd fakedata.hdg) 3.0;
  GMain.main ()

let _ = main ()