module CLKGATETST_X1 (
  input CK,
  input E,
  input SE,
  output GCK
);

  reg latched_enable;

  // This implements a clock gating latch. 
  // The effective enable signal (E OR SE) is latched.
  // The latch is transparent when CK is low, and holds its value when CK is high.
  // SE is assumed to be an active-high test enable that forces the clock to pass.
  always @(CK, E, SE) begin
    if (!CK) begin // Transparent when CK is low
      latched_enable = E | SE; // Update latched_enable with (E OR SE)
    end
    // else (CK is high), latched_enable holds its previous value
  end

  // The gated clock (GCK) is the input clock (CK) ANDed with the latched enable.
  // This ensures the clock passes only when the latched enable is high and CK is high.
  assign GCK = CK & latched_enable;

endmodule
