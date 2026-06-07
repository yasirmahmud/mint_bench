module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);
    reg EN_latch;

    // This behavioral model implements a common clock gating latch with test enable.
    // It resolves the black-box violation by providing a definition for CLKGATETST_X1
    // while preserving the intended functional behavior of a clock gate.
    // The enable signal (E) is latched when the clock (CK) is low.
    // In test mode (SE high), the clock is typically enabled unconditionally.
    always @(SE or E or CK) begin
        if (SE) begin
            // In test mode, force the enable high to pass the clock, or bypass the normal enable logic.
            EN_latch = 1'b1;
        end else if (!CK) begin
            // When the clock is low, latch the enable signal.
            EN_latch = E;
        end
        // When CK is high and SE is low, EN_latch holds its value from when CK was low.
    end

    // The gated clock (GCK) is the input clock (CK) ANDed with the latched enable.
    assign GCK = CK & EN_latch;
endmodule
