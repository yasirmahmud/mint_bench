module curve_w486_20260111_085258_attempt6 (
  input wire [7:0] data_a,
  input wire [7:0] data_b,
  output wire [5:0] result_out
);

  // Intermediate wire for the sum of data_a and data_b.
  // The sum of two 8-bit unsigned numbers (max 255 + 255 = 510)
  // requires 9 bits (2^8 = 256, 2^9 = 512). So, sum_intermediate is 9 bits.
  wire [8:0] sum_intermediate;
  assign sum_intermediate = data_a + data_b;

  // This assignment triggers W486.
  // The 'sum_intermediate' is 9 bits wide. When it is shifted right by 1,
  // the expression '(sum_intermediate >> 1)' is conceptually still 9 bits wide
  // for the purpose of the W486 rule check, even though the value range might be reduced.
  // Assigning this 9-bit RHS to the 6-bit 'result_out' LHS triggers the W486 violation,
  // as the RHS width (9) with a shift is greater than the LHS width (6),
  // indicating a potential overflow or truncation during the assignment.
  assign result_out = sum_intermediate >> 1;

endmodule
