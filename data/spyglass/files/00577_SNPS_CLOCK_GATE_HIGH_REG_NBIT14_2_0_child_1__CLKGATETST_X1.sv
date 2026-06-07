module CLKGATETST_X1 (
  input CK,  // Clock Input
  input E,   // Enable Input
  input SE,  // Test Enable Input
  output GCK // Gated Clock Output
);

  // Behavioral model for a clock gate with an enable latch and test enable.
  // The enable signal (E) is latched when the clock (CK) is low.
  // The gated clock (GCK) is asserted when CK is high AND (latched E OR Test Enable SE) is high.
  // GCK is always deasserted when CK is low.

  reg en_latch_q;

  // Level-sensitive latch for the enable signal.
  // Transparent when CK is low, holds its value when CK is high.
  always @(E or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      en_latch_q = E;
    end
    // else when CK is high, en_latch_q holds its value.
  end

  // Gated clock output logic.
  // GCK is CK ANDed with (latched E OR Test Enable SE).
  // This ensures GCK is low when CK is low, and passes CK's high pulse only when enabled.
  assign GCK = CK & (en_latch_q | SE);

endmodule
