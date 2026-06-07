`timescale 1ns/1ps
`default_nettype none

module cpu1_alu (
    input  wire [3:0]  op,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [31:0] y,
    output wire        zero,
    output wire        negative,
    output reg         carry,
    output reg         overflow
);
    wire [32:0] add_ext;
    wire [32:0] sub_ext;
    wire        add_overflow;
    wire        sub_overflow;

    assign add_ext = {1'b0, a} + {1'b0, b};
    assign sub_ext = {1'b0, a} + {1'b0, ~b} + 33'd1;
    assign add_overflow = (a[31] == b[31]) && (add_ext[31] != a[31]);
    assign sub_overflow = (a[31] != b[31]) && (sub_ext[31] != a[31]);

    always @(op or a) begin
        y        = 32'd0;
        carry    = 1'b0;

        case (op)
            4'h0: begin
                y        = add_ext[31:0];
                carry    = add_ext[32];
                overflow = add_overflow;
            end
            4'h1: begin
                y        = sub_ext[31:0];
                carry    = sub_ext[32];
                overflow = sub_overflow;
            end
            4'h2: begin
                y = a & b;
            end
            4'h3: begin
                y = a | b;
            end
            4'h4: begin
                y = a ^ b;
            end
            4'h5: begin
                y = a << b[4:0];
            end
            4'h6: begin
                y = a >> b[4:0];
            end
            4'h7: begin
                y = $signed(a) >>> b[4:0];
            end
            4'h8: begin
                y = {31'd0, ($signed(a) < $signed(b))};
            end
            4'h9: begin
                y = {31'd0, (a == b)};
            end
            4'hA: begin
                y = b;
            end
            4'hB: begin
                y = (a[15:0] * b[15:0]) ^ {a[31:16], b[31:16]};
            end
            default: begin
                y = 32'd0;
            end
        endcase
    end

    assign zero = (y === 32'd0);
    assign negative = y[31];
endmodule

`default_nettype wire
