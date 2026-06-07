module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg q_latch;

  // This latch is transparent when CK is low (active low enable).
  // When CK is low, q_latch follows E.
  // When CK is high, q_latch holds its value.
  // This ensures that the enable signal (E) is latched on the falling edge of CK
  // and held stable during the high phase of CK for clean gating.
  always @(E or CK) begin
    if (!CK) begin
      q_latch = E;
    end
  end

  // Gated clock logic:
  // If Test Enable (SE) is high, the clock gate is bypassed and GCK directly follows CK.
  // This is common for scan or test modes to avoid blocking the clock.
  // Otherwise (if SE is low), GCK is the result of CK ANDed with the latched enable (q_latch).
  // This means GCK transitions high only when CK is high AND the latched enable is high.
  assign GCK = SE ? CK : (CK & q_latch);

endmodule
