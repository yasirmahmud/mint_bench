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
    // To resolve SpyGlass rule W450L (Multi-bit expression en used as latch enable may not be synthesizable),
    // W224, and STARC05-2.1.5.3, the multi-bit enable is explicitly converted to a single-bit boolean
    // using a reduction OR, which correctly implements the original intent of enabling when non-zero.
    always @* begin
        if (|control_bus_enable_a) begin // Fixed: Using reduction OR to make it a 1-bit condition
            latched_output_a = data_in_value_a;
        end
        // No else branch means 'latched_output_a' holds its value when 'control_bus_enable_a' is 4'b0000.
    end

    // Latch 2: This second block infers another latch for 'latched_output_b'.
    // The condition 'control_bus_enable_b' is also a multi-bit expression (3 bits).
    // Similarly, to resolve SpyGlass rule W450L, W224, and STARC05-2.1.5.3,
    // a reduction OR is used to convert the multi-bit enable into a 1-bit boolean condition.
    always @* begin
        if (|control_bus_enable_b) begin // Fixed: Using reduction OR to make it a 1-bit condition
            latched_output_b = data_in_value_b;
        end
        // No else branch means 'latched_output_b' holds its value when 'control_bus_enable_b' is 3'b000.
    end

endmodule
