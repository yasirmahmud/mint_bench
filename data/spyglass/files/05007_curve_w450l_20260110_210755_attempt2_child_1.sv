module curve_w450l_20260110_210755_attempt2 (
    input [1:0] en_latch1,
    input [2:0] en_latch2,
    input d1,
    input d2,
    output reg q1,
    output reg q2
);

    always @* begin
        // W450L violation 1: Multi-bit expression 'en_latch1' used as latch enable.
        // A latch is inferred for 'q1' because it is not assigned when 'en_latch1' is false.
        if (en_latch1) begin
            q1 = d1;
        end
    end

    always @* begin
        // W450L violation 2: Multi-bit expression 'en_latch2' used as latch enable.
        // A latch is inferred for 'q2' because it is not assigned when 'en_latch2' is false.
        if (en_latch2) begin
            q2 = d2;
        end
    end

endmodule
