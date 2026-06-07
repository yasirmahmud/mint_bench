module sub_module #(parameter P = 0);
  // P is a scalar parameter (implicitly 32-bit integer in Verilog-2001).
  // Add a dummy assignment to prevent the 'WarnAnalyzeBBox: Design Unit has empty definition' warning.
  wire dummy_signal;
  assign dummy_signal = 1'b0;
endmodule
