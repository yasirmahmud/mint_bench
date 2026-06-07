module cla_adder_32 (
    output [31:0] sum,
    output        cout,
    input  [31:0] in1,
    input  [31:0] in2,
    input         cin
);
    assign {cout, sum} = in1 + in2 + cin;
endmodule
