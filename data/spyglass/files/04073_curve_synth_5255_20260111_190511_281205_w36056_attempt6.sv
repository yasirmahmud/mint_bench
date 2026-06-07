module curve_synth_5255_20260111_190511_281205_w36056_attempt6 (
    input      data_in,
    output     result_out
);

    // Declare a small wire 'Ct'
    wire [7:0] Ct;

    // Assign a value to 'Ct' to prevent unused signal warning
    assign Ct = {7'b0, data_in}; // Pad data_in to 8 bits for assignment

    // SYNTH_5255 violation: Illegal bit select. Index 31 for 'Ct' is out of range [7:0]
    assign result_out = Ct[31];

endmodule
