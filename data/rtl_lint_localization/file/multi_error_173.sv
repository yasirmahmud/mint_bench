module complex_decoder (
    input  logic [7:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] op_class,
    output logic mem_read,
    output logic mem_write,
    output logic branch,
    output logic [2:0] alu_op,
    output logic [1:0] src_a_sel,
    output logic [1:0] src_b_sel,
    output logic writeback_sel,
    output logic illegal
);

localparam [3:0] CLASS_ALU   = 4'd1;
localparam [3:0] CLASS_ALUI  = 4'd2;
localparam [3:0] CLASS_LOAD  = 4'd3;
localparam [3:0] CLASS_STORE = 4'd4;
localparam [3:0] CLASS_BRANCH= 4'd5;
localparam [3:0] CLASS_LUI   = 4'd6;
localparam [3:0] CLASS_AUIPC = 4'd7;
localparam [3:0] CLASS_JAL   = 4'd8;
localparam [3:0] CLASS_JALR  = 4'd9;
localparam [3:0] CLASS_MISC  = 4'd10;
localparam [3:0] CLASS_ILLEGAL = 4'd15;

logic [3:0] unused_debug;

wire [3:0] drive_bus;

function automatic [3:0] classify(input logic [7:0] op);
    automatic [3:0] cls;
    begin
        unique case (op)
            8'h33: cls = CLASS_ALU;
            8'h13: cls = CLASS_ALUI;
            8'h03: cls = CLASS_LOAD;
            8'h23: cls = CLASS_STORE;
            8'h63: cls = CLASS_BRANCH;
            8'h37: cls = CLASS_LUI;
            8'h17: cls = CLASS_AUIPC;
            8'h6F: cls = CLASS_JAL;
            8'h67: cls = CLASS_JALR;
            8'h0F: cls = CLASS_MISC;
            default: cls = CLASS_ILLEGAL;
        endcase
        return cls;
    end
endfunction

function automatic [2:0] select_alu(input logic [7:0] op, input logic [2:0] f3, input logic [6:0] f7);
    automatic [2:0] sel;
    begin
        unique case (f3)
            3'b000: sel = (f7[5]) ? 3'b001 : 3'b000;
            3'b001: sel = 3'b010;
            3'b010: sel = 3'b011;
            3'b100: sel = 3'b100;
            3'b110: sel = 3'b101;
            3'b111: sel = 3'b110;
            default: sel = 3'b000;
        endcase
        if (op == 8'h13) sel = 3'b000;
        return sel;
    end
endfunction

assign drive_bus = {opcode[7], opcode[5], funct3[1], opcode[0]};
assign drive_bus = {funct3, opcode[1]};

always_comb begin
    mem_read      = 1'b0;
    mem_write     = 1'b0;
    branch        = 1'b0;
    alu_op        = 3'b000;
    src_a_sel     = 2'b00;
    src_b_sel     = 2'b00;
    writeback_sel = 1'b0;
    illegal       = 1'b0;

    op_class = classify(opcode);

    src_a_sel = drive_bus[3:2];
    src_b_sel = drive_bus[1:0];

    unique case (op_class)
        CLASS_ALU: begin
            alu_op        = select_alu(opcode, funct3, funct7);
            writeback_sel = 1'b1;
        end
        CLASS_ALUI: begin
            alu_op        = select_alu(opcode, funct3, 7'b0000000);
            writeback_sel = 1'b1;
        end
        CLASS_LOAD: begin
            mem_read      = 1'b1;
            alu_op        = 3'b000;
            writeback_sel = 1'b1;
        end
        CLASS_STORE: begin
            mem_write     = 1'b1;
            alu_op        = 3'b000;
            writeback_sel = 1'b0;
        end
        CLASS_BRANCH: begin
            branch        = 1'b1;
            alu_op        = 3'b001;
            writeback_sel = 1'b0;
        end
        CLASS_LUI: begin
            alu_op        = 3'b010;
            writeback_sel = 1'b1;
        end
        CLASS_AUIPC: begin
            alu_op        = 3'b011;
            writeback_sel = 1'b1;
        end
        CLASS_JAL: begin
            branch        = 1'b1;
            alu_op        = 3'b100;
            writeback_sel = 1'b1;
        end
        CLASS_JALR: begin
            branch        = 1'b1;
            alu_op        = 3'b101;
            writeback_sel = 1'b1;
        end
        CLASS_MISC: begin
            alu_op        = 3'b110;
            writeback_sel = 1'b0;
        end
        default: begin
            illegal       = 1'b1;
            alu_op        = 3'b000;
            writeback_sel = 1'b0;
        end
    endcase

    if (op_class == CLASS_BRANCH && funct3 == 3'b000) begin
        alu_op = 3'b111;
    end
end

endmodule