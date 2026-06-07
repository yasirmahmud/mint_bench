module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latch_q; // Q output of the enable latch

  // Enable input to the latch. The 'E' and 'SE' are OR'd.
  wire active_en = E | SE;

  // Latch behavior: A negative transparent latch is commonly used for clock gating.
  // This latch is transparent when CK is low and holds its value when CK is high.
  always_latch begin
    if (!CK) begin // When clock is low, the latch is transparent
      latch_q = active_en;
    end
    // else (CK is high), latch_q holds its value
  end

  // The gated clock output GCK is the AND of the latched enable and the clock.
  // This ensures that GCK only goes high when CK is high AND the enable is latched high.
  assign GCK = latch_q & CK;

endmodule
