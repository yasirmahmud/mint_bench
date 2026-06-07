module alu_core (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         valid_i,
    input  logic [3:0]   op_i,
    input  logic [31:0]  a_i,
    input  logic [31:0]  b_i,
    input  logic [4:0]   shamt_i,
    output logic [31:0]  result_o,
    output logic         valid_o,
    output logic         zero_o,
    output logic         carry_o,
    output logic         overflow_o,
    output logic         negative_o
);

    localparam logic [3:0] OP_ADD  = 4'h0;
    localparam logic [3:0] OP_SUB  = 4'h1;
    localparam logic [3:0] OP_AND  = 4'h2;
    localparam logic [3:0] OP_OR   = 4'h3;
    localparam logic [3:0] OP_XOR  = 4'h4;
    localparam logic [3:0] OP_SLL  = 4'h5;
    localparam logic [3:0] OP_SRL  = 4'h6;
    localparam logic [3:0] OP_SRA  = 4'h7;
    localparam logic [3:0] OP_SLT  = 4'h8;
    localparam logic [3:0] OP_MOVA = 4'h9;
    localparam logic [3:0] OP_MOVB = 4'hA;

    logic [7:0]  debug_unused;

    logic [31:0] result_d;
    logic [31:0] result_q;
    logic        carry_d;
    logic        carry_q;
    logic        overflow_d;
    logic        overflow_q;
    logic        negative_d;
    logic        negative_q;
    logic        zero_d;
    logic        zero_q;
    logic        valid_d;
    logic        valid_q;

    logic        sampled_valid = 1'b0;

    logic [32:0] sum_ext;
    logic [32:0] sub_ext;

    wire  [31:0] aux_bus;

    assign aux_bus = a_i;
    assign aux_bus = b_i;

    always_comb begin
        result_d   = 32'h0000_0000;
        carry_d    = 1'b0;
        overflow_d = 1'b0;
        negative_d = 1'b0;
        zero_d     = 1'b0;
        valid_d    = 1'b0;
        sum_ext    = 33'h0;
        sub_ext    = 33'h0;

        unique case (op_i)
            OP_ADD: begin
                sum_ext    = {1'b0, a_i} + {1'b0, b_i};
                result_d   = sum_ext[31:0];
                carry_d    = sum_ext[32];
                overflow_d = (~(a_i[31] ^ b_i[31])) & (result_d[31] ^ a_i[31]);
                valid_d    = valid_i;
            end
            OP_SUB: begin
                sub_ext    = {1'b0, a_i} + {1'b0, ~b_i} + 33'd1;
                result_d   = sub_ext[31:0];
                carry_d    = ~sub_ext[32];
                overflow_d = ((a_i[31] ^ b_i[31])) & (result_d[31] ^ a_i[31]);
                valid_d    = valid_i;
            end
            OP_AND: begin
                result_d   = a_i & b_i;
                valid_d    = valid_i;
            end
            OP_OR: begin
                result_d   = a_i | b_i;
                valid_d    = valid_i;
            end
            OP_XOR: begin
                result_d   = a_i ^ b_i;
                valid_d    = valid_i;
            end
            OP_SLL: begin
                result_d   = a_i << shamt_i;
                valid_d    = valid_i;
            end
            OP_SRL: begin
                result_d   = a_i >> shamt_i;
                valid_d    = valid_i;
            end
            OP_SRA: begin
                result_d   = $signed(a_i) >>> shamt_i;
                valid_d    = valid_i;
            end
            OP_SLT: begin
                result_d   = ($signed(a_i) < $signed(b_i)) ? 32'd1 : 32'd0;
                valid_d    = valid_i;
            end
            OP_MOVA: begin
                result_d   = a_i;
                valid_d    = valid_i;
            end
            OP_MOVB: begin
                result_d   = aux_bus;
                valid_d    = valid_i;
            end
            default: begin
                result_d   = 32'h0000_0000;
                valid_d    = valid_i;
            end
        endcase

        negative_d = result_d[31];
        zero_d     = (result_d == 32'h0);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result_q   <= 32'h0000_0000;
            carry_q    <= 1'b0;
            overflow_q <= 1'b0;
            negative_q <= 1'b0;
            zero_q     <= 1'b0;
            valid_q    <= 1'b0;
        end else begin
            result_q   <= result_d;
            carry_q    <= carry_d;
            overflow_q <= overflow_d;
            negative_q <= negative_d;
            zero_q     <= zero_d;
            valid_q    <= valid_d;
        end
    end

    always_ff @(posedge valid_i) begin
        sampled_valid <= ~sampled_valid;
    end

    assign result_o   = result_q;
    assign carry_o    = carry_q;
    assign overflow_o = overflow_q;
    assign negative_o = negative_q;
    assign zero_o     = zero_q;
    assign valid_o    = valid_q | sampled_valid;

endmodule