module curve_w486_20260111_085258_attempt5 (
  input wire [5:0] factor1_in,
  input wire [5:0] factor2_in,
  output wire [6:0] scaled_product_out
);

  // Intermediate wire to store the product of factor1_in and factor2_in.
  // The product of two 6-bit unsigned numbers (max 63 * 63 = 3969)
  // requires 12 bits (2^11 = 2048, 2^12 = 4096). Therefore, product_intermediate is 12 bits.
  wire [11:0] product_intermediate;
  assign product_intermediate = factor1_in * factor2_in;

  // This assignment triggers W486.
  // The 'product_intermediate' is 12 bits wide. When it is shifted right by 4,
  // the expression '(product_intermediate >> 4)' conceptually retains the original width (12 bits)
  // for the purpose of the W486 rule check, even though the value range might be reduced.
  // Assigning this 12-bit RHS to the 7-bit 'scaled_product_out' LHS triggers the W486 violation,
  // as the RHS width (12) with a shift is greater than the LHS width (7),
  // indicating a potential overflow or truncation during the assignment.
  assign scaled_product_out = product_intermediate >> 4;

endmodule
