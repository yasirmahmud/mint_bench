module weak_assertion_example1 (
  input clk,
  input rst_n,
  input a,
  input b
);

  property p_a_implies_b_weak;
    @(posedge clk) disable iff (!rst_n)
    a |=> ##[1:2] b;
  endproperty

  assert property (p_a_implies_b_weak);

endmodule
