module curve_synth_5257_20260110_124712_attempt2 (
    input [0:0] PORT_ID_IN,
    output [1:0] PORT_ID_OUT
);

    assign PORT_ID_OUT = {PORT_ID_IN[1], PORT_ID_IN[0]};

endmodule
