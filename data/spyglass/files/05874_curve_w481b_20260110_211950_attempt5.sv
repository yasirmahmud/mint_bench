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
    // W481b violation #1: Init variable 'init_idx_1' is not the same as step variable 'step_idx_1'.
    for (init_idx_1 = 1; step_idx_1 < 5; step_idx_1 = step_idx_1 + 1) begin
      // Dummy operation to ensure 'init_idx_1' is considered 'read' and 'used' within the loop.
      // This helps prevent W528 ("set but not read") and similar unused variable warnings.
      init_idx_1 = init_idx_1 + 1;
    end

    // --- Second W481b violation ---
    // Initialize step_idx_2 before use.
    step_idx_2 = 0;
    // W481b violation #2: Init variable 'init_idx_2' is not the same as step variable 'step_idx_2'.
    for (init_idx_2 = 10; step_idx_2 < 15; step_idx_2 = step_idx_2 + 2) begin
      // Dummy operation to ensure 'init_idx_2' is considered 'read' and 'used' within the loop.
      init_idx_2 = init_idx_2 * 2;
    end
  end

endmodule
