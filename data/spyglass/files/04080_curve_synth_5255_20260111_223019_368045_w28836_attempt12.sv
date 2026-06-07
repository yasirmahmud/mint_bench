module curve_synth_5255_20260111_223019_368045_w28836_attempt12 (
    input wire [7:0] data_in,
    output wire result_out,
    output wire valid_bit_out
);

    wire [7:0] Ct;

    // Assign data_in to Ct. This ensures data_in is conceptually 'used'.
    assign Ct = data_in;

    // Use a valid bit from data_in to prevent W240 (Input declared but not read).
    assign valid_bit_out = data_in[0];

    // SYNTH_5255 violation: Illegal bit select. Index 31 for "Ct" is out of range [7:0].
    // The result is assigned to an output to prevent W528 (Variable set but not read) on Ct[31].
    assign result_out = Ct[31];

endmodule
