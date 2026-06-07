module my_module_ex2(input clk);
  // The variable 'dummy_q' was set but not read (W528 violation).
  // Since 'dummy_q' had no functional impact on the design, and was
  // only added to avoid a potential W240 violation for 'clk',
  // the simplest fix for W528 is to remove 'dummy_q' and its assignment.
  // This module now has an unused input 'clk'. If a W240 violation
  // arises for 'clk', it would need to be addressed separately (e.g.,
  // by adding functional logic that uses 'clk', removing 'clk' if truly
  // unneeded, or using tool-specific pragmas to mark it as intentionally
  // unused).
endmodule
