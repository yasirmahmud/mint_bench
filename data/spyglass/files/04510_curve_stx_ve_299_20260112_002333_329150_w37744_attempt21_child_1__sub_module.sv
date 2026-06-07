module sub_module #(parameter P = 0);
  // P is a scalar parameter (implicitly 32-bit integer in Verilog-2001).
  // The dummy_signal and its assignment were removed to resolve the W528 violation
  // "Variable 'dummy_signal' set but not read." This signal had no functional purpose
  // and its removal preserves the functional behavior while resolving the linting issue.
endmodule
