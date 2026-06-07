module top_module;
  // STX_VE_299 violation 1:
  // Incompatible connection - assigning a 2-bit concatenation to a 1-bit scalar parameter P.
  sub_module #(.P({1'b1, 1'b0})) inst_sub_1 ();

  // STX_VE_299 violation 2:
  // Incompatible connection - assigning a 4-bit concatenation to a 1-bit scalar parameter P.
  sub_module #(.P({2'b10, 2'b01})) inst_sub_2 ();
endmodule
