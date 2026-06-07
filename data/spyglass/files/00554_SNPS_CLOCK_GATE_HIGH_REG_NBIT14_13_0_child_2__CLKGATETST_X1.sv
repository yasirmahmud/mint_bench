module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg en_latch;

  // Latch the enable signal (E) when the clock (CK) is low.
  // This ensures glitch-free operation, as E is captured during the low phase of CK.
  // spyglass disable_rule InferLatch
  always @(E or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      en_latch = E;
    end
    // When CK is high, en_latch holds its value, effectively inferring a level-sensitive latch.
  end
  // spyglass enable_rule InferLatch

  // The gated clock (GCK) is produced by ANDing the clock (CK)
  // with the latched enable (en_latch) OR the test enable (SE).
  // If SE is high, it bypasses the enable latch and effectively forces the gate open,
  // allowing CK to pass through. Otherwise, CK is passed only when en_latch is high.
  assign GCK = CK && (en_latch || SE);

endmodule
