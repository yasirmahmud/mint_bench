module curve_stx_ve_361_20260111_203642_841410_w36056_attempt8 (
    input in_signal,
    output out_data // In Verilog-2001, 'output' ports are implicitly 'wire' unless specified as 'reg'
);

    // This 'always' block attempts to procedurally assign to 'out_data'.
    // Since 'out_data' is a 'wire' by default, this is a violation of STX_VE_361.
    always @(in_signal) begin
        out_data = in_signal; // VIOLATION: Procedural assignment to a net
    end

endmodule
