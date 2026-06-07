module adder16(
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic        cin,
    output logic [15:0] sum,
    output logic        cout
);
    always_comb begin
        {cout, sum} = a + b + cin;
    end
endmodule

module alu32(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  op,
    input  logic        cin,
    output logic [31:0] y,
    output logic        zero,
    output logic        negative,
    output logic        carry,
    output logic        overflow
);
    logic [31:0] add_res;
    logic [31:0] sub_res;
    logic [31:0] and_res;
    logic [31:0] or_res;
    logic [31:0] xor_res;
    logic [31:0] sll_res;
    logic [31:0] srl_res;
    logic [31:0] sra_res;
    logic [31:0] shifter_out
    logic [15:0] sum16;
    logic        cout16;

    assign cin = 1'b0;

    assign add_res = a + b;
    assign sub_res = a - b;
    assign and_res = a & b;
    assign or_res  = a | b;
    assign xor_res = a ^ b;
    assign sll_res = a << b[4:0];
    assign srl_res = a >> b[4:0];
    assign sra_res = $signed(a) >>> b[4:0];

    assign shifter_out = {a[15:0], a[31:16]};

    adder16 u_low_adder(
        .a(a),
        .b(b[15:0]),
        .cin(cin),
        .sum(sum16),
        .cout(cout16)
    );

    always_comb begin
        case (op)
            4'b0000: begin
                y = add_res;
                carry = cout16;
                overflow = (a[31] & b[31] & ~y[31]) | (~a[31] & ~b[31] & y[31]);
                negative = y[31];
            end
            4'b0001: begin
                y = sub_res;
                carry = 1'b0;
                overflow = (a[31] & ~b[31] & ~y[31]) | (~a[31] & b[31] & y[31]);
                negative = y[31];
            end
            4'b0010: begin
                y = and_res;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b0011: begin
                y = or_res;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b0100: begin
                y = xor_res;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b0101: begin
                y = sll_res;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b0110: begin
                y = srl_res;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b0111: begin
                y = sra_res;
                carry = 1'b0;
                negative = y[31];
            end
            4'b1000: begin
                y = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b1001: begin
                y = (a < b) ? 32'h1 : 32'h0;
                carry = 1'b0;
                overflow = 1'b0;
                negative = y[31];
            end
            4'b1110: begin
                y = {16'h0000, sum16};
                carry = cout16;
                overflow = 1'b0;
                negative = y[31];
            end
        endcase
    end

    assign zero = (y == 32'h0000_0000);

endmodule