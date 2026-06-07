module curve_w450l_20260111_180107_830982_w7792_attempt9 (
    input [3:0] enable_latch_control_a, // Multi-bit expression for latch A
    input [2:0] enable_latch_control_b, // Multi-bit expression for latch B
    input       data_input_a,
    input       data_input_b,
    output reg  output_latch_a,
    output reg  output_latch_b
);

    // First instance of W450L violation:
    // 'enable_latch_control_a' is a multi-bit expression used directly as the condition
    // for an 'if' statement in an 'always @*' block. When 'enable_latch_control_a'
    // evaluates to all zeros (false), 'output_latch_a' retains its previous value,
    // thus inferring a latch. This directly triggers W450L.
    always @* begin
        if (enable_latch_control_a) begin
            output_latch_a = data_input_a;
        end
    end

    // Second instance of W450L violation:
    // Similar to the first instance, 'enable_latch_control_b' is a multi-bit expression
    // used as a boolean latch enable. This ensures a second distinct occurrence for W450L.
    always @* begin
        if (enable_latch_control_b) begin
            output_latch_b = data_input_b;
        end
    end

endmodule
