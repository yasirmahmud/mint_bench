module curve_w450l_20260112_004810_980083_w6680_attempt14 (
    input [7:0] data_value_a,
    input [2:0] enable_bus_a, // Multi-bit signal for latch enable
    output reg [7:0] latched_data_a,

    input [7:0] data_value_b,
    input [2:0] enable_bus_b, // Another multi-bit signal for latch enable
    output reg [7:0] latched_data_b,

    output [7:0] unused_collector_sum
);

    // This 'always @*' block infers a latch for 'latched_data_a'.
    // The multi-bit expression 'enable_bus_a' is directly used as the condition
    // for the 'if' statement. When 'enable_bus_a' is non-zero, 'latched_data_a'
    // is updated. When 'enable_bus_a' is zero, 'latched_data_a' retains its value
    // due to the absence of an 'else' clause. This construction triggers W450L.
    always @* begin
        if (enable_bus_a) begin // Expected W450L violation for 'enable_bus_a'
            latched_data_a = data_value_a;
        end
    end

    // This second 'always @*' block provides the required second occurrence of W450L.
    // Similar to the first, 'enable_bus_b' (a multi-bit expression) serves as the
    // latch enable for 'latched_data_b'.
    always @* begin
        if (enable_bus_b) begin // Expected W450L violation for 'enable_bus_b'
            latched_data_b = data_value_b;
        end
    end

    // A dummy assignment to ensure all inputs and outputs are used, preventing
    // 'unused signal' warnings, which would be unrelated to W450L.
    assign unused_collector_sum = data_value_a + data_value_b + latched_data_a + latched_data_b;

endmodule
