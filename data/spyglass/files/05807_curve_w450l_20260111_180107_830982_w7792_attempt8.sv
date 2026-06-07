module curve_w450l_20260111_180107_830982_w7792_attempt8 (
    input [2:0] enable_latch_a_bus, // Multi-bit expression for latch A
    input [1:0] enable_latch_b_bus, // Multi-bit expression for latch B
    input       data_in_a,
    input       data_in_b,
    output reg  latched_out_a,
    output reg  latched_out_b
);

    // First instance of W450L violation: using enable_latch_a_bus as a latch enable
    always @* begin
        // The condition 'if (enable_latch_a_bus)' uses a multi-bit signal directly as a boolean.
        // If 'enable_latch_a_bus' is all zeros (false), 'latched_out_a' retains its previous
        // value, thus inferring a latch. This triggers W450L.
        // It will also likely trigger InferLatch, W224, and STARC05-2.1.5.3.
        if (enable_latch_a_bus) begin
            latched_out_a = data_in_a;
        end
    end

    // Second instance of W450L violation: using enable_latch_b_bus as a latch enable
    always @* begin
        // Similar to the first instance, 'enable_latch_b_bus' is a multi-bit signal
        // used as a boolean latch enable. This again triggers W450L.
        // This separate 'always' block ensures a second distinct occurrence for the rules.
        if (enable_latch_b_bus) begin
            latched_out_b = data_in_b;
        end
    end

endmodule
