module CLKGATETST_X1 (CK, E, SE, GCK);
  input CLK, E, SE;
  output GCK;

  reg gate_enable_latched;
  wire effective_E;

  // Combine functional enable (E) and test enable (SE)
  // Test enable (SE) takes precedence, forcing the gate open.
  assign effective_E = E | SE;

  // Latch for the enable signal. This latch is transparent when CK is low.
  // It captures the effective_E value during the low phase of the clock.
  // When CK goes high, the latch becomes opaque, holding its value.
  // This ensures that the enable signal for the clock gate is stable during the high phase of CK.
  always @(effective_E or CK) begin
    if (!CK) begin // Latch is transparent when CK is low
      gate_enable_latched = effective_E;
    end
    // When CK is high, gate_enable_latched holds its value, making it stable.
  end

  // The gated clock output is the logical AND of the input clock and the latched enable.
  assign GCK = CLK & gate_enable_latched;

endmodule
