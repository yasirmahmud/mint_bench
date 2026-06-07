// Behavioral model for the CLKGATETST_X1 clock gate cell
// This module implements a standard clock gate with a negative-transparent latch
// for the enable signal.
// .CK  : Clock input
// .E   : Enable input (active high)
// .SE  : Test/Scan Enable input (active high, overrides E)
// .GCK : Gated Clock output
module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg en_latch_out; // Output of the enable latch

  // The enable latch is transparent when CK is low and holds its value when CK is high.
  // This ensures that EN can only change the latch state when CLK is low,
  // preventing glitches on the gated clock when EN changes during CLK high.
  always @(E or CK) begin
    if (!CK) begin // When CK is low, latch is transparent
      en_latch_out = E;
    end
    // When CK is high, en_latch_out holds its previous value.
  end

  // The gated clock is the input clock ANDed with the latched enable (or test enable).
  // If SE is high, it overrides E and forces the clock to pass (GCK = CK).
  assign GCK = CK & (en_latch_out | SE);

endmodule
