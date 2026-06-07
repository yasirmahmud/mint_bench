module alu32 #(parameter int WIDTH = 32) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic [WIDTH-1:0]        a,
    input  logic [WIDTH-1:0]        b,
    input  logic [3:0]              op,
    output logic [WIDTH-1:0]        y,
    output logic                    zero,
    output logic                    carry,
    output logic                    overflow,
    output logic                    negative
);

    localparam logic [3:0] OP_ADD   = 4'h0;
    localparam logic [3:0] OP_SUB   = 4'h1;
    localparam logic [3:0] OP_AND   = 4'h2;
    localparam logic [3:0] OP_OR    = 4'h3;
    localparam logic [3:0] OP_XOR   = 4'h4;
    localparam logic [3:0] OP_SLL   = 4'h5;
    localparam logic [3:0] OP_SRL   = 4'h6;
    localparam logic [3:0] OP_SRA   = 4'h7;
    localparam logic [3:0] OP_MUL   = 4'h8;
    localparam logic [3:0] OP_PASSA = 4'h9;
    localparam logic [3:0] OP_PASSB = 4'hA;
    localparam logic [3:0] OP_NOR   = 4'hB;
    localparam logic [3:0] OP_SLTS  = 4'hC;
    localparam logic [3:0] OP_SLTU  = 4'hD;
    localparam logic [3:0] OP_ROR   = 4'hE;
    localparam logic [3:0] OP_ROL   = 4'hF;

    logic [WIDTH-1:0] result_comb;
    logic             zero_logic;
    logic             carry_logic;
    logic             overflow_logic;
    logic             negative_logic;

    logic [4:0] shamt;
    assign shamt = b[4:0];

    logic [WIDTH:0] add_ext
    logic [WIDTH:0] sub_ext;
    assign add_ext = {1'b0, a} + {1'b0, b};
    assign sub_ext = {1'b0, a} + ~{1'b0, b} + 1'b1;

    logic add_overflow;
    logic sub_overflow;
    assign add_overflow = (a[WIDTH-1] & b[WIDTH-1] & ~add_ext[WIDTH-1]) |
                          (~a[WIDTH-1] & ~b[WIDTH-1] &  add_ext[WIDTH-1]);
    assign sub_overflow = (a[WIDTH-1] & ~b[WIDTH-1] & ~sub_ext[WIDTH-1]) |
                          (~a[WIDTH-1] &  b[WIDTH-1] &  sub_ext[WIDTH-1]);

    always @* begin
        case (op)
            OP_ADD:    result_comb = add_ext[WIDTH-1:0];
            OP_SUB:    result_comb = sub_ext[WIDTH-1:0];
            OP_AND:    result_comb = a & b;
            OP_OR:     result_comb = a | b;
            OP_XOR:    result_comb = a ^ b;
            OP_NOR:    result_comb = ~(a | b);
            OP_SLL:    result_comb = a << shamt;
            OP_SRL:    result_comb = a >> shamt;
            OP_SRA:    result_comb = $signed(a) >>> shamt;
            OP_MUL:    result_comb = a * b;
            OP_PASSA:  result_comb = a;
            OP_PASSB:  result_comb = b;
            OP_ROR:    result_comb = (a >> shamt) | (a << (WIDTH - shamt));
            OP_SLTS:   result_comb = ($signed(a) < $signed(b)) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
            OP_SLTU:   result_comb = (a < b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
        endcase
    end

    assign carry_logic    = (op == OP_ADD) ? add_ext[WIDTH] :
                            (op == OP_SUB) ? sub_ext[WIDTH] : 1'b0;
    assign overflow_logic = (op == OP_ADD) ? add_overflow :
                            (op == OP_SUB) ? sub_overflow : 1'b0;
    assign zero_logic     = (result_comb == {WIDTH{1'b0}});
    assign negative_logic = result_comb[WIDTH-1];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y        <= '0;
            zero     <= 1'b0;
            carry    <= 1'b0;
            overflow <= 1'b0;
            negative <= 1'b0;
        end else if (en) begin
            y        <= result_comb;
            zero     <= zero_logic;
            carry    <= carry_logic;
            overflow <= overflow_logic;
            negative <= negative_logic;
        end
    end

endmodule