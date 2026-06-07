// mux7_32 (7-to-1 Multiplexer)
module mux7_32 (
    input [31:0] in0, in1, in2, in3, in4, in5, in6,
    input [2:0] sel,
    output [31:0] out
);
    assign out = (sel == 3'd0) ? in0 :
                 (sel == 3'd1) ? in1 :
                 (sel == 3'd2) ? in2 :
                 (sel == 3'd3) ? in3 :
                 (sel == 3'd4) ? in4 :
                 (sel == 3'd5) ? in5 : in6;
endmodule
