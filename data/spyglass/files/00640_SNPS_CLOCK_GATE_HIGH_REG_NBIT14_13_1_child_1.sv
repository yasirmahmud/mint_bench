module CLKGATETST_X1 (
  input CK,   // Clock input
  input E,    // Enable input
  input SE,   // Test Enable input (often for scan bypass)
  output GCK  // Gated Clock output
);

  reg en_latch_q;

  // D-latch to capture the enable signal (E).
  // This latch is transparent when the clock (CK) is low,
  // and holds its value when CK goes high.
  // This ensures that the enable signal is stable when the rising edge of CK occurs.
  always @(E or CK) begin
    if (!CK) begin
      en_latch_q = E;
    end
  end

  // Clock gating logic:
  // If Test Enable (SE) is high, the clock is passed directly (for test/scan mode).
  // Otherwise (SE is low), the clock is gated by the latched enable signal (en_latch_q).
  assign GCK = SE ? CK : (CK & en_latch_q);

endmodule
