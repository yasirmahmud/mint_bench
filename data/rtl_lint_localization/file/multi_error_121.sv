module instr_decoder #(parameter OPC_W=6, FNC_W=6, IMM_W=16) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     valid,
    input  logic [OPC_W-1:0]         opcode,
    input  logic [FNC_W-1:0]         funct,
    input  logic [IMM_W-1:0]         imm,
    input  logic [1:0]               mode,
    output logic [3:0]               alu_op,
    output logic                     mem_read,
    output logic                     mem_write,
    output logic                     branch,
    output logic                     jump,
    output logic                     use_imm,
    output logic                     reg_write,
    output logic                     illegal
);

    logic [3:0] alu_op_c;
    logic       mem_read_c;
    logic       mem_write_c;
    logic       branch_c;
    logic       jump_c;
    logic       use_imm_c;
    logic       reg_write_c;
    logic       illegal_c;

    logic [3:0] alu_op_r;
    logic       mem_read_r;
    logic       mem_write_r;
    logic       branch_r;
    logic       jump_r;
    logic       use_imm_r;
    logic       reg_write_r;
    logic       illegal_r;

    always @(opcode or mode) begin
        alu_op_c     = 4'd0;
        mem_read_c   = 1'b0;
        mem_write_c  = 1'b0;
        branch_c     = 1'b0;
        jump_c       = 1'b0;
        use_imm_c    = 1'b0;
        reg_write_c  = 1'b0;
        illegal_c    = 1'b0;

        unique case (opcode)
            6'h00: begin
                use_imm_c   = 1'b0;
                reg_write_c = 1'b1;
                unique case (funct[3:0])
                    4'h0: alu_op_c = 4'h1;
                    4'h1: alu_op_c = 4'h2;
                    4'h2: alu_op_c = 4'h3;
                    4'h3: alu_op_c = 4'h4;
                    4'h4: alu_op_c = 4'h5;
                    4'h5: alu_op_c = 4'h6;
                    default: begin
                        illegal_c   = 1'b1;
                        reg_write_c = 1'b0;
                        alu_op_c    = 4'h0;
                    end
                endcase
            end
            6'h08: begin
                use_imm_c   = 1'b1;
                reg_write_c = 1'b1;
                if (mode == 2'b00) begin
                    alu_op_c = 4'h1;
                end else if (mode == 2'b01) begin
                    alu_op_c = 4'h7;
                end else if (mode == 2'b10) begin
                    alu_op_c = imm[1] ? 4'h8 : 4'h9;
                end else begin
                    alu_op_c    = 4'h0;
                    illegal_c   = 1'b1;
                    reg_write_c = 1'b0;
                end
            end
            6'h20: begin
                mem_read_c   = 1'b1;
                use_imm_c    = 1'b1;
                reg_write_c  = 1'b1;
                alu_op_c     = 4'h1;
            end
            6'h28: begin
                mem_write_c  = 1'b1;
                use_imm_c    = 1'b1;
                reg_write_c  = 1'b0;
                alu_op_c     = 4'h1;
            end
            6'h30: begin
                branch_c     = 1'b1;
                use_imm_c    = 1'b1;
                reg_write_c  = 1'b0;
                alu_op_c     = 4'h2;
            end
            6'h38: begin
                jump_c       = 1'b1;
                use_imm_c    = 1'b1;
                reg_write_c  = 1'b0;
                alu_op_c     = 4'h0;
            end
            default: begin
                illegal_c    = 1'b1;
                alu_op_c     = 4'h0;
            end
        endcase

        if (mode == 2'b11 && opcode == 6'h00 && funct[5]) begin
            alu_op_c = 4'hA;
        end
    end

    always @(posedge clk or negedge rst_n or posedge valid) begin
        if (!rst_n) begin
            alu_op_r     <= 4'd0;
            mem_read_r   <= 1'b0;
            mem_write_r  <= 1'b0;
            branch_r     <= 1'b0;
            jump_r       <= 1'b0;
            use_imm_r    <= 1'b0;
            reg_write_r  <= 1'b0;
            illegal_r    <= 1'b0;
        end else if (valid) begin
            alu_op_r     <= alu_op_c;
            mem_read_r   <= mem_read_c;
            mem_write_r  <= mem_write_c;
            branch_r     <= branch_c;
            jump_r       <= jump_c;
            use_imm_r    <= use_imm_c;
            reg_write_r  <= reg_write_c;
            illegal_r    <= illegal_c;
        end else begin
        end
    end

    assign alu_op    = alu_op_r;
    assign mem_read  = mem_read_r;
    assign mem_write = mem_write_r;
    assign branch    = branch_r;
    assign jump      = jump_r;
    assign use_imm   = use_imm_r;
    assign reg_write = reg_write_r;
    assign illegal   = illegal_r;

endmodule