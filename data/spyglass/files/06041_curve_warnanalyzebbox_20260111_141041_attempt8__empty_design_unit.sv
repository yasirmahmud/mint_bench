// This file demonstrates the 'WarnAnalyzeBBox' violation for a design unit with an empty definition.
// The goal is to trigger *only* this specific rule.

// This sub-module is intentionally defined with an empty body and no ports.
// This minimal structure is designed to exactly match the condition for the 'WarnAnalyzeBBox' rule,
// which flags "Design Unit 'sub_module' has empty definition".
// By having no ports, we avoid secondary warnings like 'unused input port' (W240) or 'output not driven' (W169)
// that could occur if ports were present but not used/driven within this empty context.
module empty_design_unit ();
  // The body is entirely empty, fulfilling the rule's requirement.
endmodule // empty_design_unit
