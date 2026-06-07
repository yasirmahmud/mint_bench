module curve_badimplicitsm2_20260112_011903_605201_w6680_attempt13 (
  input wire        clk_i,
  input wire        data_i,
  output reg        q_pos_o,
  output reg        q_neg_o
);

  // Violation: badimplicitSM2
  // This always block updates registers on both positive and negative edges
  // of the same clock (clk_i), which is unsynthesizable implicit sequential logic.
  always begin
    @(posedge clk_i) q_pos_o <= data_i;
    @(negedge clk_i) q_neg_o <= ~data_i;
  end

endmodule
