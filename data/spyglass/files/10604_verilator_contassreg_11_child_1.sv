module test11(input [2:0] sel);
  // The 'reg' type variable 'next_sel_reg' was driven by a continuous
  // assignment, causing Verilator's CONTASSREG warning.
  // Additionally, 'next_sel_reg' was set but never read, causing
  // SpyGlass W528 (Variable set but not read).
  //
  // To resolve both violations while preserving functional behavior
  // (as the variable was unused and had no external impact), 'next_sel_reg'
  // and its assignment have been removed.
endmodule
