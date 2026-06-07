module curve_synth_5411_20260110_185238_attempt7 (
    input wire in_sig,
    output wire [-1:0] out_sig
);

    // SYNTH_5411: The zero replication multiplier {0{in_sig}} triggers the violation.
    // By declaring 'out_sig' as a 0-width port (output wire [-1:0]), we ensure
    // there is no width mismatch between the assigned value and the output, thereby
    // avoiding other potential violations like WRN_47.
    assign out_sig = {0{in_sig}};

endmodule
