module test_wrn_62 (
  input [1:0] in_a,
  input [2:0] in_b,
  output [1:0] out_c
);

  // WRN_62: Use parentheses with reduction OR following bit-wise OR
  // The reduction OR (|in_b) is an operand to the bit-wise OR (|).
  // Since 'in_a' is multi-bit, the operator '|' acts as a bit-wise OR.
  // SpyGlass expects explicit parentheses around the reduction OR, e.g., in_a | (|in_b).
  assign out_c = in_a | |in_b;

endmodule
