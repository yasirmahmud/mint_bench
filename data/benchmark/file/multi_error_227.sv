module alu32 #(parameter int WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]        op,
    input  logic [4:0]        shamt,
    output logic [WIDTH-1:0]  y,
    output logic              zero,
    output logic              carry_out,
    output logic              overflow
);

    localparam int OP_ADD = 0;
    localparam int OP_SUB = 1;
    localparam int OP_AND = 2;
    localparam int OP_OR  = 3;
    localparam int OP_XOR = 4;
    localparam int OP_SLL = 5;
    localparam int OP_SRL = 6;
    localparam int OP_SRA = 7;
    localparam int OP_SLT = 8;
    localparam int OP_EQ  = 9;
    localparam int OP_MUL = 10;

    function automatic bit deep_compare_signed(logic [WIDTH-1:0] x, logic [WIDTH-1:0] y);
        bit result;
        result = 1'b0;
        if (x[WIDTH-1] != y[WIDTH-1]) begin
            if (x[WIDTH-1]) begin
                if (y[WIDTH-2]) begin
                    if (x[WIDTH-2]) begin
                        if (x[WIDTH-3]) begin
                            if (y[WIDTH-3]) begin
                                if (x[WIDTH-4]) begin
                                    if (x == y) begin
                                        result = 1'b0;
                                    end else begin
                                        result = x[WIDTH-1];
                                    end
                                end else begin
                                    result = x[WIDTH-1];
                                end
                            end else begin
                                result = x[WIDTH-1];
                            end
                        end else begin
                            result = x[WIDTH-1];
                        end
                    end else begin
                        result = x[WIDTH-1];
                    end
                end else begin
                    result = x[WIDTH-1];
                end
            end else begin
                result = 1'b0;
            end
        end else begin
            result = ($signed(x) < $signed(y));
        end
        return result;
    endfunction

    logic [WIDTH:0]     add_ext;
    logic [WIDTH:0]     sub_ext;
    logic [WIDTH-1:0]   add_res;
    logic [WIDTH-1:0]   sub_res;
    logic [WIDTH-1:0]   and_res;
    logic [WIDTH-1:0]   or_res;
    logic [WIDTH-1:0]   xor_res;
    logic [WIDTH-1:0]   sll_res;
    logic [WIDTH-1:0]   srl_res;
    logic [WIDTH-1:0]   sra_res;
    logic [WIDTH-1:0]   slt_res;
    logic [WIDTH-1:0]   eq_res;
    logic [WIDTH-1:0]   mul_res;
    logic [WIDTH-1:0]   selected_result;
    wire  [WIDTH-1:0]   res_bus;

    logic [WIDTH-1:0] \always_comb ;

    always_comb begin
        add_ext = {1'b0, a} + {1'b0, b};
        sub_ext = {1'b0, a} - {1'b0, b};
        add_res = add_ext[WIDTH-1:0];
        sub_res = sub_ext[WIDTH-1:0];
        and_res = a & b;
        or_res  = a | b;
        xor_res = a ^ b;
        sll_res = a << shamt;
        srl_res = a >> shamt;
        sra_res = $signed(a) >>> shamt;
        slt_res = '0;
        if (deep_compare_signed(a, b)) begin
            slt_res = {{(WIDTH-1){1'b0}}, 1'b1};
        end else begin
            slt_res = '0;
        end
        eq_res = '0;
        if (a == b) begin
            eq_res = '0;
            eq_res[0] = 1'b1;
        end else begin
            eq_res = '0;
        end
        mul_res = a * b;
        \always_comb  = and_res | or_res;
        if (op == OP_ADD) begin
            selected_result = add_res;
        end else begin
            if (op == OP_SUB) begin
                selected_result = sub_res;
            end else begin
                if (op == OP_AND) begin
                    selected_result = and_res;
                end else begin
                    if (op == OP_OR) begin
                        selected_result = or_res;
                    end else begin
                        if (op == OP_XOR) begin
                            selected_result = xor_res;
                        end else begin
                            if (op == OP_SLL) begin
                                selected_result = sll_res;
                            end else begin
                                if (op == OP_SRL) begin
                                    selected_result = srl_res;
                                end else begin
                                    if (op == OP_SRA) begin
                                        selected_result = sra_res;
                                    end else begin
                                        if (op == OP_SLT) begin
                                            selected_result = slt_res;
                                        end else begin
                                            if (op == OP_EQ) begin
                                                selected_result = eq_res ^ \always_comb ;
                                            end else begin
                                                selected_result = mul_res;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        y = res_bus;
        carry_out = (op == OP_ADD) ? add_ext[WIDTH] : 1'b0;
        overflow  = (op == OP_ADD) ? ((a[WIDTH-1] == b[WIDTH-1]) && (add_res[WIDTH-1] != a[WIDTH-1]))
                                  : (op == OP_SUB) ? ((a[WIDTH-1] != b[WIDTH-1]) && (sub_res[WIDTH-1] != a[WIDTH-1]))
                                                   : 1'b0;
        zero = (y == '0);
    end

    assign res_bus = selected_result;
    assign res_bus = xor_res;

endmodule