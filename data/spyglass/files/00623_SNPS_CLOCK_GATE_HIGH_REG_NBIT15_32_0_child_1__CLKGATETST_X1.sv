// Behavioral model for the clock gate cell 'CLKGATETST_X1'
// This module implements a standard clock gate with an enable latch and a test enable (SE).
// The enable 'E' is latched by the negative phase of 'CK'.
// The 'SE' signal acts as a test enable, forcing the clock to pass through when high.
module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK, E, SE;
  output GCK;

  reg internal_en_latch;

  // Negative-level-sensitive latch for enable 'E'.
  // The latch is transparent when CK is low, and holds its value when CK is high.
  always @(E or CK) begin
    if (!CK) begin
      internal_en_latch = E;
    end
  end

  // Gated clock output logic:
  // If SE (test enable) is high, the clock passes through directly (GCK = CK).
  // Otherwise, GCK is the logical AND of CK and the latched enable (internal_en_latch).
  assign GCK = SE ? CK : (CK & internal_en_latch);

endmodule
