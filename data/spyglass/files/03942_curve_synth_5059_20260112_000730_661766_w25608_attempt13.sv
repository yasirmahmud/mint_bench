module curve_synth_5059_20260112_000730_661766_w25608_attempt13 (
    input [3:0] data_in,
    output wire match_flag
);

    // Trigger SYNTH_5059: Case inequality (!==) which is not supported by synthesis.
    // This example compares a multi-bit input with a constant containing a 'z' bit.
    assign match_flag = (data_in !== 4'b101z);

endmodule
