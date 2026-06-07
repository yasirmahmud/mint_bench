module curve_stx_ve_361_20260111_230514_542320_w28836_attempt11 (
    output wire out_data
);

    wire my_net; // Explicitly declared as a net (wire)

    // This initial block attempts a procedural assignment to the net 'my_net'.
    // This directly violates STX_VE_361: Procedural assignment statement cannot drive a net.
    initial begin
        my_net = 1'b0; // VIOLATION: Procedural assignment to a net (wire) is forbidden
    end

    // Assign 'my_net' to 'out_data' to prevent 'my_net' from being flagged as unused.
    assign out_data = my_net;

endmodule
