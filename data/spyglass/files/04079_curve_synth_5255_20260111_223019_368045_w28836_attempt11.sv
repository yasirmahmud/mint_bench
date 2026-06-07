module curve_synth_5255_20260111_223019_368045_w28836_attempt11 (
    input wire [3:0] data_in_vec,
    output wire output_val
);

    // SYNTH_5255 violation: Illegal bit select. Index 31 for 'data_in_vec' is out of range [3:0].
    assign output_val = data_in_vec[31];

endmodule
