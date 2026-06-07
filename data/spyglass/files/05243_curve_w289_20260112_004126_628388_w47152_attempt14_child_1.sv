module curve_w289_20260112_004126_628388_w47152_attempt14 ();

  // This task contains the W289 violation. By making the task uncalled,
  // we aim to isolate the violation from other synthesis-related rules
  // like SYNTH_5290 or SYNTH_5143. Lint tools might not elaborate
  // or analyze code within uncalled procedures for certain synthesis checks.
  task perform_real_comparison;
    real local_real_value; // Declaration of a real variable
    begin
      local_real_value = 7.89; // Assign a value to the real variable

      // W289 violation: A real_var operand: 'local_real_value' should not be used with logical comparison operator '=='
      // Fixed: Replaced direct equality comparison with a tolerance-based comparison using $fabs.
      if ($fabs(local_real_value - 7.89) < 1e-9) begin // Using a small epsilon for real comparison.
        $display("Real comparison performed inside an uncalled task at %0t.", $time);
      end
    end
  endtask

  // No initial or always blocks are present at the module level
  // to avoid triggering SYNTH_5143 (Initial block ignored) or
  // SYNTH_5290 (Usage of 'Real' is not synthesizable) if they were
  // directly associated with module-level procedural code.
  // No inputs or outputs are declared to prevent unused signal warnings (e.g., W528).

endmodule
