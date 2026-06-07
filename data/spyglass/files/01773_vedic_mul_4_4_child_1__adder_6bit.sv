module adder_6bit(
    input [5:0] in1,
    input [5:0] in2,
    output [5:0] out
);
    assign out = in1 + in2;
endmodule
