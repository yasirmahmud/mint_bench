module decoder(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         enable,
    input  logic [1:0]   mode,
    input  logic [6:0]   opcode,
    input  logic [2:0]   funct3,
    input  logic [6:0]   funct7,
    input  logic [31:0]  instr,
    output logic [3:0]   alu_op,
    output logic         mem_read,
    output logic         mem_write,
    output logic         branch,
    output logic         jump,
    output logic         reg_write,
    output logic [2:0]   imm_sel,
    output logic [31:0]  imm_ext,
    output logic [31:0]  target_offset,
    output logic [31:0]  decode_flags
);

    logic                predecode_valid;
    logic                decoded_valid_q;
    logic [31:0]         imm_i;
    logic [31:0]         imm_s;
    logic [31:0]         imm_b;
    logic [31:0]         imm_u;
    logic [31:0]         imm_j;
    logic [31:0]         base_offset;

    assign imm_i = {{21{instr[31]}}, instr[30:20]};
    assign imm_s = {{21{instr[31]}}, instr[30:25], instr[11:7]};
    assign imm_b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign imm_u = {instr[31:12], 12'b0};
    assign imm_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    assign base_offset = {16'b0, instr[15:8], 8'b0};

    always @(opcode or enable) begin
        if (!enable) begin
            predecode_valid = 1'b0;
        end else begin
            if (mode == 2'b00)
                predecode_valid = (opcode == 7'h33) || (opcode == 7'h03) || (opcode == 7'h23);
            else
                predecode_valid = (opcode == 7'h63) || (opcode == 7'h6F);
        end
    end

    always @(clk or rst_n) begin
        if (!rst_n) begin
            decoded_valid_q <= 1'b0;
        end else if (clk) begin
            decoded_valid_q <= predecode_valid & enable;
        end
    end

    always @(*) begin
        alu_op    = 4'h0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        branch    = 1'b0;
        reg_write = 1'b0;
        imm_sel   = 3'b000;
        case (opcode)
            7'h33: begin
                reg_write = 1'b1;
                imm_sel   = 3'b000;
                case (funct3)
                    3'b000: alu_op = (funct7[5]) ? 4'h1 : 4'h2;
                    3'b001: alu_op = 4'h5;
                    3'b010: alu_op = 4'h6;
                    3'b111: alu_op = 4'h3;
                    default: alu_op = 4'h0;
                endcase
            end
            7'h03: begin
                mem_read  = 1'b1;
                reg_write = 1'b1;
                imm_sel   = 3'b001;
                alu_op    = 4'h2;
            end
            7'h23: begin
                mem_write = 1'b1;
                imm_sel   = 3'b010;
                alu_op    = 4'h2;
            end
            7'h63: begin
                branch    = 1'b1;
                imm_sel   = 3'b011;
                alu_op    = 4'h4;
            end
            7'h6F: begin
                reg_write = 1'b1;
                imm_sel   = 3'b100;
                jump      = 1'b1;
            end
        endcase
    end

    always_comb begin
        imm_ext       = 32'h0;
        target_offset = 32'h0;
        decode_flags  = 32'h0;
        if (imm_sel == 3'b001) begin
            if (funct3 == 3'b000) begin
                if (decoded_valid_q) begin
                    imm_ext       = imm_i;
                    target_offset = imm_i;
                    decode_flags[0] = 1'b1;
                    if (funct7[0]) begin
                        decode_flags[4] = 1'b1;
                        if (instr[14]) begin
                            decode_flags[8] = 1'b1;
                            if (instr[13]) begin
                                decode_flags[12] = 1'b1;
                            end else begin
                                decode_flags[13] = 1'b1;
                            end
                        end else begin
                            decode_flags[9] = 1'b1;
                        end
                    end else begin
                        decode_flags[5] = 1'b1;
                    end
                end else begin
                    imm_ext       = 32'h0;
                    target_offset = 32'h0;
                end
            end else begin
                imm_ext       = imm_i;
                target_offset = imm_i;
                decode_flags[1] = 1'b1;
            end
        end else if (imm_sel == 3'b010) begin
            if (funct3[1]) begin
                imm_ext       = imm_s;
                target_offset = imm_s;
                decode_flags[2] = 1'b1;
            end else begin
                if (funct3[0]) begin
                    imm_ext       = imm_s;
                    target_offset = imm_s + base_offset;
                    decode_flags[3] = 1'b1;
                end else begin
                    imm_ext       = imm_s;
                    target_offset = imm_s;
                end
            end
        end else if (imm_sel == 3'b011) begin
            if (branch) begin
                imm_ext       = imm_b;
                target_offset = imm_b;
                decode_flags[6] = 1'b1;
            end else begin
                imm_ext       = 32'h0;
                target_offset = 32'h0;
            end
        end else if (imm_sel == 3'b100) begin
            imm_ext       = imm_j;
            target_offset = imm_j;
            decode_flags[7] = 1'b1;
        end else begin
            imm_ext       = imm_u;
            target_offset = imm_u;
            decode_flags[10] = 1'b1;
        end
        decode_flags[16] = reg_write;
        decode_flags[17] = mem_read;
        decode_flags[18] = mem_write;
        decode_flags[19] = branch;
        decode_flags[20] = jump;
        decode_flags[24 +: 4] = alu_op;
    end

endmodule