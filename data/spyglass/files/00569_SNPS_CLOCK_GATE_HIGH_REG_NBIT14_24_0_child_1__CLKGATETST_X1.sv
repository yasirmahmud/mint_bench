module CLKGATETST_X1 ( CK, E, SE, GCK );
  input CK, E, SE;
  output GCK;

  reg en_latch;

  // Latch the enable signal when clock is low
  always @(CK or E) begin
    if (!CK) begin
      en_latch = E;
    end
  end

  // Gated clock output
  // GCK is high only when CK is high AND (en_latch is high OR SE is high).
  // This models SE as a bypass/force enable high for testing.
  assign GCK = CK & (en_latch | SE);

endmodule
