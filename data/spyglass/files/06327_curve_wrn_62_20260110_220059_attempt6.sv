module curve_wrn_62_20260110_220059_attempt6 (
  input in_a,
  input in_b,
  input [2:0] in_vec_c,
  input [3:0] in_vec_d,
  output out_x,
  output out_y
);

  // WRN_62 violation 1:
  // The 1-bit signal 'in_a' is bit-wise ORed with the result of the
  // reduction OR '|in_vec_c'. The reduction OR directly follows the
  // bit-wise OR without being enclosed in parentheses.
  assign out_x = in_a | |in_vec_c;

  // WRN_62 violation 2:
  // The result of the bit-wise AND operation '(in_b & in_a)' is bit-wise ORed
  // with the result of the reduction OR '|in_vec_d'. The reduction OR
  // directly follows the bit-wise OR without being enclosed in parentheses.
  // This violation is placed inside an 'always @*' block to demonstrate distinctness.
  always @* begin
    out_y = (in_b & in_a) | |in_vec_d;
  end

endmodule
