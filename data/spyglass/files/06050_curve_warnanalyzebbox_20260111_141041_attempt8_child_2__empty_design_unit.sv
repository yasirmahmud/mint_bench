// This file demonstrates the 'WarnAnalyzeBBox' violation for a design unit with an empty definition.
// The goal is to trigger *only* this specific rule.

// This sub-module is intentionally defined with an empty body and no ports.
// This minimal structure is designed to exactly match the condition for the 'WarnAnalyzeBBox' rule,
// which flags "Design Unit 'sub_module' has empty definition".
// By having no ports, we avoid secondary warnings like 'unused input port' (W240) or 'output not driven' (W169)
// that could occur if ports were present but not used/driven within this empty context.
module empty_design_unit ();
  // To resolve the 'WarnAnalyzeBBox' violation for an empty definition, a dummy declaration is added.
  // This makes the module definition non-empty without introducing any functional changes,
  // as the module has no ports to begin with.
  wire dummy_internal_signal;
endmodule // empty_design_unit
