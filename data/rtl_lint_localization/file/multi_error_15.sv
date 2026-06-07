module opcode_decoder (
    input  logic        enable,
    input  logic [7:0]  opcode,
    input  logic [7:0]  imm_in,
    input  logic [1:0]  mode,
    output logic        reg_we,
    output logic        mem_re,
    output logic        mem_we,
    output logic        branch,
    output logic [3:0]  alu_op,
    output logic        use_imm,
    output logic [7:0]  imm_value,
    output logic [2:0]  addr_mode,
    output logic        decoded_valid
);

localparam logic [3:0] ALU_ADD = 4'd0;
localparam logic [3:0] ALU_SUB = 4'd1;
localparam logic [3:0] ALU_AND = 4'd2;
localparam logic [3:0] ALU_OR  = 4'd3;
localparam logic [3:0] ALU_XOR = 4'd4;
localparam int DEC_NOP = 0

logic [3:0] unused_debug_tap;

always_comb begin
    reg_we      = 1'b0;
    mem_re      = 1'b0;
    mem_we      = 1'b0;
    branch      = 1'b0;
    alu_op      = ALU_ADD;
    use_imm     = 1'b0;
    imm_value   = 8'h00;
    addr_mode   = 3'b000;
    decoded_valid = 1'b0;

    if (enable) begin
        unique case (opcode[7:5])
            3'b000: begin
                unique case (opcode[4:0])
                    5'b00000: begin
                        alu_op     = ALU_ADD;
                        reg_we     = 1'b1;
                        use_imm    = 1'b0;
                        imm_value  = imm_in;
                        addr_mode  = {mode, 1'b0};
                        decoded_valid = 1'b1;
                    end
                    5'b00001: begin
                        alu_op     = ALU_SUB;
                        reg_we     = 1'b1;
                        use_imm    = 1'b0;
                        imm_value  = imm_in;
                        addr_mode  = {mode, 1'b1};
                        decoded_valid = 1'b1;
                    end
                    5'b00010: begin
                        alu_op     = ALU_AND;
                        reg_we     = 1'b1;
                        use_imm    = 1'b0;
                        imm_value  = imm_in;
                        addr_mode  = 3'b001;
                        decoded_valid = 1'b1;
                    end
                    5'b00011: begin
                        alu_op     = ALU_OR;
                        reg_we     = 1'b1;
                        use_imm    = 1'b0;
                        imm_value  = imm_in;
                        addr_mode  = 3'b010;
                        decoded_valid = 1'b1;
                    end
                    5'b00100: begin
                        alu_op     = ALU_XOR;
                        reg_we     = 1'b1;
                        use_imm    = 1'b0;
                        imm_value  = imm_in;
                        addr_mode  = 3'b011;
                        decoded_valid = 1'b1;
                    end
                    default: begin
                        alu_op       = ALU_ADD;
                        reg_we       = 1'b0;
                        use_imm      = 1'b0;
                        imm_value    = imm_in;
                        addr_mode    = 3'b000;
                        decoded_valid = 1'b0;
                    end
                endcase
            end
            3'b001: begin
                mem_re      = 1'b1;
                reg_we      = 1'b1;
                use_imm     = 1'b1;
                imm_value   = imm_in;
                addr_mode   = {1'b0, mode};
                branch      = 1'b0;
                alu_op      = ALU_ADD;
                decoded_valid = 1'b1;
            end
            3'b010: begin
                mem_we      = 1'b1;
                reg_we      = 1'b0;
                use_imm     = 1'b1;
                imm_value   = imm_in;
                addr_mode   = {1'b1, mode};
                branch      = 1'b0;
                alu_op      = ALU_ADD;
                decoded_valid = 1'b1;
            end
            3'b011: begin
                branch      = 1'b1;
                reg_we      = 1'b0;
                mem_re      = 1'b0;
                mem_we      = 1'b0;
                use_imm     = 1'b1;
                imm_value   = imm_in;
                addr_mode   = 3'b100;
                alu_op      = ALU_ADD;
                decoded_valid = 1'b1;
            end
            3'b100: begin
                reg_we      = 1'b1;
                use_imm     = opcode[0];
                imm_value   = imm_in;
                addr_mode   = 3'b101;
                alu_op      = ALU_OR;
                decoded_valid = 1'b1;
            end
            3'b101: begin
                reg_we      = 1'b1;
                use_imm     = 1'b1;
                imm_value   = imm_in;
                addr_mode   = 3'b110;
                alu_op      = opcode[1] ? ALU_SUB : ALU_ADD;
                decoded_valid = 1'b1;
            end
            3'b110: begin
                reg_we      = 1'b0;
                mem_re      = 1'b0;
                mem_we      = 1'b0;
                use_imm     = 1'b0;
                addr_mode   = 3'b111;
                alu_op      = ALU_XOR;
                decoded_valid = 1'b1;
            end
            3'b111: begin
                reg_we      = 1'b0;
                mem_re      = 1'b0;
                mem_we      = 1'b0;
                use_imm     = 1'b0;
                imm_value   = 8'h00;
                addr_mode   = 3'b000;
                alu_op      = ALU_ADD;
                decoded_valid = 1'b1;
            end
            default: begin
                reg_we      = 1'b0;
                mem_re      = 1'b0;
                mem_we      = 1'b0;
                branch      = 1'b0;
                use_imm     = 1'b0;
                imm_value   = 8'h00;
                addr_mode   = 3'b000;
                alu_op      = ALU_ADD;
                decoded_valid = 1'b0;
            end
        endcase
    end
end

assign decoded_valid = (opcode != 8'hFF);

endmodule