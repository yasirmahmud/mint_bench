module curve_w502_20260111_115546_attempt4 (
    input wire en,
    input wire d,
    output reg q
);

    // This always block implements a basic gated latch.
    // The W502 violation occurred because 'q' was included in the sensitivity list
    // while also being assigned within the always block. Removing 'q' from the
    // sensitivity list resolves the W502 warning without changing functionality.
    // The 'InferLatch' error is a consequence of the explicit design requirement
    // for a gated latch, and thus cannot be removed without changing the specified
    // functional behavior of the design.
    always @(en or d) begin
        if (en) begin
            q = d;
        end
        // When 'en' is false, 'q' (a 'reg') implicitly holds its value,
        // which is the desired behavior for a gated latch.
    end

endmodule
