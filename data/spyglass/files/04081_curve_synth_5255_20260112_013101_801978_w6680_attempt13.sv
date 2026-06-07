module curve_synth_5255_20260112_013301_801978_w6680_attempt13 (
    input [1:0] data_vec_in,
    output      result_bit_out
);

    // SYNTH_5255 violation: Illegal bit select. Index 2 for 'data_vec_in' is out of range [1:0].
    assign result_bit_out = data_vec_in[2];

endmodule
