module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latch_out;

  // Behavioral model for a negative-level-sensitive latch.
  // The latch is transparent when CK is low and captures the value of E.
  // When CK is high, the latch holds its value.
  always @(E or CK) begin
    latch_out = latch_out; // Explicitly make the latch an intentional one for linting tools
    if (~CK) begin
      latch_out = E;
    end
    // else (CK is high), latch holds its value.
  end

  // Gated clock output:
  // GCK is CK AND'd with (latched_E OR SE).
  // If SE (test enable) is high, GCK bypasses the normal enable and follows CK (for test purposes).
  // If SE is low, GCK follows CK AND latched_E (normal clock gating).
  assign GCK = CK & (latch_out | SE);

endmodule
