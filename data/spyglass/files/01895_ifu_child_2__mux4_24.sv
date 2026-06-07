module mux4_24 (
    output [23:0] out,
    input [23:0] in0, input [23:0] in1, input [23:0] in2, input [23:0] in3,
    input [1:0] sel
);
    reg [23:0] r_out;
    always @(*) begin
        case (sel)
            2'd0: r_out = in0;
            2'd1: r_out = in1;
            2'd2: r_out = in2;
            2'd3: r_out = in3;
            default: r_out = 24'bx;
        endcase
    end
    assign out = r_out;
endmodule
