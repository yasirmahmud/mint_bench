module mux3_8 (
    output [7:0] out,
    input [7:0] in0, input [7:0] in1, input [7:0] in2,
    input [1:0] sel
);
    reg [7:0] r_out;
    always @(*) begin
        case (sel)
            2'd0: r_out = in0;
            2'd1: r_out = in1;
            2'd2: r_out = in2;
            default: r_out = 8'bx;
        endcase
    end
    assign out = r_out;
endmodule
