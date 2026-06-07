module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg en_latched;

  // Latch for the effective enable signal (E OR SE).
  // The latch is transparent when CK is high, and holds its value when CK is low.
  always @(CK or E or SE) begin
    if (CK == 1'b1) begin
      en_latched = E | SE;
    end
    // When CK is low, en_latched holds its previous value (implied by no 'else' assignment)
  end

  // The gated clock output is the logical AND of the input clock and the latched enable.
  assign GCK = CK & en_latched;

endmodule
