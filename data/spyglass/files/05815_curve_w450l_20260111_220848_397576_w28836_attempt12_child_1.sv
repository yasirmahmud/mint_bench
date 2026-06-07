module curve_w450l_module (
    input wire [7:0] data_input_a,
    input wire [3:0] enable_control_a, // Multi-bit expression for latch enable
    output reg [7:0] latched_output_a,

    input wire [15:0] data_input_b,
    input wire [2:0] enable_control_b, // Another multi-bit expression for latch enable
    output reg [15:0] latched_output_b
);

    // Latch 1: This block infers a latch for 'latched_output_a'.
    // The condition 'enable_control_a' is a multi-bit expression (4 bits).
    // Using a multi-bit expression directly as a boolean condition for a latch enable
    // triggers SpyGlass rule W450L (Multi-bit expression en used as latch enable may not be synthesizable).
    always @* begin
        if (enable_control_a != 4'b0) begin // Explicitly check for non-zero to resolve W450L, W224, STARC05-2.1.5.3 violations
            latched_output_a = data_input_a;
        end
        // No else branch means 'latched_output_a' holds its value when 'enable_control_a' is 4'b0000,
        // thus inferring a latch.
    end

    // Latch 2: This second block infers another latch for 'latched_output_b'.
    // The condition 'enable_control_b' is also a multi-bit expression (3 bits).
    // Its use as a latch enable condition similarly triggers SpyGlass rule W450L,
    // providing the second required occurrence for the rule.
    always @* begin
        if (enable_control_b != 3'b0) begin // Explicitly check for non-zero to resolve W450L, W224, STARC05-2.1.5.3 violations
            latched_output_b = data_input_b;
        end
        // No else branch means 'latched_output_b' holds its value when 'enable_control_b' is 3'b000,
        // thus inferring a latch.
    end

endmodule
