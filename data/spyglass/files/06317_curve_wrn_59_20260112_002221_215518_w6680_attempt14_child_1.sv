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
    integer driver_count; // Declare an integer to store the return value of $countdrivers.

    // WRN_59 fix: Assign the return value of $countdrivers to a variable.
    // This ensures the system function is used as a function.
    // W528 fix: By calling $countdrivers(test_signal) and using its result,
    // 'test_signal' is considered read, resolving the 'set but not read' warning.
    driver_count = $countdrivers(test_signal);
    $display("Simulation started. $countdrivers invoked for test_signal. Number of drivers: %0d", driver_count);
  end

endmodule
