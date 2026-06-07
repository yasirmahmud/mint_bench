module curve_wrn_62_20260110_220059_attempt4 (
  input in_a,
  input [2:0] in_b,
  input [3:0] in_c,
  output out_d,
  output out_e
);

  // WRN_62 violation 1:
  // The first '|' acts as a bit-wise OR between 'in_a' (1-bit) and
  // the result of '|in_b' (1-bit reduction OR). The reduction OR '|in_b'
  // directly follows the bit-wise OR without being enclosed in parentheses.
  assign out_d = in_a | |in_b;

  // WRN_62 violation 2:
  // Similarly, the first '|' is a bit-wise OR between '1'b0' (1-bit) and
  // the result of '|in_c' (1-bit reduction OR). The reduction OR '|in_c'
  // directly follows the bit-wise OR without being enclosed in parentheses.
  assign out_e = 1'b0 | |in_c;

endmodule
