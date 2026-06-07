module top_module;
  wire dummy_clk; // A simple wire to connect to sub_module's port

  // Drive dummy_clk to resolve 'UndrivenInTerm-ML' and 'W287a' violations.
  assign dummy_clk = 1'b0;

  // STX_VE_299 violation 1 fixed:
  // The original assignment of a 2-bit concatenation to a 1-bit scalar parameter P
  // is fixed by explicitly selecting the LSB (index 0) to provide a 1-bit value.
  sub_module #(.P({1'b1, 1'b0}[0])) inst_sub_1 (.clk(dummy_clk));

  // STX_VE_299 violation 2 fixed:
  // The original assignment of a 4-bit concatenation to a 1-bit scalar parameter P
  // is fixed by explicitly selecting the LSB (index 0) to provide a 1-bit value.
  sub_module #(.P({2'b10, 2'b01}[0])) inst_sub_2 (.clk(dummy_clk));
endmodule
