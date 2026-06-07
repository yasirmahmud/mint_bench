// Definition of CLKGATETST_X1 to resolve black-box violation.
// This is a behavioral model of a glitch-free clock gate with a test enable (SE).
// In normal mode (SE=0), the enable signal E is latched when CK is low
// to ensure glitch-free operation of the gated clock (GCK).
// In test mode (SE=1), the clock is unconditionally enabled.
module CLKGATETST_X1 (
  input CK,
  input E,
  input SE, // Test Enable (active high to bypass clock gating)
  output GCK
);
  reg  latched_E;

  always @(E or CK or SE) begin
    if (SE) begin
      latched_E = 1'b1; // In test mode, force enable to high
    end else begin
      if (CK == 1'b0) begin // Latch is transparent when CK is low
        latched_E = E;
      end
      // When CK is high, latched_E holds its value.
      // This ensures latched_E is stable when CK is rising, preventing glitches on GCK.
    end
  end

  // The gated clock is the input clock ANDed with the latched enable.
  assign GCK = CK & latched_E;

endmodule
