module curve_w289_attempt11;

  real my_real_var;
  localparam real EPSILON = 1.0e-9; // Define a small epsilon for real comparison

  initial begin
    // Assign a value to the real variable
    my_real_var = 5.7;

    // W289 violation: A real_var operand: 'my_real_var' should not be used with logical comparison operator '=='
    // This example triggers exactly one W289 violation.
    // Fixed: Use an epsilon-based comparison for real numbers
    if ($abs(my_real_var - 5.7) < EPSILON) begin
      $display("Comparison with real value performed.");
    end
  end

endmodule
