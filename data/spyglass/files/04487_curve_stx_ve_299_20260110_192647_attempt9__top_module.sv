module top_module;
  // STX_VE_299 violation: Incompatible connection to parameter 'P'.
  // 'P' is declared as an integer (default 32-bit signed in Verilog).
  // Attempting to assign a 2-bit unsigned bit-vector concatenation '{1'b1, 1'b0}'
  // to an integer parameter is an incompatible type/width connection, triggering the rule.
  sub_module #(.P({1'b1, 1'b0})) inst_sub_1 ();
endmodule
