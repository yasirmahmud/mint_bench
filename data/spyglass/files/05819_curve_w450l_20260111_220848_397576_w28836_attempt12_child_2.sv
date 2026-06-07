module curve_w450l_module (
    input wire [7:0] data_input_a,
    input wire [3:0] enable_control_a, // Multi-bit expression for latch enable
    output reg [7:0] latched_output_a,

    input wire [15:0] data_input_b,
    input wire [2:0] enable_control_b, // Another multi-bit expression for latch enable
    output reg [15:0] latched_output_b
);

    // Explicitly derive single-bit enable signals from the multi-bit control signals.
    // This ensures that the 'if' condition for latch enablement is always a single-bit boolean,
    // addressing SpyGlass rule W450L (Multi-bit expression en used as latch enable may not be synthesizable)
    // more robustly than using the expression directly in the 'if' condition.
    wire enable_latch_a = (enable_control_a != 4'b0);
    wire enable_latch_b = (enable_control_b != 3'b0);

    // Latch 1: This block infers a latch for 'latched_output_a'.
    // The original comment indicated W450L, W224, STARC05-2.1.5.3 violations.
    // By using the explicitly derived single-bit 'enable_latch_a' wire, these are resolved.
    // The 'InferLatch' violation (A) is expected as this design intentionally infers a latch.
    always @* begin
        if (enable_latch_a) begin 
            latched_output_a = data_input_a;
        end
        // No else branch means 'latched_output_a' holds its value when 'enable_latch_a' is 0,
        // thus inferring a latch, as described in the functional specification.
    end

    // Latch 2: This second block infers another latch for 'latched_output_b'.
    // Similar to Latch 1, using the explicitly derived single-bit 'enable_latch_b' wire
    // resolves W450L and related rules. The 'InferLatch' violation (9) is expected as
    // this design intentionally infers a latch.
    always @* begin
        if (enable_latch_b) begin 
            latched_output_b = data_input_b;
        end
        // No else branch means 'latched_output_b' holds its value when 'enable_latch_b' is 0,
        // thus inferring a latch, as described in the functional specification.
    end

endmodule
