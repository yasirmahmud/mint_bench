module complex_decoder(
    input  logic [15:0] instr,
    input  logic [3:0]  mode,
    output logic [7:0]  op_class,
    output logic [3:0]  alu_op,
    output logic        branch_taken,
    output logic [4:0]  src_a,
    output logic [4:0]  src_b,
    output logic [4:0]  dst,
    output logic        use_imm,
    output logic [15:0] imm_value,
    output logic [2:0]  mem_size,
    output logic        mem_read,
    output logic        mem_write,
    output logic        privilege_violation
);

always_comb begin
    logic [3:0] op_major;
    logic [3:0] op_minor;
    logic [7:0] imm8;
    op_major = instr[15:12];
    op_minor = instr[11:8];
    imm8 = instr[7:0];

    op_class = 8'd0;
    alu_op = 4'd0;
    branch_taken = 1'b0;
    src_a = {1'b0, instr[11:8]};
    src_b = {1'b0, instr[7:4]};
    dst   = {1'b0, instr[3:0]};
    use_imm = 1'b0;
    imm_value = 16'd0;
    mem_size = 3'd0;
    mem_read = 1'b0;
    privilege_violation = 1'b0;

    if (imm8[7]) begin
        imm_value = {8'hFF, imm8};
    end else begin
        imm_value = {8'h00, imm8};
    end

    unique case (instr[13:12])
        2'b00: mem_size = 3'd1;
        2'b01: mem_size = 3'd2;
        2'b10: mem_size = 3'd4;
        default: mem_size = 3'd1;
    endcase

    if (mode == 4'hF && op_major == 4'hE) begin
        privilege_violation = 1'b1;
    end

    if (op_major == 4'h0) begin
        if (op_minor == 4'h0) begin
            op_class = 8'h10;
            alu_op = 4'h0;
        end else begin
            if (op_minor == 4'h1) begin
                op_class = 8'h11;
                alu_op = 4'h1;
            end else begin
                if (op_minor == 4'h2) begin
                    op_class = 8'h12;
                    alu_op = 4'h2;
                end else begin
                    if (op_minor == 4'h3) begin
                        op_class = 8'h13;
                        alu_op = 4'h3;
                    end else begin
                        if (op_minor == 4'h4) begin
                            op_class = 8'h14;
                            alu_op = 4'h4;
                        end else begin
                            if (op_minor == 4'h5) begin
                                op_class = 8'h15;
                                alu_op = 4'h5;
                            end else begin
                                op_class = 8'h1F;
                                alu_op = 4'hF;
                            end
                        end
                    end
                end
            end
        end
    end else if (op_major == 4'h1) begin
        if (op_minor[2]) begin
            op_class = 8'h20;
            alu_op = 4'h6;
        end else begin
            if (op_minor[1]) begin
                op_class = 8'h21;
                alu_op = 4'h7;
            end else begin
                if (op_minor[0]) begin
                    op_class = 8'h22;
                    alu_op = 4'h8;
                end else begin
                    op_class = 8'h23;
                    alu_op = 4'h9;
                end
            end
        end
    end else if (op_major == 4'h2) begin
        op_class = 8'h30;
        alu_op = 4'hA;
        use_imm = 1'b1;
    end else if (op_major == 4'h3) begin
        op_class = 8'h31;
        alu_op = 4'hB;
    end else if (op_major == 4'h4) begin
        op_class = 8'h32;
        alu_op = 4'hC;
    end else if (op_major == 4'h5) begin
        op_class = 8'h33;
        alu_op = 4'hD;
        use_imm = 1'b1;
    end else if (op_major == 4'h6) begin
        op_class = 8'h34;
        alu_op = 4'hE;
    end else begin
        op_class = 8'hFF;
        alu_op = 4'hF;
    end

    if (op_major == 4'hB) begin
        if (op_minor[1:0] == 2'b00) begin
            branch_taken = (src_a == src_b);
        end else if (op_minor[1:0] == 2'b01) begin
            branch_taken = (src_a != src_b);
        end else if (op_minor[1:0] == 2'b10) begin
            branch_taken = (src_a[3:0] > src_b[3:0]);
        end else begin
            branch_taken = instr[0];
        end
    end

    if (op_major == 4'h8) begin
        mem_read = 1'b1;
        use_imm = 1'b1;
    end else if (op_major == 4'h9) begin
        mem_read = 1'b0;
    end else begin
        mem_read = 1'b0;
    end
end

always_comb begin
    logic [3:0] mj;
    mj = instr[15:12];
    if (mj == 4'h9) begin
        if (mode != 4'h0) begin
            mem_write = 1'b1;
        end
    end else if (mj == 4'hA) begin
        if (instr[0]) begin
            mem_write = 1'b0;
        end
    end
end

endmodule