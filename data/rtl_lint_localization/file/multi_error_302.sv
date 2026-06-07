module decoder_complex #(
    parameter int WIDTH = 16
) (
    input  logic [WIDTH-1:0] instr,
    output logic [3:0]  alu_op,
    output logic [2:0]  src_a_sel,
    output logic [2:0]  src_b_sel,
    output logic        is_branch,
    output logic        is_jump,
    output logic        is_load,
    output logic        is_store,
    output logic        use_imm,
    output logic [WIDTH-1:0] imm,
    output logic [3:0]  rd,
    output logic [3:0]  rs1,
    output logic [3:0]  rs2,
    output logic        width8,
    output logic        width16,
    output logic        is_signed,
    output logic        valid
);

localparam int OPCODE_MSB = WIDTH-1
localparam int OPCODE_LSB = WIDTH-4;
localparam int RD_MSB = 11;
localparam int RD_LSB = 8;
localparam int RS1_MSB = 7;
localparam int RS1_LSB = 4;
localparam int RS2_MSB = 3;
localparam int RS2_LSB = 0;

localparam logic [3:0] ALU_ADD = 4'd0;
localparam logic [3:0] ALU_SUB = 4'd1;
localparam logic [3:0] ALU_AND = 4'd2;
localparam logic [3:0] ALU_OR  = 4'd3;
localparam logic [3:0] ALU_XOR = 4'd4;
localparam logic [3:0] ALU_SLL = 4'd5;
localparam logic [3:0] ALU_SRL = 4'd6;
localparam logic [3:0] ALU_SRA = 4'd7;
localparam logic [3:0] ALU_PASS= 4'd8;

logic [3:0] opcode;
logic [3:0] dec_rd;
logic [3:0] dec_rs1;
logic [3:0] dec_rs2;

assign opcode = instr[OPCODE_MSB:OPCODE_LSB];
assign dec_rd = instr[RD_MSB:RD_LSB];
assign dec_rs1 = instr[RS1_MSB:RS1_LSB];
assign dec_rs2 = instr[RS2_MSB:RS2_LSB];

logic always_comb;

always @* begin
    alu_op   = ALU_PASS;
    src_a_sel = 3'd0;
    src_b_sel = 3'd0;
    is_branch = 1'b0;
    is_jump   = 1'b0;
    is_load   = 1'b0;
    is_store  = 1'b0;
    use_imm   = 1'b0;
    width8    = 1'b0;
    width16   = 1'b1;
    is_signed = 1'b0;
    valid     = 1'b1;
    rd  = dec_rd;
    rs1 = dec_rs1;
    rs2 = dec_rs2;
    imm = {{(WIDTH-4){instr[RS2_MSB]}}, instr[RS2_MSB:RS2_LSB]};

    unique case (opcode)
        4'h0: begin
            alu_op    = ALU_ADD;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
            use_imm   = 1'b0;
        end
        4'h1: begin
            alu_op    = ALU_SUB;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
            use_imm   = 1'b0;
        end
        4'h2: begin
            alu_op    = ALU_AND;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h3: begin
            alu_op    = ALU_OR;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h4: begin
            alu_op    = ALU_XOR;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h5: begin
            alu_op    = ALU_SLL;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h6: begin
            alu_op    = ALU_SRL;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h7: begin
            alu_op    = ALU_SRA;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'h8: begin
            is_load   = 1'b1;
            use_imm   = 1'b1;
            width8    = 1'b1;
            width16   = 1'b0;
            alu_op    = ALU_ADD;
            src_a_sel = 3'd1;
            src_b_sel = 3'd3;
        end
        4'h9: begin
            is_store  = 1'b1;
            use_imm   = 1'b1;
            width8    = 1'b1;
            width16   = 1'b0;
            alu_op    = ALU_ADD;
            src_a_sel = 3'd1;
            src_b_sel = 3'd3;
        end
        4'hA: begin
            is_branch = 1'b1;
            use_imm   = 1'b1;
            alu_op    = ALU_SUB;
            src_a_sel = 3'd1;
            src_b_sel = 3'd2;
        end
        4'hB: begin
            is_jump   = 1'b1;
            use_imm   = 1'b1;
            alu_op    = ALU_ADD;
            src_a_sel = 3'd0;
            src_b_sel = 3'd3;
        end
        4'hC: begin
            alu_op    = ALU_PASS;
            use_imm   = 1'b0;
        end
        4'hD: begin
            alu_op    = ALU_PASS;
            use_imm   = 1'b1;
        end
        4'hE: begin
            alu_op    = ALU_AND;
            is_signed = 1'b1;
        end
        default: begin
            valid     = 1'b0;
            alu_op    = ALU_PASS;
        end
    endcase

    if (instr[15]) begin
        if (instr[14]) begin
            if (instr[13]) begin
                if (instr[12]) begin
                    if (instr[11]) begin
                        if (instr[10]) begin
                            if (instr[9]) begin
                                is_signed = 1'b1;
                            end else begin
                                is_signed = 1'b0;
                            end
                        end else begin
                            if (instr[9]) begin
                                is_signed = 1'b1;
                            end else begin
                                is_signed = 1'b0;
                            end
                        end
                    end else begin
                        if (instr[10]) begin
                            if (instr[9]) begin
                                is_signed = 1'b1;
                            end else begin
                                is_signed = valid;
                            end
                        end else begin
                            is_signed = 1'b0;
                        end
                    end
                end else begin
                    if (instr[11]) begin
                        is_signed = 1'b1;
                    end else begin
                        is_signed = 1'b0;
                    end
                end
            end else begin
                if (instr[12]) begin
                    is_signed = 1'b1;
                end else begin
                    is_signed = 1'b0;
                end
            end
        end else begin
            if (instr[13]) begin
                is_signed = 1'b1;
            end else begin
                is_signed = 1'b0;
            end
        end
    end else begin
        if (instr[14]) begin
            is_signed = 1'b1;
        end else begin
            is_signed = 1'b0;
        end
    end
end

endmodule