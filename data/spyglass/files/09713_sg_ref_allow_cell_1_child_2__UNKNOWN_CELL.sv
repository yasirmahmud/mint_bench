module UNKNOWN_CELL (
  input in_a,
  output out_z
);
  // This module is intentionally left empty to represent a black box.
  // Providing an empty module definition resolves the SpyGlass "ErrorAnalyzeBBox" violation
  // by defining the previously undefined 'UNKNOWN_CELL'.
endmodule
