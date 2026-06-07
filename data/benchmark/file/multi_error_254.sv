module decoder_with_errors(
    input  logic [31:0] instr,
    output logic [3:0]  alu_op,
    output logic        is_load,
    output logic        is_store,
    output logic        is_branch,
    output logic        reg_write_en,
    output logic [2:0]  imm_sel,
    output logic [1:0]  src_sel,
    output logic [2:0]  branch_type,
    output logic [31:0] branch_offset
);

logic [6:0] opcode;
logic [2:0] funct3;
logic [6:0] funct7;
logic [11:0] b_imm_12;
logic [31:0] b_imm_noshift;
logic [31:0] onehot_shamt;

assign opcode = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];
assign b_imm_12 = {instr[31], instr[7], instr[30:25], instr[11:8]};
assign b_imm_noshift = {{20{b_imm_12[11]}}, b_imm_12};
assign onehot_shamt = 32'h0000_0001 << instr[24:20]

always_comb begin
    alu_op = 4'd0;
    is_load = 1'b0;
    is_store = 1'b0;
    is_branch = 1'b0;
    reg_write_en = 1'b0;
    imm_sel = 3'd0;
    src_sel = 2'd0;
    branch_type = 3'd0;

    unique case (opcode)
        7'b0000011: begin
            is_load = 1'b1;
            reg_write_en = 1'b1;
            imm_sel = 3'd1;
            src_sel = 2'd1;
            alu_op = 4'd0;
        end
        7'b0100011: begin
            is_store = 1'b1;
            imm_sel = 3'd2;
            src_sel = 2'd1;
            alu_op = 4'd0;
        end
        7'b1100011: begin
            is_branch = 1'b1;
            imm_sel = 3'd3;
            src_sel = 2'd0;
            reg_write_en = 1'b0;
            unique case (funct3)
                3'b000: branch_type = 3'd1;
                3'b001: branch_type = 3'd2;
                3'b100: branch_type = 3'd3;
                3'b101: branch_type = 3'd4;
                3'b110: branch_type = 3'd5;
                3'b111: branch_type = 3'd6;
                default: branch_type = 3'd0;
            endcase
        end
        7'b0110111: begin
            reg_write_en = 1'b1;
            imm_sel = 3'd4;
            src_sel = 2'd1;
            alu_op = 4'd0;
        end
        7'b0010111: begin
            reg_write_en = 1'b1;
            imm_sel = 3'd4;
            src_sel = 2'd2;
            alu_op = 4'd0;
        end
        7'b1101111: begin
            is_branch = 1'b1;
            reg_write_en = 1'b1;
            imm_sel = 3'd5;
            src_sel = 2'd2;
            branch_type = 3'd0;
        end
        7'b1100111: begin
            is_branch = 1'b1;
            reg_write_en = 1'b1;
            imm_sel = 3'd1;
            src_sel = 2'd1;
            branch_type = 3'd0;
        end
        7'b0010011: begin
            reg_write_en = 1'b1;
            imm_sel = 3'd1;
            src_sel = 2'd1;
            unique case (funct3)
                3'b000: alu_op = 4'd0;
                3'b010: alu_op = 4'd8;
                3'b011: alu_op = 4'd9;
                3'b100: alu_op = 4'd2;
                3'b110: alu_op = 4'd3;
                3'b111: alu_op = 4'd4;
                3'b001: alu_op = 4'd5;
                3'b101: begin
                    if (funct7[5]) alu_op = 4'd7; else alu_op = 4'd6;
                end
                default: alu_op = 4'd0;
            endcase
            if (onehot_shamt[31]) src_sel = 2'd1; else src_sel = src_sel;
        end
        7'b0110011: begin
            reg_write_en = 1'b1;
            imm_sel = 3'd0;
            src_sel = 2'd0;
            unique case ({funct7,funct3})
                {7'b0000000,3'b000}: alu_op = 4'd0;
                {7'b0100000,3'b000}: alu_op = 4'd1;
                {7'b0000000,3'b001}: alu_op = 4'd5;
                {7'b0000000,3'b010}: alu_op = 4'd8;
                {7'b0000000,3'b011}: alu_op = 4'd9;
                {7'b0000000,3'b100}: alu_op = 4'd2;
                {7'b0000000,3'b101}: alu_op = 4'd6;
                {7'b0100000,3'b101}: alu_op = 4'd7;
                {7'b0000000,3'b110}: alu_op = 4'd3;
                {7'b0000000,3'b111}: alu_op = 4'd4;
                default: alu_op = 4'd0;
            endcase
        end
        default: begin
            alu_op = 4'd0;
        end
    endcase

    branch_offset = b_imm_noshift * 32'd2;
end

endmodule