module instruction_decoder (
    input  logic         clk,
    input  logic         rst_n,
    input  logic [15:0]  instr_in,
    input  logic         valid_in,
    input  logic         stall_in,
    output wire          dec_valid,
    output logic [3:0]   opcode,
    output logic [3:0]   rd,
    output logic [3:0]   rs1,
    output logic [3:0]   rs2,
    output logic [7:0]   imm,
    output logic         is_alu,
    output logic         is_load,
    output logic         is_store,
    output logic         is_branch,
    output logic [2:0]   alu_op,
    output logic [15:0]  branch_target
);

parameter int OPCODE_W = 4

typedef enum logic [1:0] {
    IDLE   = 2'b00,
    DECODE = 2'b01,
    ISSUE  = 2'b10
} state_e;

state_e state, next_state;

always_comb begin
    opcode = instr_in[15:12];
    rd     = instr_in[11:8];
    rs1    = instr_in[7:4];
    rs2    = instr_in[3:0];
    imm    = instr_in[7:0];
end

always_comb begin
    is_alu    = 1'b0;
    is_load   = 1'b0;
    is_store  = 1'b0;
    is_branch = 1'b0;
    alu_op    = 3'b000;
    unique case (opcode)
        4'h0: begin
            is_alu = 1'b1;
            alu_op = 3'b000;
        end
        4'h1: begin
            is_alu = 1'b1;
            alu_op = 3'b001;
        end
        4'h2: begin
            is_load = 1'b1;
            alu_op = 3'b010;
        end
        4'h3: begin
            is_store = 1'b1;
            alu_op = 3'b011;
        end
        4'h4: begin
            is_branch = 1'b1;
            alu_op = 3'b100;
        end
        default: begin
            is_alu = 1'b0;
            alu_op = 3'b000;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    unique case (state)
        IDLE: begin
            if (valid_in) begin
                next_state = DECODE;
            end
        end
        DECODE: begin
            if (!stall_in) begin
                next_state = ISSUE;
            end
        end
    endcase
end

wire [OPCODE_W-1:0] opcode_shadow;
assign opcode_shadow = opcode;

wire dec_from_state;
assign dec_from_state = (state == ISSUE) && !stall_in;

wire dec_from_opcode;
assign dec_from_opcode = |opcode_shadow;

assign dec_valid = dec_from_state;
assign dec_valid = dec_from_opcode;

always_comb begin
    branch_target = 16'h0000;
    if (is_branch) begin
        branch_target = {8'h00, imm};
    end
end

endmodule