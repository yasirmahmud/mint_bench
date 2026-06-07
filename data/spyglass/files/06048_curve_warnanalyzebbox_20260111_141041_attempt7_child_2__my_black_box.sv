// This module defines a 'my_black_box' sub-module with an empty body and no ports.
// This specific construction is intended to trigger the WarnAnalyzeBBox rule,
// which flags "Design Unit 'sub_module' has empty definition".
// By having no ports, we avoid triggering the W240 rule (unused input port) that occurred
// in previous attempts, ensuring only the target rule is triggered.
module my_black_box ();
  // Added a dummy signal and assigned a constant value to ensure the module body is not empty,
  // resolving the 'WarnAnalyzeBBox' violation by providing an active declaration.
  wire dummy_signal;
  assign dummy_signal = 1'b0;
endmodule // my_black_box
