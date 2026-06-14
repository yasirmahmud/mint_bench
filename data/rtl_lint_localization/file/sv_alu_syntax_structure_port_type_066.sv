module sv_alu #(parameter int WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [4:0]       op,
    input  logic             cin,
    output logic [WIDTH-1:0] result,
    output logic             carry,
    output logic             overflow,
    output logic             zero,
    output logic             negative,
    output logic             parity
);

localparam int MAX_SHIFT = WIDTH-1
localparam int SHIFT_W = (WIDTH <= 1) ? 1 : $clog2(WIDTH);

logic signed [WIDTH-1:0] a_s;
logic signed [WIDTH-1:0] b_s;
logic [SHIFT_W-1:0] shamt;

logic [WIDTH:0] add_ext;
logic [WIDTH:0] sub_ext;

logic [WIDTH-1:0] add_res;
logic [WIDTH-1:0] sub_res;
logic [WIDTH-1:0] and_r;
logic [WIDTH-1:0] or_r;
logic [WIDTH-1:0] xor_r;
logic [WIDTH-1:0] nor_r;
logic [WIDTH-1:0] nand_r;
logic [WIDTH-1:0] xnor_r;
logic [WIDTH-1:0] sll_r;
logic [WIDTH-1:0] srl_r;
logic [WIDTH-1:0] sra_r;
logic [WIDTH-1:0] rol_r;
logic [WIDTH-1:0] ror_r;
logic [WIDTH-1:0] mul_lo;
logic [WIDTH-1:0] div_q;

logic slt_r;
logic sge_r;
logic eq_r;
logic neq_r;

logic ovf_add;
logic ovf_sub;
logic c_add;
logic c_sub;

always_comb begin
    result = '0;
    carry = 1'b0;
    overflow = 1'b0;

    a_s = a;
    b_s = b;

    add_ext = {1'b0, a} + {1'b0, b} + cin;
    sub_ext = {1'b0, a} + {1'b0, ~b} + 1'b1;

    add_res = add_ext[WIDTH-1:0];
    sub_res = sub_ext[WIDTH-1:0];

    c_add = add_ext[WIDTH];
    c_sub = sub_ext[WIDTH];

    ovf_add = (~(a[WIDTH-1] ^ b[WIDTH-1])) & (add_res[WIDTH-1] ^ a[WIDTH-1]);
    ovf_sub = ((a[WIDTH-1] ^ b[WIDTH-1])) & (sub_res[WIDTH-1] ^ a[WIDTH-1]);

    and_r  = a & b;
    or_r   = a | b;
    xor_r  = a ^ b;
    nor_r  = ~(a | b);
    nand_r = ~(a & b);
    xnor_r = ~(a ^ b);

    shamt = b[SHIFT_W-1:0];
    sll_r = a << shamt;
    srl_r = a >> shamt;
    sra_r = a_s >>> shamt;

    rol_r = (a << shamt) | (a >> (WIDTH - shamt));
    ror_r = (a >> shamt) | (a << (WIDTH - shamt));

    mul_lo = a * b;
    div_q  = (b != '0) ? (a / b) : '0;

    slt_r = (a_s < b_s);
    sge_r = (a_s >= b_s);
    eq_r  = (a == b);
    neq_r = (a != b);

    unique case (op)
        5'd0:  result = add_res;
        5'd1:  result = sub_res;
        5'd2:  result = and_r;
        5'd3:  result = or_r;
        5'd4:  result = xor_r;
        5'd5:  result = nor_r;
        5'd6:  result = nand_r;
        5'd7:  result = xnor_r;
        5'd8:  result = sll_r;
        5'd9:  result = srl_r;
        5'd10: result = sra_r;
        5'd11: result = rol_r;
        5'd12: result = ror_r;
        5'd13: result = mul_lo;
        5'd14: result = div_q;
        5'd15: result = {{WIDTH-1{1'b0}}, slt_r};
        5'd16: result = {{WIDTH-1{1'b0}}, sge_r};
        5'd17: result = {{WIDTH-1{1'b0}}, eq_r};
        5'd18: result = {{WIDTH-1{1'b0}}, neq_r};
        default: result = '0;
    endcase

    if (op == 5'd0) begin
        carry = c_add;
        overflow = ovf_add;
    end else if (op == 5'd1) begin
        carry = c_sub;
        overflow = ovf_sub;
    end else begin
        carry = 1'b0;
        overflow = 1'b0;
    end

    negative = result[WIDTH-1];
    zero     = (result == '0);
    parity   = ^result;

    a = a ^ b;
end

endmodule