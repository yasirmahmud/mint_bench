// Definition of the clock gating cell CLKGATETST_X1
// This module implements a common clock gating cell structure.
// It uses a level-sensitive latch to capture the enable signal 'E'
// when the clock 'CK' is low. The latched enable, combined with the
// test enable 'SE', controls an AND gate with 'CK' to generate the
// gated clock 'GCK'. If 'SE' is high, the clock is always passed through
// for test purposes, bypassing the enable 'E'.
module CLKGATETST_X1 (
  input CK,   // Clock input
  input E,    // Enable input
  input SE,   // Test Enable input (active high)
  output GCK  // Gated Clock output
);

  reg  q_latch_reg;        // Internal register for the latched enable
  wire enable_for_gating;  // Wire for the effective enable, considering SE

  // Level-sensitive latch for the enable signal 'E'.
  // This latch is transparent when the clock 'CK' is low (active low transparency).
  // When 'CK' is low, 'q_latch_reg' follows 'E'.
  // When 'CK' goes high, 'q_latch_reg' holds its last value from when 'CK' was low.
  // This ensures that 'E' is stable when 'CK' rises, preventing glitches on GCK.
  always @(E or CK) begin
    if (!CK) begin // If CK is low, latch is transparent
      q_latch_reg = E;
    end
  end

  // Logic to incorporate the Test Enable (SE) signal.
  // If 'SE' is high, 'enable_for_gating' becomes high, effectively bypassing 'E'
  // and forcing the clock gate to pass the clock for testing purposes.
  // If 'SE' is low, 'enable_for_gating' is determined solely by the latched enable 'q_latch_reg'.
  assign enable_for_gating = q_latch_reg | SE;

  // Final clock gating logic.
  // The Gated Clock 'GCK' is produced by ANDing the main clock 'CK'
  // with the effective enable signal 'enable_for_gating'.
  assign GCK = CK & enable_for_gating;

endmodule
