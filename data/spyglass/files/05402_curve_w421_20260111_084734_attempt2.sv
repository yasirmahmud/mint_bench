`timescale 1ns/1ps
module curve_w421_20260111_084734_attempt2 ();

  // W421: No event control (@) in always block
  // This always block uses a delay control (#1) instead of an event control (@* or @posedge clk).
  // The 'null statement' (;) within the always block ensures no hardware is implied,
  // thus avoiding synthesis warnings like SYNTH_5166 or warnings about uninitialized registers,
  // unused signals, or multiple drivers. It also avoids latches and implicit nets.
  // The `timescale directive prevents the CheckDelayTimescale-ML warning.
  always #1;

endmodule
