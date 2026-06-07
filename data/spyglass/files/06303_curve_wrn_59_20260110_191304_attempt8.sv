module curve_wrn_59_20260110_191304_attempt8;

  // Declare an internal register. This avoids an unused input warning (W240) 
  // from previous attempt which used an input port that was only passed to $countdrivers.
  reg some_signal;

  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    // This rule is triggered because $countdrivers is a system function (it returns a value),
    // but its return value is not assigned or used, making it behave like a system task.
    $countdrivers(some_signal);
  end

endmodule
