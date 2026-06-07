module curve_wrn_62_20260110_220059_attempt5 (
  input in_a,
  input [2:0] in_b,
  input [3:0] in_c,
  output out_d,
  output out_e
);

  // WRN_62 violation 1:
  // The expression 'in_c[2]' (1-bit) is bit-wise ORed with the
  // result of the reduction OR '|in_b' (1-bit). The reduction OR '|in_b'
  // directly follows the bit-wise OR without being enclosed in parentheses.
  assign out_d = in_c[2] | |in_b;

  // WRN_62 violation 2:
  // The result of the expression '(in_a & in_b[0])' (1-bit) is bit-wise ORed with the
  // result of the reduction OR '|in_c' (1-bit). The reduction OR '|in_c'
  // directly follows the bit-wise OR without being enclosed in parentheses.
  assign out_e = (in_a & in_b[0]) | |in_c;

endmodule
