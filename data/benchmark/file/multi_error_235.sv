module decoder (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         valid_i,
    input  logic         stall_i,
    input  logic [31:0]  instr_i,
    output logic [3:0]   alu_op_o,
    output logic         use_imm_o,
    output logic         branch_o,
    output logic         mem_read_o,
    output logic         mem_write_o,
    output logic         reg_write_o,
    output logic [31:0]  imm_o,
    output logic [4:0]   rs1_addr_o,
    output logic [4:0]   rs2_addr_o,
    output logic [4:0]   rd_addr_o,
    output logic         illegal_o,
    output logic         ready_o
);

    typedef enum logic [3:0] {
        ALU_ADD = 4'd0,
        ALU_SUB = 4'd1,
        ALU_AND = 4'd2,
        ALU_OR  = 4'd3,
        ALU_XOR = 4'd4,
        ALU_SLT = 4'd5,
        ALU_SLL = 4'd6,
        ALU_SRL = 4'd7
    } alu_e;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [4:0]  rd;

    logic [31:0] imm_i_type;
    logic [31:0] imm_s_type;
    logic [31:0] imm_b_type;
    logic [31:0] imm_u_type;

    logic [3:0]  dec_alu_op;
    logic        dec_use_imm;
    logic        dec_branch;
    logic        dec_mem_read;
    logic        dec_mem_write;
    logic        dec_reg_write;
    logic [31:0] dec_imm;
    logic [4:0]  dec_rs1;
    logic [4:0]  dec_rs2;
    logic [4:0]  dec_rd;
    logic        dec_illegal;

    logic        stage_valid;
    logic        next_valid;

    logic [3:0]  dbg_unused;

    always_comb begin
        opcode = instr_i[6:0];
        funct3 = instr_i[14:12];
        funct7 = instr_i[31:25];
        rd     = instr_i[11:7];
        rs1    = instr_i[19:15];
        rs2    = instr_i[24:20];

        imm_i_type = {{20{instr_i[31]}}, instr_i[31:20]};
        imm_s_type = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
        imm_b_type = {{19{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
        imm_u_type = {instr_i[31:12], 12'b0};

        dec_alu_op    = ALU_ADD;
        dec_use_imm   = 1'b0;
        dec_branch    = 1'b0;
        dec_mem_read  = 1'b0;
        dec_mem_write = 1'b0;
        dec_reg_write = 1'b0;
        dec_imm       = 32'h0000_0000;
        dec_rs1       = rs1;
        dec_rs2       = rs2;
        dec_rd        = rd;
        dec_illegal   = 1'b0;

        unique case (opcode)
            7'b0110011: begin
                case (funct3)
                    3'b000: dec_alu_op = funct7[5] ? ALU_SUB : ALU_ADD;
                    3'b111: dec_alu_op = ALU_AND;
                    3'b110: dec_alu_op = ALU_OR;
                    3'b100: dec_alu_op = ALU_XOR;
                    3'b010: dec_alu_op = ALU_SLT;
                    3'b001: dec_alu_op = ALU_SLL;
                    3'b101: dec_alu_op = ALU_SRL;
                    default: dec_illegal = 1'b1;
                endcase
                dec_use_imm   = 1'b0;
                dec_reg_write = 1'b1;
            end
            7'b0010011: begin
                case (funct3)
                    3'b000: dec_alu_op = ALU_ADD;
                    3'b111: dec_alu_op = ALU_AND;
                    3'b110: dec_alu_op = ALU_OR;
                    3'b100: dec_alu_op = ALU_XOR;
                    3'b010: dec_alu_op = ALU_SLT;
                    3'b001: dec_alu_op = ALU_SLL;
                    3'b101: dec_alu_op = ALU_SRL;
                    default: dec_illegal = 1'b1;
                endcase
                dec_use_imm   = 1'b1;
                dec_imm       = imm_i_type;
                dec_reg_write = 1'b1;
            end
            7'b0000011: begin
                dec_use_imm   = 1'b1;
                dec_imm       = imm_i_type;
                dec_mem_read  = 1'b1;
                dec_reg_write = 1'b1;
                dec_alu_op    = ALU_ADD;
            end
            7'b0100011: begin
                dec_use_imm   = 1'b1;
                dec_imm       = imm_s_type;
                dec_mem_write = 1'b1;
                dec_alu_op    = ALU_ADD;
            end
            7'b1100011: begin
                dec_branch    = 1'b1;
                dec_use_imm   = 1'b1;
                dec_imm       = imm_b_type;
                dec_alu_op    = ALU_SUB;
            end
            7'b0110111: begin
                dec_use_imm   = 1'b1;
                dec_imm       = imm_u_type;
                dec_reg_write = 1'b1;
                dec_alu_op    = ALU_ADD;
            end
            7'b0010111: begin
                dec_use_imm   = 1'b1;
                dec_imm       = imm_u_type;
                dec_reg_write = 1'b1;
                dec_alu_op    = ALU_ADD;
            end
            default: begin
                dec_illegal = 1'b1;
            end
        endcase

        next_valid = valid_i && !stall_i;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            alu_op_o     <= 4'd0;
            use_imm_o    <= 1'b0;
            branch_o     <= 1'b0;
            mem_read_o   <= 1'b0;
            mem_write_o  <= 1'b0;
            reg_write_o  <= 1'b0;
            imm_o        <= 32'h0;
            rs1_addr_o   <= 5'd0;
            rs2_addr_o   <= 5'd0;
            rd_addr_o    <= 5'd0;
            illegal_o    <= 1'b0;
            stage_valid  <= 1'b0;
            ready_o      <= 1'b0;
        end else begin
            if (!stall_i) begin
                stage_valid = next_valid;
                if (valid_i) begin
                    alu_op_o     <= dec_alu_op;
                    use_imm_o    <= dec_use_imm;
                    branch_o     <= dec_branch;
                    mem_read_o   <= dec_mem_read;
                    mem_write_o  <= dec_mem_write;
                    reg_write_o  <= dec_reg_write;
                    imm_o        <= dec_imm;
                    rs1_addr_o   <= dec_rs1;
                    rs2_addr_o   <= dec_rs2;
                    rd_addr_o    <= dec_rd;
                    illegal_o    <= dec_illegal;
                end
                ready_o <= stage_valid;
            end
        end
    end

endmodule