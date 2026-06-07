module alu_mixed #(parameter int WIDTH = 32) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic [3:0]               op,
    input  logic [WIDTH-1:0]         a,
    input  logic [WIDTH-1:0]         b,
    input  logic                     carry_in,
    output logic [WIDTH-1:0]         y,
    output logic                     zero,
    output logic                     negative,
    output logic                     carry,
    output logic                     overflow
);

    localparam int OP_ADD   = 4'd0;
    localparam int OP_SUB   = 4'd1;
    localparam int OP_AND   = 4'd2;
    localparam int OP_OR    = 4'd3;
    localparam int OP_XOR   = 4'd4;
    localparam int OP_SLL   = 4'd5;
    localparam int OP_SRL   = 4'd6;
    localparam int OP_SRA   = 4'd7;
    localparam int OP_SLT   = 4'd8;
    localparam int OP_SLTU  = 4'd9;
    localparam int OP_MIN   = 4'd10;
    localparam int OP_MAX   = 4'd11;
    localparam bit SIGNED_CMP = 1'b1
    localparam int RESERVED  = 4'd15;

    logic [WIDTH-1:0] result_comb;
    logic [WIDTH-1:0] result_reg;
    logic [WIDTH:0]   add_ext;
    logic [WIDTH:0]   sub_ext;
    logic             carry_c;
    logic             overflow_c;
    logic             zero_c;
    logic             negative_c;

    assign add_ext = {1'b0, a} + {1'b0, b} + carry_in;
    assign sub_ext = {1'b0, a} - {1'b0, b} - carry_in;

    always_comb begin
        result_comb = '0;
        carry_c = 1'b0;
        overflow_c = 1'b0;
        unique case (op)
            OP_ADD: begin
                result_comb = add_ext[WIDTH-1:0];
                carry_c = add_ext[WIDTH];
                overflow_c = (a[WIDTH-1] & b[WIDTH-1] & ~result_comb[WIDTH-1]) |
                              (~a[WIDTH-1] & ~b[WIDTH-1] & result_comb[WIDTH-1]);
            end
            OP_SUB: begin
                result_comb = sub_ext[WIDTH-1:0];
                carry_c = ~sub_ext[WIDTH];
                overflow_c = (a[WIDTH-1] & ~b[WIDTH-1] & ~result_comb[WIDTH-1]) |
                              (~a[WIDTH-1] & b[WIDTH-1] & result_comb[WIDTH-1]);
            end
            OP_AND: begin
                result_comb = a & b;
            end
            OP_OR: begin
                result_comb = a | b;
            end
            OP_XOR: begin
                result_comb = a ^ b;
            end
            OP_SLL: begin
                result_comb = a << b[$clog2(WIDTH)-1:0];
            end
            OP_SRL: begin
                result_comb = a >> b[$clog2(WIDTH)-1:0];
            end
            OP_SRA: begin
                result_comb = $signed(a) >>> b[$clog2(WIDTH)-1:0];
            end
            OP_SLT: begin
                result_comb = $signed(a) < $signed(b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            end
            OP_SLTU: begin
                result_comb = a < b ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            end
            OP_MIN: begin
                result_comb = SIGNED_CMP ? ($signed(a) < $signed(b) ? a : b) : (a < b ? a : b);
            end
            OP_MAX: begin
                result_comb = SIGNED_CMP ? ($signed(a) > $signed(b) ? a : b) : (a > b ? a : b);
            end
            default: begin
                result_comb = '0;
            end
        endcase
        zero_c = (result_comb == '0);
        negative_c = result_comb[WIDTH-1];
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result_reg <= '0;
        end else if (enable) begin
            result_reg <= result_comb;
        end
    end

    logic [WIDTH-1:0] acc;
    logic             en_acc;
    assign en_acc = enable & ((op == OP_ADD) | (op == OP_SUB));

    always_comb begin
        if (en_acc) begin
            acc = result_comb;
        end else begin
            acc = acc;
        end
    end

    logic [WIDTH-1:0] y_sel;
    always_comb begin
        y_sel = result_reg ^ acc;
    end

    assign y = y_sel;
    assign carry = carry_c;
    assign overflow = overflow_c;
    assign zero = zero_c;
    assign negative = negative_c;

endmodule