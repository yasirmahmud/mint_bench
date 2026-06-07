module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);
  reg latched_E;

  // Implement a negative-level sensitive latch for the enable signal 'E'.
  // The latch is transparent when CK is low and holds its value when CK is high.
  // This behavior is typical for a glitch-free clock gate.
  always @(E or CK) begin
    if (!CK) begin // When CK is low, the latch is transparent
      latched_E = E;
    end
    // When CK is high, latched_E holds its previous value (implicit latch)
  end

  // Implement the clock gating logic.
  // If SE (test-enable) is high, the gated clock (GCK) directly follows CK (bypass mode for testing).
  // Otherwise, GCK is the result of CK ANDed with the latched enable signal (latched_E).
  assign GCK = SE ? CK : (latched_E & CK);

endmodule
