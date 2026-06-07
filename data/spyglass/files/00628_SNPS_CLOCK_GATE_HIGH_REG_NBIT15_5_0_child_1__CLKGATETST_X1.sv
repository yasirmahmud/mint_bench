module CLKGATETST_X1 (
  input CK,  // Clock input
  input E,   // Enable input
  input SE,  // Test Enable input
  output GCK // Gated Clock output
);

  reg en_latch_q; // Output of the active-low transparent latch

  // Active-low transparent latch for the enable signal
  // en_latch_q follows E when CK is low
  // en_latch_q holds its value when CK is high
  always @(E or CK) begin
    if (!CK) begin 
      en_latch_q = E;
    end
  end

  // Gated clock generation
  // GCK is high only when CK is high AND (en_latch_q is high OR SE is high)
  // SE acts as a test enable, bypassing the normal enable logic.
  assign GCK = CK & (en_latch_q | SE);

endmodule
