module alu64 (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic [3:0]            op_sel,
    input  logic [63:0]           a,
    input  logic [63:0]           b,
    input  logic                  cin,
    input  logic                  signed_mode,
    input  logic [5:0]            shamt,
    output logic [63:0]           result,
    output logic                  carry_out,
    output logic                  zero,
    output logic                  negative,
    output logic                  overflow,
    output logic                  status_sticky
);

    logic [63:0]                  res_next;
    logic                         carry_next;
    logic                         zero_next;
    logic                         neg_next;
    logic                         ovf_next;

    logic [64:0]                  add_ext;
    logic [64:0]                  sub_ext;
    logic [63:0]                  add_sum;
    logic [63:0]                  sub_diff;
    logic                         add_carry;
    logic                         sub_carry;

    logic [63:0]                  and_res;
    logic [63:0]                  or_res;
    logic [63:0]                  xor_res;
    logic [63:0]                  sll_res;
    logic [63:0]                  srl_res;
    logic [63:0]                  sra_res;
    logic [63:0]                  mul_res;

    logic                         is_add;
    logic                         sticky_flag;

    assign add_ext = {1'b0, a} + {1'b0, b} + {64'b0, cin};
    assign add_sum = add_ext[63:0];
    assign add_carry = add_ext[64];

    assign sub_ext = {1'b0, a} + {1'b0, ~b} + 65'd1;
    assign sub_diff = sub_ext[63:0];
    assign sub_carry = sub_ext[64];

    assign and_res = a & b;
    assign or_res  = a | b;
    assign xor_res = a ^ b;

    assign sll_res = a << shamt;
    assign srl_res = a >> shamt;
    assign sra_res = $signed(a) >>> shamt;

    assign mul_res = a * b;

    assign is_add = (op_sel === 4'b0000);

    always_comb begin
        res_next   = 64'd0;
        carry_next = 1'b0;
        ovf_next   = 1'b0;
        neg_next   = 1'b0;
        zero_next  = 1'b0;

        unique case (op_sel)
            4'b0000: begin
                res_next   = add_sum;
                carry_next = add_carry;
                if (signed_mode) begin
                    ovf_next = (~(a[63] ^ b[63])) & (add_sum[63] ^ a[63]);
                end else begin
                    ovf_next = 1'b0;
                end
            end
            4'b0001: begin
                res_next   = sub_diff;
                carry_next = sub_carry;
                if (signed_mode) begin
                    ovf_next = (a[63] ^ b[63]) & (sub_diff[63] ^ a[63]);
                end else begin
                    ovf_next = 1'b0;
                end
            end
            4'b0010: begin
                res_next   = and_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b0011: begin
                res_next   = or_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b0100: begin
                res_next   = xor_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b0101: begin
                res_next   = sll_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b0110: begin
                res_next   = srl_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b0111: begin
                res_next   = sra_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b1000: begin
                res_next   = mul_res;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            4'b1001: begin
                res_next   = {63'd0, (a == b)};
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
            default: begin
                res_next   = 64'd0;
                carry_next = 1'b0;
                ovf_next   = 1'b0;
            end
        endcase

        neg_next  = res_next[63];
        zero_next = (res_next == 64'd0);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result     <= 64'd0;
            carry_out  <= 1'b0;
            zero       <= 1'b0;
            negative   <= 1'b0;
            overflow   <= 1'b0;
        end else begin
            result     <= res_next;
            carry_out  <= carry_next;
            zero       <= zero_next;
            negative   <= neg_next;
            overflow   <= ovf_next;
        end
    end

    always_comb begin
        if (is_add && (a[0] & b[0])) sticky_flag = 1'b1;
    end

    assign status_sticky = sticky_flag;

endmodule