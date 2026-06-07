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

  // To resolve W486, we explicitly truncate the RHS to match the LHS width.
  // The original assignment implicitly truncates the upper bits of the 9-bit
  // shifted result (sum_intermediate >> 1) to fit the 6-bit result_out.
  // By using a part-select '[5:0]', we make this truncation explicit,
  // satisfying the SpyGlass rule without altering the intended functional behavior.
  assign result_out = (sum_intermediate >> 1)[5:0];

endmodule
