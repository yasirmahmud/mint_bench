module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

    reg en_latched;

    // Clock gating latch logic:
    // The enable signal (E) is latched. This latch is transparent when CK is low
    // and holds its value when CK is high. This ensures that the 'en_latched'
    // signal is stable when CK transitions from low to high, preventing glitches
    // on the gated clock output (GCK).
    always @(E or CK) begin
        if (!CK) begin // Latch is transparent when CK is low
            en_latched = E;
        end
        // When CK is high, en_latched holds its last value.
    end

    // Output logic for the gated clock (GCK):
    // If SE (Test Enable) is active (high), the clock gating is bypassed,
    // and CK is passed directly to GCK (for testability).
    // Otherwise, CK is gated with the latched enable signal (en_latched).
    assign GCK = SE ? CK : (en_latched & CK);

endmodule
