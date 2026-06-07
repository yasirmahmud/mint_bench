module curve_synth_5411_20260110_185238_attempt9 (
    input wire [3:0] in_data,
    output wire out_data
);

    // The original design triggered SYNTH_5411 by using a zero repetition multiplier:
    // assign out_data = { 0 { in_data } };
    // This assignment effectively produces a zero-width value, which when assigned
    // to a 1-bit output, typically defaults to 0 in synthesis and simulation if
    // allowed. To resolve the SYNTH_5411 violation while maintaining the most
    // logical interpretation of assigning a "zero-width" value to a single bit
    // (i.e., making it a logical zero), the direct assignment of 0 is used.

    assign out_data = 1'b0;

endmodule
