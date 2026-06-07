module curve_w289_20260110_205726_attempt2 ();

  real my_real_var_1;
  real my_real_var_2;
  parameter real EPSILON = 1e-9; // Define a small epsilon for real comparisons

  initial begin
    my_real_var_1 = 1.0;
    my_real_var_2 = 2.0;

    // W289 fixed: Use absolute difference for real comparison
    if ($abs(my_real_var_1 - 0.5) < EPSILON) begin
      $display("Condition 1 met\n");
    end

    // W289 fixed: Use absolute difference for real comparison
    if ($abs(my_real_var_2 - 2.0) < EPSILON) begin
      $display("Condition 2 met\n");
    end
  end

endmodule
