module curve_synth_5255_20260112_013101_801978_w6680_attempt14 (
    input [0:0] data_in,
    output wire result_out
);

    wire [0:0] internal_vec;
    
    // Drive the internal wire with the input, ensuring 'data_in' is read.
    assign internal_vec = data_in;

    // SYNTH_5255 violation: Illegal bit select. Index 1 for 'internal_vec' is out of range [0:0].
    // This assignment also ensures 'internal_vec' is read.
    assign result_out = internal_vec[1];

endmodule
