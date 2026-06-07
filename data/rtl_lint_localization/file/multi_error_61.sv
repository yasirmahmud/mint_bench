module alu_two_lint_errors #(parameter int WIDTH = 32) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic [WIDTH-1:0]       op_a,
    input  logic [WIDTH-1:0]       op_b,
    input  logic [3:0]             opcode,
    input  logic                   override_en,
    input  logic [WIDTH-1:0]       override_val,
    output logic [WIDTH-1:0]       result,
    output logic                   carry_out,
    output logic                   zero,
    output logic                   overflow
);

    localparam logic [3:0] OP_ADD   = 4'h0;
    localparam logic [3:0] OP_SUB   = 4'h1;
    localparam logic [3:0] OP_AND   = 4'h2;
    localparam logic [3:0] OP_OR    = 4'h3;
    localparam logic [3:0] OP_XOR   = 4'h4;
    localparam logic [3:0] OP_SLL   = 4'h5;
    localparam logic [3:0] OP_SRL   = 4'h6;
    localparam logic [3:0] OP_SRA   = 4'h7;
    localparam logic [3:0] OP_SLT   = 4'h8;
    localparam logic [3:0] OP_PASSA = 4'h9;
    localparam logic [3:0] OP_PASSB = 4'hA;

    logic [WIDTH:0]        add_ext;
    logic [WIDTH:0]        sub_ext;
    logic [WIDTH-1:0]      add_res;
    logic [WIDTH-1:0]      sub_res;
    logic                  add_carry;
    logic                  sub_borrow;
    logic                  add_overflow;
    logic                  sub_overflow;

    logic [WIDTH-1:0]      result_c;
    logic                  carry_c;
    logic                  overflow_c;
    logic                  zero_c;
    logic                  eq_xsafe;

    always_comb begin
        add_ext      = {1'b0, op_a} + {1'b0, op_b};
        sub_ext      = {1'b0, op_a} - {1'b0, op_b};
        add_res      = add_ext[WIDTH-1:0];
        sub_res      = sub_ext[WIDTH-1:0];
        add_carry    = add_ext[WIDTH];
        sub_borrow   = sub_ext[WIDTH];
        add_overflow = (~(op_a[WIDTH-1] ^ op_b[WIDTH-1])) & (add_res[WIDTH-1] ^ op_a[WIDTH-1]);
        sub_overflow = ((op_a[WIDTH-1] ^ op_b[WIDTH-1])) & (sub_res[WIDTH-1] ^ op_a[WIDTH-1]);

        result_c     = '0;
        carry_c      = 1'b0;
        overflow_c   = 1'b0;

        eq_xsafe = (op_a === op_b);

        case (opcode)
            OP_ADD: begin
                result_c   = add_res;
                carry_c    = add_carry;
                overflow_c = add_overflow;
            end
            OP_SUB: begin
                result_c   = sub_res;
                carry_c    = sub_borrow;
                overflow_c = sub_overflow;
            end
            OP_AND: begin
                result_c   = op_a & op_b;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_OR: begin
                result_c   = op_a | op_b;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_XOR: begin
                result_c   = op_a ^ op_b;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_SLL: begin
                result_c   = op_a << op_b[4:0];
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_SRL: begin
                result_c   = op_a >> op_b[4:0];
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_SRA: begin
                result_c   = $signed(op_a) >>> op_b[4:0];
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_SLT: begin
                result_c   = '0;
                result_c[0]= ($signed(op_a) < $signed(op_b));
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_PASSA: begin
                result_c   = op_a;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            OP_PASSB: begin
                result_c   = op_b;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
            default: begin
                result_c   = '0;
                carry_c    = 1'b0;
                overflow_c = 1'b0;
            end
        endcase

        zero_c = ((result_c == '0) || eq_xsafe);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result     <= '0;
            carry_out  <= 1'b0;
            overflow   <= 1'b0;
            zero       <= 1'b1;
        end else begin
            result     <= result_c;
            carry_out  <= carry_c;
            overflow   <= overflow_c;
            zero       <= zero_c;
        end
    end

    always_ff @(posedge clk) begin
        if (override_en) op_a <= override_val;
    end

endmodule