// Definition for mux8 module to resolve ErrorAnalyzeBBox
module mux8 (
    output wire out,
    input wire in0,
    input wire in1,
    input wire in2,
    input wire in3,
    input wire in4,
    input wire in5,
    input wire in6,
    input wire in7,
    input wire [7:0] sel // 8-bit one-hot select, derived from usage with shft_dsel[7:0]
);
    assign out = (sel[0] & in0) |
                 (sel[1] & in1) |
                 (sel[2] & in2) |
                 (sel[3] & in3) |
                 (sel[4] & in4) |
                 (sel[5] & in5) |
                 (sel[6] & in6) |
                 (sel[7] & in7);
endmodule
