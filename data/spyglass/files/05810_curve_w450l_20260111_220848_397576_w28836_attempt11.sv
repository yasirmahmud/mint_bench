module curve_w450l_module (
    input [7:0] data_in_value_a,
    input [3:0] control_bus_enable_a, // Multi-bit expression for latch enable
    output reg [7:0] latched_output_a,

    input [7:0] data_in_value_b,
    input [2:0] control_bus_enable_b, // Another multi-bit expression for latch enable
    output reg [7:0] latched_output_b
);

    // Latch 1: This block infers a latch for 'latched_output_a'.
    // The condition 'control_bus_enable_a' is a multi-bit expression (4 bits).
    // Using a multi-bit expression directly as a boolean condition for a latch enable
    // triggers SpyGlass rule W450L (Multi-bit expression en used as latch enable may not be synthesizable).
    always @* begin
        if (control_bus_enable_a) begin
            latched_output_a = data_in_value_a;
        end
        // No else branch means 'latched_output_a' holds its value when 'control_bus_enable_a' is 4'b0000.
    end

    // Latch 2: This second block infers another latch for 'latched_output_b'.
    // The condition 'control_bus_enable_b' is also a multi-bit expression (3 bits).
    // Its use as a latch enable condition similarly triggers SpyGlass rule W450L,
    // providing the second required occurrence for the rule.
    always @* begin
        if (control_bus_enable_b) begin
            latched_output_b = data_in_value_b;
        end
        // No else branch means 'latched_output_b' holds its value when 'control_bus_enable_b' is 3'b000.
    end

endmodule
