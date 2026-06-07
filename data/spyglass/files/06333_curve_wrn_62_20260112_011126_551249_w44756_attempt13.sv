module curve_wrn_62_20260112_011126_551249_w44756_attempt13 (
  input in_a,
  input in_b,
  input [3:0] vec_a,
  input [1:0] val_x,
  input [1:0] val_y,
  input [7:0] vec_b,
  output result1,
  output result2
);

  // WRN_62 violation 1:
  // A bit-wise OR operator ('|') is immediately followed by a reduction OR ('|vec_a')
  // without the reduction OR being enclosed in its own set of parentheses.
  // The left-hand operand is a logical AND expression.
  assign result1 = (in_a && in_b) | |vec_a;

  // WRN_62 violation 2:
  // A bit-wise OR operator ('|') is immediately followed by a reduction OR ('|vec_b')
  // without the reduction OR being enclosed in its own set of parentheses.
  // The left-hand operand is an equality comparison.
  assign result2 = (val_x == val_y) | |vec_b;

endmodule
