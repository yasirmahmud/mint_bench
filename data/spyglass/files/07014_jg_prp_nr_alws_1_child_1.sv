module module_prp_nr_alws_1 (
  input clk,
  input rst_n,
  input data_in
);

  // To resolve W240 (Input '...' declared but not read) warnings.
  // These dummy reads ensure inputs are recognized as 'used' by linting tools.
  // They will be optimized away by synthesis tools as they drive nothing.
  wire _sg_dummy_read_rst_n = rst_n;
  wire _sg_dummy_read_data_in = data_in;

`ifndef SYNTHESIS
  // To resolve SYNTH_5064 (ASSERT statements are not synthesizable) warning.
  // Assertions are for verification and are excluded from synthesis builds.
  always @(posedge clk) begin
    // Concurrent assertion inside a procedural block
    assert property (@(posedge clk) disable iff (!rst_n) (data_in == 1'b1));
  end
`endif

endmodule
