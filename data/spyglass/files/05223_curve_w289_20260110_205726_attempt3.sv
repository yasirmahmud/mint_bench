module curve_w289_20260110_205726_attempt3 ();

  real my_decimal_value_1;
  real my_decimal_value_2;

  initial begin
    my_decimal_value_1 = 3.0;
    my_decimal_value_2 = 4.5;

    // W289: A real_var operand: 'my_decimal_value_1' should not be used with logical comparison operator '=='
    // This will trigger the first W289 violation.
    if (my_decimal_value_1 == 3.0) begin
      // No action here to keep it minimal and avoid other warnings like unused signals.
    end

    // W289: A real_var operand: 'my_decimal_value_2' should not be used with logical comparison operator '=='
    // This will trigger the second W289 violation.
    if (my_decimal_value_2 == 4.5) begin
      // No action here.
    end
  end

endmodule
