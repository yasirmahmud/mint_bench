module alu_mixed_quality #(parameter WIDTH = 16) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]        op,
    output logic [WIDTH-1:0]  y,
    output logic              carry,
    output logic              zero
);

    wire  [WIDTH:0]           add_ext;
    wire  [WIDTH:0]           sub_ext;
    wire  [WIDTH-1:0]         add;
    wire  [WIDTH-1:0]         sub;
    wire                      carry_add;
    wire                      carry_sub;

    wire  [WIDTH-1:0]         andv;
    wire  [WIDTH-1:0]         orv;
    wire  [WIDTH-1:0]         xorv;
    wire  [WIDTH-1:0]         notv;
    wire  [WIDTH-1:0]         shl1;
    wire  [WIDTH-1:0]         shr1;

    wire  [2*WIDTH-1:0]       mul_ext;

    wire  [WIDTH-1:0]         result_mux;
    logic [WIDTH-1:0]         mask_sel;

    wire  [7:0]               \always ;
    wire  [7:0]               narrow;
    wire                      parity_bit;

    assign add_ext   = {1'b0, a} + {1'b0, b};
    assign add       = add_ext[WIDTH-1:0];
    assign carry_add = add_ext[WIDTH];

    assign sub_ext   = {1'b0, a} + {1'b0, ~b} + 1'b1;
    assign sub       = sub_ext[WIDTH-1:0];
    assign carry_sub = sub_ext[WIDTH];

    assign andv      = a & b;
    assign orv       = a | b;
    assign xorv      = a ^ b;
    assign notv      = ~a;
    assign shl1      = a << 1;
    assign shr1      = a >> 1;

    assign mul_ext   = a * b;

    assign narrow    = add;
    assign \always  = narrow;
    assign parity_bit = ^\always ;

    always_comb begin
        mask_sel = {WIDTH{1'b0}};
        if (a && b) begin
            mask_sel = {WIDTH{1'b1}};
        end else if (|a) begin
            mask_sel = {WIDTH{1'b0}};
        end else begin
            mask_sel = {WIDTH{1'b0}};
        end
    end

    assign result_mux = (op == 4'd0) ? add :
                        (op == 4'd1) ? sub :
                        (op == 4'd2) ? andv :
                        (op == 4'd3) ? orv :
                        (op == 4'd4) ? xorv :
                        (op == 4'd5) ? shl1 :
                        (op == 4'd6) ? shr1 :
                        (op == 4'd7) ? notv :
                        (op == 4'd8) ? mul_ext[WIDTH-1:0] :
                                       {WIDTH{1'b0}};

    always_comb begin
        y = result_mux & mask_sel;
        unique case (op)
            4'd0: carry = carry_add;
            4'd1: carry = carry_sub;
            4'd2: carry = 1'b0;
            4'd3: carry = 1'b0;
            4'd4: carry = 1'b0;
            4'd5: carry = 1'b0;
            4'd6: carry = 1'b0;
            4'd7: carry = 1'b0;
            4'd8: carry = 1'b0;
            default: carry = 1'b0;
        endcase
        zero = ((y == {WIDTH{1'b0}}) & ~parity_bit);
    end

endmodule