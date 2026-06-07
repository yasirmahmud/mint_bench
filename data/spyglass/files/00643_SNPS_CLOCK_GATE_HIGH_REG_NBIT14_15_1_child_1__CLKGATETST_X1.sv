module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

    // Internal register for the latched enable signal
    reg  internal_en_latched;

    // Behavioral model for a level-sensitive latch (transparent when CK is low).
    // This ensures that the enable signal is stable during the high phase of CK,
    // preventing glitches on the gated clock output.
    always @(CK or E or SE) begin
        if (~CK) begin // Latch is transparent when CK is low
            internal_en_latched = E | SE; // Capture E OR SE
        end
        // Else, when CK is high, internal_en_latched holds its value.
    end

    // The gated clock output (GCK) is the result of ANDing the clock (CK)
    // with the latched enable signal (internal_en_latched).
    // This creates a glitch-free gated clock: GCK will only follow CK when
    // internal_en_latched is high, and internal_en_latched only changes when
    // CK is low, ensuring GCK is also low at that point.
    assign GCK = CK & internal_en_latched;

endmodule
