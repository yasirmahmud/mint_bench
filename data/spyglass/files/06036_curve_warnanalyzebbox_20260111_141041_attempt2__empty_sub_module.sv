// This module is designed to trigger the WarnAnalyzeBBox rule.
// It has an empty definition, meaning it declares ports but no internal logic.
// The rule specifically targets a 'sub_module' with an empty definition.
module empty_sub_module (
  input in_val,
  output out_val
);
  // This module has an empty definition, expected to trigger WarnAnalyzeBBox.
endmodule
