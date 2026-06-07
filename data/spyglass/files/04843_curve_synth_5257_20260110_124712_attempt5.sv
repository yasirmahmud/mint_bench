module curve_synth_5257_20260110_124712_attempt5 #(
    parameter PARAM_WIDTH = 1,
    parameter PARAM_LOW = 1,
    parameter PARAM_HIGH = 1
) (
    input [PARAM_WIDTH - 1 : 0] PORT_ID_IN, // With default PARAM_WIDTH=1, this is [0:0]
    output [0:0] PORT_ID_OUT // A single-bit output
);

    // This assignment generates the SYNTH_5257 violation.
    // With default parameters, this translates to PORT_ID_IN[1:1]
    // which is out of range for PORT_ID_IN[0:0].
    // PORT_ID_IN[0] is not explicitly used here but the rule is specifically for the illegal part-select.
    // The output PORT_ID_OUT is declared as a single bit [0:0] to be syntactically valid 
    // and match the expected bit-width of a 'slice' if it were valid, avoiding the invalid 
    // output port width declaration seen in the context example (output [-1:0]).
    assign PORT_ID_OUT[0] = PORT_ID_IN[PARAM_HIGH : PARAM_LOW];

endmodule
