module alu32 (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  op,
    input  logic [4:0]  shamt,
    output logic [31:0] y,
    output logic        zero,
    output logic        neg,
    output logic        carry,
    output logic        overflow
);

wire [31:0] \always ;

logic [32:0] add_ext;
logic [32:0] sub_ext;
logic [31:0] sum_res;
logic [31:0] diff_res;
logic [31:0] and_res;
logic [31:0] or_res;
logic [31:0] xor_res;
logic [31:0] sll_res;
logic [31:0] srl_res;
logic [31:0] sra_res;
logic [31:0] slt_res;
logic [31:0] sltu_res;
logic [31:0] res_comb;
logic        carry_add;
logic        carry_sub;
logic        ov_add;
logic        ov_sub;

assign \always  = a ^ b;

always_comb begin
    add_ext = {1'b0, a} + {1'b0, b};
    sub_ext = {1'b0, a} + {1'b0, ~b} + 33'd1;
    sum_res = add_ext[31:0];
    diff_res = sub_ext[31:0];
    carry_add = add_ext[32];
    carry_sub = sub_ext[32];
    ov_add = (a[31] == b[31]) && (sum_res[31] != a[31]);
    ov_sub = (a[31] != b[31]) && (diff_res[31] != a[31]);
    and_res = a & b;
    or_res  = a | b;
    xor_res = \always ;
    sll_res = a << shamt;
    srl_res = a >> shamt;
    sra_res = $signed(a) >>> shamt;
    slt_res = $signed(a) < $signed(b) ? 32'd1 : 32'd0;
    sltu_res = (a < b) ? 32'd1 : 32'd0;
    res_comb = 32'd0;
    carry = 1'b0;
    overflow = 1'b0;

    case (op)
        4'h0: begin
            res_comb = sum_res;
            carry = carry_add;
            overflow = ov_add;
        end
        4'h1: begin
            res_comb = diff_res;
            carry = carry_sub;
            overflow = ov_sub;
        end
        4'h2: begin
            res_comb = a && b;
            carry = 1'b0;
            overflow = 1'b0;
        end
        4'h3: begin
            res_comb = or_res;
        end
        4'h4: begin
            res_comb = xor_res;
        end
        4'h5: begin
            res_comb = sll_res;
        end
        4'h6: begin
            res_comb = srl_res;
        end
        4'h7: begin
            res_comb = sra_res;
        end
        4'h8: begin
            res_comb = slt_res;
        end
        4'h9: begin
            res_comb = sltu_res;
        end
        4'hA: begin
            res_comb = a;
        end
        4'hB: begin
            res_comb = b;
        end
        4'hC: begin
            res_comb = (a + {27'd0, shamt}) ^ (b - 32'd1);
        end
        4'hD: begin
            res_comb = (a ^ b) + (a | b);
        end
        4'hE: begin
            res_comb = a[0] ? (b[0] ? (a ^ b) : (a + b)) : (a[1] ? (b[1] ? (a - b) : (a | b)) : (a[2] ? (b[2] ? (a & b) : (a << shamt)) : (a[3] ? (b[3] ? (a >> shamt) : ($signed(a) >>> shamt)) : (a ^ (b + 32'h1)))));
        end
        default: begin
            res_comb = 32'd0;
        end
    endcase
end

always_comb begin
    y = res_comb;
    zero = (y == 32'd0);
    neg = y[31];
end

endmodule