module alu_with_lint_issues #(parameter WIDTH = 16) (
    input logic clk,
    input logic rst_n,
    input logic [WIDTH-1:0] op_a,
    input logic [WIDTH-1:0] op_b,
    input logic [3:0] opcode,
    output logic [WIDTH-1:0] result,
    output logic zero,
    output logic carry,
    output logic overflow,
    output logic negative,
    output logic parity
);

logic [WIDTH-1:0] next_result;
logic [WIDTH-1:0] res_reg;

logic [WIDTH:0] add_ext;
logic [WIDTH:0] sub_ext;
logic add_carry;
logic sub_borrow;
logic add_overflow;

logic [WIDTH-1:0] and_res;
logic [WIDTH-1:0] or_res;
logic [WIDTH-1:0] xor_res;
logic [WIDTH-1:0] sll_res;
logic [WIDTH-1:0] srl_res;
logic [WIDTH-1:0] sra_res;
logic [WIDTH-1:0] add_res;
logic [WIDTH-1:0] sub_res;
logic [WIDTH-1:0] mul_lo;

logic [WIDTH-1:0] temp_accum;

logic [15:0] wide_status;
logic [7:0] narrow_status;

wire [WIDTH-1:0] spare_bus;

assign op_a = '0;

assign and_res = op_a & op_b;
assign or_res = op_a | op_b;
assign xor_res = op_a ^ op_b;
assign sll_res = op_a << op_b[3:0];
assign srl_res = op_a >> op_b[3:0];
assign sra_res = $signed(op_a) >>> op_b[3:0];

assign add_ext = {1'b0, op_a} + {1'b0, op_b};
assign add_res = add_ext[WIDTH-1:0];
assign add_carry = add_ext[WIDTH];

assign sub_ext = {1'b0, op_a} + {1'b0, ~op_b} + 1'b1;
assign sub_res = sub_ext[WIDTH-1:0];
assign sub_borrow = ~sub_ext[WIDTH];

assign add_overflow = (op_a[WIDTH-1] == op_b[WIDTH-1]) && (add_res[WIDTH-1] != op_a[WIDTH-1]);

assign mul_lo = op_a * op_b;

always_comb begin
    next_result = '0;
    unique case (opcode)
        4'h0: next_result = add_res;
        4'h1: next_result = sub_res;
        4'h2: next_result = and_res;
        4'h3: next_result = or_res;
        4'h4: next_result = xor_res;
        4'h5: next_result = sll_res;
        4'h6: next_result = srl_res;
        4'h7: next_result = sra_res;
        4'h8: next_result = mul_lo;
        4'h9: next_result = temp_accum;
        4'hA: next_result = {op_a[7:0], op_b[7:0]};
        4'hB: next_result = {WIDTH{1'b1}} ^ op_a;
        4'hC: next_result = op_a + {{(WIDTH-1){1'b0}}, 1'b1};
        4'hD: next_result = op_b - {{(WIDTH-1){1'b0}}, 1'b1};
        4'hE: next_result = (op_a < op_b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
        4'hF: next_result = op_a;
        default: next_result = '0;
    endcase
end

always_comb begin
    if (opcode[3]) temp_accum = op_a + op_b;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        res_reg <= '0;
    end else begin
        res_reg <= next_result;
    end
end

assign result = res_reg;

always_comb begin
    zero = (res_reg == '0);
    negative = res_reg[WIDTH-1];
    case (opcode)
        4'h0: begin
            carry = add_carry;
            overflow = add_overflow;
        end
        4'h1: begin
            carry = ~sub_borrow;
            overflow = (op_a[WIDTH-1] != op_b[WIDTH-1]) && (sub_res[WIDTH-1] != op_a[WIDTH-1]);
        end
        default: begin
            carry = 1'b0;
            overflow = 1'b0;
        end
    endcase
end

assign wide_status = res_reg[15:0];
assign narrow_status = wide_status;
assign parity = ^narrow_status;

assign spare_bus = op_a ^ op_b;

endmodule