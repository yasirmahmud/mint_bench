module CLKGATETST_X1 (
    input CK,  // Clock
    input E,   // Functional Enable
    input SE,  // Scan/Test Enable
    output GCK // Gated Clock
);

    wire effective_en = E | SE; // Combine functional and test enable (SE typically overrides E)
    reg enable_state;           // State of the enable latch

    // This is a level-sensitive latch, transparent when CK is LOW.
    // When CK is high, enable_state holds its value.
    // This ensures that the enable signal can change while CK is low,
    // and the new state is captured before CK goes high, preventing glitches.
    always @(CK or effective_en) begin
        if (!CK) begin // Latch is transparent when CK is low
            enable_state = effective_en;
        end
        // else (CK is high), enable_state holds its previous value
    end

    // The gated clock is the clock ANDed with the output of the enable latch.
    // This structure is critical for glitch-free clock gating.
    assign GCK = CK & enable_state;

endmodule
