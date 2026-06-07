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

  // This assignment triggered W486 because the conceptual width of the RHS (12 bits after shift)
  // was greater than the LHS width (7 bits), indicating implicit truncation.
  // To resolve W486 while preserving functional behavior, we explicitly truncate the shifted
  // result to 7 bits using a part-select, making the truncation explicit.
  assign scaled_product_out = (product_intermediate >> 4)[6:0];

endmodule
