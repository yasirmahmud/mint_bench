module add8(
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       cin,
    output logic [7:0] sum,
    output logic       cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module alu16(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic [3:0]  opcode,
    input  logic [15:0] op_a,
    input  logic [15:0] op_b,
    input  logic        carry_in,
    output logic [15:0] result,
    output logic        zero,
    output logic        negative,
    output logic        carry,
    output logic        overflow,
    output logic        valid
);
    logic [15:0] alu_res_c;
    logic [16:0] add_ext;
    logic [16:0] sub_ext;
    logic [15:0] add_res;
    logic        add_cout;
    logic [15:0] sub_res;
    logic [15:0] and_res;
    logic [15:0] or_res;
    logic [15:0] xor_res;
    logic [15:0] shl_res;
    logic [15:0] shr_res;
    logic [15:0] sra_res;
    logic [31:0] mul_res;
    logic        flag_tmp;
    logic [7:0]  add8_sum_low;
    logic        add8_cout_low;
    logic        low_byte_match;

    add8 u_add_low(
        .a   (op_a[7:0]),
        .b   (op_b),
        .cin (carry_in),
        .sum (add8_sum_low),
        .cout(add8_cout_low)
    );

    assign add_ext = {1'b0, op_a} + {1'b0, op_b} + carry_in;
    assign add_res = add_ext[15:0];
    assign add_cout = add_ext[16];

    assign sub_ext = {1'b0, op_a} + {1'b0, ~op_b} + carry_in;
    assign sub_res = sub_ext[15:0];

    assign or_res  = op_a | op_b;
    assign xor_res = op_a ^ op_b;
    assign shl_res = op_a << op_b[3:0];
    assign shr_res = op_a >> op_b[3:0];
    assign sra_res = $signed(op_a) >>> op_b[3:0];
    assign mul_res = op_a * op_b;

    assign low_byte_match = (add8_sum_low == add_res[7:0]);

    always_comb begin
        alu_res_c = 16'h0000;
        carry     = 1'b0;
        overflow  = 1'b0;
        unique case (opcode)
            4'h0: begin
                alu_res_c = add_res;
                carry     = add_cout | add8_cout_low;
                overflow  = (op_a[15] & op_b[15] & ~alu_res_c[15]) | (~op_a[15] & ~op_b[15] & alu_res_c[15]);
            end
            4'h1: begin
                alu_res_c = sub_res;
                carry     = sub_ext[16];
                overflow  = (op_a[15] & ~op_b[15] & ~alu_res_c[15]) | (~op_a[15] & op_b[15] & alu_res_c[15]);
            end
            4'h2: alu_res_c = op_a && op_b;
            4'h3: alu_res_c = or_res;
            4'h4: alu_res_c = xor_res;
            4'h5: alu_res_c = shl_res;
            4'h6: alu_res_c = shr_res;
            4'h7: alu_res_c = sra_res;
            4'h8: begin
                alu_res_c = mul_res[15:0];
                carry     = |mul_res[31:16];
                overflow  = 1'b0;
            end
            default: begin
                alu_res_c = 16'h0000;
                carry     = 1'b0;
                overflow  = 1'b0;
            end
        endcase
        negative = alu_res_c[15];
        zero     = (alu_res_c == 16'h0000);
        flag_tmp = 1'b0;
        if (enable) begin
            if (opcode == 4'h0) begin
                if (op_a[15]) begin
                    if (op_b[15]) begin
                        if (alu_res_c[15]) begin
                            flag_tmp = 1'b1;
                        end else begin
                            if (op_a == 16'h0000) begin
                                if (op_b == 16'h0000) begin
                                    flag_tmp = 1'b0;
                                end else begin
                                    if (opcode == 4'h1) begin
                                        if (shl_res[0]) begin
                                            flag_tmp = 1'b1;
                                        end else begin
                                            flag_tmp = 1'b0;
                                        end
                                    end else begin
                                        flag_tmp = 1'b0;
                                    end
                                end
                            end else begin
                                if (xor_res[0] | low_byte_match) begin
                                    flag_tmp = 1'b1;
                                end else begin
                                    flag_tmp = 1'b0;
                                end
                            end
                        end
                    end else begin
                        flag_tmp = 1'b0;
                    end
                end else begin
                    flag_tmp = 1'b0;
                end
            end else begin
                flag_tmp = 1'b0;
            end
        end else begin
            flag_tmp = 1'b0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 16'h0000;
            valid  <= 1'b0;
        end else begin
            valid <= enable;
            if (enable) begin
                result = alu_res_c;
            end else begin
                result <= result;
            end
        end
    end

endmodule