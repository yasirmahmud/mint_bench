module curve_synth_5235_20260111_220322_596091_w38092_attempt11 (
  input [7:0] data_in,
  output [7:0] data_out_div
);

  // SYNTH_5235 violation: Division by zero is illegal.
  // The localparam 'ZERO_DIVISOR_CALC' evaluates to 8'd0 at compile time (10 - 10 = 0).
  localparam [7:0] ZERO_DIVISOR_CALC = 8'd10 - 8'd10;

  assign data_out_div = data_in / ZERO_DIVISOR_CALC;

endmodule
