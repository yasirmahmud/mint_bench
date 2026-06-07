module mux8_4 (
    output [3:0] out,
    input  [3:0] in0,
    input  [3:0] in1,
    input  [3:0] in2,
    input  [3:0] in3,
    input  [3:0] in4,
    input  [3:0] in5,
    input  [3:0] in6,
    input  [3:0] in7,
    input  [7:0] sel
);
    assign out = (sel[0] ? in0 : 4'b0) |
                 (sel[1] ? in1 : 4'b0) |
                 (sel[2] ? in2 : 4'b0) |
                 (sel[3] ? in3 : 4'b0) |
                 (sel[4] ? in4 : 4'b0) |
                 (sel[5] ? in5 : 4'b0) |
                 (sel[6] ? in6 : 4'b0) |
                 (sel[7] ? in7 : 4'b0) ;
endmodule
