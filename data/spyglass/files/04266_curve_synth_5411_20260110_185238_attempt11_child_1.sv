module curve_synth_5411_20260110_185238_attempt11 (
    input wire [3:0] data_in,
    output wire [0:0] data_out
);

    // The original code assigned {0{data_in}}, which results in a zero-width vector.
    // This triggered SYNTH_5411 and other related synthesis errors, as zero-width
    // vectors cannot be assigned to non-zero-width outputs in synthesizable RTL.
    // To resolve the SpyGlass violations and make the design synthesizable, 
    // data_out is now explicitly assigned a constant 0.
    // This preserves the intent of not using 'data_in' to derive 'data_out'
    // and provides a synthesizable, well-defined value for the output.
    assign data_out = 1'b0;

endmodule
