module curve_wrn_63_20260110_220754_attempt1 (
  input wire [7:0] in_data,
  output wire [7:0] out_result
);

  // WRN_63: Division by zero in an expression
  assign out_result = in_data / 8'd0;

endmodule
