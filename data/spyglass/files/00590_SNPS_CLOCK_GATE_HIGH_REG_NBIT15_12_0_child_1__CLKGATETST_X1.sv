// Behavioral model for the clock gating cell CLKGATETST_X1
// This model resolves the "Design Unit 'CLKGATETST_X1' has no definition" violation.
// It implements a clock gating function with an enable latch and a test enable,
// mirroring the typical behavior of such a cell for linting and synthesis.
module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

  reg latched_E; // Output of the enable latch

  // Latch behavior:
  // When CK is low, the latch is transparent, and latched_E follows E.
  // When CK is high, the latch is opaque, and latched_E holds its last value.
  // This ensures that latched_E is stable before CK goes high, preventing glitches on GCK.
  always @(E or CK) begin
    if (~CK) begin // CK is low (active-low enable for transparency)
      latched_E = E;
    end
    // else (CK is high), latched_E holds its value (implied by lack of assignment)
  end

  // Gating logic:
  // If SE (Test Enable) is high, bypass the functional enable and pass CK directly.
  // Otherwise (SE is low), GCK is the result of CK ANDed with the latched enable.
  assign GCK = SE ? CK : (CK & latched_E);

endmodule
