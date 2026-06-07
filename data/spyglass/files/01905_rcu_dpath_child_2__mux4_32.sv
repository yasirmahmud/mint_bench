// mux4_32 (4-to-1 Multiplexer)
module mux4_32 (
    input [31:0] in0, in1, in2, in3,
    input [1:0] sel,
    output [31:0] out
);
    assign out = (sel == 2'd0) ? in0 :
                 (sel == 2'd1) ? in1 :
                 (sel == 2'd2) ? in2 : in3;
endmodule
