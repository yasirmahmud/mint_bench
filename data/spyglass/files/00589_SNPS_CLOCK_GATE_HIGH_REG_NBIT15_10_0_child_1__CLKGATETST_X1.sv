module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg enable_latch;

  // This latch is transparent when CK is low and holds its value when CK is high.
  // This models a typical clock gate enable latch which captures the enable state
  // when the clock is low, to control the next positive clock edge.
  always @(E or CK) begin
    if (!CK) begin
      enable_latch = E;
    end
    // else, enable_latch holds its value when CK is high
  end

  // Gated clock output logic:
  // If SE (Test Enable) is high, the clock is passed unconditionally (test mode).
  // If SE is low, the clock is gated by the latched enable signal.
  assign GCK = SE ? CK : (CK & enable_latch);

endmodule
