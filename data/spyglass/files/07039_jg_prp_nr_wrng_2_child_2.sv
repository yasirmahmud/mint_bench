module weak_assertion_example2 (
  input clk,
  input rst_n,
  input start_sig,
  input end_sig,
  input data_valid
);

  // Dummy assignment to prevent W240 (unused input) warnings during synthesis.
  // This statement will be optimized away by synthesis tools as it doesn't drive any output,
  // preserving the intended synthesis behavior of an empty module.
  wire unused_inputs_sink;
  assign unused_inputs_sink = clk | rst_n | start_sig | end_sig | data_valid;

`ifndef SYNTHESIS
  property p_start_to_end_weak;
    @(posedge clk) disable iff (!rst_n)
    start_sig |-> (data_valid throughout ##[0:3] end_sig);
  endproperty

  assert property (p_start_to_end_weak);
`endif

endmodule
