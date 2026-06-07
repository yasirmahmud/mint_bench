// Definition of the clock gate cell to resolve black-box violation
// This behavioral model emulates a typical latch-based clock gate (ICG)
// with an active-high enable (E) and a test enable (SE).
// The enable signal 'E' is latched on the low phase of the clock 'CK' for glitch-free operation.
module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);
  reg  en_latched; // Internal register to latch the enable signal

  // Behavioral model for a negative-level-sensitive latch for the enable signal.
  // When the clock (CK) is low, 'en_latched' tracks 'E'.
  // When CK is high, 'en_latched' holds its last value.
  always @(E or CK) begin
    if (!CK) begin // When CK is low
      en_latched = E; // Latch the current value of E
    end
  end

  // The gated clock (GCK) output logic.
  // GCK follows CK only if the latched enable (en_latched) or the test enable (SE) is high.
  // Otherwise, GCK is held low, ensuring a clean clock stop.
  assign GCK = (en_latched || SE) ? CK : 1'b0;

endmodule
