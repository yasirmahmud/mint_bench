module curve_badimplicitsm2_20260111_183255_347751_w53504_attempt7 (
  input wire clk_i,
  input wire data_i,
  output reg out_negedge_r,
  output reg out_posedge_r
);

  // This 'always' block contains unsynthesizable implicit sequential logic.
  // States are updated on both negative and positive clock phases within the same block,
  // which is not supported by synthesis tools and violates the 'badimplicitSM2' rule.
  always begin
    @(negedge clk_i) out_negedge_r <= data_i;
    @(posedge clk_i) out_posedge_r <= ~data_i;
  end

endmodule
