module UnusedRegisterExample1 (
  input clk,
  input rst_n,
  input data_in
);

  // The 'my_unused_ff' register and its associated logic have been removed.
  // This resolves the SpyGlass W528 "Variable set but not read" violation 
  // because the register was never read or used by any other logic or output port.
  // Removing it preserves the observable functional behavior of the module,
  // as the unused register had no impact on the module's outputs.

endmodule
