module curve_synth_5235_20260110_154936_attempt2 (
  input [31:0] in_val,
  input [31:0] in_val_2,
  output [31:0] out_a,
  output [31:0] out_b
);

  // First occurrence: Division by a single-bit zero constant (sign-extended to 32 bits)
  assign out_a = in_val / 1'b0;

  // Second occurrence: Division by a 32-bit zero constant
  assign out_b = in_val_2 / 32'd0;

endmodule
