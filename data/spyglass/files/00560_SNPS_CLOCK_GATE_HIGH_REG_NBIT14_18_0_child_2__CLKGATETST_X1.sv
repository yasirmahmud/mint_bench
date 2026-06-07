module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg en_latch; // Latch for the enable signal

  // synopsys template_latch
  // The enable signal (E) is latched when CK is low (negative level sensitive).
  always @(E or CK) begin
    if (!CK) begin // Transparent when CK is low
      en_latch = E;
    end
  end

  // The gated clock (GCK) is generated based on the latched enable and CK.
  // If SE (Test Enable) is high, it typically forces the clock gate to be open,
  // allowing CK to pass through directly. Otherwise, the clock is gated by en_latch.
  assign GCK = SE ? CK : (CK & en_latch);

endmodule
