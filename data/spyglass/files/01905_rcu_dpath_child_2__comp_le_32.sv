// comp_le_32 (Less Than or Equal Comparator)
module comp_le_32 (
    input [31:0] in1,
    input [31:0] in2,
    output le
);
    assign le = (in1 <= in2);
endmodule
