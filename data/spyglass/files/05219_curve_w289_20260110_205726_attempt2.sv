module curve_w289_20260110_205726_attempt2 ();

  real my_real_var_1;
  real my_real_var_2;

  initial begin
    my_real_var_1 = 1.0;
    my_real_var_2 = 2.0;

    // W289: A real_var operand: 'my_real_var_1' should not be used with logical comparison operator '=='
    if (my_real_var_1 == 0.5) begin
      $display("Condition 1 met\n");
    end

    // W289: A real_var operand: 'my_real_var_2' should not be used with logical comparison operator '=='
    if (my_real_var_2 == 2.0) begin
      $display("Condition 2 met\n");
    end
  end

endmodule
