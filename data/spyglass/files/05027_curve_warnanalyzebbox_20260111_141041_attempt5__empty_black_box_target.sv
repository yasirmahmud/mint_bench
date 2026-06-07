// This module is designed to intentionally trigger the WarnAnalyzeBBox violation.
// It has no ports and an entirely empty body, satisfying the condition
// 'Design Unit 'sub_module' has empty definition' without leading to other warnings
// like 'input not read' or 'output not driven' that might occur if ports were present.
module empty_black_box_target;
  // The body of this module is intentionally empty.
endmodule // empty_black_box_target
