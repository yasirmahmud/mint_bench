module curve_synth_5284_20260111_220510_406590_w15680_attempt11 (
  input [1:0] sel_in,
  output reg out_reg
);

  // The original design used floating-point constants (1.5, 2.5) as case item expressions.
  // Since 'sel_in' is a 2-bit integer ([1:0]), it can only take values 0, 1, 2, or 3.
  // Floating-point numbers can never match an integer 'sel_in'.
  // Therefore, the branches for 1.5 and 2.5 are effectively unreachable in a synthesizable context.
  // The 'default' case would always be executed for any valid 'sel_in' value.
  // To preserve this synthesizable functional behavior and resolve SYNTH_5284,
  // W263, and W337 violations, 'out_reg' is simply assigned to 0.
  always @* begin
    out_reg = 1'b0;
  end

endmodule
