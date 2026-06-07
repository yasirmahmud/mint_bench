module curve_synth_5058_20260111_182548_231391_w37940_attempt6 (
    input wire [3:0] data_in_a,
    input wire [3:0] data_in_b,
    output wire       match_strict
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
    // This assignment uses the case equality operator '===',
    // which triggers the SYNTH_5058 rule.
    assign match_strict = (data_in_a === data_in_b);

endmodule
