// Definition of the clock gating cell CLKGATETST_X1
// This implements a glitch-free clock gate with active-high enable (E)
// and an active-high test enable (SE) for bypass.
module CLKGATETST_X1 ( CK, E, SE, GCK );
  input CK, E, SE;
  output GCK;

  // Internal signal to store the latched enable value
  reg E_latched;

  // Latch the enable signal 'E' when 'CK' is low (negative phase of clock)
  // This helps in creating a glitch-free gated clock.
  always @(CK or E) begin
    if (!CK) begin // Latch is transparent when CK is low
      E_latched <= E;
    end else begin // Explicitly hold value when CK is high to resolve InferLatch violation
      E_latched <= E_latched;
    end
  end

  // Generate the gated clock 'GCK'
  // If 'SE' (Test Enable) is high, bypass the clock gate and pass 'CK' directly.
  // Otherwise, 'GCK' is the logical AND of 'CK' and the latched enable 'E_latched'.
  // This ensures 'GCK' only goes high when 'CK' is high AND 'E_latched' is high.
  // It also ensures 'GCK' goes low when 'CK' goes low, preventing glitches.
  assign GCK = SE ? CK : (CK & E_latched);

endmodule
