module sub_module ();
  // This sub-module originally had no parameters defined.
  // Added a dummy declaration to resolve the "Design Unit 'sub_module' has empty definition" warning (WarnAnalyzeBBox).
  wire dummy_signal_to_avoid_empty_module_warning;
endmodule
