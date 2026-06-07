module curve_wrn_59_20260110_135421_attempt5;
  reg target_signal;

  // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
  // This triggers the violation because $countdrivers is a function being called as a standalone statement,
  // which is typically the syntax for a system task.
  initial begin
    $countdrivers(target_signal);
  end

endmodule
