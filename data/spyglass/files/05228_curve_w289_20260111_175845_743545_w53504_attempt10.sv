module curve_w289_20260111_175845_743545_w53504_attempt10 ();

  // Declare two distinct real variables to trigger multiple W289 violations.
  real my_first_real_value;
  real my_second_real_value;

  initial begin
    // Initialize the real variables to avoid W123 (variable read but never set).
    my_first_real_value = 1.0;
    my_second_real_value = 2.0;

    // W289 violation #1: Logical comparison of a real variable using '=='.
    if (my_first_real_value == 1.0) begin
      $display("First real value matched.");
    end

    // W289 violation #2: Logical comparison of another real variable using '=='.
    if (my_second_real_value == 2.0) begin
      $display("Second real value matched.");
    end
  end

endmodule
