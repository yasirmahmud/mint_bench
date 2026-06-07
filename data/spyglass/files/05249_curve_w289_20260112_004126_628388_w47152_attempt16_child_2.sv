module curve_w289_20260112_004126_628388_w47152_attempt16 ();

  // This task contains the W289 violations. It is intentionally not called
  // from within the module to prevent its contents from being elaborated
  // in a way that might trigger other synthesis-related rules (e.g., SYNTH_5143
  // for initial blocks, or SYNTH_5290 for non-synthesizable use of 'real'
  // if directly placed in an 'always' block). Lint tools, however, typically
  // still analyze uncalled procedures for certain violations like W289.
  task perform_two_distinct_real_comparisons;
    real real_var_alpha; // Declare the first real variable
    real real_var_beta;  // Declare the second real variable

    begin
      real_var_alpha = 10.5; // Assign a value to the first real variable
      real_var_beta  = 20.0; // Assign a value to the second real variable

      // W289 violation #1: A real_var operand: 'real_var_alpha' should not be used with logical comparison operator '=='
      // FIX: Replace '==' with an epsilon comparison using $abs to adhere to W289 best practices for real numbers.
      if ($abs(real_var_alpha - 10.5) < 1e-9) begin
        // FIX W528: Add real_var_alpha to $display to ensure it's recognized as 'read'.
        $display("First real comparison occurred at %0t. Alpha: %f", $time, real_var_alpha);
      end

      // W289 violation #2: A real_var operand: 'real_var_beta' should not be used with logical comparison operator '=='
      // FIX: Replace '==' with an epsilon comparison using $abs to adhere to W289 best practices for real numbers.
      if ($abs(real_var_beta - 20.0) < 1e-9) begin
        // FIX W528: Add real_var_beta to $display to ensure it's recognized as 'read'.
        $display("Second real comparison occurred at %0t. Beta: %f", $time, real_var_beta);
      end
    end
  endtask

  // No initial or always blocks are present at the module level.
  // No inputs or outputs are declared to prevent unused signal warnings (e.g., W528).
  // The task 'perform_two_distinct_real_comparisons' is not called, which further
  // isolates the W289 violations and prevents other rules from being triggered.

endmodule
