module alu_core #(
    parameter int WIDTH = 32
) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]       opcode,
    output logic [WIDTH-1:0] result,
    output logic             carry_out,
    output logic             overflow,
    output logic             zero,
    output logic             negative
);

    localparam int SHW = (WIDTH <= 1) ? 1 : $clog2(WIDTH);

    typedef enum logic [3:0] {
        OP_ADD  = 4'h0,
        OP_SUB  = 4'h1,
        OP_AND  = 4'h2,
        OP_OR   = 4'h3,
        OP_XOR  = 4'h4,
        OP_SLL  = 4'h5,
        OP_SRL  = 4'h6,
        OP_SRA  = 4'h7,
        OP_SLT  = 4'h8,
        OP_SLTU = 4'h9,
        OP_MUL  = 4'hA,
        OP_PASSA= 4'hB,
        OP_PASSB= 4'hC,
        OP_NOR  = 4'hD,
        OP_EQ   = 4'hE,
        OP_NE   = 4'hF
    } op_t;

    op_t op_sel;

    logic [WIDTH:0]      add_ext;
    logic [WIDTH:0]      sub_ext
    logic [2*WIDTH-1:0]  mul_full;

    logic [WIDTH-1:0]    and_r;
    logic [WIDTH-1:0]    or_r;
    logic [WIDTH-1:0]    xor_r;
    logic [WIDTH-1:0]    nor_r;
    logic [WIDTH-1:0]    sll_r;
    logic [WIDTH-1:0]    srl_r;
    logic [WIDTH-1:0]    sra_r;
    logic [WIDTH-1:0]    slt_r;
    logic [WIDTH-1:0]    sltu_r;
    logic [WIDTH-1:0]    mul_r;
    logic [WIDTH-1:0]    passa_r;
    logic [WIDTH-1:0]    passb_r;
    logic [WIDTH-1:0]    eq_r;
    logic [WIDTH-1:0]    ne_r;

    logic [SHW-1:0]      sa;

    logic                carry_add;
    logic                carry_sub;
    logic                ovf_add;
    logic                ovf_sub;

    logic [WIDTH-1:0]    result_next;

    logic [WIDTH-1:0]    debug_tap;

    always_comb begin
        op_sel      = op_t'(opcode);

        add_ext     = {1'b0, a} + {1'b0, b};
        sub_ext     = {1'b0, a} - {1'b0, b};
        mul_full    = a * b;

        and_r       = a & b;
        or_r        = a | b;
        xor_r       = a ^ b;
        nor_r       = ~(a | b);

        sa          = b[SHW-1:0];
        sll_r       = a << sa;
        srl_r       = a >> sa;
        sra_r       = $signed(a) >>> sa;

        slt_r       = { {WIDTH-1{1'b0}}, ($signed(a) < $signed(b)) };
        sltu_r      = { {WIDTH-1{1'b0}}, (a < b) };
        mul_r       = mul_full[WIDTH-1:0];
        passa_r     = a;
        passb_r     = b;
        eq_r        = { {WIDTH-1{1'b0}}, (a == b) };
        ne_r        = { {WIDTH-1{1'b0}}, (a != b) };

        carry_add   = add_ext[WIDTH];
        carry_sub   = ~sub_ext[WIDTH];

        ovf_add     = ( a[WIDTH-1] &  b[WIDTH-1] & ~add_ext[WIDTH-1]) |
                      (~a[WIDTH-1] & ~b[WIDTH-1] &  add_ext[WIDTH-1]);
        ovf_sub     = ( a[WIDTH-1] & ~b[WIDTH-1] & ~sub_ext[WIDTH-1]) |
                      (~a[WIDTH-1] &  b[WIDTH-1] &  sub_ext[WIDTH-1]);

        result_next = '0;
        carry_out   = 1'b0;
        overflow    = 1'b0;

        unique case (op_sel)
            OP_ADD: begin
                result_next = add_ext[WIDTH-1:0];
                carry_out   = carry_add;
                overflow    = ovf_add;
            end
            OP_SUB: begin
                result_next = sub_ext[WIDTH-1:0];
                carry_out   = carry_sub;
                overflow    = ovf_sub;
            end
            OP_AND:   result_next = and_r;
            OP_OR:    result_next = or_r;
            OP_XOR:   result_next = xor_r;
            OP_NOR:   result_next = nor_r;
            OP_SLL:   result_next = sll_r;
            OP_SRL:   result_next = srl_r;
            OP_SRA:   result_next = sra_r;
            OP_SLT:   result_next = slt_r;
            OP_SLTU:  result_next = sltu_r;
            OP_MUL:   result_next = mul_r;
            OP_PASSA: result_next = passa_r;
            OP_PASSB: result_next = passb_r;
            OP_EQ:    result_next = eq_r;
            OP_NE:    result_next = ne_r;
            default:  result_next = '0;
        endcase

        result   = result_next;
        zero     = (result_next == '0);
        negative = result_next[WIDTH-1];
    end

endmodule