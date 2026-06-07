module cla_adder_32 (
    output [31:0] sum,
    output        cout,
    input  [31:0] in1,
    input  [31:0] in2,
    input         cin
);
    wire [32:0] temp_sum;
    assign temp_sum = in1 + in2 + cin;
    assign sum = temp_sum[31:0];
    assign cout = temp_sum[32]; // Carry-out is the MSB of the 33-bit sum
endmodule
