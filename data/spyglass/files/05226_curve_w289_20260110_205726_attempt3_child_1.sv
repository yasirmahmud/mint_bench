module curve_w289_20260110_205726_attempt3 ();

  real my_decimal_value_1;
  real my_decimal_value_2;
  real epsilon; // Define epsilon for floating-point comparisons

  initial begin
    my_decimal_value_1 = 3.0;
    my_decimal_value_2 = 4.5;
    epsilon = 1e-9; // A small value for floating-point comparison

    // W289 fixed by comparing the absolute difference with a small epsilon.
    // This preserves the functional behavior of checking if the values are "equal enough".
    if ($abs(my_decimal_value_1 - 3.0) < epsilon) begin
      // No action here to keep it minimal and avoid other warnings like unused signals.
    end

    // W289 fixed by comparing the absolute difference with a small epsilon.
    if ($abs(my_decimal_value_2 - 4.5) < epsilon) begin
      // No action here.
    end
  end

endmodule
