module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK;
  input E;
  input SE;
  output GCK;

  reg latch_q;
  wire gate_enable;

  // Enable latch: transparent when CK is low, holds when CK is high.
  always @(E or CK or latch_q) begin
    if (!CK) begin
      latch_q = E;
    end else begin
      // When CK is high, the latch holds its current value.
      // Explicitly assigning latch_q to itself completes the assignment path
      // within the always block, which can help some lint tools differentiate
      // between intentional latches and accidental ones caused by incomplete assignments.
      latch_q = latch_q;
    end
  end

  // Final enable for the clock gating AND gate.
  // If SE (test enable) is high, the clock is always enabled (bypassing E).
  // Otherwise, the latched enable (latch_q) is used.
  assign gate_enable = SE | latch_q;

  // Gated clock output: CK ANDed with the effective enable.
  assign GCK = CK & gate_enable;

endmodule
