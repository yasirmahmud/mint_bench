module curve_w450l_20260110_210755_attempt6 (
    input [3:0] enable_sig_a,
    input       data_a_in,
    output reg  data_a_out,

    input [4:0] enable_sig_b,
    input       data_b_in,
    output reg  data_b_out
);

    // W450L violation 1: Multi-bit expression 'enable_sig_a' used as latch enable.
    // A latch is inferred for 'data_a_out' because it is not assigned when 'enable_sig_a' evaluates to false (4'b0000).
    always @* begin
        if (enable_sig_a) begin // 'enable_sig_a' is a [3:0] multi-bit expression
            data_a_out = data_a_in;
        end
    end

    // W450L violation 2: Multi-bit expression 'enable_sig_b' used as latch enable.
    // A latch is inferred for 'data_b_out' because it is not assigned when 'enable_sig_b' evaluates to false (5'b00000).
    always @*
        if (enable_sig_b) // 'enable_sig_b' is a [4:0] multi-bit expression
            data_b_out = data_b_in;

endmodule
