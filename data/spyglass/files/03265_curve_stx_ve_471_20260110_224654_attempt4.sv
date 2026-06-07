module curve_stx_ve_471_20260110_224654_attempt4 ();

  // SpyGlass typically ignores code blocks between translate_off and translate_on.
  // The STX_VE_471 rule is triggered when there is unexpected text immediately
  // following the "// synopsys translate_on" pragma on the same line.

  // --- Violation 1 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'integer' is unexpected.
  // This line is expected to trigger the first violation.
  // synopsys translate_on integer my_int_var;


  // --- Violation 2 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'function' is unexpected.
  // This line is expected to trigger the second violation.
  // synopsys translate_on function automatic integer my_func;


  // --- Violation 3 of 3 ---
  // Start of ignored block
  // synopsys translate_off

  // STX_VE_471: Syntax error after token ( translate_on ), 'task' is unexpected.
  // This line is expected to trigger the third violation.
  // synopsys translate_on task my_task;

endmodule
