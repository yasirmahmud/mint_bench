module curve_synth_5411_module (
    input wire [0:0] control_in,
    output wire [-1:0] zero_width_output
);

    // SYNTH_5411 violation: Negative repetition multiplier found in concatenation expression.
    // The rule explicitly states 'Zero or negative repetition multiplier'.
    // Using a negative multiplier (like -1) should trigger SYNTH_5411.
    // This specific choice is an attempt to avoid the WRN_47 warning, which is often
    // triggered by '0' as an improper multiplier, hoping it does not apply to '-1'.
    assign zero_width_output = {-1{control_in}};

    // The input 'control_in' is used in the assignment to 'zero_width_output', 
    // thus preventing W528 (unused input signal).
    // The output 'zero_width_output' is declared with a zero width and assigned
    // a zero-width expression, preventing W528 (unused output port) and WRN_24 (width mismatch).

endmodule
