// cmp_we_32 (Equality Comparator with Write Enable)
module cmp_we_32 (
    input [31:0] in1,
    input [31:0] in2,
    input enable,
    output out
);
    assign out = enable && (in1 == in2);
endmodule
