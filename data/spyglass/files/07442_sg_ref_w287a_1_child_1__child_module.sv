module child_module (input in_a);
  // To resolve W240 (input 'in_a' declared but not read)
  // and WarnAnalyzeBBox (Design Unit 'child_module' has empty definition),
  // we add a dummy internal usage for the input.
  wire dummy_use_in_a;
  assign dummy_use_in_a = in_a;
 endmodule
