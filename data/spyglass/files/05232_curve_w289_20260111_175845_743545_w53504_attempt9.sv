module curve_w289_20260111_175845_743545_w53504_attempt9 ();

  real my_real_value;

  initial begin
    // Initialize the real variable to avoid W123 (variable read but never set).
    my_real_value = 12.34;

    // W289: A real_var operand: 'my_real_value' should not be used with logical comparison operator '=='
    // This triggers exactly one W289 violation.
    if (my_real_value == 12.34) begin
      // An empty block or simple $display is used here.
      // This avoids unused signal warnings (e.g., W528) and latches.
      $display("Real value matched.");
    end
  end

endmodule
