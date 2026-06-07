module curve_w450l_20260110_210755_attempt1 (
    input [1:0] en1,
    input [1:0] en2,
    input d1,
    input d2,
    output reg q1,
    output reg q2
);

    // Violation 1: Multi-bit expression 'en1' used as latch enable
    always @* begin
        if (en1) begin
            q1 = d1;
        end
        // No else for q1 implies a latch
    end

    // Violation 2: Multi-bit expression 'en2' used as latch enable
    always @* begin
        if (en2) begin
            q2 = d2;
        end
        // No else for q2 implies a latch
    end

endmodule
