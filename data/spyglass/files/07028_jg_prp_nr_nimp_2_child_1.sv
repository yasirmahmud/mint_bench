module NegatedImplicationExample2 (
  input clk,
  input rst_n,
  input start_cond,
  input end_cond
);

  property p_another_negated_implication;
    @(posedge clk) (start_cond |=> !end_cond);
  endproperty

  assert property (p_another_negated_implication);

endmodule
