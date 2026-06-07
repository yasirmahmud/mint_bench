module curve_synth_5235_20260112_005233_352607_w44756_attempt14 (
  input [7:0] data_in,
  output [7:0] data_out_div
);

  // Parameter explicitly calculated to be zero using a right shift operation
  // that shifts a non-zero value entirely out of the bit width.
  parameter [7:0] DIVISOR_ZERO_SHIFT = 8'd100 >> 8'd8; // 100 shifted right by 8 bits results in 0

  // SYNTH_5235 violation: Division by a parameter explicitly calculated to zero.
  assign data_out_div = data_in / DIVISOR_ZERO_SHIFT;

endmodule
