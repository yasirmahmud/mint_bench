module curve_wrn_59_20260112_002221_215518_w6680_attempt14 ();

  // Declare a wire to be passed to $countdrivers.
  wire test_signal;

  // Provide a single driver for the signal to avoid 'undriven net' warnings
  // and ensure 'test_signal' is considered used/read by having a source.
  assign test_signal = 1'b0;

  // Place the system function call in an 'initial' block to clearly indicate
  // simulation-only intent. This prevents synthesis-related warnings (e.g., SYNTH_5166)
  // that typically occur when non-synthesizable constructs are found in always blocks.
  initial begin
    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    // The return value of $countdrivers is not assigned to any variable or used in an expression,
    // causing it to behave like a system task.
    $countdrivers(test_signal);
    $display("Simulation started. $countdrivers invoked for test_signal.");
  end

endmodule
