module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  // Internal register to latch the enable signal
  reg internal_en;

  // Level-sensitive latch for the enable signal.
  // It is transparent when CK is low and holds its value when CK is high.
  // This is a common method in clock gating to prevent glitches on GCK if E changes while CK is high.
  always @(CK or E) begin
    if (!CK) begin // When CK is low, the latch is transparent
      internal_en = E;
    end
    // When CK is high, the latch holds its value.
    // In Verilog, if a 'reg' is not assigned a value in an 'always' block for a specific condition,
    // it implicitly holds its previous value, modeling a latch.
  end

  // Generate the gated clock output (GCK)
  // If SE (Test Enable) is high, bypass the clock gating and pass CK directly.
  // Else (SE is low), gate CK with the latched enable signal (internal_en).
  assign GCK = SE ? CK : (CK & internal_en);

endmodule
