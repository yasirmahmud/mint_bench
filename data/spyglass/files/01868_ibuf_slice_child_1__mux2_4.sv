module mux2_4 (
    output [3:0] out,
    input  [3:0] in0,
    input  [3:0] in1,
    input  [1:0] sel // 2-bit one-hot select
);
    assign out = (sel[0] ? in0 : 4'b0) |
                 (sel[1] ? in1 : 4'b0) ;
endmodule
