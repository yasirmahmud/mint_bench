module curve_wrn_62_20260111_181456_331007_w36056_attempt8 (
  input wire scalar_a,
  input wire [3:0] vector_b,
  output wire out_s
);

  // WRN_62: Use parentheses with reduction OR following bit-wise OR
  // This triggers a single WRN_62 violation because a reduction OR (`|vector_b`)
  // is used as the right-hand operand of a binary bit-wise OR (`|`) without explicit parentheses.
  // This pattern `1-bit_signal | |multi_bit_vector` is consistent with Example 2
  // where `Drdy | |rnd[9:1]` triggered the violation.
  assign out_s = scalar_a | |vector_b;

endmodule
