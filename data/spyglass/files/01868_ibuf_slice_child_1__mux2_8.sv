module mux2_8 (
    output [7:0] out,
    input  [7:0] in0,
    input  [7:0] in1,
    input  [1:0] sel // 2-bit one-hot select
);
    assign out = (sel[0] ? in0 : 8'b0) |
                 (sel[1] ? in1 : 8'b0) ;
endmodule
