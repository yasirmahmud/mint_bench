module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latched_E_q;

  // Behavioral model for a positive transparent latch for the enable signal E.
  // The latch is transparent when CK is high and holds its value when CK is low.
  always @(E or CK) begin
    if (CK) begin
      latched_E_q = E;
    end
  end

  // Gated clock output.
  // GCK is enabled when CK is high AND (latched_E_q is high OR SE is high).
  // This models SE (Test Enable) as an override to force the clock ON for testing purposes.
  assign GCK = CK & (latched_E_q | SE);

endmodule
