module CLKGATETST_X1 (
    input CK,   // Input clock
    input E,    // Enable signal
    input SE,   // Test Enable / Scan Enable signal
    output GCK  // Gated clock output
);

    reg latched_E; // Internal signal to store the latched enable

    // Behavioral model for a clock gate latch:
    // The enable signal (E) is latched when the clock (CK) is low.
    // The Test Enable (SE) can override or combine with E.
    // When CK is low, latched_E is transparently updated with (E | SE).
    // When CK is high, latched_E holds its value, acting as a latch.
    always @(CK or E or SE) begin
        if (~CK) begin // Clock is low, latch is transparent
            latched_E = E | SE; // Combine enable and test enable
        end
    end

    // The gated clock (GCK) follows CK only if the latched enable is high.
    // If latched_E is low, GCK is held low.
    assign GCK = CK & latched_E;

endmodule
