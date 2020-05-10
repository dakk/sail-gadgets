open Graphics;;

let draw y entries i = 
  let rec draw_entries en curx idx = match en with
  | [] -> ()
  | e::en' -> 
    let inc = 150 in
      (* String.length e * 12 + 24 in *)
    let cpos = (current_x (), current_y ()) in
    moveto (curx-8) (y);
    set_line_width 2;
    if idx = i then set_color Style.sel else set_color Style.ac;
    lineto (curx + inc - 16) (y);
    set_color Style.fg;
    moveto (fst cpos) (snd cpos);
    draw_string e;
    moveto (curx + inc) (y - 25);
    draw_entries en' (curx + inc) (idx+1)
  in
  (* set_color Style.ac;
  moveto 25 70;
  lineto (size_x () - 25) 70;
  set_color Style.fg; *)
  let sx = if i = 0 then 30 else 30 - 150 * i / 2 + 75 in
  moveto sx @@ y - 25;
  draw_entries entries sx 0
;;