# Sail-gadgets
Sail Gadgets is a Gtk software to offer realtime data and tools for sailing; the software
is organized in "Gadgets", which offers new functionality adding a tab to the main notebook.
The software automatically connects to serial NMEA data source to achieve data from GPS and
other NMEA instruments.

Sail-gadgets will be compatible with broadway, so every HTML5 enabled device in the boat
can access the software interface.

![Broadway](https://raw.githubusercontent.com/dakk/sail-gadgets/master/media/broadway.jpg =250x)

## Build and start

```make``

or using broadway:

```broadwayd :5 & GDK_BACKEND=broadway BROADWAY_DISPLAY=:5 make```

then connect to: http://127.0.0.1:8085/


## Data sources
At the moment the datasource is the hardcoded /dev/ttyACM0; we will implement a customizable and
multisource feature soon.


## Planned gadgets

- dashboard: shows current position, speed, heading, tripdist, compass
- satview: shows current connected gps satellites
- wind: shows wind indicator with true / apparent speed and direction
- radar: shows AIS and Radar targets in range
- mob: allows to drop a marker in the current position, and drive you to that point
- startline: helper for regatta start
- track: shows current track in a vector map


## Implement a new gadget

Every gadget is a module with the following signature:

```ocaml
module type t = sig 
  val name: string
  (* name of the gadget, used for logging *)

  val create: Ndata.t -> GPack.notebook -> GBin.frame option
  (* [create data nb] creates the gadget, appending pages to nb; it maybe returns a settings frame *)
end
```

The create function receives a record of (react) nmea data signals (Ndata.t), the main notebook (where it
appends one or more pages) and returns an optional frame for gadget settings.


## License

```
Copyright (c) 2020 Davide Gessa

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
```