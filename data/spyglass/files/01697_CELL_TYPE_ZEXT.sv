module CELL_TYPE_ZEXT #(parameter PARAM_IN_WIDTH=1, parameter PARAM_OUT_WIDTH=1) (input [PARAM_IN_WIDTH - 1 : 0] PORT_ID_IN, output [PARAM_OUT_WIDTH - 1 : 0] PORT_ID_OUT); assign PORT_ID_OUT = {{(PARAM_OUT_WIDTH - PARAM_IN_WIDTH){1'b0}}, PORT_ID_IN};
 endmodule
