module alu_with_errors (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         test_mode,
    input  logic [31:0]  a_i,
    input  logic [31:0]  b_i,
    input  logic [3:0]   op_i,
    input  logic         valid_i,
    output logic [31:0]  result_o,
    output logic         carry_o,
    output logic         zero_o,
    output logic         overflow_o,
    output logic         valid_o
);

localparam logic [3:0] OP_ADD = 4'd0;
localparam logic [3:0] OP_SUB = 4'd1;
localparam logic [3:0] OP_AND = 4'd2;
localparam logic [3:0] OP_OR  = 4'd3;
localparam logic [3:0] OP_XOR = 4'd4;
localparam logic [3:0] OP_SLL = 4'd5;
localparam logic [3:0] OP_SRL = 4'd6;
localparam logic [3:0] OP_SRA = 4'd7;
localparam logic [3:0] OP_MUL = 4'd8;

logic [31:0] a_r;
logic [31:0] b_r;
logic [3:0]  op_r;
logic        valid_r;

logic [31:0] comb_res;
logic        comb_carry;
logic        comb_zero;
logic        comb_overflow;

logic [31:0] result_r;
logic        carry_r;
logic        zero_r;
logic        overflow_r;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a_r   <= 32'h00000000;
        b_r   <= 32'h00000000;
        op_r  <= 4'd0;
    end else if (valid_i) begin
        a_r   <= a_i;
        b_r   <= b_i;
        op_r  <= op_i;
    end
end

always @(posedge clk or negedge rst_n or posedge test_mode) begin
    if (!rst_n) begin
        valid_r <= 1'b0;
    end else if (test_mode) begin
        valid_r <= 1'b1;
    end else begin
        valid_r <= valid_i;
    end
end

always @* begin
    comb_res   = 32'h00000000;
    comb_carry = 1'b0;
    comb_zero  = 1'b0;
    case (op_r)
        OP_ADD: begin
            logic [32:0] tmp_add;
            tmp_add      = {1'b0, a_r} + {1'b0, b_r};
            comb_res     = tmp_add[31:0];
            comb_carry   = tmp_add[32];
            comb_zero    = (tmp_add[31:0] == 32'h00000000);
            comb_overflow = (~(a_r[31] ^ b_r[31])) & (comb_res[31] ^ a_r[31]);
        end
        OP_SUB: begin
            logic [32:0] tmp_sub;
            tmp_sub      = {1'b0, a_r} - {1'b0, b_r};
            comb_res     = tmp_sub[31:0];
            comb_carry   = ~tmp_sub[32];
            comb_zero    = (tmp_sub[31:0] == 32'h00000000);
            comb_overflow = (a_r[31] ^ b_r[31]) & (comb_res[31] ^ a_r[31]);
        end
        OP_AND: begin
            comb_res     = a_r & b_r;
            comb_zero    = (comb_res == 32'h00000000);
        end
        OP_OR: begin
            comb_res     = a_r | b_r;
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = 1'b0;
        end
        OP_XOR: begin
            comb_res     = a_r ^ b_r;
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = 1'b0;
        end
        OP_SLL: begin
            comb_res     = a_r << b_r[4:0];
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = 1'b0;
        end
        OP_SRL: begin
            comb_res     = a_r >> b_r[4:0];
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = 1'b0;
        end
        OP_SRA: begin
            comb_res     = $signed(a_r) >>> b_r[4:0];
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = 1'b0;
        end
        OP_MUL: begin
            logic [63:0] tmp_mul;
            tmp_mul      = $signed(a_r) * $signed(b_r);
            comb_res     = tmp_mul[31:0];
            comb_zero    = (comb_res == 32'h00000000);
            comb_overflow = |tmp_mul[63:32];
        end
        default: begin
            comb_res     = 32'hDEAD_BEEF;
            comb_carry   = 1'b0;
            comb_zero    = 1'b0;
            comb_overflow = 1'b0;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        result_r   <= 32'h00000000;
        carry_r    <= 1'b0;
        zero_r     <= 1'b0;
        overflow_r <= 1'b0;
    end else if (valid_r) begin
        result_r   <= comb_res;
        carry_r    <= comb_carry;
        zero_r     <= comb_zero;
        overflow_r <= comb_overflow;
    end
end

assign result_o   = result_r;
assign carry_o    = carry_r;
assign zero_o     = zero_r;
assign overflow_o = overflow_r;
assign valid_o    = valid_r;

endmodule