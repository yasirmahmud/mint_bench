module curve_synth_5059_20260112_000730_661766_w25608_attempt14 (
    input [3:0] data_a,
    input [3:0] data_b,
    output wire match_result
);

    // Trigger SYNTH_5059: Case inequality (!==) which is not supported by synthesis.
    // This example compares two multi-bit input signals, ensuring no 'x' or 'z' literals
    // are present in the comparison, thereby avoiding related rules like STARC05-2.10.1.4b.
    assign match_result = (data_a !== data_b);

endmodule
