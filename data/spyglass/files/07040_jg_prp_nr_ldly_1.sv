module large_delay_range_prop (
  input clk,
  input rst_n,
  input a,
  input b
);

  property p_check_b_after_a;
    @(posedge clk) disable iff (!rst_n) a |=> ##[1:2000] b;
  endproperty

  assert property (p_check_b_after_a) else $error("Assertion p_check_b_after_a failed!");

endmodule
