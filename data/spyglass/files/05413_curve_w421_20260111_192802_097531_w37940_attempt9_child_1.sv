`timescale 1ns/1ps

module curve_w421_20260111_192802_097531_w37940_attempt9 (
  output reg out_val
);

  // W421 violation: No event control (@) in always block.
  // This 'always' block uses a timing control (#10) but lacks an event control list.
  // It avoids combinational loops (CombLoop) and sensitivity list warnings (W122)
  // by assigning a constant value after a delay, instead of reading its own value.
  // 
  // Fix: Changed 'always' block to an 'initial' block to resolve W421, as the
  // behavior is a one-time delayed assignment, typically for simulation initialization.
  initial begin #10 out_val = 1'b1; end

endmodule
