// Dummy module for xbar to resolve ErrorAnalyzeBBox
module xbar #(
    parameter DATA_TYPE = 16,
    parameter NUM_PES = 32,
    parameter INPUT_BW = 32,
    parameter LOG2_PES = 5
) (
    input clk,
    input rst,
    input [NUM_PES * DATA_TYPE - 1 : 0] i_data_bus,
    input [NUM_PES * LOG2_PES - 1 : 0] i_mux_bus,
    output [NUM_PES * DATA_TYPE - 1 : 0] o_dist_bus
);
    assign o_dist_bus = '0;
endmodule
