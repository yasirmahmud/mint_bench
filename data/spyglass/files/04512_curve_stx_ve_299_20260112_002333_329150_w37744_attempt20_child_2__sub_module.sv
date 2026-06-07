module sub_module #(parameter P = 0);
  // The parameter 'P' is declared as a simple scalar (integer type by default in Verilog-2001).
  // No ports are defined for simplicity, matching the instantiation style.
  // Fix for WarnAnalyzeBBox: The previous 'wire dummy_signal;' was insufficient.
  // Changing to a 'reg' and adding an 'always' block ensures the module is not considered empty by SpyGlass.
  reg dummy_signal;
  always @(*) begin
    dummy_signal = 1'b0; // Dummy assignment to make the block active and module non-empty
  end
endmodule
