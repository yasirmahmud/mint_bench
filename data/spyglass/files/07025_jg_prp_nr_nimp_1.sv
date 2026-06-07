module NegatedImplicationExample1 (
  input clk,
  input rst_n,
  input a,
  input b
);

  property p_negated_implication;
    @(posedge clk) !(a |-> b);
  endproperty

  assert property (p_negated_implication) else $error("Negated implication failed!");

endmodule
