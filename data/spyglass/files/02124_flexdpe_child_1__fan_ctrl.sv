// Dummy module for fan_ctrl to resolve ErrorAnalyzeBBox
module fan_ctrl #(
    parameter DATA_TYPE = 16,
    parameter NUM_PES = 32,
    parameter LOG2_PES = 5
) (
    input clk,
    input rst,
    input [NUM_PES * LOG2_PES - 1 : 0] i_vn,
    input i_stationary,
    input i_data_valid,
    output [(NUM_PES - 1) - 1 : 0] o_reduction_add,
    output [3 * (NUM_PES - 1) - 1 : 0] o_reduction_cmd,
    output [19 : 0] o_reduction_sel,
    output o_reduction_valid
);
    assign o_reduction_add = '0;
    assign o_reduction_cmd = '0;
    assign o_reduction_sel = '0;
    assign o_reduction_valid = 1'b0;
endmodule
