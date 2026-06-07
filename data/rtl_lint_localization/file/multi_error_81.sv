module decoder_unit(
    input logic clk,
    input logic rst_n,
    input wire [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [31:0] instr,
    output logic is_load,
    output logic is_store,
    output logic is_branch,
    output logic is_jal,
    output logic is_jalr,
    output logic is_alu_imm,
    output logic is_alu_reg,
    output logic [3:0] alu_op,
    output logic use_rs1,
    output logic use_rs2,
    output logic write_rd,
    output logic [31:0] imm_out,
    output logic illegal
);

    localparam [3:0] ALU_ADD  = 4'd0;
    localparam [3:0] ALU_SUB  = 4'd1;
    localparam [3:0] ALU_AND  = 4'd2;
    localparam [3:0] ALU_OR   = 4'd3;
    localparam [3:0] ALU_XOR  = 4'd4;
    localparam [3:0] ALU_SLL  = 4'd5;
    localparam [3:0] ALU_SRL  = 4'd6;
    localparam [3:0] ALU_SRA  = 4'd7;
    localparam [3:0] ALU_SLT  = 4'd8;
    localparam [3:0] ALU_SLTU = 4'd9;

    logic is_load_d;
    logic is_store_d;
    logic is_branch_d;
    logic is_jal_d;
    logic is_jalr_d;
    logic is_alu_imm_d;
    logic is_alu_reg_d;
    logic [3:0] alu_op_d;
    logic use_rs1_d;
    logic use_rs2_d;
    logic write_rd_d;
    logic [31:0] imm_d;
    logic illegal_d;

    assign opcode = instr[6:0];

    always_comb begin
        is_load_d     = 1'b0;
        is_store_d    = 1'b0;
        is_branch_d   = 1'b0;
        is_jal_d      = 1'b0;
        is_jalr_d     = 1'b0;
        is_alu_imm_d  = 1'b0;
        is_alu_reg_d  = 1'b0;
        alu_op_d      = ALU_ADD;
        use_rs1_d     = 1'b0;
        use_rs2_d     = 1'b0;
        write_rd_d    = 1'b0;
        imm_d         = 32'd0;
        illegal_d     = 1'b0;

        unique case (opcode)
            7'h03: begin
                is_load_d    = 1'b1;
                is_store_d   = 1'b0;
                is_branch_d  = 1'b0;
                is_jal_d     = 1'b0;
                is_jalr_d    = 1'b0;
                is_alu_imm_d = 1'b1;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b0;
                alu_op_d     = ALU_ADD;
                imm_d        = {{20{instr[31]}}, instr[31:20]};
            end
            7'h23: begin
                is_load_d    = 1'b0;
                is_store_d   = 1'b1;
                is_branch_d  = 1'b0;
                is_jal_d     = 1'b0;
                is_jalr_d    = 1'b0;
                is_alu_imm_d = 1'b1;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b0;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b1;
                alu_op_d     = ALU_ADD;
                imm_d        = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
            7'h63: begin
                is_load_d    = 1'b0;
                is_store_d   = 1'b0;
                is_branch_d  = 1'b1;
                is_jal_d     = 1'b0;
                is_jalr_d    = 1'b0;
                is_alu_imm_d = 1'b0;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b0;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b1;
                alu_op_d     = ALU_SUB;
                imm_d        = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end
            7'h6F: begin
                is_load_d    = 1'b0;
                is_store_d   = 1'b0;
                is_branch_d  = 1'b0;
                is_jal_d     = 1'b1;
                is_jalr_d    = 1'b0;
                is_alu_imm_d = 1'b0;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                use_rs1_d    = 1'b0;
                use_rs2_d    = 1'b0;
                alu_op_d     = ALU_ADD;
                imm_d        = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            end
            7'h67: begin
                is_load_d    = 1'b0;
                is_store_d   = 1'b0;
                is_branch_d  = 1'b0;
                is_jal_d     = 1'b0;
                is_jalr_d    = 1'b1;
                is_alu_imm_d = 1'b1;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b0;
                alu_op_d     = ALU_ADD;
                imm_d        = {{20{instr[31]}}, instr[31:20]};
            end
            7'h37: begin
                is_alu_imm_d = 1'b0;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                imm_d        = {instr[31:12], 12'b0};
            end
            7'h17: begin
                is_alu_imm_d = 1'b0;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                imm_d        = {instr[31:12], 12'b0};
            end
            7'h13: begin
                is_alu_imm_d = 1'b1;
                is_alu_reg_d = 1'b0;
                write_rd_d   = 1'b1;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b0;
                imm_d        = {{20{instr[31]}}, instr[31:20]};
                alu_op_d     = (funct3 == 3'b000) ? ALU_ADD :
                               (funct3 == 3'b010) ? ALU_SLT :
                               (funct3 == 3'b011) ? ALU_SLTU :
                               (funct3 == 3'b100) ? ALU_XOR :
                               (funct3 == 3'b110) ? ALU_OR  :
                               (funct3 == 3'b111) ? ALU_AND :
                               (funct3 == 3'b001) ? ALU_SLL :
                               ((funct3 == 3'b101) && (funct7[5] == 1'b1)) ? ALU_SRA : ALU_SRL;
            end
            7'h33: begin
                is_alu_imm_d = 1'b0;
                is_alu_reg_d = 1'b1;
                write_rd_d   = 1'b1;
                use_rs1_d    = 1'b1;
                use_rs2_d    = 1'b1;
                case (funct3)
                    3'b000: alu_op_d = (funct7[5]) ? ALU_SUB : ALU_ADD;
                    3'b001: alu_op_d = ALU_SLL;
                    3'b010: alu_op_d = ALU_SLT;
                    3'b011: alu_op_d = ALU_SLTU;
                    3'b100: alu_op_d = ALU_XOR;
                    3'b101: alu_op_d = (funct7[5]) ? ALU_SRA : ALU_SRL;
                    3'b110: alu_op_d = ALU_OR;
                    3'b111: alu_op_d = ALU_AND;
                    default: alu_op_d = ALU_ADD;
                endcase
            end
            default: begin
                illegal_d = 1'b1;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            is_load   <= 1'b0;
            is_store  <= 1'b0;
            is_branch <= 1'b0;
            is_jal    <= 1'b0;
            is_jalr   <= 1'b0;
            is_alu_imm<= 1'b0;
            is_alu_reg<= 1'b0;
            alu_op    <= ALU_ADD;
            use_rs1   <= 1'b0;
            use_rs2   <= 1'b0;
            write_rd  <= 1'b0;
            imm_out   <= 32'd0;
            illegal   <= 1'b0;
        end else begin
            is_load    <= is_load_d;
            is_store   <= is_store_d;
            is_branch  <= is_branch_d;
            is_jal     <= is_jal_d;
            is_jalr    <= is_jalr_d;
            is_alu_imm <= is_alu_imm_d;
            is_alu_reg <= is_alu_reg_d;
            alu_op     =  alu_op_d;
            use_rs1    <= use_rs1_d;
            use_rs2    <= use_rs2_d;
            write_rd   <= write_rd_d;
            imm_out    <= imm_d;
            illegal    <= illegal_d;
        end
    end

endmodule