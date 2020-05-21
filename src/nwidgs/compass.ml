open Cairo;;

let pi2 = 8. *. atan 1.;;

class compass_widget ?packing ?show () =
  let da = GMisc.drawing_area ?packing ?show () in
  object (self)
    inherit GObj.widget da#as_widget

    val mutable hdg = 0.5

    method set_heading h =
      hdg <- h;
      self#misc#queue_draw ()

    method draw cr =
      let allocation = self#misc#allocation in
      let width = float allocation.Gtk.width in
      let height = float allocation.Gtk.height in

      let r = 0.25 *. width in
      set_source_rgba cr 0. 1. 0. opac;
      arc cr (0.5 *. width) (0.35 *. height) ~r ~a1:0. ~a2:pi2;
      fill cr;
      set_source_rgba cr 1. 0. 0. opac;
      arc cr (0.35 *. width) (0.65 *. height) ~r ~a1:0. ~a2:pi2;
      fill cr;
      set_source_rgba cr 0. 0. 1. opac;
      arc cr (0.65 *. width) (0.65 *. height) ~r ~a1:0. ~a2:pi2;
      fill cr;
      
      true

    initializer
      self#misc#connect#draw ~callback:(self#draw) |> ignore
end
