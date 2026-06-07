module top_module_ex2;
  wire a;
  wire not_a; // Intermediate wire to resolve DEBUG_LINT_BITWISE_NEGATION_IN_PORT_CONNECTION

  assign a = 1'b0;
  assign not_a = ~a; // Assign negated value to intermediate wire

  // Instantiate child_mod, connecting 'not_a' to 'i'.
  // The added output 'o' is left unconnected as it's not used by top_module_ex2.
  child_mod u_inst (.i (not_a), .o ());
endmodule
