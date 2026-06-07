module curve_synth_5235_20260111_175750_339064_w47100_attempt9 (
  input [7:0] in_a,
  input [7:0] in_b,
  output [7:0] out_div_a,
  output [7:0] out_div_b
);

  localparam EIGHT_BIT_ZERO = 8'd0;

  assign out_div_a = in_a / EIGHT_BIT_ZERO;
  assign out_div_b = in_b / 8'h0;

endmodule
