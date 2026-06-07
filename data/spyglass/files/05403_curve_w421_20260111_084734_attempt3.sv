`timescale 1ns/1ps

module curve_w421_20260111_084734_attempt3 ();

  // Declare a register for the always block to drive.
  // It's initialized to avoid X-propagation issues in simulation,
  // though not strictly required for the W421 violation.
  reg my_toggle_signal = 1'b0;

  // W421: No event control (@) in always block
  // This always block uses a delay control (#10) instead of an event control (@* or @posedge clk).
  // It creates a free-running oscillation for 'my_toggle_signal'.
  // The `timescale directive prevents the CheckDelayTimescale-ML warning.
  always #10 my_toggle_signal = ~my_toggle_signal;

endmodule
