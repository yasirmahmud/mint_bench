module CELL_TYPE_SLICE #(parameter PARAM_WIDTH=1, parameter PARAM_LOW=1, parameter PARAM_HIGH=1) (input [PARAM_WIDTH - 1 : 0] PORT_ID_IN, output [PARAM_HIGH - PARAM_LOW - 1 : 0] PORT_ID_OUT); assign PORT_ID_OUT = PORT_ID_IN[PARAM_HIGH:PARAM_LOW];
 endmodule
