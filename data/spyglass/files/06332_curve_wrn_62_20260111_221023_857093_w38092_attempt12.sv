module curve_wrn_62_20260111_221023_857093_w38092_attempt12 (
  input [1:0] input_vec,
  input [9:0] wide_bus,
  input       single_bit_in,
  input [3:0] smaller_bus,
  output      out_a,
  output      out_b
);

  // WRN_62 violation 1:
  // The expression '(input_vec[0] + input_vec[1])' results in a 2-bit value
  // (due to addition), which is then implicitly truncated to 1-bit for the
  // bit-wise OR operation. The bit-wise OR operator ('|') is immediately
  // followed by a reduction OR ('|wide_bus') without the reduction OR being
  // enclosed in its own set of parentheses.
  assign out_a = (input_vec[0] + input_vec[1]) | |wide_bus;

  // WRN_62 violation 2:
  // The unary bit-wise NOT operator ('~single_bit_in') results in a 1-bit value.
  // This 1-bit result is an operand to a bit-wise OR ('|'), which is then
  // immediately followed by a reduction OR ('|smaller_bus') without the
  // required parentheses for the reduction OR.
  assign out_b = (~single_bit_in) | |smaller_bus;

endmodule
