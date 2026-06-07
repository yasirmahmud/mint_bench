module decoder_unit (
    input  logic [31:0] instr,
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    input  logic [31:0] rs1,
    input  logic [31:0] rs2,
    output logic is_load,
    output logic is_store,
    output logic is_branch,
    output logic use_imm,
    output logic [3:0] alu_op,
    output logic [1:0] mem_width,
    output logic [31:0] imm_out,
    output logic [31:0] addr_base,
    output logic [31:0] scaled_offset,
    output logic [1:0] write_back_sel
);

    localparam [6:0] OPC_LOAD   = 7'h03;
    localparam [6:0] OPC_STORE  = 7'h23;
    localparam [6:0] OPC_OPIMM  = 7'h13;
    localparam [6:0] OPC_OP     = 7'h33;
    localparam [6:0] OPC_BRANCH = 7'h63;
    localparam [6:0] OPC_LUI    = 7'h37;
    localparam [6:0] OPC_AUIPC  = 7'h17;
    localparam [6:0] OPC_JAL    = 7'h6F;
    localparam [6:0] OPC_JALR   = 7'h67;

    always_comb begin
        is_load = 1'b0;
        is_store = 1'b0;
        is_branch = 1'b0;
        use_imm = 1'b0;
        alu_op = 4'h0;
        imm_out = 32'h0000_0000;
        addr_base = 32'h0000_0000;
        write_back_sel = 2'b00;

        case (opcode)
            OPC_LOAD: begin
                is_load = 1'b1;
                use_imm = 1'b1;
                imm_out = {{20{instr[31]}}, instr[31:20]};
                alu_op = 4'h0;
                addr_base = rs1 + imm_out;
                write_back_sel = 2'b01;
            end
            OPC_STORE: begin
                is_store = 1'b1;
                use_imm = 1'b1;
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
                alu_op = 4'h0;
                addr_base = rs1 + imm_out;
                write_back_sel = 2'b00;
            end
            OPC_BRANCH: begin
                is_branch = 1'b1;
                use_imm = 1'b1;
                imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
                alu_op = 4'h8;
                addr_base = rs1 + imm_out;
                write_back_sel = 2'b00;
            end
            OPC_OPIMM: begin
                use_imm = 1'b1;
                imm_out = {{20{instr[31]}}, instr[31:20]};
                case (funct3)
                    3'b000: alu_op = 4'h0;
                    3'b010: alu_op = 4'h1;
                    3'b011: alu_op = 4'h2;
                    3'b100: alu_op = 4'h3;
                    3'b110: alu_op = 4'h4;
                    3'b111: alu_op = 4'h5;
                    3'b001: alu_op = 4'h6;
                    3'b101: begin
                        if (funct7[5]) alu_op = 4'h7; else alu_op = 4'h9;
                    end
                    default: alu_op = 4'h0;
                endcase
                addr_base = rs1;
                write_back_sel = 2'b10;
            end
            OPC_OP: begin
                use_imm = 1'b0;
                imm_out = 32'h0;
                case (funct3)
                    3'b000: begin
                        if (funct7[5]) alu_op = 4'hA; else alu_op = 4'h0;
                    end
                    3'b001: alu_op = 4'h6;
                    3'b010: alu_op = 4'h1;
                    3'b011: alu_op = 4'h2;
                    3'b100: alu_op = 4'h3;
                    3'b101: begin
                        if (funct7[5]) alu_op = 4'h7; else alu_op = 4'h9;
                    end
                    3'b110: alu_op = 4'h4;
                    3'b111: alu_op = 4'h5;
                    default: alu_op = 4'h0;
                endcase
                addr_base = rs1 + rs2;
                write_back_sel = 2'b10;
            end
            OPC_LUI: begin
                use_imm = 1'b1;
                imm_out = {instr[31:12], 12'b0};
                alu_op = 4'hB;
                addr_base = 32'h0;
                write_back_sel = 2'b10;
            end
            OPC_AUIPC: begin
                use_imm = 1'b1;
                imm_out = {instr[31:12], 12'b0};
                alu_op = 4'h0;
                addr_base = imm_out;
                write_back_sel = 2'b10;
            end
            OPC_JAL: begin
                use_imm = 1'b1;
                imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
                alu_op = 4'h0;
                addr_base = imm_out;
                write_back_sel = 2'b11;
            end
            OPC_JALR: begin
                use_imm = 1'b1;
                imm_out = {{20{instr[31]}}, instr[31:20]};
                alu_op = 4'h0;
                addr_base = rs1 + imm_out;
                write_back_sel = 2'b11;
            end
            default: begin
                use_imm = 1'b0;
                imm_out = 32'h0;
                alu_op = 4'h0;
                addr_base = 32'h0;
                write_back_sel = 2'b00;
            end
        endcase
    end

    always @(opcode) begin
        mem_width = 2'b00;
        if (opcode == OPC_LOAD || opcode == OPC_STORE) begin
            case (funct3)
                3'b000: mem_width = 2'b00;
                3'b001: mem_width = 2'b01;
                3'b010: mem_width = 2'b10;
                default: mem_width = 2'b00;
            endcase
        end else begin
            mem_width = 2'b00;
        end
    end

    assign scaled_offset = imm_out * 32'd1000;

endmodule