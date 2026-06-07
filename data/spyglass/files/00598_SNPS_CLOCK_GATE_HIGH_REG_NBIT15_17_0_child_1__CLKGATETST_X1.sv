module CLKGATETST_X1 ( output GCK, input CK, E, SE );
  reg EN_latch;

  // This models a glitch-free clock gate with a transparent latch for the enable signal.
  // The latch captures the (E | SE) value when CK is low.
  // When CK is high, the latch holds its value, ensuring EN_latch does not change
  // during the active phase of CK, thus preventing glitches on GCK.
  always @(CK, E, SE) begin
    if (!CK) begin // Latch is transparent when CK is low
      EN_latch = E | SE; // If SE is high, the gate is effectively always enabled. Otherwise, E controls it.
    end
    // Else (CK is high), EN_latch holds its previous value (implicit latch).
  end

  // The actual gated clock output is the AND of the clock and the latched enable.
  // GCK follows CK only when EN_latch is high.
  assign GCK = EN_latch & CK;
endmodule
