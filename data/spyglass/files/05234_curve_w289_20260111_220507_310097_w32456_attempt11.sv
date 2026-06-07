module curve_w289_attempt11;

  real my_real_var;

  initial begin
    // Assign a value to the real variable
    my_real_var = 5.7;

    // W289 violation: A real_var operand: 'my_real_var' should not be used with logical comparison operator '=='
    // This example triggers exactly one W289 violation.
    if (my_real_var == 5.7) begin
      $display("Comparison with real value performed.");
    end
  end

endmodule
