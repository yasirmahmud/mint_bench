module curve_wrn_62_20260110_220059_attempt3 (
  input [1:0] in_a,
  input [2:0] in_b,
  output [1:0] out_d
);

  // WRN_62: Use parentheses with reduction OR following bit-wise OR
  // The '|' operator acts as a bit-wise OR because 'in_a' is a multi-bit signal
  // and '|in_b' (a 1-bit reduction OR) is zero-extended to match 'in_a's width.
  // The reduction OR expression '|in_b' is a direct operand to the bit-wise OR
  // and is not enclosed in explicit parentheses, triggering the violation.
  assign out_d = in_a | |in_b;

endmodule
