module curve_w481b_20260110_211950_attempt2;

  // Variables for the first loop
  integer init_var1; // Loop initialization variable
  integer step_var1; // Loop step variable
  integer dummy_data1; // Used to consume init_var1 to avoid W528

  // Variables for the second loop
  integer init_var2;
  integer step_var2;
  integer dummy_data2;

  initial begin
    // W481b violation 1: Initialization variable 'init_var1' is not the same as the step variable 'step_var1'.
    // 'step_var1' is uninitialized at loop entry, which is common in such unsynthesizable simulation constructs.
    // To resolve W481b, the loop counter, condition, and step must use the same variable (step_var1).
    // To preserve functional behavior, init_var1's initial value (0) is explicitly set before the loop.
    init_var1 = 0; // Ensures init_var1 is set and subsequently read (resolves W528 for init_var1)
    for (step_var1 = 0; step_var1 < 10; step_var1 = step_var1 + 1) begin // W481b fixed
      dummy_data1 = init_var1 + 1; // Reads init_var1, preventing W528 for it
    end

    // W481b violation 2: Initialization variable 'init_var2' is not the same as the step variable 'step_var2'.
    // 'step_var2' is uninitialized at loop entry, mirroring behavior in SpyGlass examples.
    // To resolve W481b, the loop counter, condition, and step must use the same variable (step_var2).
    // To preserve functional behavior, init_var2's initial value (100) is explicitly set before the loop.
    init_var2 = 100; // Ensures init_var2 is set and subsequently read (resolves W528 for init_var2)
    for (step_var2 = 100; step_var2 > 50; step_var2 = step_var2 - 1) begin // W481b fixed
      dummy_data2 = init_var2; // Reads init_var2, preventing W528 for it
    end
  end

endmodule
