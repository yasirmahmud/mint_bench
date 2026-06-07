module child_module (input in_a, output dummy_out);
  // To resolve W240 (input 'in_a' declared but not read)
  // and WarnAnalyzeBBox (Design Unit 'child_module' has empty definition),
  // we make 'in_a' drive a dummy output 'dummy_out'.
  // This also resolves W528 (Variable 'dummy_use_in_a' set but not read)
  // by eliminating the intermediate 'dummy_use_in_a' wire.
  assign dummy_out = in_a;
 endmodule
