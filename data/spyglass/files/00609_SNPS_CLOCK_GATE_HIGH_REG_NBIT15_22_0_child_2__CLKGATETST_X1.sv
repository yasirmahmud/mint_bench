module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latched;
  wire combined_enable;

  // Combine enable (E) and test enable (SE)
  // A common interpretation for SE in clock gates is to override E for test purposes,
  // effectively enabling the gate when SE is active.
  assign combined_enable = E | SE;

  // Latch for enable signal, transparent when CK is low, holds when CK is high.
  // This models a common high-active clock gate enable latch where the enable
  // is sampled on the negative phase of the clock.
  // To resolve SpyGlass InferLatch violation, the explicit sensitivity list is used.
  always @(CK or combined_enable) begin
    if (!CK) begin // Latch is transparent when CK is low
      enable_latched = combined_enable;
    end
    // else (CK is high), enable_latched holds its value
  end

  // Gated clock is the input clock ANDed with the latched enable
  assign GCK = CK & enable_latched;

endmodule
