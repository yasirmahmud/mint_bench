module top_module;
  wire dummy_clk; // A simple wire to connect to sub_module's port

  // Drive dummy_clk to resolve 'UndrivenInTerm-ML' and 'W287a' violations.
  assign dummy_clk = 1'b0;

  // STX_VE_479 violation 1 fixed:
  // The original SystemVerilog-2009 'select on concatenation' construct
  // is replaced with a direct 1-bit value assignment that achieves the same functional result.
  // ({1'b1, 1'b0}[0]) evaluates to 1'b0.
  sub_module #(.P(1'b0)) inst_sub_1 (.clk(dummy_clk));

  // STX_VE_479 violation 2 fixed:
  // The original SystemVerilog-2009 'select on concatenation' construct
  // is replaced with a direct 1-bit value assignment that achieves the same functional result.
  // ({2'b10, 2'b01}[0]) evaluates to 1'b1.
  sub_module #(.P(1'b1)) inst_sub_2 (.clk(dummy_clk));
endmodule
