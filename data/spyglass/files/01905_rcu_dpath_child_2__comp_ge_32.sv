// comp_ge_32 (Greater Than or Equal Comparator)
module comp_ge_32 (
    input [31:0] in1,
    input [31:0] in2,
    output ge
);
    assign ge = (in1 >= in2);
endmodule
