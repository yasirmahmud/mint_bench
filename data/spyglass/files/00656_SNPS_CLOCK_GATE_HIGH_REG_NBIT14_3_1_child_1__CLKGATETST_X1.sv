// Definition of CLKGATETST_X1 to resolve the black-box error.
// This module implements a basic clock gating cell with a negative-transparent latch
// for the enable signal and a test enable override.
module CLKGATETST_X1 (
    input CK,  // Clock input
    input E,   // Enable input
    input SE,  // Scan Enable / Test Enable input
    output GCK // Gated Clock output
);

    // Register to hold the latched enable value
    reg latched_E;

    // Level-sensitive latch for the enable signal.
    // The latch is transparent when CK is low and holds its value when CK is high.
    // This ensures that the enable signal is stable during the active phase (high) of CK,
    // preventing glitches on GCK if E changes while CK is high.
    always @(E or CK) begin
        if (!CK) begin // Transparent when CK is low
            latched_E = E;
        end
        // When CK is high, latched_E holds its previous value (implicit latch behavior)
    end

    // Generate the gated clock.
    // GCK is the input clock ANDed with either the latched enable or the test enable.
    // SE (Test Enable) provides an override, allowing the clock to pass regardless of E.
    assign GCK = CK & (latched_E | SE);

endmodule
