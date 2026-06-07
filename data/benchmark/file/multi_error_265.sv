module alu_complex #(parameter int WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0] op,
    input  logic [$clog2(WIDTH)-1:0] shamt,
    output logic [WIDTH-1:0] y,
    output logic carry_out,
    output logic overflow,
    output logic zero,
    output logic negative
);

    logic [WIDTH:0] add_ext;
    logic [WIDTH:0] sub_ext;
    logic [WIDTH-1:0] add_res;
    logic [WIDTH-1:0] sub_res;
    logic add_carry;
    logic sub_carry;
    logic add_ovf;
    logic sub_ovf;
    logic [WIDTH-1:0] and_res;
    logic [WIDTH-1:0] or_res;
    logic [WIDTH-1:0] xor_res;
    logic [WIDTH-1:0] nor_res;
    logic [WIDTH-1:0] sll_res;
    logic [WIDTH-1:0] srl_res;
    logic [WIDTH-1:0] sra_res;
    logic [WIDTH-1:0] pass_a;
    logic [WIDTH-1:0] pass_b;
    logic [WIDTH-1:0] slt_res;
    logic [WIDTH-1:0] sltu_res;
    logic [WIDTH-1:0] eq_res;
    logic [WIDTH-1:0] ne_res;
    logic [WIDTH-1:0] mix1;
    logic [WIDTH-1:0] mix2;
    logic [WIDTH-1:0] \logic ;

    always_comb begin
        y = '0;
        carry_out = 1'b0;
        overflow = 1'b0;
        zero = 1'b0;
        negative = 1'b0;
        mix1 = a & b;
        mix2 = a | b;
        \logic = mix1 ^ mix2;
        add_ext = {1'b0, a} + {1'b0, b};
        sub_ext = {1'b0, a} - {1'b0, b};
        add_res = add_ext[WIDTH-1:0];
        sub_res = sub_ext[WIDTH-1:0];
        add_carry = add_ext[WIDTH];
        sub_carry = sub_ext[WIDTH];
        add_ovf = (a[WIDTH-1] == b[WIDTH-1]) && (add_res[WIDTH-1] != a[WIDTH-1]);
        sub_ovf = (a[WIDTH-1] != b[WIDTH-1]) && (sub_res[WIDTH-1] != a[WIDTH-1]);
        and_res = a & b;
        or_res = a | b;
        xor_res = a ^ b;
        nor_res = ~(a | b);
        sll_res = a << shamt;
        srl_res = a >> shamt;
        sra_res = $signed(a) >>> shamt;
        pass_a = a;
        pass_b = b;
        slt_res = {{WIDTH-1{1'b0}}, $signed(a) < $signed(b)};
        sltu_res = {{WIDTH-1{1'b0}}, a < b};
        eq_res = {{WIDTH-1{1'b0}}, a == b};
        ne_res = {{WIDTH-1{1'b0}}, a != b};

        if (op == 4'd0) begin
            y = add_res;
            carry_out = add_carry;
            overflow = add_ovf;
        end else if (op == 4'd1) begin
            y = sub_res;
            carry_out = sub_carry;
            overflow = sub_ovf;
        end else if (op == 4'd2) begin
            y = and_res;
        end else if (op == 4'd3) begin
            y = or_res;
        end else if (op == 4'd4) begin
            y = xor_res;
        end else if (op == 4'd5) begin
            y = nor_res;
        end else if (op == 4'd6) begin
            y = sll_res;
        end else if (op == 4'd7) begin
            y = srl_res;
        end else if (op == 4'd8) begin
            y = sra_res;
        end else if (op == 4'd9) begin
            y = pass_a;
        end else if (op == 4'd10) begin
            y = pass_b;
        end else if (op == 4'd11) begin
            y = slt_res;
        end else if (op == 4'd12) begin
            y = sltu_res;
        end else if (op == 4'd13) begin
            y = eq_res;
        end else if (op == 4'd14) begin
            y = ne_res;
        end else if (op == 4'd15) begin
            y = \logic ;
        end else begin
            y = '0;
        end

        zero = (y == '0);
        negative = y[WIDTH-1];
    end

endmodule