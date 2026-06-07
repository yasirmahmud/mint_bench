module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latch_val;

  // Behavioral model for a clock gate enable latch:
  // The latch is transparent when the clock (CK) is low (active low enable phase),
  // and holds its value when CK is high.
  always @* begin // Changed sensitivity list to @* to satisfy linting tools for intended latches
    if (!CK) begin // When clock is low, the latch follows the enable input 'E'
      enable_latch_val = E;
    end
    // If CK is high, enable_latch_val holds its previous value (latch is opaque)
  end

  // Gated clock (GCK) generation:
  // GCK is the main clock (CK) ANDed with the latched enable value or the test enable (SE).
  // If either enable_latch_val or SE is high, the clock passes through.
  assign GCK = CK & (enable_latch_val | SE);

endmodule
