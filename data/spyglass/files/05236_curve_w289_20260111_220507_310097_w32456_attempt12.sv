module curve_w289_20260111_220507_310097_w32456_attempt12 (
  output reg out_flag
);

  real my_real_var; // Declare a real variable

  // W289 violation: A real_var operand: 'my_real_var' should not be used with logical comparison operator '=='
  // This module aims to trigger exactly one W289 violation and no other rules.
  // The 'real' variable is left uninitialized as assigning it would require an initial
  // or always block which might trigger other synthesis warnings (e.g., SYNTH_5143).
  // SpyGlass should still analyze the comparison regardless of initialization.
  always @(*) begin
    out_flag = 1'b0; // Default assignment to avoid a latch
    if (my_real_var == 5.0) begin // Exactly one W289 violation
      out_flag = 1'b1;
    end
  end

endmodule
