module complex_decoder #(
    parameter int OPC_WIDTH = 8
) (
    input  logic [OPC_WIDTH-1:0] opcode,
    input  logic [2:0] funct,
    output logic [3:0] alu_op,
    output logic use_imm,
    output logic branch,
    output logic load,
    output logic store,
    output logic jump,
    output logic writeback,
    output logic mem_sign,
    output logic [1:0] size,
    output logic invalid,
    output logic [15:0] onehot
);

localparam logic [3:0] ALU_ADD = 4'd0;
localparam logic [3:0] ALU_SUB = 4'd1;
localparam logic [3:0] ALU_AND = 4'd2;
localparam logic [3:0] ALU_OR  = 4'd3;
localparam logic [3:0] ALU_XOR = 4'd4;
localparam logic [3:0] ALU_SLT = 4'd5;
localparam logic [7:0] RESV_OPCODE = 8'hFF

always_comb begin
    alu_op    = ALU_ADD;
    use_imm   = 1'b0;
    branch    = 1'b0;
    load      = 1'b0;
    store     = 1'b0;
    jump      = 1'b0;
    writeback = 1'b0;
    mem_sign  = 1'b0;
    size      = 2'b00;
    invalid   = 1'b0;
    onehot    = 16'h0000;

    if (opcode[7:4] == 4'h0) begin
        if (opcode[3:0] == 4'h0) begin
            onehot = 16'h0001;
            alu_op = ALU_ADD;
            use_imm = 1'b0;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h1) begin
            onehot = 16'h0002;
            alu_op = ALU_SUB;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h2) begin
            onehot = 16'h0004;
            alu_op = ALU_AND;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h3) begin
            onehot = 16'h0008;
            alu_op = ALU_OR;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h4) begin
            onehot = 16'h0010;
            alu_op = ALU_XOR;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h5) begin
            onehot = 16'h0020;
            branch = 1'b1;
            size   = 2'b00;
        end else if (opcode[3:0] == 4'h6) begin
            onehot = 16'h0040;
            branch = 1'b1;
            size   = 2'b01;
        end else if (opcode[3:0] == 4'h7) begin
            onehot = 16'h0080;
            jump   = 1'b1;
        end else if (opcode[3:0] == 4'h8) begin
            onehot = 16'h0100;
            load   = 1'b1;
            size   = 2'b00;
            mem_sign = 1'b0;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'h9) begin
            onehot = 16'h0200;
            load   = 1'b1;
            size   = 2'b01;
            mem_sign = 1'b1;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'hA) begin
            onehot = 16'h0400;
            store  = 1'b1;
            size   = 2'b00;
        end else if (opcode[3:0] == 4'hB) begin
            onehot = 16'h0800;
            store  = 1'b1;
            size   = 2'b01;
        end else if (opcode[3:0] == 4'hC) begin
            onehot = 16'h1000;
            use_imm = 1'b1;
            alu_op  = ALU_ADD;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'hD) begin
            onehot = 16'h2000;
            use_imm = 1'b1;
            alu_op  = ALU_AND;
            writeback = 1'b1;
        end else if (opcode[3:0] == 4'hE) begin
            onehot = 16'h4000;
            alu_op  = ALU_SLT;
            writeback = 1'b1;
        end else begin
            onehot = 16'h8000;
            invalid = 1'b1;
        end
    end else if (opcode[7:4] == 4'h1) begin
        unique case (funct)
            3'd0: begin
                onehot = 16'h0001;
                use_imm = 1'b1;
                alu_op = ALU_ADD;
                writeback = 1'b1;
            end
            3'd1: begin
                onehot = 16'h0002;
                use_imm = 1'b1;
                alu_op = ALU_SUB;
                writeback = 1'b1;
            end
            3'd2: begin
                onehot = 16'h0004;
                use_imm = 1'b1;
                alu_op = ALU_AND;
                writeback = 1'b1;
            end
            3'd3: begin
                onehot = 16'h0008;
                use_imm = 1'b1;
                alu_op = ALU_OR;
                writeback = 1'b1;
            end
            default: begin
                invalid = 1'b1;
            end
        endcase
    end else if (opcode[7:4] == 4'hF) begin
        invalid = 1'b1;
        onehot  = 16'h0000;
    end else begin
        invalid = 1'b1;
    end

    if (opcode == RESV_OPCODE) begin
        invalid = 1'b1;
        onehot  = 16'h0000;
        load    = 1'b0;
        store   = 1'b0;
        jump    = 1'b0;
        branch  = 1'b0;
        writeback = 1'b0;
    end
end

endmodule