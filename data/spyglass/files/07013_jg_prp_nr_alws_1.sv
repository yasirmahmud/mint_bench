module module_prp_nr_alws_1 (
  input clk,
  input rst_n,
  input data_in
);

  always @(posedge clk) begin
    // Concurrent assertion inside a procedural block
    assert property (@(posedge clk) disable iff (!rst_n) (data_in == 1'b1));
  end

endmodule
