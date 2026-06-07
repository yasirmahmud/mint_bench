module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg latch_q;
  wire combined_en = E | SE;

  // Level-sensitive latch for the enable signal
  // It is transparent when CK is low, and holds its value when CK is high.
  always @(CK or combined_en) begin
    if (!CK) begin
      latch_q = combined_en;
    end
    // When CK is high, latch_q holds its previous value (inferred latch).
  end

  // Gated clock is the input clock ANDed with the latched enable.
  // This prevents glitches and ensures the clock only passes when enabled.
  assign GCK = CK & latch_q;

endmodule
