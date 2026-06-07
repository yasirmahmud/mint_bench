module curve_synth_5255_20260112_013101_801978_w6680_attempt15 (
    input [1:0] data_in,
    output wire result_out
);

    wire [1:0] intermediate_sig;
    
    // Drive 'intermediate_sig' fully with 'data_in' to ensure 'data_in' is read and 'intermediate_sig' is driven.
    assign intermediate_sig = data_in;

    // SYNTH_5255 violation: Illegal bit select. Index 2 for 'intermediate_sig' is out of range [1:0].
    // This assignment ensures 'intermediate_sig' is read, even with an invalid access, and 'result_out' is driven.
    assign result_out = intermediate_sig[2];

endmodule
