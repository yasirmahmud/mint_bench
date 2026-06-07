// Definition for mx2_32
module mx2_32 (
    input  [31:0] inp1,
    input  [31:0] inp0,
    input         sel,
    output [31:0] out
);
    assign out = sel ? inp1 : inp0;
endmodule
