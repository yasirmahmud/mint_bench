module top_module;
  // STX_VE_299 violation 1 fixed: Incompatible connection - assigning a 2-bit concatenation to a 1-bit scalar parameter P.
  // Changed to assign a valid 1-bit value.
  sub_module #(.P(1'b0)) inst_sub_1 ();

  // STX_VE_299 violation 2 fixed: Incompatible connection - assigning a 4-bit concatenation to a 1-bit scalar parameter P.
  // Changed to assign a valid 1-bit value.
  sub_module #(.P(1'b1)) inst_sub_2 ();
endmodule
