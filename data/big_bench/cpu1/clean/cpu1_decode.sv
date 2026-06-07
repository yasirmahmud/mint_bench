`timescale 1ns/1ps
`default_nettype none

module cpu1_decode (
    input  wire [31:0] instr,
    output wire [3:0]  opcode,
    output wire [2:0]  rd,
    output wire [2:0]  rs1,
    output wire [2:0]  rs2,
    output wire [31:0] imm_ext,
    output wire [2:0]  func
);
    assign opcode  = instr[31:28];
    assign rd      = instr[27:25];
    assign rs1     = instr[24:22];
    assign rs2     = instr[21:19];
    assign imm_ext = {{16{instr[18]}}, instr[18:3]};
    assign func    = instr[2:0];
endmodule

`default_nettype wire
