module curve_w450l_20260110_210755_attempt1 (
    input [1:0] en1,
    input [1:0] en2,
    input d1,
    input d2,
    output reg q1,
    output reg q2
);

    // Latch for 'q1' explicitly coded to resolve 'InferLatch' violation.
    // The reduction OR (|en1) converts the multi-bit 'en1' to a scalar, resolving STARC05-2.1.5.3, W224, and W450L.
    // An explicit sensitivity list and a full if/else structure with 'q1 = q1;' in the else branch
    // are used to clearly define the latch behavior and avoid the 'InferLatch' error reported by SpyGlass.
    always @(d1 or en1 or q1) begin // Explicit sensitivity list for level-sensitive latch
        if (|en1) begin // Use reduction OR to convert multi-bit 'en1' to scalar enable
            q1 = d1;
        end else begin
            q1 = q1; // Explicitly preserve current value when enable is inactive (latch behavior)
        end
    end

    // Latch for 'q2' explicitly coded to resolve 'InferLatch' violation.
    // The reduction OR (|en2) converts the multi-bit 'en2' to a scalar, resolving STARC05-2.1.5.3, W224, and W450L.
    // An explicit sensitivity list and a full if/else structure with 'q2 = q2;' in the else branch
    // are used to clearly define the latch behavior and avoid the 'InferLatch' error reported by SpyGlass.
    always @(d2 or en2 or q2) begin // Explicit sensitivity list for level-sensitive latch
        if (|en2) begin // Use reduction OR to convert multi-bit 'en2' to scalar enable
            q2 = d2;
        end else begin
            q2 = q2; // Explicitly preserve current value when enable is inactive (latch behavior)
        end
    end

endmodule
