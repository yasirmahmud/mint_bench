module curve_noassignx_ml_20260111_200027_127799_w47100_attempt10 (
  output reg out_signal
);

  // The previous approach using 'dummy_x_source' introduced a W123 violation
  // because the variable was read but never explicitly set.
  // To resolve the W123 violation, 'dummy_x_source' is removed.
  // The design's functional behavior of continuously assigning an 'x' value to 'out_signal'
  // is preserved by directly assigning '1'bx' to 'out_signal' within an always block.
  always @(*) begin
    out_signal = 1'bx;
  end

endmodule
