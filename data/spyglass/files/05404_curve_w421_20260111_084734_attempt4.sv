`timescale 1ns/1ps

module curve_w421_20260111_084734_attempt4 ();

  // Declare a register to be driven by the always block.
  // No initial assignment to prevent SYNTH_89 warning.
  reg my_signal_state;

  // W421: No event control (@) in always block
  // This always block uses a delay control (#20) instead of an event control (@* or @posedge clk).
  // It assigns a constant value to 'my_signal_state' to avoid a combinational loop (CombLoop violation).
  always #20 my_signal_state = 1'b1;

endmodule
