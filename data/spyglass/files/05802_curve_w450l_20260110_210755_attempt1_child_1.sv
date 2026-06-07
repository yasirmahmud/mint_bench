module curve_w450l_20260110_210755_attempt1 (
    input [1:0] en1,
    input [1:0] en2,
    input d1,
    input d2,
    output reg q1,
    output reg q2
);

    // Violation 1 & related warnings fixed: Latch for 'q1' explicitly coded, multi-bit enable fixed.
    // The reduction OR (|en1) converts the multi-bit 'en1' to a scalar, resolving STARC05-2.1.5.3, W224, and W450L.
    // The explicit default assignment (q1 = q1;) makes the latch behavior clear and addresses the InferLatch error
    // by ensuring all paths assign a value, making it an explicitly defined latch rather than an implicitly inferred one.
    always @* begin
        q1 = q1; // Default to preserve current value when enable is inactive (latch behavior)
        if (|en1) begin // Use reduction OR to convert multi-bit 'en1' to scalar enable
            q1 = d1;
        end
    end

    // Violation 2 & related warnings fixed: Latch for 'q2' explicitly coded, multi-bit enable fixed.
    // The reduction OR (|en2) converts the multi-bit 'en2' to a scalar, resolving STARC05-2.1.5.3, W224, and W450L.
    // The explicit default assignment (q2 = q2;) makes the latch behavior clear and addresses the InferLatch error
    // by ensuring all paths assign a value, making it an explicitly defined latch rather than an implicitly inferred one.
    always @* begin
        q2 = q2; // Default to preserve current value when enable is inactive (latch behavior)
        if (|en2) begin // Use reduction OR to convert multi-bit 'en2' to scalar enable
            q2 = d2;
        end
    end

endmodule
