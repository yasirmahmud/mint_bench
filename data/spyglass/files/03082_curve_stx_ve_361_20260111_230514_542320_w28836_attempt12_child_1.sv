module curve_stx_ve_361_20260111_230514_542320_w28836_attempt12 (
    input clk,
    output wire out_signal
);

    reg my_internal_net; // Changed from wire to reg to allow procedural assignment

    // This always block now correctly assigns to the reg 'my_internal_net'.
    always @(posedge clk) begin
        my_internal_net = 1'b1; // NO VIOLATION: Procedural assignment to a reg is allowed
    end

    // Assign 'my_internal_net' to 'out_signal' to prevent 'my_internal_net' from being flagged as unused.
    assign out_signal = my_internal_net;

endmodule
