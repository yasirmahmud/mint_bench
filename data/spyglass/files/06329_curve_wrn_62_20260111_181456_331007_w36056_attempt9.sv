module curve_wrn_62_20260111_181456_331007_w36056_attempt9 (
  input wire input_a,
  input wire [4:0] input_vec,
  input wire input_b,
  output wire out_s
);

  // WRN_62: Use parentheses with reduction OR following bit-wise OR
  // This triggers a single WRN_62 violation because a reduction OR (`|input_vec`)
  // immediately follows a binary bit-wise OR (`input_a | ...`) without explicit parentheses.
  // The expression `input_a | |input_vec | input_b` is structurally similar to Example 2
  // (`Drdy | |rnd[9:1] | sel`), which also triggered one WRN_62 violation.
  assign out_s = input_a | |input_vec | input_b;

endmodule
