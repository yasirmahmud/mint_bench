// Dummy module for cmp_we_4 (4-bit comparator with enable)
module cmp_we_4 (
    output out,
    input [3:0] in1,
    input [3:0] in2,
    input enable
);
    assign out = enable && (in1 == in2);
endmodule
