module curve_w496a_20260110_231726_attempt4 (
    input wire in_a,
    input wire in_b,
    input wire in_c,
    output reg out_a,
    output reg out_b,
    output reg out_c
);

    always @(*) begin
        // Default assignments to prevent latches
        out_a = 1'b0;
        out_b = 1'b0;
        out_c = 1'b0;

        // First W496a violation: Comparison of a single-bit input with 1'bz
        if (in_a == 1'bz) begin
            out_a = 1'b1;
        end

        // Second W496a violation: Comparison of another single-bit input with 1'bz
        if (in_b == 1'bz) begin
            out_b = 1'b1;
        end

        // Third W496a violation: Comparison of a third single-bit input with 1'bz
        if (in_c == 1'bz) begin
            out_c = 1'b1;
        }
    end

endmodule
