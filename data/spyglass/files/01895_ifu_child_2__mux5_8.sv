module mux5_8 (
    output [7:0] out,
    input [7:0] in0, input [7:0] in1, input [7:0] in2, input [7:0] in3, input [7:0] in4,
    input [2:0] sel
);
    reg [7:0] r_out;
    always @(*) begin
        case (sel)
            3'd0: r_out = in0;
            3'd1: r_out = in1;
            3'd2: r_out = in2;
            3'd3: r_out = in3;
            3'd4: r_out = in4;
            default: r_out = 8'bx;
        endcase
    end
    assign out = r_out;
endmodule
