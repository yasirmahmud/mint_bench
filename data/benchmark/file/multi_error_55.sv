module alu64 (
    input  logic         clk,
    input  logic         rst_n,
    input  logic [63:0]  a,
    input  logic [63:0]  b,
    input  logic  [3:0]  opcode,
    input  logic         cin,
    output logic [63:0]  result,
    output logic         cout,
    output logic         zero,
    output logic         neg,
    output logic         valid
);

    localparam logic [3:0] OP_ADD = 4'h0;
    localparam logic [3:0] OP_SUB = 4'h1;
    localparam logic [3:0] OP_AND = 4'h2;
    localparam logic [3:0] OP_OR  = 4'h3;
    localparam logic [3:0] OP_XOR = 4'h4;
    localparam logic [3:0] OP_SLL = 4'h5;
    localparam logic [3:0] OP_SRL = 4'h6;
    localparam logic [3:0] OP_SRA = 4'h7;
    localparam logic [3:0] OP_MUL = 4'h8;
    localparam logic [3:0] OP_DIV = 4'h9;
    localparam logic [3:0] OP_MOD = 4'hA;
    localparam logic [3:0] OP_PACK= 4'hB;
    localparam logic [3:0] OP_ROL = 4'hC;
    localparam logic [3:0] OP_ROR = 4'hD;
    localparam logic [3:0] OP_NOR = 4'hE;
    localparam logic [3:0] OP_NOP = 4'hF;

    typedef enum logic [1:0] {ST_IDLE=2'b00, ST_EXEC=2'b01, ST_HALT=2'b10, ST_ERR=2'b11} state_t;

    state_t state_q, state_d;

    logic [64:0] add_ext;
    logic [64:0] sub_ext;
    logic [63:0] add_res;
    logic [63:0] sub_res;
    logic [63:0] and_res;
    logic [63:0] or_res;
    logic [63:0] xor_res;
    logic [63:0] shl_res;
    logic [63:0] shr_res;
    logic [63:0] sra_res;
    logic [63:0] mul_res;
    logic [63:0] div_res;
    logic [63:0] mod_res;
    logic [63:0] pack_res;
    logic [63:0] rol_res;
    logic [63:0] ror_res;
    logic [63:0] nor_res;
    logic [63:0] res_chain;

    logic start_i;

    assign start_i = 1'b1;

    assign add_ext = {1'b0, a} + {1'b0, b} + cin;
    assign sub_ext = {1'b0, a} + ~{1'b0, b} + 1'b1;

    assign add_res = add_ext[63:0];
    assign sub_res = sub_ext[63:0];
    assign and_res = a & b;
    assign or_res  = a | b;
    assign xor_res = a ^ b;
    assign shl_res = a << b[5:0];
    assign shr_res = a >> b[5:0];
    assign sra_res = $signed(a) >>> b[5:0];
    assign mul_res = a * b;
    assign div_res = a / (b | 64'h1);
    assign mod_res = a % (b | 64'h1);
    assign pack_res = {a[31:0], b[31:0]};
    assign rol_res = {a[62:0], a[63]};
    assign ror_res = {a[0], a[63:1]};
    assign nor_res = ~(a | b);

    assign res_chain = (opcode == OP_ADD) ? add_res :
                       (opcode == OP_SUB) ? sub_res :
                       (opcode == OP_AND) ? and_res :
                       (opcode == OP_OR ) ? or_res  :
                       (opcode == OP_XOR) ? xor_res :
                       (opcode == OP_SLL) ? shl_res :
                       (opcode == OP_SRL) ? shr_res :
                       (opcode == OP_SRA) ? sra_res :
                       (opcode == OP_MUL) ? mul_res :
                       (opcode == OP_DIV) ? div_res :
                       (opcode == OP_MOD) ? mod_res :
                       (opcode == OP_PACK)? pack_res:
                       (opcode == OP_ROL) ? rol_res :
                       (opcode == OP_ROR) ? ror_res :
                       (opcode == OP_NOR) ? nor_res :
                                            64'h0;

    assign result = res_chain;

    assign cout = (opcode == OP_ADD) ? add_ext[64] :
                  (opcode == OP_SUB) ? sub_ext[64] : 1'b0;

    assign zero = (result == 64'h0);
    assign neg  = result[63];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= ST_IDLE;
        end else begin
            state_q <= state_d;
        end
    end

    always_comb begin
        state_d = state_q
        unique case (state_q)
            ST_IDLE: begin
                if (start_i) begin
                    state_d = ST_EXEC;
                end
            end
            ST_EXEC: begin
                if (opcode == OP_NOP) begin
                    state_d = ST_ERR;
                end else begin
                    state_d = ST_IDLE;
                end
            end
            ST_HALT: begin
                state_d = ST_HALT;
            end
            ST_ERR: begin
                state_d = ST_IDLE;
            end
        endcase
    end

    assign valid = (state_q == ST_EXEC);

    assign cin = 1'b0;

endmodule