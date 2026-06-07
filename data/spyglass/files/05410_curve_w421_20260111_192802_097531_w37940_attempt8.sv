`timescale 1ns/1ps

module curve_w421_20260111_192802_097531_w37940_attempt8 (
  output reg toggle_val
);

  // W421 violation: No event control (@) in always block.
  // This 'always' block uses a timing control (#10) but lacks an event control list.
  // It creates a free-running oscillator without being triggered by a clock or other event.
  always #10 toggle_val = ~toggle_val;

endmodule
