module curve_w450l_20260110_210755_attempt4 (
    input [3:0] enable_sig_a,
    input [4:0] enable_sig_b,
    input data_in_a,
    input data_in_b,
    output reg output_q_a,
    output reg output_q_b
);

    // W450L violation 1: Multi-bit expression 'enable_sig_a' used as latch enable.
    // A latch is inferred for 'output_q_a' because it is not assigned when 'enable_sig_a' evaluates to false (i.e., 4'b0000).
    always @* begin
        if (enable_sig_a) begin // 'enable_sig_a' is a [3:0] multi-bit expression
            output_q_a = data_in_a;
        end
    end

    // W450L violation 2: Multi-bit expression 'enable_sig_b' used as latch enable.
    // A latch is inferred for 'output_q_b' because it is not assigned when 'enable_sig_b' evaluates to false (i.e., 5'b00000).
    always @* begin
        if (enable_sig_b) begin // 'enable_sig_b' is a [4:0] multi-bit expression
            output_q_b = data_in_b;
        end
    end

endmodule
