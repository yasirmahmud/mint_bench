module curve_w450l_20260110_210755_attempt3 (
    input [1:0] en_latch1,
    input [2:0] en_latch2,
    input d1,
    input d2,
    output reg q1,
    output reg q2
);

    // W450L violation 1: Multi-bit expression 'en_latch1' used as latch enable.
    // A latch is inferred for 'q1' because it is not assigned when 'en_latch1' evaluates to false (i.e., 2'b00).
    always @* begin
        if (en_latch1) begin // 'en_latch1' is a [1:0] multi-bit expression
            q1 = d1;
        end
        // No else clause, leading to latch inference for q1.
    end

    // W450L violation 2: Multi-bit expression 'en_latch2' used as latch enable.
    // A latch is inferred for 'q2' because it is not assigned when 'en_latch2' evaluates to false (i.e., 3'b000).
    always @* begin
        if (en_latch2) begin // 'en_latch2' is a [2:0] multi-bit expression
            q2 = d2;
        
        end
        // No else clause, leading to latch inference for q2.
    end

endmodule
