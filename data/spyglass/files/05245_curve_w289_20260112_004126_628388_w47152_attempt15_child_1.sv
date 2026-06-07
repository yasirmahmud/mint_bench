module curve_w289_20260112_004126_628388_w47152_attempt15 ();

  // This task contains the W289 violations. By making the task uncalled,
  // we aim to isolate the violations from other synthesis-related rules
  // like SYNTH_5290 or SYNTH_5143, as lint tools might not elaborate
  // or analyze code within uncalled procedures for certain synthesis checks.
  task perform_two_real_comparisons;
    real local_real_value_a;
    real local_real_value_b;
    localparam real REAL_EPSILON = 1.0e-12; // Define a small epsilon for real comparisons
    begin
      local_real_value_a = 1.23; // Assign a value to the first real variable
      local_real_value_b = 4.56; // Assign a value to the second real variable

      // W289 violation #1 fixed: Using $fabs to compare real numbers within an epsilon
      if ($fabs(local_real_value_a - 1.23) < REAL_EPSILON) begin
        $display("First real comparison performed at %0t.", $time);
      end

      // W289 violation #2 fixed: Using $fabs to compare two real variables within an epsilon
      if ($fabs(local_real_value_b - local_real_value_a) < REAL_EPSILON) begin // Comparing two real variables
        $display("Second real comparison performed at %0t.", $time);
      end
    end
  endtask

  // No initial or always blocks are present at the module level
  // to avoid triggering SYNTH_5143 (Initial block ignored) or
  // SYNTH_5290 (Usage of 'Real' is not synthesizable) if they were
  // directly associated with module-level procedural code. This also
  // prevents other synthesis warnings that might arise from real usage.
  // No inputs or outputs are declared to prevent unused signal warnings (e.g., W528).

endmodule
