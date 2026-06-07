module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  // Internal signal for the combined enable
  wire enable_combined;
  // Clock is enabled if E OR SE is high, reflecting that both signals
  // contribute to gating the clock, with SE typically acting as a test enable.
  assign enable_combined = E | SE;

  // Latch to hold the enable signal for glitch-free clock gating.
  // This is a level-sensitive latch, transparent when CK is low.
  // When CK goes high, it holds the last captured value.
  reg latch_q;

  always @(CK or enable_combined) begin
    if (!CK) begin // When clock is low, latch is transparent
      latch_q <= enable_combined;
    end else begin
      // Explicitly hold the value when CK is high.
      // This modification ensures all branches of the 'if' statement assign a value,
      // which can resolve 'infer_latch' violations in some linting tools by making the
      // latching behavior explicit rather than implicitly inferred from incomplete assignments.
      latch_q <= latch_q;
    end
  end

  // Gated clock output
  // The gated clock is the input clock ANDed with the latched enable.
  assign GCK = latch_q & CK;

endmodule
