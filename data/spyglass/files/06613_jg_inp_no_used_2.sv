module unused_input_example_2 (
  input wire in_a,
  input wire in_b, // This input will be unused
  input wire in_c, // This input will also be unused
  output wire out_d
);

  assign out_d = in_a;

  // in_b and in_c are declared but never read or used in any expression.

endmodule
