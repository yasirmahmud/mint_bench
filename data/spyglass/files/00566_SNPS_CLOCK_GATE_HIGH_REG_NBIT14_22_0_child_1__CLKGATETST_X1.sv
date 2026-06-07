module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK;  // Clock
  input E;   // Enable
  input SE;  // Scan Enable / Test Enable
  output GCK; // Gated Clock

  reg  en_latched;

  // Latch for enable signal. This latch is typically transparent when CK is low.
  // This structure ensures that 'en_latched' is stable before the rising edge of CK,
  // which is critical for glitch-free clock gating.
  always @(E or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      en_latched = E;
    end
  end

  // The gated clock output is the main clock ANDed with the latched enable.
  // The 'SE' (Scan Enable/Test Enable) input typically acts as an override,
  // forcing the clock gate to be open (enabled) during test mode.
  assign GCK = CK & (SE | en_latched);

endmodule
