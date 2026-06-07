module test_inp_nr_asgn_1 (
  input a,
  output reg y
);

  always @(a) begin
    a = 1'b0; // Violates INP_NR_ASGN: input 'a' is driven inside the module
    y = a;
  end

endmodule
