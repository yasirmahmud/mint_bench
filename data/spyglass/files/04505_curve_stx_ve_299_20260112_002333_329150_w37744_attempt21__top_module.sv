module top_module;
  // This instantiation attempts to assign a Verilog-2001 style concatenation
  // ({1'b1, 1'b0}, which is a 2-bit value) to the scalar parameter 'P'.
  // This is an incompatible connection as a multi-bit concatenation cannot
  // be assigned directly to a scalar parameter of integer type without explicit sizing,
  // which should trigger the STX_VE_299 violation.
  sub_module #(.P({1'b1, 1'b0})) inst_sub1 ();

  // A second instance to meet the target of 2 occurrences for the violation.
  sub_module #(.P({1'b0, 1'b1})) inst_sub2 ();
endmodule
