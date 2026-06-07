module less_comp3 (
    output less,
    input [2:0] in1,
    input [2:0] in2
);
    assign less = (in1 < in2);
endmodule
