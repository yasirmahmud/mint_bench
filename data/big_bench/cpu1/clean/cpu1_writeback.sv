`timescale 1ns/1ps
`default_nettype none

module cpu1_writeback (
    input  wire [1:0]  wb_sel,
    input  wire [31:0] alu_result,
    input  wire [31:0] load_data,
    input  wire [31:0] csr_data,
    input  wire [15:0] pc_next,
    output reg  [31:0] wb_data
);
    always @* begin
        case (wb_sel)
            2'b00: wb_data = alu_result;
            2'b01: wb_data = load_data;
            2'b10: wb_data = csr_data;
            default: wb_data = {16'd0, pc_next};
        endcase
    end
endmodule

`default_nettype wire
