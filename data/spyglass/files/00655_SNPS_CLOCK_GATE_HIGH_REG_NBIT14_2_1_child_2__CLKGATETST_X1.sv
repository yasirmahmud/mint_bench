// Definition for CLKGATETST_X1
module CLKGATETST_X1 (
    input CK,
    input E,
    input SE,
    output GCK
);

    reg latched_e_val; // Value held by the internal latch

    // Behavioral model for a common clock gating cell:
    // The enable (E) signal is captured by a latch which is transparent when CK is low.
    // When CK goes high, the latch holds its value.
    // SE (Test Enable) is typically used to force the enable high for test purposes,
    // ensuring the clock propagates unconditionally during test.
    always @* begin // Changed sensitivity list to @* to help linters recognize complete logic
        if (SE) begin
            latched_e_val = 1'b1; // Force enable high during test
        end else if (!CK) begin // Latch is transparent when CK is low
            latched_e_val = E;
        end
        // else (when CK is high and SE is low) latched_e_val holds its previous value
        // This implicit hold behavior is essential for a clock gating latch.
    end

    // The gated clock (GCK) is the input clock (CK) ANDed with the latched enable value.
    assign GCK = CK & latched_e_val;

endmodule
