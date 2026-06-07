module curve_w481b_20260110_211950_attempt5;

  // Variables for the first W481b violation
  integer init_idx_1; // Loop initialization variable
  integer step_idx_1; // Loop step variable (also used in condition)

  // Variables for the second W481b violation
  integer init_idx_2; // Loop initialization variable
  integer step_idx_2; // Loop step variable (also used in condition)

  initial begin
    // --- First W481b violation ---
    // Initialize step_idx_1 before use to avoid potential uninitialized variable warnings.
    step_idx_1 = 0;
    // To resolve W481b (Unsynthesizable loop: Init variable 'init_idx_1' is not same as step variable 'step_idx_1'),
    // the initialization of 'init_idx_1' is moved outside the 'for' loop.
    // The 'for' loop's initialization, condition, and step must use the same variable, which is 'step_idx_1' in this case.
    init_idx_1 = 1;
    for (step_idx_1 = 0; step_idx_1 < 5; step_idx_1 = step_idx_1 + 1) begin
      // Dummy operation to ensure 'init_idx_1' is considered 'read' and 'used' within the loop.
      // This resolves W528 ("Variable 'init_idx_1' set but not read") for the initial assignment of 'init_idx_1'.
      init_idx_1 = init_idx_1 + 1;
    end

    // --- Second W481b violation ---
    // Initialize step_idx_2 before use.
    step_idx_2 = 0;
    // To resolve W481b (Unsynthesizable loop: Init variable 'init_idx_2' is not same as step variable 'step_idx_2'),
    // the initialization of 'init_idx_2' is moved outside the 'for' loop.
    // 'step_idx_2' is used consistently as the loop counter.
    init_idx_2 = 10;
    for (step_idx_2 = 0; step_idx_2 < 15; step_idx_2 = step_idx_2 + 2) begin
      // Dummy operation to ensure 'init_idx_2' is considered 'read' and 'used' within the loop.
      // This resolves W528 ("Variable 'init_idx_2' set but not read") for the initial assignment of 'init_idx_2'.
      init_idx_2 = init_idx_2 * 2;
    end
  end

endmodule
