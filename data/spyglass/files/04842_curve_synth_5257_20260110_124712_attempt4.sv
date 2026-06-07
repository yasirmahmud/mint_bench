module curve_synth_5257_20260110_124712_attempt4 (
    input [0:0] PORT_ID_IN,
    output [1:0] PORT_ID_OUT
);

    // SYNTH_5257: Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
    // PORT_ID_IN[0] is explicitly used to avoid W240 (unused input bit).
    assign PORT_ID_OUT = {PORT_ID_IN[1:1], PORT_ID_IN[0]};

endmodule
