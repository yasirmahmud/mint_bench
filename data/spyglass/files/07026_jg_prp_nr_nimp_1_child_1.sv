module NegatedImplicationExample1 (
  input clk,
  input rst_n,
  input a,
  input b
);

  // The expression !(a |-> b) is equivalent to (a && !b) for single-cycle boolean evaluation.
  // The |-> operator is a sequence concatenation operator and not intended for this direct boolean negation.
  property p_negated_implication;
    @(posedge clk) (a && !b);
  endproperty

  assert property (p_negated_implication) else $error("Negated implication failed!");

endmodule
