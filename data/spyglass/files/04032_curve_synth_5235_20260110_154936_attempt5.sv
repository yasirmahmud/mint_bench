module curve_synth_5235_20260110_154936_attempt5 (
  input [7:0] in_a,
  input [7:0] in_b,
  output [7:0] out_c,
  output [7:0] out_d
);

  // SYNTH_5235: Division by zero is illegal.
  // This directly assigns the result of a division by a static zero constant.
  assign out_c = in_a / 8'd0;

  // SYNTH_5235: Division by zero is illegal.
  // This provides a second, distinct instance of division by a static zero.
  assign out_d = in_b / 8'd0;

endmodule
