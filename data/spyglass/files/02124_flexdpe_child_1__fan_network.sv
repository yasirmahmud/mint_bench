// Dummy module for fan_network to resolve ErrorAnalyzeBBox
module fan_network #(
    parameter DATA_TYPE = 32,
    parameter NUM_PES = 32,
    parameter LOG2_PES = 5
) (
    input clk,
    input rst,
    input i_valid,
    input [NUM_PES * DATA_TYPE - 1 : 0] i_data_bus,
    input [(NUM_PES - 1) - 1 : 0] i_add_en_bus,
    input [3 * (NUM_PES - 1) - 1 : 0] i_cmd_bus,
    input [19 : 0] i_sel_bus,
    output [NUM_PES - 1 : 0] o_valid,
    output [NUM_PES * DATA_TYPE - 1 : 0] o_data_bus
);
    assign o_valid = '0;
    assign o_data_bus = '0;
endmodule
