`timescale 1ns/1ps

module curve_w421_20260111_084734_attempt5 (
  output reg out_val
);

  // W421: No event control (@) in always block.
  // This always block uses a delay control (#10) but lacks an event control (@).
  // 'out_val' is declared as an output, which ensures it is considered 'read',
  // thus resolving the W528 (variable set but not read) violation from the previous attempt.
  // The constant assignment to 1'b0 prevents combinational loops or uninitialized value issues
  // and avoids other unintended violations.
  always #10 out_val = 1'b0;

endmodule
