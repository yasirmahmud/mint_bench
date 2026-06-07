module mux8_8 (
    output [7:0] out,
    input  [7:0] in0,
    input  [7:0] in1,
    input  [7:0] in2,
    input  [7:0] in3,
    input  [7:0] in4,
    input  [7:0] in5,
    input  [7:0] in6,
    input  [7:0] in7,
    input  [7:0] sel
);
    assign out = (sel[0] ? in0 : 8'b0) |
                 (sel[1] ? in1 : 8'b0) |
                 (sel[2] ? in2 : 8'b0) |
                 (sel[3] ? in3 : 8'b0) |
                 (sel[4] ? in4 : 8'b0) |
                 (sel[5] ? in5 : 8'b0) |
                 (sel[6] ? in6 : 8'b0) |
                 (sel[7] ? in7 : 8'b0) ;
endmodule
