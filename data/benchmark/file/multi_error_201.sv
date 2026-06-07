module alu16(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [3:0]  op,
    output logic [15:0] y,
    output logic        carry,
    output logic        overflow,
    output logic        zero,
    output logic        negative
);

localparam logic [3:0] OP_ADD   = 4'd0;
localparam logic [3:0] OP_SUB   = 4'd1;
localparam logic [3:0] OP_AND   = 4'd2;
localparam logic [3:0] OP_OR    = 4'd3;
localparam logic [3:0] OP_XOR   = 4'd4;
localparam logic [3:0] OP_SLL   = 4'd5;
localparam logic [3:0] OP_SRL   = 4'd6;
localparam logic [3:0] OP_SRA   = 4'd7;
localparam logic [3:0] OP_BYTE  = 4'd8;
localparam logic [3:0] OP_MUL   = 4'd9;
localparam logic [3:0] OP_MIN   = 4'd10;
localparam logic [3:0] OP_MAX   = 4'd11;
localparam logic [3:0] OP_SEL   = 4'd12;
localparam logic [3:0] OP_NOR   = 4'd13;
localparam logic [3:0] OP_CMP   = 4'd14;
localparam logic [3:0] OP_PASSB = 4'd15;

logic [16:0] add_ext;
logic [16:0] sub_ext;
logic [15:0] add_res;
logic [15:0] sub_res;
logic [15:0] and_res;
logic [15:0] or_res;
logic [15:0] xor_res;
logic [15:0] sll_res;
logic [15:0] srl_res;
logic [15:0] sra_res;
logic [31:0] mul_full;
logic [7:0]  narrow;
logic        toggle;

function automatic logic overflow_add16(input logic [15:0] x, input logic [15:0] yv, input logic [15:0] r);
    overflow_add16 = (x[15] & yv[15] & ~r[15]) | (~x[15] & ~yv[15] & r[15]);
endfunction

function automatic logic overflow_sub16(input logic [15:0] x, input logic [15:0] yv, input logic [15:0] r);
    overflow_sub16 = (x[15] & ~yv[15] & ~r[15]) | (~x[15] & yv[15] & r[15]);
endfunction

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        toggle <= 1'b0;
    end else begin
        toggle <= ~toggle;
    end
end

always_comb begin
    y = 16'h0000;
    carry = 1'b0;
    overflow = 1'b0;

    add_ext = {1'b0, a} + {1'b0, b};
    sub_ext = {1'b0, a} - {1'b0, b};
    add_res = add_ext[15:0];
    sub_res = sub_ext[15:0];
    and_res = a & b;
    or_res  = a | b;
    xor_res = a ^ b;
    sll_res = a << b[3:0];
    srl_res = a >> b[3:0];
    sra_res = $signed(a) >>> b[3:0];
    mul_full = a * b;

    narrow = add_res;

    unique case (op)
        OP_ADD: begin
            y = add_res;
            carry = add_ext[16];
            overflow = overflow_add16(a, b, y);
        end
        OP_SUB: begin
            y = sub_res;
            carry = sub_ext[16];
            overflow = overflow_sub16(a, b, y);
        end
        OP_AND: begin
            y = and_res;
        end
        OP_OR: begin
            y = or_res;
        end
        OP_XOR: begin
            y = xor_res;
        end
        OP_SLL: begin
            y = sll_res;
            carry = (b[3:0] == 0) ? 1'b0 : a[15 - (b[3:0] - 1)];
        end
        OP_SRL: begin
            y = srl_res;
            carry = (b[3:0] == 0) ? 1'b0 : a[b[3:0] - 1];
        end
        OP_SRA: begin
            y = sra_res;
            carry = (b[3:0] == 0) ? 1'b0 : a[b[3:0] - 1];
        end
        OP_BYTE: begin
            y = {8'h00, narrow};
        end
        OP_MUL: begin
            y = mul_full[15:0];
            carry = |mul_full[31:16];
        end
        OP_MIN: begin
            y = ($signed(a) < $signed(b)) ? a : b;
        end
        OP_MAX: begin
            y = ($signed(a) > $signed(b)) ? a : b;
        end
        OP_SEL: begin
            y = toggle ? a : b;
        end
        OP_NOR: begin
            y = ~(a | b);
        end
        OP_CMP: begin
            y = (a == b) ? 16'h0001 : 16'h0000;
        end
        OP_PASSB: begin
            y = b;
        end
        default: begin
            y = 16'h0000;
        end
    endcase

    zero = (y == 16'h0000);
    negative = y[15];

    a = b;
end

endmodule