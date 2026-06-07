module curve_wrn_62_20260111_221023_857093_w38092_attempt11 (
  input [3:0] data_in,
  input       select,
  input [7:0] bus_a,
  input       enable,
  input [1:0] input_val,
  input [3:0] bus_b,
  output      out1,
  output      out2
);

  // WRN_62 violation 1:
  // The reduction OR '|bus_a' immediately follows a bit-wise OR operator ('|')
  // without being enclosed in its own set of parentheses. The expression
  // '(data_in[3] ^ select)' provides the left-hand operand for the bit-wise OR.
  assign out1 = (data_in[3] ^ select) | |bus_a;

  // WRN_62 violation 2:
  // Similarly, the reduction OR '|bus_b' immediately follows a bit-wise OR operator ('|')
  // without being enclosed in parentheses. The conditional expression
  // '(enable ? input_val[0] : input_val[1])' provides the left-hand operand.
  assign out2 = (enable ? input_val[0] : input_val[1]) | |bus_b;

endmodule
