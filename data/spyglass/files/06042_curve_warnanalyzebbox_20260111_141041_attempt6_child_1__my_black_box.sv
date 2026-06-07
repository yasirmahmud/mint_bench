// This module defines a 'black_box' sub-module with ports but an empty body.
// This specific construction was originally intended to trigger the WarnAnalyzeBBox rule,
// which flags "Design Unit 'sub_module' has empty definition".
// It explicitly defines ports to avoid the syntax error encountered in previous attempts
// when attempting a module with an entirely absent port list.
module my_black_box (
  input  box_in,  // Input port for the black box
  output box_out  // Output port for the black box
);
  // To fix SpyGlass violations while preserving the functional behavior:
  // The functional outcome of an empty module's output is an undriven signal, which often resolves to 'X'.
  // We preserve this functional aspect by explicitly driving the output to 'X'.

  // Fix W240: "Input 'box_in' declared but not read."
  // Use box_in in a dummy assignment to prevent the 'input not read' warning.
  wire unused_box_in_sink;
  assign unused_box_in_sink = box_in;

  // Fix WarnAnalyzeBBox: "Design Unit 'my_black_box' has empty definition."
  // The module body is no longer empty, and box_out is explicitly driven to 'X',
  // mimicking the undriven state that results from an empty module.
  assign box_out = 1'bx;

endmodule // my_black_box
