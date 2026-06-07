// Definition of the clock gating cell CLKGATETST_X1
// This module implements a common glitch-free clock gating cell using a negative-level sensitive latch
// to control the enable signal, thereby preventing glitches on the rising edge of the clock.
module CLKGATETST_X1 (
    input CK,  // Clock input
    input E,   // Functional Enable input
    input SE,  // Test Enable (Scan Enable) input
    output GCK // Gated Clock output
);

    wire effective_E;
    reg  latch_q;

    // Combine functional enable (E) and test enable (SE).
    // A common interpretation for 'SE' in clock gates is to force the enable high
    // during test/scan operations, effectively keeping the clock gate 'open'.
    assign effective_E = E | SE;

    // Negative-level sensitive latch for the effective enable signal (effective_E).
    // The latch is transparent when the clock (CK) is low (active-low enable).
    // When CK is high, the latch holds its last value.
    always @* begin
        if (~CK) begin // If clock is low (negative phase)
            latch_q = effective_E; // Latch is transparent, pass through effective_E
        end
        // else (CK is high), latch_q holds its current value (inferred latch behavior)
    end

    // Gated clock generation: AND the input clock (CK) with the latched enable (latch_q).
    // This ensures that the gated clock (GCK) transitions only when CK goes high,
    // and only if latch_q is high, providing a glitch-free clock gating mechanism.
    assign GCK = CK & latch_q;

endmodule
