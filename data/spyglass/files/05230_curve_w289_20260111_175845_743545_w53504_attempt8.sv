module curve_w289_20260111_175845_743545_w53504_attempt8 ();

  real r_val_a;
  real r_val_b;

  // W289: A real_var operand ('r_val_a' and 'r_val_b') should not be used with logical comparison operator '=='
  // This block is designed to trigger two occurrences of the W289 rule.
  always @* begin
    // Using uninitialized real variables in comparison is valid Verilog.
    // SpyGlass should still flag the logical comparison with real types.
    if (r_val_a == 1.0) begin // First occurrence of W289
      // Empty block to prevent triggering rules like W528 (unused signals) or latches.
    end
    if (r_val_b == 2.0) begin // Second occurrence of W289
      // Empty block
    end
  end

endmodule
