// This module defines a 'my_black_box' sub-module with an empty body and no ports.
// This specific construction is intended to trigger the WarnAnalyzeBBox rule,
// which flags "Design Unit 'sub_module' has empty definition".
// By having no ports, we avoid triggering the W240 rule (unused input port) that occurred
// in previous attempts, ensuring only the target rule is triggered.
module my_black_box ();
  // The body of this module is intentionally empty.
  // No internal logic, declarations, or assignments are present,
  // fulfilling the condition for an "empty definition".
endmodule // my_black_box
