module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latched_enable;

  // Glitch-free enable latch: transparent when CK is low, opaque when CK is high.
  // This captures the enable signal E during the low phase of the clock.
  always @(E or CK) begin
    if (!CK) begin // If CK is low, latch is transparent
      latched_enable = E;
    end
    // If CK is high, latched_enable holds its value (opaque)
  end

  // The effective enable for the clock gate combines the latched_enable and the test enable SE.
  // If SE is high, the clock is effectively always enabled, regardless of E.
  // Otherwise, the latched_enable controls the clock.
  wire effective_enable;
  assign effective_enable = latched_enable | SE; // SE overrides E, forcing enable high for test.

  // Gated clock output: ANDs the clock with the effective enable.
  // This ensures glitch-free operation because latched_enable is stable when CK rises.
  assign GCK = CK & effective_enable;

endmodule
