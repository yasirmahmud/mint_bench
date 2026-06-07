module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

    reg en_latch;

    // Latch the enable signal 'E' when 'CK' is low
    // This forms a transparent latch. When CK is low, 'en_latch' follows 'E'.
    // When CK is high, 'en_latch' holds its value.
    always @(E or CK) begin
        if (!CK) begin
            en_latch = E;
        end
    end

    // Gated clock output
    // The gated clock 'GCK' is active only when 'CK' is high
    // AND (the latched enable 'en_latch' is high OR the test enable 'SE' is high).
    assign GCK = CK & (en_latch | SE);

endmodule
