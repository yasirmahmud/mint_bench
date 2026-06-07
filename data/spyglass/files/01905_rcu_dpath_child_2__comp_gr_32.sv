// comp_gr_32 (Greater Than Comparator)
module comp_gr_32 (
    input [31:0] in1,
    input [31:0] in2,
    output gr
);
    assign gr = (in1 > in2);
endmodule
