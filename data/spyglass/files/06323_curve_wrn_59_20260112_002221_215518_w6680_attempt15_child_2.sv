module curve_wrn_59_20260112_002221_215518_w6680_attempt15 (
  output reg dummy_output
);

  wire target_net; // The signal whose drivers are to be counted.

  // Drive target_net to ensure it's not undriven and has a source.
  assign target_net = 1'b0;

  // Synthesizable logic to ensure target_net is "read" by something,
  // preventing 'W528: Variable 'target_net' set but not read.'
  // 'dummy_output' is an output port, so it is considered 'used' externally.
  always @(*) begin
    dummy_output = target_net;
  end

  // Define a task where the WRN_59 violation will occur.
  // A task is a simulation construct and is typically ignored for synthesis,
  // preventing SYNTH_5166 for its contents.
  // This task is *never called* within the module, which avoids SYNTH_5143
  // (initial block ignored for synthesis) or other warnings related to calling
  // simulation constructs from synthesizable logic. SpyGlass's static analysis
  // is expected to detect the violation within the task definition.
  task check_drivers_task;
    input [0:0] signal_to_check;
    integer driver_count; // Declare a local variable to capture the function's return value.

    // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
    // The return value of $countdrivers is not assigned to any variable or used in an expression.
    // Fix: Assign the return value of $countdrivers to a variable.
    driver_count = $countdrivers(signal_to_check);
    // Fix W528: Variable 'driver_count' set but not read.
    // Since the task is not called and is simulation-only, a dummy read like $display is sufficient
    // to resolve the linting violation without affecting functional behavior.
    $display("DEBUG: Driver count for signal %b is %0d", signal_to_check, driver_count);
  endtask

endmodule
