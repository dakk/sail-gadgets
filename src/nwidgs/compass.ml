open Cairo;;

let pi2 = 8. *. atan 1.;;
let dtor d =  (d -. 90.) *. (3.14 /. 180.);;

class compass_widget ?packing ?show () =
  let da = GMisc.drawing_area ?packing ?show () in
  object (self)
    inherit GObj.widget da#as_widget

    val mutable hdg = 0.0

    method set_heading h =
      hdg <- h;
      self#misc#queue_draw ()

    method draw cr =
      let allocation = self#misc#allocation in
      let width = float allocation.Gtk.width in
      let height = float allocation.Gtk.height in

      let r = 0.45 *. width in
      set_line_width cr 7.0;
      set_source_rgba cr 0.9 (165. /. 255.) 0. 0.9;
      arc cr (width /. 2.0) (height /. 2.0) ~r ~a1:0. ~a2:pi2;
      stroke cr;
      set_source_rgba cr 0.9 0. 0. 0.9;
      arc cr (width /. 2.0) (height /. 2.0) ~r ~a1:(dtor @@ hdg -. 3.) ~a2:(dtor @@ hdg +. 3.);
      stroke cr;
      
      true

    initializer
      self#misc#connect#draw ~callback:(self#draw) |> ignore
end
