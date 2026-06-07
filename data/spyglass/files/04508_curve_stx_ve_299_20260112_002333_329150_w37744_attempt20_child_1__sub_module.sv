module sub_module #(parameter P = 0);
  // The parameter 'P' is declared as a simple scalar (integer type by default in Verilog-2001).
  // No ports are defined for simplicity, matching the instantiation style.
  // Fix for WarnAnalyzeBBox: Add a dummy internal declaration to make the module non-empty.
  wire dummy_signal;
endmodule
