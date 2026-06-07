module test_inp_nr_asgn_2 (
  input clk,
  input b,
  output c
);

  assign b = 1'b1; // Violates INP_NR_ASGN: input 'b' is driven inside the module
  assign c = b;

endmodule
