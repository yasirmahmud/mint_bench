module weak_assertion_example2 (
  input clk,
  input rst_n,
  input start_sig,
  input end_sig,
  input data_valid
);

  property p_start_to_end_weak;
    @(posedge clk) disable iff (!rst_n)
    start_sig |-> (data_valid throughout ##[0:3] end_sig);
  endproperty

  assert property (p_start_to_end_weak);

endmodule
