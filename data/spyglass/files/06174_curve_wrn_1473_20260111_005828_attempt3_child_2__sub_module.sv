module sub_module #(
  parameter DUMMY_PARAM = 1 // Adding a dummy parameter to resolve "Design Unit 'sub_module' has empty definition" (WarnAnalyzeBBox).
) ;
  // The 'wire dummy_signal_to_avoid_empty_module_warning;' was an earlier attempt
  // to resolve the 'empty definition' warning, but was not sufficient for WarnAnalyzeBBox.
  // The addition of DUMMY_PARAM is the effective fix.
  wire dummy_signal_to_avoid_empty_module_warning;
endmodule
