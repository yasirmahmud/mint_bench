// Behavioral model for CLKGATETST_X1 to resolve ErrorAnalyzeBBox violation
// This implements a latch-based clock gating mechanism with a test enable (SE).
// The enable signal (E) is latched when the clock (CK) is low. The gated clock (GCK)
// is produced by ANDing CK with the latched enable or forcing it open via SE.
module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  (* LATCH = "TRUE" *) reg  latch_q; // Latched enable signal

  // D-latch: transparent when CK is low, captures E
  always @(E or CK) begin
    if (!CK) begin
      latch_q <= E;
    end
  end

  // Gated clock output: CK ANDed with (latched enable OR test enable)
  // If SE is high, the clock is forced ON (GCK = CK).
  // Otherwise, GCK = CK & latch_q.
  assign GCK = CK & (latch_q | SE);
endmodule
