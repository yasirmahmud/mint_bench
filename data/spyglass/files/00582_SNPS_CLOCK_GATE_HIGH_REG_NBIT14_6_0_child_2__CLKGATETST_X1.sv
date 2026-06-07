// Definition for CLKGATETST_X1 to resolve ErrorAnalyzeBBox violation.
// This module implements a basic glitch-free clock gating cell with a test enable.
// It uses a low-level transparent latch for the enable signal.
module CLKGATETST_X1 (CK, E, SE, GCK);
  input CK;   // Clock input
  input E;    // Enable input
  input SE;   // Scan/Test Enable input (active high for bypass)
  output GCK; // Gated Clock output

  reg  en_latch_q; // Internal register for the latched enable signal

  // Latch for the enable signal 'E'.
  // It is transparent when CK is low (active-low transparent latch).
  // It holds its value when CK is high.
  always_latch begin
    if (~CK) begin // If CK is low, latch is transparent
      en_latch_q = E;
    end
    // Else (CK is high), en_latch_q holds its value.
  end

  // Generate the gated clock output 'GCK'.
  // If SE is high (test mode), GCK bypasses the gating and directly outputs CK.
  // Otherwise (functional mode), GCK is CK ANDed with the latched enable (en_latch_q).
  assign GCK = SE ? CK : (CK & en_latch_q);

endmodule
