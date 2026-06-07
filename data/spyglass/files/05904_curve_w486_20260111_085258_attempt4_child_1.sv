module curve_w486_20260111_085258_attempt4 (
  input wire [7:0] data_a,
  input wire [7:0] data_b,
  output wire [5:0] scaled_sum
);

  // Intermediate wire to store the sum of data_a and data_b.
  // The sum of two 8-bit unsigned numbers can be up to 255 + 255 = 510,
  // which requires 9 bits (e.g., 9'b1_1111_1110 for 510).
  // Declaring sum_intermediate as 9 bits wide correctly captures the full sum.
  wire [8:0] sum_intermediate;
  assign sum_intermediate = data_a + data_b;

  // The 'sum_intermediate' is 9 bits wide. When it is shifted right by 2,
  // the expression '(sum_intermediate >> 2)' retains a conceptual width of 9 bits.
  // Assigning this 9-bit RHS to the 6-bit 'scaled_sum' LHS originally triggered the W486 violation,
  // as the RHS width (9) with a shift was greater than the LHS width (6),
  // potentially causing implicit truncation.
  // To resolve W486 and make the truncation explicit while preserving functional behavior,
  // a part-select is added to explicitly select the lower 6 bits of the shifted result.
  assign scaled_sum = (sum_intermediate >> 2)[5:0];

endmodule
