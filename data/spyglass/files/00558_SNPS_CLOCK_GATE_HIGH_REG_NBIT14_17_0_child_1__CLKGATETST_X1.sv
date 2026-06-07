module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latched;

  // This models a negative-level sensitive latch for the enable signal.
  // When CK is low, the latch is transparent and 'enable_latched' follows 'E'.
  // When CK is high, the latch holds its value.
  always @(CK or E) begin
    if (!CK) begin
      enable_latched = E; // Use blocking assignment for combinational latch behavior
    end
  end

  // The gated clock is the input clock ANDed with the latched enable or test enable.
  // This ensures the gated clock only passes when the enable is active,
  // and the latch prevents glitches on the output when the enable changes
  // while the clock is high.
  assign GCK = CK & (enable_latched | SE);

endmodule
