module curve_wrn_62_20260111_181456_331007_w36056_attempt10 (
  input wire input_a,
  input wire input_b,
  input wire [3:0] input_vec,
  output wire out_s
);

  // WRN_62: Use parentheses with reduction OR following bit-wise OR
  // This triggers a single WRN_62 violation because a reduction OR (`|input_vec`)
  // immediately follows a binary bit-wise OR (`(input_a & input_b) | ...`)
  // without explicit parentheses. The expression `(input_a & input_b) | |input_vec`
  // demonstrates the core issue: a bit-wise OR has a reduction OR as its right-hand operand
  // without the reduction OR being enclosed in its own set of parentheses.
  assign out_s = (input_a & input_b) | |input_vec;

endmodule
