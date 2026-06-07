module curve_w486_20260111_085258_attempt3 (
  input wire [3:0] factor_a,
  input wire [3:0] factor_b,
  output wire [3:0] scaled_result
);

  // Intermediate wire to store the product of factor_a and factor_b.
  // A 4-bit by 4-bit multiplication can result in an 8-bit value (e.g., 15 * 15 = 225).
  // Declaring intermediate_product as 8 bits wide captures the full product.
  wire [7:0] intermediate_product;
  assign intermediate_product = factor_a * factor_b;

  // The 'intermediate_product' is 8 bits wide. When it is shifted right by 2,
  // the expression '(intermediate_product >> 2)' still has a conceptual width of 8 bits.
  // Assigning this 8-bit RHS to the 4-bit 'scaled_result' LHS triggers the W486 violation,
  // as the RHS width (8) with a shift is greater than the LHS width (4), potentially causing overflow.
  assign scaled_result = intermediate_product >> 2;

endmodule
