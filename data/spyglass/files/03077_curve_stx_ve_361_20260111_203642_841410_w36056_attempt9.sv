module curve_stx_ve_361_20260111_203642_841410_w36056_attempt9 (
    input in_signal,
    output out_data
);

    // Declare an explicit 'wire' type net.
    wire internal_net;

    // Continuously assign the output to the internal net.
    // This is allowed and does not trigger a violation.
    assign out_data = internal_net;

    // This 'always' block attempts a procedural assignment to 'internal_net'.
    // Since 'internal_net' is a 'wire' (net type), this procedural assignment
    // directly violates STX_VE_361.
    always @(in_signal) begin
        internal_net = in_signal; // VIOLATION: Procedural assignment to a net
    end

endmodule
