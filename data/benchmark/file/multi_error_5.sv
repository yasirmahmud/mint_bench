module decoder #(parameter W = 32) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [7:0]           opcode,
    input  logic [W-1:0]         in_data,
    output logic [W-1:0]         out_data,
    output logic                 write_en,
    output logic                 branch_taken,
    output logic [3:0]           alu_op,
    output logic [7:0]           imm,
    output logic                 valid
);

    function automatic logic [W-1:0] sign_extend8(input logic [7:0] v);
        sign_extend8 = {{(W-8){v[7]}}, v};
    endfunction

    logic [7:0]           opcode_q;
    logic [W-1:0]         stage1_data;
    logic [W-1:0]         stage2_data;
    logic                 write_en_q;
    logic                 branch_q;
    logic                 valid_q;
    logic [3:0]           alu_op_q;
    logic [7:0]           imm_q;

    logic                 dec_write_en;
    logic                 dec_branch;
    logic                 dec_valid;
    logic [3:0]           dec_alu_op;
    logic [7:0]           dec_imm;
    logic [W-1:0]         next_stage1_data;

    logic [3:0]           debug_unused;

    always_comb begin
        dec_write_en      = 1'b0;
        dec_branch        = 1'b0;
        dec_alu_op        = 4'h0;
        dec_imm           = 8'h00;
        dec_valid         = 1'b0;
        next_stage1_data  = in_data;
        if (opcode === 8'hFF) begin
            dec_valid = 1'b1;
        end
        unique case (opcode[7:4])
            4'h0: begin
                dec_alu_op       = 4'h0;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode;
            end
            4'h1: begin
                dec_alu_op       = 4'h1;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = {4'b0000, opcode[3:0]};
                next_stage1_data = in_data + sign_extend8(dec_imm);
            end
            4'h2: begin
                dec_alu_op       = 4'h2;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = {opcode[3:0], 4'b0000};
                next_stage1_data = in_data - {{(W-8){1'b0}}, dec_imm};
            end
            4'h3: begin
                dec_alu_op       = 4'h3;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = opcode ^ 8'hA5;
                next_stage1_data = in_data ^ {{(W-8){1'b0}}, dec_imm};
            end
            4'h4: begin
                dec_alu_op       = 4'h4;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode | 8'h0F;
                dec_branch       = opcode[0];
            end
            4'h5: begin
                dec_alu_op       = 4'h5;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode & 8'hF0;
                if (opcode[1]) dec_branch = 1'b1;
            end
            4'h6: begin
                dec_alu_op       = 4'h6;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = {opcode[2:0], 5'b00000};
            end
            4'h7: begin
                dec_alu_op       = 4'h7;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = {opcode[6:3], 4'b0011};
            end
            4'h8: begin
                dec_alu_op       = 4'h8;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = ~opcode;
                next_stage1_data = ~in_data;
            end
            4'h9: begin
                dec_alu_op       = 4'h9;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = {opcode[7], opcode[7], opcode[7], opcode[7], opcode[3:0]};
            end
            4'hA: begin
                dec_alu_op       = 4'hA;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = 8'h3C;
                next_stage1_data = {in_data[W-2:0], 1'b0};
            end
            4'hB: begin
                dec_alu_op       = 4'hB;
                dec_write_en     = 1'b1;
                dec_valid        = 1'b1;
                dec_imm          = 8'hC3;
                next_stage1_data = {1'b0, in_data[W-1:1]};
            end
            4'hC: begin
                dec_alu_op       = 4'hC;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode + 8'h01;
            end
            4'hD: begin
                dec_alu_op       = 4'hD;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode - 8'h01;
            end
            4'hE: begin
                dec_alu_op       = 4'hE;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b1;
                dec_imm          = opcode;
                dec_branch       = opcode[0] | opcode[1];
            end
            default: begin
                dec_alu_op       = 4'hF;
                dec_write_en     = 1'b0;
                dec_valid        = 1'b0;
                dec_imm          = 8'h00;
            end
        endcase
        if (dec_branch && (in_data[0] & in_data[1])) begin
            next_stage1_data = {W{1'b1}};
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            opcode_q     <= '0;
            write_en_q   <= 1'b0;
            branch_q     <= 1'b0;
            alu_op_q     <= '0;
            imm_q        <= '0;
            valid_q      <= 1'b0;
            stage1_data  <= '0;
            stage2_data  <= '0;
            out_data     <= '0;
        end else begin
            opcode_q     <= opcode;
            write_en_q   <= dec_write_en;
            branch_q     <= dec_branch;
            alu_op_q     <= dec_alu_op;
            imm_q        <= dec_imm;
            valid_q      <= dec_valid;
            stage1_data  = next_stage1_data;
            stage2_data  <= stage1_data ^ {{(W-8){1'b0}}, (valid_q ? imm_q : opcode_q)};
            out_data     <= stage2_data;
        end
    end

    assign write_en     = write_en_q;
    assign branch_taken = branch_q;
    assign alu_op       = alu_op_q;
    assign imm          = imm_q;
    assign valid        = valid_q;

endmodule