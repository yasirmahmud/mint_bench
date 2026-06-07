module top_module;
  wire dummy_clk; // A simple wire to connect to sub_module's port

  // STX_VE_299 violation 1:
  // Incompatible connection - assigning a 2-bit concatenation to a 1-bit scalar parameter P.
  sub_module #(.P({1'b1, 1'b0})) inst_sub_1 (.clk(dummy_clk));

  // STX_VE_299 violation 2:
  // Incompatible connection - assigning a 4-bit concatenation to a 1-bit scalar parameter P.
  sub_module #(.P({2'b10, 2'b01})) inst_sub_2 (.clk(dummy_clk));
endmodule
