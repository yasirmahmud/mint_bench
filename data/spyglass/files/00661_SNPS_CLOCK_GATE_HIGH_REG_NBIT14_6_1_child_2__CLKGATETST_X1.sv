module CLKGATETST_X1 (
  input CK,
  input E,
  input SE, // Test Enable
  output GCK
);

  // Behavioral model for a glitch-free clock gate with test enable.
  // The enable signal 'E' is latched by the falling edge or low phase of 'CK'.
  // The test enable 'SE' bypasses the latch and forces the clock through.

  reg enable_latch_q; // Represents the latched enable value

  // Level-sensitive latch: transparent when CK is low, holds value when CK is high.
  // This models the enable latch that captures 'E' when 'CK' is low,
  // preventing glitches on 'GCK' during the rising edge of 'CK'.
  // Using always_latch to explicitly indicate an intentional latch, resolving the InferLatch violation.
  always_latch begin
    if (!CK) begin // When clock is low, the latch is transparent
      enable_latch_q = E;
    end
    // else, enable_latch_q holds its value (when CK is high)
  end

  // Gated clock output:
  // GCK is high only if CK is high AND (latched_E is high OR SE is high).
  // This ensures GCK goes low when CK goes low, and only goes high if the enable condition is met.
  assign GCK = CK & (enable_latch_q | SE);

endmodule
