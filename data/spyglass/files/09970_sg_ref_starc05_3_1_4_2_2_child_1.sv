module my_module_ex2 (input clk);
  wire sig;
  // Fix for SpyGlass W240: Input 'clk' declared but not read.
  // Assigning 'clk' to an internal unused wire to acknowledge its presence
  // without introducing new functional behavior or changing the module interface.
  wire unused_clk = clk;
endmodule
