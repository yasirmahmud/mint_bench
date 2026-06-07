module curve_stx_ve_361_20260111_230514_542320_w28836_attempt12 (
    input clk,
    output wire out_signal
);

    wire my_internal_net; // Explicitly declared as a net (wire)

    // This always block attempts a procedural assignment to the net 'my_internal_net'.
    // This directly violates STX_VE_361: Procedural assignment statement cannot drive a net.
    always @(posedge clk) begin
        my_internal_net = 1'b1; // VIOLATION: Procedural assignment to a net (wire) is forbidden
    end

    // Assign 'my_internal_net' to 'out_signal' to prevent 'my_internal_net' from being flagged as unused.
    assign out_signal = my_internal_net;

endmodule
