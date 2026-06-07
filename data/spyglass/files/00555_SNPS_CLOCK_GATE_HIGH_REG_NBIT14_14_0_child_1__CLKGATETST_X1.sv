module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);
    reg  en_latched;

    // Level-sensitive latch for enable 'E'
    // Transparent when CK is low, holds value when CK is high.
    always @(E or CK) begin
        if (!CK) begin // When CK is low, latch is transparent
            en_latched = E;
        end
        // When CK is high, en_latched holds its value (implied by no else branch).
        // This models a positive latch whose enable is active low (tied to !CK).
    end

    // Gated clock generation
    // GCK is the clock 'CK' ANDed with the effective enable.
    // The effective enable is 'en_latched' OR 'SE' (test enable).
    // This ensures that when SE is high, the clock passes regardless of 'E'.
    // It also ensures glitch-free operation because 'en_latched' only changes when 'CK' is low.
    assign GCK = CK & (en_latched | SE);

endmodule // CLKGATETST_X1
