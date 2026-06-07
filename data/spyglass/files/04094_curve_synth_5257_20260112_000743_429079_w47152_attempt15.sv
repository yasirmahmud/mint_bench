module curve_synth_5257_attempt15 (
    input wire [0:0] part_select_input,
    output wire      violating_output,
    output wire      dummy_output
);

    // Target violation: SYNTH_5257
    // Rule description: CELL_TYPE_SLICE -> Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
    // 'part_select_input' is declared as a 1-bit vector [0:0].
    // Attempting a part-select [1:1] accesses a bit (bit 1) that is outside this declared range,
    // directly triggering the SYNTH_5257 error.
    assign violating_output = part_select_input[1:1];

    // This assignment ensures that the valid bit of the input 'part_select_input[0]' is used,
    // thereby avoiding any unused signal warnings (like W240 or WRN_240 from SpyGlass) and maintaining minimal code.
    assign dummy_output = part_select_input[0];

endmodule
