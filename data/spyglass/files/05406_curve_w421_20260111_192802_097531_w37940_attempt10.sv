`timescale 1ns/1ps

module curve_w421_20260111_192802_097531_w37940_attempt10 (
  output reg result
);

  // W421 violation: No event control (@) in always block.
  // This 'always' block uses a timing control (#7) but lacks an event control list.
  // It avoids other common violations by driving a single output with a constant value after a delay.
  always #7 result = 1'b0;

endmodule
