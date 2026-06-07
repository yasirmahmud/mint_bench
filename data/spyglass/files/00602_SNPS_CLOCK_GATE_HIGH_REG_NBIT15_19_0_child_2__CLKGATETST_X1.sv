module CLKGATETST_X1 (
  input CK,  // Clock
  input E,   // Enable
  input SE,  // Scan Enable / Test Enable
  output GCK  // Gated Clock
);

  reg en_latch; // Latch to store the enable signal

  // Level-sensitive latch for the enable signal 'E'
  // It is transparent when CK is high, and holds its value when CK is low.
  (* syn_preserve_latch = 1 *) // Attribute to explicitly mark this as an intentional latch
  always @(CK or E) begin
    if (CK) begin
      en_latch = E;
    end
    // If CK is low, en_latch holds its previous value (implied by no assignment in else block)
  end

  // Gated clock generation
  // If SE (test enable) is active (high), it forces the enable high to allow clock propagation
  // for test purposes, overriding the functional enable 'en_latch'.
  // Otherwise, the clock is gated by the latched functional enable.
  assign GCK = CK & (en_latch | SE);

endmodule
