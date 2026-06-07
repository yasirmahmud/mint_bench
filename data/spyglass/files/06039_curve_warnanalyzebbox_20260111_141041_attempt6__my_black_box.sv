// This module defines a 'black_box' sub-module with ports but an empty body.
// This specific construction is intended to trigger the WarnAnalyzeBBox rule,
// which flags "Design Unit 'sub_module' has empty definition".
// It explicitly defines ports to avoid the syntax error encountered in previous attempts
// when attempting a module with an entirely absent port list.
module my_black_box (
  input  box_in,  // Input port for the black box
  output box_out  // Output port for the black box
);
  // The body of this module is intentionally empty.
  // No internal logic, declarations, or assignments are present,
  // fulfilling the condition for an "empty definition".
endmodule // my_black_box
