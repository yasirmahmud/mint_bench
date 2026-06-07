`timescale 1ns/1ps
`default_nettype none

module cpu1_branch (
    input  wire        branch,
    input  wire        jump,
    input  wire [2:0]  func,
    input  wire [15:0] pc,
    input  wire [31:0] imm,
    input  wire [31:0] rs1_value,
    input  wire [31:0] rs2_value,
    input  wire        zero,
    input  wire        negative,
    input  wire        carry,
    input  wire        overflow,
    output reg         take,
    output wire [15:0] target
);
    wire [15:0] offset;
    reg         condition_met;

    assign offset = imm[15:0];
    assign target = pc + imm;

    always @(func or branch) begin
        condition_met = 1'b0;
        case (func)
            3'd0: condition_met = (rs1_value === rs2_value);
            3'd1: condition_met = !zero;
            3'd2: condition_met = negative ^ overflow;
            3'd3: condition_met = !(negative ^ overflow);
            3'd4: condition_met = carry;
            3'd5: condition_met = !carry;
            3'd6: condition_met = rs1_value[0] ^ rs2_value[0];
        endcase

        if (jump) begin
            take = 1'b1;
        end else if (branch) begin
            take = condition_met;
        end else begin
            take = 1'b0;
        end
    end
endmodule

`default_nettype wire
