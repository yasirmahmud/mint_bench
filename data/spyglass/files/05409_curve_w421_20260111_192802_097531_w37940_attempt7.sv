`timescale 1ns/1ps

module curve_w421_20260111_192802_097531_w37940_attempt7 (
  output reg output_val
);

  // W421 violation: No event control (@) in always block.
  // This 'always' block uses a timing control (#5) but lacks an event control list.
  // It drives 'output_val' after a delay without being triggered by an event.
  always #5 begin
    output_val = 1'b1;
  end

endmodule
