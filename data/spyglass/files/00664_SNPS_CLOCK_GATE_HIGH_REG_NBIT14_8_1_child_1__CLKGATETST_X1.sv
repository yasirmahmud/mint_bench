// Behavioral model for the CLKGATETST_X1 clock gating cell.
// This definition resolves the "ErrorAnalyzeBBox" violation
// by providing an explicit definition for the black-boxed module.
// It models a glitch-free clock gate where the enable (E | SE) is latched
// when the clock (CK) is low, and the gated clock (GCK) is outputted
// only when CK is high and the latched enable is active.
module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  wire effective_en = E | SE; // Combine enable and test enable

  reg latch_q; // Latch output for glitch-free operation

  // Level-sensitive latch: transparent when CK is low, holds when CK is high
  always @ (effective_en or CK) begin
    if (!CK) begin // When CK is low, latch is transparent
      latch_q = effective_en;
    end
    // When CK is high, the latch holds its value, preventing glitches
  end

  // Gated clock output: CK is passed only when latched_enable is high
  assign GCK = CK & latch_q;

endmodule
