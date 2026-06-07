module curve_synth_5257_attempt13 (
    input wire [0:0] data_input_0,
    output wire      invalid_access_output
);

    // SYNTH_5257 violation: CELL_TYPE_SLICE -> Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
    // 'data_input_0' is a 1-bit vector ([0:0]). Attempting to access bit [1:1] is out of its declared range.
    assign invalid_access_output = data_input_0[1:1];

endmodule
