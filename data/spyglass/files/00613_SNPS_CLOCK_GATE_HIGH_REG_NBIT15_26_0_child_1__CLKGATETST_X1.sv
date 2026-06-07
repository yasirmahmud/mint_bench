module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latch;

  // Latch for enable signal
  // Transparent when CK is low, holds its value when CK is high.
  // This prevents glitches by only allowing E to change state when CK is low.
  always @(E or CK) begin
    if (!CK) begin
      enable_latch = E;
    end
  end

  // Gated clock output
  // GCK follows CK only when enable_latch is high OR SE is high (test enable override).
  assign GCK = CK & (enable_latch | SE);

endmodule // CLKGATETST_X1
