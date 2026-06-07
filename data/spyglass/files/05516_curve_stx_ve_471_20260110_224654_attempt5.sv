module curve_stx_ve_471_20260110_224654_attempt5 ();

  // The STX_VE_471 rule triggers when unexpected text follows
  // "// synopsys translate_on" on the same line.

  // --- Violation 1 of 3 ---
  // SpyGlass expects the pragma to end after 'translate_on'.
  // Providing an input declaration immediately after 'translate_on' violates the rule.
  // synopsys translate_off
  // synopsys translate_on input wire clk;

  // --- Violation 2 of 3 ---
  // Similarly, an output declaration on the same line will cause a violation.
  // synopsys translate_off
  // synopsys translate_on output reg [7:0] data_out;

  // --- Violation 3 of 3 ---
  // A parameter declaration also causes a syntax error after the 'translate_on' token.
  // synopsys translate_off
  // synopsys translate_on parameter WIDTH = 8;

endmodule
