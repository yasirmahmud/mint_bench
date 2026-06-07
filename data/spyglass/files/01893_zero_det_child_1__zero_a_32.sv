// Definition for zero_a_32
module zero_a_32 (
    input  [31:0] inp,
    output        zero_31_2,
    output        zero32
);
    assign zero32 = (inp == 32'd0);
    assign zero_31_2 = (inp[31:2] == 30'd0);
endmodule
