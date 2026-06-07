module curve_synth_5257_20260112_000743_429079_w47152_attempt16 (
    input wire [0:0] data_port_in,
    output wire      error_output,
    output wire      valid_output
);

    // Parameters define the indices for the part-select.
    // 'data_port_in' is declared as a 1-bit vector [0:0].
    // 'SELECT_BIT_MSB' and 'SELECT_BIT_LSB' are set to 1,
    // resulting in a part-select of [1:1].
    parameter SELECT_BIT_MSB = 1;
    parameter SELECT_BIT_LSB = 1;

    // TARGET VIOLATION: SYNTH_5257
    // Rule description: CELL_TYPE_SLICE -> Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
    // The part-select 'data_port_in[SELECT_BIT_MSB : SELECT_BIT_LSB]' effectively attempts to access 'data_port_in[1:1]'.
    // Since 'data_port_in' is a 1-bit vector declared as [0:0], bit 1 is out of its valid range.
    // This direct out-of-bounds access on a port vector triggers the SYNTH_5257 error during synthesis.
    assign error_output = data_port_in[SELECT_BIT_MSB : SELECT_BIT_LSB];

    // This assignment uses the valid bit (data_port_in[0]) of the input,
    // ensuring that 'data_port_in' is not flagged as an unused signal.
    assign valid_output = data_port_in[0];

endmodule
