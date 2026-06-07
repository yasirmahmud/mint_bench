module test_logical_and_multibit (
  input [1:0] a,
  input [1:0] b,
  output      c
);

assign c = a && b; // Logical AND applied to multi-bit operands

endmodule
