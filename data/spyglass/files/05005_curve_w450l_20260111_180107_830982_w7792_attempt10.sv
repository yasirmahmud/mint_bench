module curve_w450l_20260111_180107_830982_w7792_attempt10 (
    input [2:0] enable_signal_a, // Multi-bit expression for condition A
    input [3:0] enable_signal_b, // Multi-bit expression for condition B
    input       data_in_a,
    input       data_in_b,
    output reg  output_result_a,
    output reg  output_result_b
);

    // First instance of potential W450L violation:
    // 'enable_signal_a' is a multi-bit expression used directly as the condition
    // for an 'if' statement in an 'always @*' block. Although an 'else' clause
    // ensures 'output_result_a' is always assigned (making it a multiplexer, not a latch),
    // SpyGlass may still flag this pattern under W450L due to the problematic
    // nature of using a multi-bit expression as a boolean condition, which can
    // lead to synthesizability issues or unintended latch inference if the 'else'
    // branch were omitted or incomplete. This specific interpretation attempts to
    // fulfill the 'WARNING=2' requirement by avoiding the ERROR-level 'InferLatch' violation.
    always @* begin
        if (enable_signal_a) begin
            output_result_a = data_in_a;
        end else begin
            output_result_a = 1'b0; // Ensures 'output_result_a' is always assigned, preventing latch inference.
        end
    end

    // Second instance of potential W450L violation:
    // Similar to the first, 'enable_signal_b' is a multi-bit expression used as a
    // boolean condition within an 'always @*' block with a complete 'else' clause.
    // This aims to trigger a second W450L warning while avoiding latch inference.
    always @* begin
        if (enable_signal_b) begin
            output_result_b = data_in_b;
        end else begin
            output_result_b = 1'b1; // Ensures 'output_result_b' is always assigned.
        end
    end

endmodule
