module curve_synth_5255_20260111_190511_281205_w36056_attempt10 (
    input       data_in, // single bit input, effectively [0:0]
    output wire data_out
);

    // SYNTH_5255: Illegal bit select. Index 1 for "data_in" is out of range [0:0]
    assign data_out = data_in[1];

endmodule
