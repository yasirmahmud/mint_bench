module curve_badimplicitsm2_20260111_222406_878524_w28836_attempt12 (
  input wire clk_i,
  input wire [3:0] data_i,
  output reg [3:0] q_neg_edge,
  output reg [3:0] q_pos_edge
);

  // SpyGlass badimplicitSM2 violation will be triggered here.
  // This 'always' block implicitly defines two sequential elements,
  // one sensitive to the negative edge of 'clk_i'
  // and another sensitive to the positive edge of 'clk_i'.
  // This mixed-edge sensitivity within a single 'always' block is unsynthesizable,
  // leading to the badimplicitSM2 violation.
  always begin
    @(negedge clk_i) q_neg_edge <= data_i;
    @(posedge clk_i) q_pos_edge <= data_i;
  end

endmodule
