open Cairo;;

let pi2 = 8. *. atan 1.;;
let dtor d =  (d -. 90.) *. (3.14 /. 180.);;

class number_widget ?packing ?show () =
  let da = GMisc.drawing_area ?packing ?show () in
  object (self)
    inherit GObj.widget da#as_widget

    val mutable value = ""
    val mutable title = ""

    method set_title t =
      title <- t;
      self#misc#queue_draw ()

    method set_value v =
      value <- v;
      self#misc#queue_draw ()

    method draw cr =
      let allocation = self#misc#allocation in
      let width = float allocation.Gtk.width in
      let height = float allocation.Gtk.height in

      set_source_rgba cr 0.9 (165. /. 255.) 0. 0.9;
      move_to cr 100. 100.;
      set_font_size cr 24.;
      show_text cr title;
      stroke cr;

      set_source_rgba cr 0.9 (165. /. 255.) 0. 0.9;
      move_to cr 100. 100.;
      set_font_size cr 24.;
      show_text cr value;
      stroke cr;
      
      true

    initializer
      self#misc#connect#draw ~callback:(self#draw) |> ignore
end
