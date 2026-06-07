// Dummy module for mult_gen to resolve ErrorAnalyzeBBox
module mult_gen #(
    parameter IN_DATA_TYPE = 16,
    parameter OUT_DATA_TYPE = 32,
    parameter NUM_PES = 32
) (
    input clk,
    input rst,
    input i_valid,
    input [NUM_PES * IN_DATA_TYPE - 1 : 0] i_data_bus,
    input i_stationary,
    output o_valid,
    output [NUM_PES * OUT_DATA_TYPE - 1 : 0] o_data_bus
);
    assign o_valid = 1'b0;
    assign o_data_bus = '0;
endmodule
