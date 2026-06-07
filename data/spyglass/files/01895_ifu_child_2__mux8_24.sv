module mux8_24 (
    output [23:0] out,
    input [23:0] in0, input [23:0] in1, input [23:0] in2, input [23:0] in3,
    input [23:0] in4, input [23:0] in5, input [23:0] in6, input [23:0] in7,
    input [2:0] sel
);
    reg [23:0] r_out;
    always @(*) begin
        case (sel)
            3'd0: r_out = in0;
            3'd1: r_out = in1;
            3'd2: r_out = in2;
            3'd3: r_out = in3;
            3'd4: r_out = in4;
            3'd5: r_out = in5;
            3'd6: r_out = in6;
            3'd7: r_out = in7;
            default: r_out = 24'bx;
        endcase
    end
    assign out = r_out;
endmodule
