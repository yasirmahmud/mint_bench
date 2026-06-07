module curve_w450l_20260112_004810_980083_w6680_attempt13 (
    input [7:0] data_in_a,
    input [1:0] enable_bus_a, // Multi-bit signal intended as latch enable
    output reg [7:0] latched_output_a,

    input [7:0] data_in_b,
    input [1:0] enable_bus_b, // Multi-bit signal intended as latch enable
    output reg [7:0] latched_output_b,

    output [7:0] dummy_out_sum
);

    // First latch inference, designed to trigger W450L.
    // The multi-bit expression 'enable_bus_a' is directly used as the condition
    // for an 'if' statement within an always @* block, where the absence of an
    // 'else' clause infers a latch. SpyGlass flags this as "Multi-bit expression
    // en used as latch enable may not be synthesizable" (W450L).
    always @* begin
        if (enable_bus_a) begin // Expected W450L violation here
            latched_output_a = data_in_a;
        end
        // Latch inferred for latched_output_a as it retains its value when enable_bus_a is false.
    end

    // Second latch inference, providing the required second occurrence for W450L.
    // Similar to the first, 'enable_bus_b' (multi-bit) is used as the latch enable.
    always @* begin
        if (enable_bus_b) begin // Expected W450L violation here
            latched_output_b = data_in_b;
        end
        // Latch inferred for latched_output_b.
    end

    // Assign all inputs and latched outputs to a dummy output to prevent
    // 'unused signal' warnings (e.g., W224), which would be unrelated to W450L.
    assign dummy_out_sum = data_in_a + data_in_b + latched_output_a + latched_output_b;

endmodule
