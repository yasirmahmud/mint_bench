module unequal_op_and (
  input [3:0] a,
  input [7:0] b,
  output [7:0] c
);

  assign c = a & b; // 'a' is 4 bits, 'b' is 8 bits. Unequal length operands for bitwise AND.

endmodule
