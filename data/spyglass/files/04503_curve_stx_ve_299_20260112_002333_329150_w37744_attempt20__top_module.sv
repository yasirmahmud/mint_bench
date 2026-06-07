module top_module;
  // This instantiation attempts to assign a SystemVerilog-style aggregate literal
  // ('{1, 2}') to the scalar Verilog-2001 parameter 'P'. This is an incompatible
  // connection and should trigger the STX_VE_299 violation.
  sub_module #(.P('{1, 2})) inst_sub1 ();

  // A second instance to meet the target of 2 occurrences.
  sub_module #(.P('{3, 4})) inst_sub2 ();
endmodule
