module curve_w289_20260110_205726_attempt5 ();

  real my_real_val_1;
  real my_real_val_2;

  initial begin
    // Initialize real variables (outside declaration to avoid SYNTH_89 warning)
    my_real_val_1 = 1.0;
    my_real_val_2 = 2.0;

    // W289 violation 1: Comparing real_var_a with '=='
    // Rule: A real_var operand: 'my_real_val_1' should not be used with logical comparison operator '=='
    if (my_real_val_1 == 1.0) begin
      $display("Violation 1 triggered.");
    end

    // W289 violation 2: Comparing real_var_b with '=='
    // Rule: A real_var operand: 'my_real_val_2' should not be used with logical comparison operator '=='
    if (my_real_val_2 == 2.0) begin
      $display("Violation 2 triggered.");
    end
  end

endmodule
