module curve_w450l_20260111_180107_830982_w7792_attempt7 (
    input [3:0] enable_condition_bus,
    input data_in_val,
    output reg q_latch_out
);

    always @* begin
        // W450L violation: Multi-bit expression 'enable_condition_bus' used as latch enable.
        // SpyGlass will flag this because using a multi-bit signal directly as a boolean
        // condition for a latch can lead to non-synthesizable or non-portable designs.
        // FIX: Use reduction OR to explicitly convert the multi-bit signal to a single-bit boolean value.
        if (|enable_condition_bus) begin // Changed 'enable_condition_bus' to '|enable_condition_bus' to resolve W224, STARC05-2.1.5.3, and W450L.
            q_latch_out = data_in_val;
        end
        // If 'enable_condition_bus' evaluates to all zeros (false), 'q_latch_out' retains
        // its previous value, thus inferring a latch. This behavior is intentionally preserved as described.
    end

endmodule
