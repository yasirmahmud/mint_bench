`timescale 1ns/1ps
`default_nettype none

module cpu1_fetch (
    input  wire [15:0] pc,
    output reg  [31:0] instr,
    output wire        valid
);
    wire [7:0] unused_fetch_page;

    assign unused_fetch_page = pc[15:8];
    assign valid = 1'b1;

    always @* begin
        case (pc[7:1])
            7'd0:  instr = {4'h2, 3'd1, 3'd0, 3'd0, 16'h0004, 3'd0};
            7'd1:  instr = {4'h2, 3'd2, 3'd0, 3'd0, 16'h0010, 3'd0};
            7'd2:  instr = {4'h1, 3'd3, 3'd1, 3'd2, 16'h0000, 3'd0};
            7'd3:  instr = {4'h3, 3'd4, 3'd3, 3'd2, 16'h0000, 3'd0};
            7'd4:  instr = {4'h4, 3'd5, 3'd4, 3'd1, 16'h0000, 3'd0};
            7'd5:  instr = {4'h6, 3'd0, 3'd0, 3'd5, 16'h0020, 3'd0};
            7'd6:  instr = {4'h5, 3'd6, 3'd0, 3'd0, 16'h0020, 3'd0};
            7'd7:  instr = {4'h7, 3'd0, 3'd6, 3'd5, 16'h0006, 3'd1};
            7'd8:  instr = {4'hA, 3'd7, 3'd6, 3'd1, 16'h0000, 3'd0};
            7'd9:  instr = {4'hB, 3'd7, 3'd7, 3'd1, 16'h0000, 3'd0};
            7'd10: instr = {4'h9, 3'd1, 3'd7, 3'd0, 16'h0001, 3'd0};
            7'd11: instr = {4'hC, 3'd2, 3'd7, 3'd6, 16'h0000, 3'd0};
            7'd12: instr = {4'h8, 3'd0, 3'd0, 3'd0, 16'hFFE8, 3'd0};
            7'd13: instr = {4'h2, 3'd1, 3'd1, 3'd0, 16'h0001, 3'd0};
            7'd14: instr = {4'h6, 3'd0, 3'd0, 3'd1, 16'h0024, 3'd0};
            7'd15: instr = {4'h5, 3'd2, 3'd0, 3'd0, 16'h0024, 3'd0};
            7'd16: instr = {4'h1, 3'd3, 3'd2, 3'd1, 16'h0000, 3'd0};
            7'd17: instr = {4'h4, 3'd4, 3'd3, 3'd2, 16'h0000, 3'd0};
            7'd18: instr = {4'h3, 3'd5, 3'd4, 3'd1, 16'h0000, 3'd0};
            7'd19: instr = {4'h7, 3'd0, 3'd5, 3'd0, 16'h0004, 3'd4};
            7'd20: instr = {4'h9, 3'd6, 3'd5, 3'd0, 16'h0002, 3'd0};
            7'd21: instr = {4'h8, 3'd0, 3'd0, 3'd0, 16'hFFD6, 3'd0};
            7'd22: instr = {4'h2, 3'd1, 3'd1, 3'd0, 16'h0002, 3'd0};
            7'd23: instr = {4'hA, 3'd2, 3'd1, 3'd1, 16'h0000, 3'd0};
            7'd24: instr = {4'hB, 3'd3, 3'd2, 3'd1, 16'h0000, 3'd1};
            7'd25: instr = {4'h6, 3'd0, 3'd0, 3'd3, 16'h0028, 3'd0};
            7'd26: instr = {4'h5, 3'd4, 3'd0, 3'd0, 16'h0028, 3'd0};
            7'd27: instr = {4'hC, 3'd5, 3'd4, 3'd3, 16'h0000, 3'd0};
            7'd28: instr = {4'h7, 3'd0, 3'd5, 3'd0, 16'h0004, 3'd0};
            7'd29: instr = {4'h9, 3'd6, 3'd5, 3'd0, 16'h0003, 3'd0};
            7'd30: instr = {4'h8, 3'd0, 3'd0, 3'd0, 16'hFFC4, 3'd0};
            7'd31: instr = {4'h0, 3'd0, 3'd0, 3'd0, 16'h0000, 3'd0};
        endcase
    end
endmodule

`default_nettype wire
