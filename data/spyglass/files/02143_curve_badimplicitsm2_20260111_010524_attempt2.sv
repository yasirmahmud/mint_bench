module curve_badimplicitsm2_20260111_010524_attempt2 (
  input wire data_in,
  input wire sys_clk,
  output reg pos_edge_out_q,
  output reg neg_edge_out_q
);

  always begin
    @(posedge sys_clk) pos_edge_out_q <= data_in;
    @(negedge sys_clk) neg_edge_out_q <= ~data_in;
  end

endmodule
