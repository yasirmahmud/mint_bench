module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);
    reg E_latched; // The output of the enable latch
    wire GCK_gated_internal; // The gated clock before test mode selection

    // Behavioral model for the enable latch
    // This latch is transparent when CK is low (active-low enable phase)
    // and holds its value when CK is high.
    // This ensures that E is stable before the rising edge of CK.
    always @(E or CK) begin
        if (!CK) begin // Transparent when CK is low
            E_latched = E;
        end
        // When CK is high, E_latched holds its value.
    end

    // Gated clock generation: AND operation of CK and the latched enable
    assign GCK_gated_internal = CK && E_latched;

    // Test mode bypass: If SE is high, output CK directly; otherwise, output the gated clock
    assign GCK = SE ? CK : GCK_gated_internal;

endmodule
