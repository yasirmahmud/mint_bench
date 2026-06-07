module curve_stx_ve_471_20260110_224654_attempt3 ();

  // SpyGlass typically ignores code blocks between translate_off and translate_on.
  // The STX_VE_471 rule is triggered when there is unexpected text immediately
  // following the "// synopsys translate_on" pragma on the same line.

  // --- Violation 1 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'wire' is unexpected.
  // This line is expected to trigger the first violation.
  // synopsys translate_on wire my_signal_a;


  // --- Violation 2 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'reg' is unexpected.
  // This line is expected to trigger the second violation.
  // synopsys translate_on reg my_signal_b;


  // --- Violation 3 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'localparam' is unexpected.
  // This line is expected to trigger the third violation.
  // synopsys translate_on localparam MY_CONSTANT_C = 10;

endmodule
