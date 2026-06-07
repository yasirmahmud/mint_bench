module curve_wrn_62_20260112_011126_551249_w44756_attempt14 (
  input in_c,
  input in_d,
  input [2:0] vec_c,
  input [3:0] data_in_val,
  input [4:0] vec_d,
  output result1,
  output result2
);

  // WRN_62 violation 1:
  // A bit-wise OR operator ('|') is immediately followed by a reduction OR ('|vec_c')
  // without the reduction OR being enclosed in its own set of parentheses.
  // The left-hand operand is a bit-wise XOR expression `(in_c ^ in_d)`.
  assign result1 = (in_c ^ in_d) | |vec_c;

  // WRN_62 violation 2:
  // A bit-wise OR operator ('|') is immediately followed by a reduction OR ('|vec_d')
  // without the reduction OR being enclosed in its own set of parentheses.
  // The left-hand operand is a right-shift operation `(data_in_val >> 1)`.
  assign result2 = (data_in_val >> 1) | |vec_d;

endmodule
