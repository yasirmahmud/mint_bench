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
    for (init_var1 = 0; step_var1 < 10; step_var1 = step_var1 + 1) begin
      dummy_data1 = init_var1 + 1; // Reads init_var1 to prevent W528 (variable set but not read)
    end

    // W481b violation 2: Initialization variable 'init_var2' is not the same as the step variable 'step_var2'.
    // 'step_var2' is uninitialized at loop entry, mirroring behavior in SpyGlass examples.
    for (init_var2 = 100; step_var2 > 50; step_var2 = step_var2 - 1) begin
      dummy_data2 = init_var2; // Reads init_var2 to prevent W528
    end
  end

endmodule
