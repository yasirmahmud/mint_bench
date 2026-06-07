module curve_wrn_63_20260110_220754_attempt5 (
  input wire [7:0] in_numerator,
  output wire [7:0] out_result_1,
  output wire [7:0] out_result_2
);

  // WRN_63 occurrence 1: Direct division by constant zero.
  assign out_result_1 = in_numerator / 8'd0;

  // WRN_63 occurrence 2: Another direct division by constant zero.
  assign out_result_2 = in_numerator / 8'd0;

endmodule
