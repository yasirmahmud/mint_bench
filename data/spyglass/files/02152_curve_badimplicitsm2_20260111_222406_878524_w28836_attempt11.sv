module curve_badimplicitsm2_20260111_222406_878524_w28836_attempt11 (
  input wire sys_clk,
  input wire d_in,
  output reg reg_pos_edge,
  output reg reg_neg_edge
);

  // SpyGlass badimplicitSM2 violation will be triggered here.
  // This 'always' block implicitly defines two sequential elements,
  // one sensitive to the positive edge of 'sys_clk'
  // and another sensitive to the negative edge of 'sys_clk'.
  // This mixed-edge sensitivity within a single 'always' block is unsynthesizable.
  always begin
    @(posedge sys_clk) reg_pos_edge <= d_in;
    @(negedge sys_clk) reg_neg_edge <= ~d_in;
  end

endmodule
