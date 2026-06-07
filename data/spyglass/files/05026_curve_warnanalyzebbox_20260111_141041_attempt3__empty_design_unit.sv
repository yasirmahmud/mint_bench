// This module is intentionally left with an empty definition.
// According to the rule description, an "empty definition" for a design unit
// like 'empty_design_unit' will trigger the WarnAnalyzeBBox violation.
// This specific implementation avoids declaring any ports for the empty module,
// which helps in preventing secondary linting issues such as W240 (unused inputs)
// or W528 (unused variables) that might arise if ports were present but had no logic.
module empty_design_unit;
  // This module has an empty definition.
endmodule // empty_design_unit
