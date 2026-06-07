module PortComment_ex1 (input clk);
  // To resolve W240 "Input 'clk' declared but not read",
  // we add a dummy assignment to ensure 'clk' is read without altering functional behavior.
  wire unused_clk_signal;
  assign unused_clk_signal = clk;
endmodule
