module curve_badimplicitsm2_20260111_183255_347751_w53504_attempt8 (
  input wire main_clk,
  input wire input_val,
  output reg pos_edge_out,
  output reg neg_edge_out
);

  // This 'always' block triggers badimplicitSM2 because it attempts to update
  // sequential logic elements on both positive and negative clock edges
  // within the same block, which is unsynthesizable.
  always begin
    @(posedge main_clk) pos_edge_out <= input_val;
    @(negedge main_clk) neg_edge_out <= ~input_val;
  end

endmodule
