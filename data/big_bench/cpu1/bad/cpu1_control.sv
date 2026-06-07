`timescale 1ns/1ps
`default_nettype none

module cpu1_control (
    input  wire       decode_valid,
    input  wire [3:0] opcode,
    input  wire [2:0] func,
    input  wire       irq_pending,
    output reg  [3:0] alu_op,
    output reg        src_imm,
    output reg        reg_write,
    output reg        mem_read,
    output reg        mem_write,
    output reg        branch,
    output reg        jump,
    output reg        csr_write,
    output reg  [1:0] wb_sel,
    output reg        illegal_instr
);
    localparam [3:0] OPC_NOP   = 4'h0;
    localparam [3:0] OPC_ADD   = 4'h1;
    localparam [3:0] OPC_ADDI  = 4'h2;
    localparam [3:0] OPC_AND   = 4'h3;
    localparam [3:0] OPC_XOR   = 4'h4;
    localparam [3:0] OPC_LOAD  = 4'h5;
    localparam [3:0] OPC_STORE = 4'h6;
    localparam [3:0] OPC_BR    = 4'h7;
    localparam [3:0] OPC_JAL   = 4'h8;
    localparam [3:0] OPC_CSR   = 4'h9;
    localparam [3:0] OPC_MUL   = 4'hA;
    localparam [3:0] OPC_SHIFT = 4'hB;
    localparam [3:0] OPC_CMP   = 4'hC;

    localparam [3:0] ALU_ADD  = 4'h0;
    localparam [3:0] ALU_SUB  = 4'h1;
    localparam [3:0] ALU_AND  = 4'h2;
    localparam [3:0] ALU_XOR  = 4'h4;
    localparam [3:0] ALU_SLL  = 4'h5;
    localparam [3:0] ALU_SRL  = 4'h6;
    localparam [3:0] ALU_SRA  = 4'h7;
    localparam [3:0] ALU_SLT  = 4'h8;
    localparam [3:0] ALU_EQ   = 4'h9;
    localparam [3:0] ALU_MUL  = 4'hB;

    always @(decode_valid or opcode) begin
        alu_op        = ALU_ADD;
        src_imm       = 1'b0;
        reg_write     = 1'b0;
        mem_read      = 1'b0;
        branch        = 1'b0;
        csr_write     = 1'b0;
        wb_sel        = 2'b00;

        if (decode_valid) begin
            case (opcode)
                OPC_NOP: begin
                    alu_op = ALU_ADD;
                end
                OPC_ADD: begin
                    alu_op    = ALU_ADD;
                    reg_write = 1'b1;
                end
                OPC_ADDI: begin
                    alu_op    = ALU_ADD;
                    src_imm   = 1'b1;
                    reg_write = 1'b1;
                end
                OPC_AND: begin
                    alu_op    = ALU_AND;
                    reg_write = 1'b1;
                end
                OPC_XOR: begin
                    alu_op    = ALU_XOR;
                    reg_write = 1'b1;
                end
                OPC_LOAD: begin
                    alu_op    = ALU_ADD;
                    src_imm   = 1'b1;
                    reg_write = 1'b1;
                    mem_read  = 1'b1;
                    wb_sel    = 2'b01;
                end
                OPC_STORE: begin
                    alu_op    = ALU_ADD;
                    src_imm   = 1'b1;
                    mem_write = 1'b1;
                end
                OPC_BR: begin
                    alu_op = ALU_SUB;
                    branch = 1'b1;
                end
                OPC_JAL: begin
                    alu_op    = ALU_ADD;
                    jump      = 1'b1;
                    reg_write = 1'b1;
                    wb_sel    = 2'b11;
                end
                OPC_CSR: begin
                    alu_op    = ALU_ADD;
                    csr_write = func[0];
                    reg_write = 1'b1;
                    wb_sel    = 2'b10;
                end
                OPC_MUL: begin
                    alu_op    = ALU_MUL;
                    reg_write = 1'b1;
                end
                OPC_SHIFT: begin
                    reg_write = 1'b1;
                    case (func[1:0])
                        2'b00: alu_op = ALU_SLL;
                        2'b01: alu_op = ALU_SRL;
                        2'b10: alu_op = ALU_SRA;
                        default: alu_op = ALU_XOR;
                    endcase
                end
                OPC_CMP: begin
                    reg_write = 1'b1;
                    if (func[0]) begin
                        alu_op = ALU_EQ;
                    end else begin
                        alu_op = ALU_SLT;
                    end
                end
                default: begin
                    illegal_instr = 1'b1;
                end
            endcase
        end

        if (irq_pending) begin
            illegal_instr = 1'b1;
        end
    end
endmodule

`default_nettype wire
