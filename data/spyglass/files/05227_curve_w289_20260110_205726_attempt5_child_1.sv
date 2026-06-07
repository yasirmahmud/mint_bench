module curve_w289_20260110_205726_attempt5 ();

  real my_real_val_1;
  real my_real_val_2;

  // Define a small epsilon for real number comparisons
  parameter real EPSILON = 1.0e-9;

  initial begin
    // Initialize real variables (outside declaration to avoid SYNTH_89 warning)
    my_real_val_1 = 1.0;
    my_real_val_2 = 2.0;

    // W289 violation 1 fixed: Comparing real_var_a with '==' replaced with approximate comparison
    // Rule: A real_var operand: 'my_real_val_1' should not be used with logical comparison operator '=='
    if ($fabs(my_real_val_1 - 1.0) < EPSILON) begin
      $display("Violation 1 triggered.");
    end

    // W289 violation 2 fixed: Comparing real_var_b with '==' replaced with approximate comparison
    // Rule: A real_var operand: 'my_real_val_2' should not be used with logical comparison operator '=='
    if ($fabs(my_real_val_2 - 2.0) < EPSILON) begin
      $display("Violation 2 triggered.");
    end
  end

endmodule
