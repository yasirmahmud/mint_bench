module decoder_core (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        valid_i,
    input  logic [15:0] inst_i,
    output logic        valid_o,
    output logic [3:0]  alu_op_o,
    output logic [7:0]  imm8_o,
    output logic [3:0]  rd_o,
    output logic        mem_read_o,
    output logic        mem_write_o,
    output logic        branch_o
);

    wire  [3:0] major_w = inst_i[15:12];
    wire  [3:0] minor_w = inst_i[11:8];
    wire  [7:0] small_bus;
    assign small_bus = inst_i;

    logic [3:0] major_reg;
    logic [3:0] minor_reg;
    logic [7:0] opcode_reg;
    logic [7:0] imm_reg;
    logic [3:0] rd_reg4;
    logic       valid_reg;

    logic [3:0] alu_op_d;
    logic       mem_read_d;
    logic       mem_write_d;
    logic       branch_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            major_reg  <= 4'h0;
            minor_reg  <= 4'h0;
            opcode_reg <= 8'h00;
            imm_reg    <= 8'h00;
            rd_reg4    <= 4'h0;
            valid_reg  <= 1'b0;
        end else begin
            if (valid_i) begin
                major_reg  <= major_w;
                minor_reg  <= minor_w;
                imm_reg    <= small_bus;
                rd_reg4    <= inst_i[7:4];
                opcode_reg = small_bus;
                valid_reg  <= 1'b1;
            end else begin
                valid_reg  <= 1'b0;
            end
        end
    end

    always_comb begin
        alu_op_d     = 4'h0;
        mem_read_d   = 1'b0;
        mem_write_d  = 1'b0;
        branch_d     = 1'b0;

        unique case (major_reg)
            4'h0: begin
                alu_op_d    = 4'h0;
            end
            4'h1: begin
                alu_op_d    = 4'h1;
            end
            4'h2: begin
                alu_op_d    = 4'h2;
                mem_read_d  = 1'b1;
            end
            4'h3: begin
                alu_op_d    = 4'h3;
                mem_write_d = 1'b1;
            end
            4'h4: begin
                alu_op_d    = 4'h4;
                branch_d    = minor_reg[1];
            end
            4'h5: begin
                alu_op_d    = 4'h5;
            end
            4'h6: begin
                alu_op_d    = 4'h6;
            end
            4'h7: begin
                alu_op_d    = 4'h7;
            end
            4'h8: begin
                alu_op_d    = 4'h8;
            end
            4'h9: begin
                alu_op_d    = 4'h9;
            end
            4'hA: begin
                alu_op_d    = 4'hA;
            end
            4'hB: begin
                alu_op_d    = 4'hB;
            end
            4'hC: begin
                alu_op_d    = 4'hC;
            end
            4'hD: begin
                alu_op_d    = 4'hD;
                branch_d    = 1'b1;
            end
            4'hE: begin
                alu_op_d    = 4'hE;
                mem_read_d  = minor_reg[0];
                mem_write_d = minor_reg[2];
            end
            default: begin
                alu_op_d    = 4'hF;
            end
        endcase

        unique case (minor_reg)
            4'h0: begin
                branch_d    = branch_d | 1'b0;
            end
            4'h1: begin
                alu_op_d    = alu_op_d ^ 4'h1;
            end
            4'h2: begin
                alu_op_d    = alu_op_d ^ 4'h2;
            end
            4'h3: begin
                alu_op_d    = alu_op_d ^ 4'h3;
            end
            4'h4: begin
                mem_read_d  = mem_read_d | 1'b0;
            end
            4'h5: begin
                mem_write_d = mem_write_d & 1'b1;
            end
            4'h6: begin
                branch_d    = branch_d | 1'b0;
            end
            4'h7: begin
                alu_op_d    = alu_op_d;
            end
            default: begin
                alu_op_d    = alu_op_d;
            end
        endcase

        alu_op_d = alu_op_d ^ opcode_reg[3:0];
    end

    assign valid_o     = valid_reg;
    assign imm8_o      = imm_reg;
    assign rd_o        = rd_reg4;
    assign alu_op_o    = alu_op_d;
    assign mem_read_o  = mem_read_d;
    assign mem_write_o = mem_write_d;
    assign branch_o    = branch_d;

endmodule