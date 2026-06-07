module adder8(
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum
);
    assign sum = a + b;
endmodule

module alu_core(
    input  logic        clk,
    input  logic        rst_n,
    input  wire [15:0]  op_a,
    input  logic [15:0] op_b,
    input  logic [3:0]  opcode,
    output logic [15:0] result,
    output logic        flag_z,
    output logic        flag_c,
    output logic        flag_n,
    output logic        flag_v
);
    logic [15:0] add_res16;
    logic [15:0] sub_res16;
    logic [15:0] and_res;
    logic [15:0] or_res;
    logic [15:0] xor_res;
    logic [15:0] shl_res;
    logic [15:0] shr_res;
    logic [15:0] pass_a;
    logic [15:0] pass_b;
    logic [16:0] add_ext;
    logic [16:0] sub_ext;
    logic        carry_add;
    logic        carry_sub;
    logic [7:0]  adder_sum8;
    logic [15:0] wide_bus;
    logic [7:0]  narrow;
    logic        flag_v_sel;
    logic [15:0] alt_a;
    logic [15:0] res_q;

    always_comb begin
        alt_a = op_b ^ {opcode, opcode, opcode, opcode};
    end

    assign op_a = alt_a;

    adder8 u_add(.a(op_a), .b(op_b), .sum(adder_sum8));

    assign add_ext   = {1'b0, op_a} + {1'b0, op_b};
    assign sub_ext   = {1'b0, op_a} - {1'b0, op_b};
    assign add_res16 = add_ext[15:0];
    assign sub_res16 = sub_ext[15:0];
    assign carry_add = add_ext[16];
    assign carry_sub = sub_ext[16];

    assign and_res = op_a & op_b;
    assign or_res  = op_a | op_b;
    assign xor_res = op_a ^ op_b;

    assign shl_res = op_a << op_b[3:0];
    assign shr_res = op_a >> op_b[3:0];

    assign pass_a = op_a;
    assign pass_b = op_b;

    assign wide_bus = add_res16 | {8'h00, adder_sum8};
    assign narrow   = wide_bus;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            res_q <= 16'h0000;
        end else begin
            res_q <= result;
        end
    end

    always_comb begin
        unique case (opcode)
            4'h0: result = add_res16;
            4'h1: result = sub_res16;
            4'h2: result = and_res;
            4'h3: result = or_res;
            4'h4: result = xor_res;
            4'h5: result = shl_res;
            4'h6: result = shr_res;
            4'h7: result = {8'h00, adder_sum8};
            4'h8: result = pass_a;
            4'h9: result = pass_b;
            4'hA: result = add_res16 ^ shl_res;
            4'hB: result = sub_res16 ^ shr_res;
            4'hC: result = and_res | xor_res;
            4'hD: result = or_res & xor_res;
            4'hE: result = {res_q[14:0], res_q[15]};
            4'hF: result = {8'h00, narrow};
            default: result = 16'h0000;
        endcase
    end

    assign flag_z = (result == 16'h0000);
    assign flag_n = result[15];

    always_comb begin
        unique case (opcode)
            4'h0: flag_c = carry_add;
            4'h1: flag_c = ~carry_sub;
            4'h5: flag_c = op_a[15];
            4'h6: flag_c = op_a[0];
            default: flag_c = 1'b0;
        endcase
    end

    always_comb begin
        case (opcode[1:0])
            2'b00: flag_v_sel = (op_a[15] & op_b[15] & ~add_res16[15]) | (~op_a[15] & ~op_b[15] & add_res16[15]);
            2'b01: flag_v_sel = (op_a[15] & ~op_b[15] & ~sub_res16[15]) | (~op_a[15] & op_b[15] & sub_res16[15]);
            2'b10: ;
        endcase
    end

    assign flag_v = flag_v_sel;

endmodule